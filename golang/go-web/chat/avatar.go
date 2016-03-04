// アバター画像を取得する処理を抽象化する
package main

import (
	"crypto/md5"
	"errors"
	"fmt"
	"io"
	"strings"
)

// ErrNoAvatarはAvatarインスタンスがアバターのURLを返すことが出来ない
// 場合に発生するエラー
var ErrNoAvatarURL = errors.New("chat: アバターのURLを取得することが出来ません")

// Avatarはユーザーのプロフィール画像を表す型
type Avatar interface {
	// GetAvatarURL は指定されたクライアントのアバター画像のURLを返す
	// 問題が発生した場合にはエラーを返す.
	// 特にURLを取得できなかった場合にはErrNoAvatarURLを返す
	GetAvatarURL(c *client) (string, error)
}

type AuthAvatar struct{}

var UseAuthAvatar AuthAvatar

func (_ AuthAvatar) GetAvatarURL(c *client) (string, error) {
	if url, ok := c.userData["avatar_url"]; ok {
		if urlStr, ok := url.(string); ok {
			return urlStr, nil
		}
	}
	return "", ErrNoAvatarURL
}

type GravatarAvatar struct{}

var UseGravatar GravatarAvatar

func (_ GravatarAvatar) GetAvatarURL(c *client) (string, error) {
	if email, ok := c.userData["email"]; ok {
		if emailStr, ok := email.(string); ok {
			m := md5.New()
			io.WriteString(m, strings.ToLower(emailStr))
			return fmt.Sprintf("//www.gravatar.com/avatar/%x", m.Sum(nil)), nil
		}
	}
	return "", ErrNoAvatarURL
}
