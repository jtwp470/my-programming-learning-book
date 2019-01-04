package google

import (
	"context"
	"encoding/json"
	"net/http"

	"github.com/ryosan-470/practice/golang/concurrency_patterns/context/userip"
)

type Results []Result

type Result struct {
	Title, URL string
}

func Search(ctx context.Context, query string) (Results, error) {
	// Google Search API リクエストを準備する
	req, err := http.NewRequest("GET", "https://ajax.googleapis.com/ajax/services/search/web?v=1.0", nil)
	if err != nil {
		return nil, err
	}

	q := req.URL.Query()
	q.Set("q", query)

	// ctx がユーザーのIPアドレスを持っている場合、サーバーにそれを送ります。
	// Google APIはそのユーザーのIPアドレスを用いて、エンドユーザーのリクエストの初期リクエストを区別します
	if userIP, ok := userip.FromContext(ctx); ok {
		q.Set("userip", userIP.String())
	}

	req.URL.RawQuery = q.Encode()

	var results Results
	err = httpDo(ctx, req, func(resp *http.Response, err error) error {
		if err != nil {
			return err
		}
		defer resp.Body.Close()

		// JSONの検索結果をパースします
		// https://developers.google.com/web-search/docs/#fonje
		var data struct {
			ResponseData struct {
				Results []struct {
					TitleNoFormatting string
					URL               string
				}
			}
		}
		if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
			return err
		}
		for _, res := range data.ResponseData.Results {
			results = append(results, Result{Title: res.TitleNoFormatting, URL: res.URL})
		}
		return nil
	})
	// httpDo は return が返ってくるまでクロージャーを待つため、ここで結果を読むことは安全です
	return results, err
}

func httpDo(ctx context.Context, req *http.Request, f func(*http.Response, error) error) error {
	// goroutine内でHTTPリクエストを動かし、レスポンスをfにわたします
	c := make(chan error, 1)
	req = req.WithContext(ctx)
	go func() { c <- f(http.DefaultClient.Do(req)) }()
	select {
	case <-ctx.Done():
		<-c // fが戻ってくるのをまつ
		return ctx.Err()
	case err := <-c:
		return err
	}
}
