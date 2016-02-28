// 2.6.4 メッセージ表示の拡張
package main

import (
	"time"
)

// messageは一つのメッセージを表す
type message struct {
	Name    string    // ユーザー名
	Message string    // メッセージ本体
	When    time.Time // メッセージ送信時刻
}
