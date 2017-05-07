# Rust
[プログラミング言語Rust](https://www.rust-lang.org/)をもとにRustを勉強していくリポジトリです。

Rustは

* 安全性
* 速度
* 並行性

の3つのゴールにフォーカスした言語。

## インストールと利用
Macで利用する場合はHomebrewでインストールができる。

```bash
$ brew -v install rust
$ rustc --version
rustc 1.17.0
```

また、エディタとして、Spacemacsを利用する場合、きちんとRust用のレイヤーが用意されている。

* [Rust contribution layer for Spacemacs](https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/rust)

この手順でインストールを進めていくと、補完機能を有効にするためには、Racerをインストールせよとあるので、`cargo` を使ってインストールしておく。

```bash
$ cargo install racer rustfmt
```

これでOK
