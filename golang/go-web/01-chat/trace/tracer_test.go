package trace

import (
	"bytes"
	"testing"
)

/*
 * Goでは*_test.goというファイルで関数名がTestで始まり, *testing.T型の引数を
 * を1つ受け取る関数はすべてユニットテストとみなされる
 */
func TestNew(t *testing.T) {
	var buf bytes.Buffer
	tracer := New(&buf)
	if tracer == nil {
		t.Error("Newからの戻り値がnilです.")
	} else {
		tracer.Trace("こんにちは, traceパッケージ")
		if buf.String() != "こんにちは, traceパッケージ\n" {
			t.Errorf("%s という誤った文字列が出力されました", buf.String())
		}
	}
}

// 1.4.3 記録を無効化できるようにする
func TestOff(t *testing.T) {
	var silentTracer Tracer = Off()
	silentTracer.Trace("データ")
}
