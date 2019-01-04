// Refs:  https://blog.golang.org/context/userip/userip.go
package userip

import (
	"context"
	"fmt"
	"net"
	"net/http"
)

// 他のパッケージで定義されるキーとの重複を防ぐため、キーはエクスポートしないようにしています
type key int

// userIPKey はユーザーのIPアドレスのコンテキストのキーです。
// その値のゼロは任意です。もしパッケージが他のコンテキストのキーを定義している場合、
// 他の数を定義する必要があります
const userIPKey key = 0

func FromRequest(req *http.Request) (net.IP, error) {
	ip, _, err := net.SplitHostPort(req.RemoteAddr)
	if err != nil {
		return nil, fmt.Errorf("userip: %q is not IP:port", req.RemoteAddr)
	}

	userIP := net.ParseIP(ip)
	if userIP == nil {
		return nil, fmt.Errorf("userip: %q is not IP:port", req.RemoteAddr)
	}
	return userIP, nil
}

func NewContext(ctx context.Context, userIP net.IP) context.Context {
	return context.WithValue(ctx, userIPKey, userIP)
}

func FromContext(ctx context.Context) (net.IP, bool) {
	// ctx.Value はもし ctx のキーがない場合、nilを返します。
	// net.IP の型アサーションが nilの場合 ok は false を返します
	userIP, ok := ctx.Value(userIPKey).(net.IP)
	return userIP, ok
}
