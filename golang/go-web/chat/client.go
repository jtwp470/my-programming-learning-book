package main

import (
	"github.com/gorilla/websocket"
	"time"
)

type client struct {
	// socket はこのクライアントのWebSocket
	socket *websocket.Conn
	// send はメッセージが送られるチャネル
	send chan *message
	// room はこのクライアントが参加しているチャットルーム
	room *room
	// userDataはユーザーに関する情報を保持する
	userData map[string]interface{}
}

// client 側での処理としてWebSocketへの読み書きを行うメソッド
// WebSocketのReadJSONを利用してmessage型をデコードする
func (c *client) read() {
	for {
		var msg *message
		if err := c.socket.ReadJSON(&msg); err == nil {
			msg.When = time.Now()
			msg.Name = c.userData["name"].(string)
			msg.AvatarURL, _ = c.room.avatar.GetAvatarURL(c)
			if avasterURL, ok := c.userData["avaster_url"]; ok {
				msg.AvatarURL = avasterURL.(string)
			}
			c.room.forward <- msg
		} else {
			break
		}
	}
	c.socket.Close()
}

// WebSocketのWriteJSONメソッドを利用してエンコードをする
func (c *client) write() {
	for msg := range c.send {
		if err := c.socket.WriteJSON(msg); err != nil {
			break
		}
	}
	c.socket.Close()
}
