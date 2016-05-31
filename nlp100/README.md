# 言語処理100本ノック

* [Python](./python)

## 確認方法
2章以降におけるシェルコマンドによる確認方法を示す.

### 10. 行数のカウント

```bash
$ wc -l hightemp.txt
```

### 11. タブをスペースに置換

```bash
$ sed 's/\t/ /g' hightemp.txt
```

(Macではデフォルトのsedコマンドでは動かないのでGNU版のsedを別途入れる必要がある.)

### 12. 1列目をcol1.txtに, 2列目をcol2.txt に保存

```bash
$ cut -f 1 hightemp.txt > col1.txt
$ cut -f 2 hightemp.txt > col2.txt
```

### 13. col1.txtとcol2.txtをマージ

```bash
$ paste col1.txt col2.txt
```

### 14. 先頭からN行を出力

```bash
$ head -n 10 hightemp.txt
```

### 15. 末尾のN行を出力

```bash
$ tail -n 10 hightemp.txt
```

### 16. ファイルをN分割する

### 17. 1列目の文字列の異なり

### 18. 各行を3コラム目の数値の降順にソート

### 19. 各行の1コラム目の文字列の出現頻度を求め,出現頻度の高い順に並べる
