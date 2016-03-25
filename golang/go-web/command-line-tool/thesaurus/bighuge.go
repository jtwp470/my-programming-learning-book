package thesaurus

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type BigHuge struct {
	APIKey string
}

type synonyms struct {
	Noun *words `json:"noun"`
	Verb *words `json:"verb"`
}

type words struct {
	Syn []string `json:"syn"`
}

func (b *BigHuge) Synonyms(term string) ([]string, error) {
	var syns []string
	url := fmt.Sprintf("http://words.bighugelabs.com/api/2/%s/%s/json", b.APIKey, term)

	response, err := http.Get(url)
	if err != nil {
		return syns, fmt.Errorf("bighuge:  %qの類語検索に失敗しました: %v", term, err)
	}
	var data synonyms
	defer response.Body.Close()
	// contents, err := ioutil.ReadAll(response.Body)

	if err := json.NewDecoder(response.Body).Decode(&data); err != nil {
		return syns, err
	}
	syns = append(syns, data.Noun.Syn...)
	syns = append(syns, data.Verb.Syn...)
	return syns, nil
}
