package main

import (
	"github.com/gorilla/websocket"
)

type client struct {
	// socket はこのクライアントのWebSocket
	socket *websocket.Conn
	// send はメッセージが送られるチャネル
	send chan []byte
	// room はこのクライアントが参加しているチャットルーム
	room *room
}

// client 側での処理としてWebSocketへの読み書きを行うメソッド
func (c *client) read() {
	for {
		if _, msg, err := c.socket.ReadMessage(); err == nil {
			c.room.forward <- msg
		} else {
			break
		}
	}
	c.socket.Close()
}

func (c *client) write() {
	for msg := range c.send {
		if err := c.socket.WriteMessage(websocket.TextMessage, msg); err != nil {
			break
		}
	}
	c.socket.Close()
}
