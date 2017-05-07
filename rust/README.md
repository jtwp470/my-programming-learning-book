# Rust
[プログラミング言語Rust](https://www.rust-lang.org/)をもとにRustを勉強していくリポジトリです。

Rustは

* 安全性
* 速度
* 並行性

の3つのゴールにフォーカスした言語。

## インストールと利用
HomebrewでRust自体はインストールできるが、推奨は[rustup](https://www.rustup.rs/)を使うことらしいのでそれを使う。

```bash
$ curl https://sh.rustup.rs -sSf | sh
$ rustc --version
rustc 1.17.0 (56124baa9 2017-04-24)
```

PATHを以下のように指定しておく。

```
export PATH="~/.cargo/bin:$PATH" # rust
```

また、エディタとして、Spacemacsを利用する場合、きちんとRust用のレイヤーが用意されている。

* [Rust contribution layer for Spacemacs](https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/rust)

この手順でインストールを進めていくと、補完機能を有効にするためには、Racerをインストールせよとあるので、`cargo` を使ってインストールしておく。

```bash
$ cargo install racer rustfmt
$ rustup component add rust-src
```

macOSの場合は、先程のコンポーネントは以下のパスにあるので、次のように環境変数を設定しておく。

```
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
```

あとは、コマンドラインで効いているかどうかテストをする。

```bash
$ racer complete std::io::std
MATCH stdin,205,7,/Users/ryosuke.sato/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/libstd/io/stdio.rs,Function,pub fn stdin() -> Stdin
MATCH stdout,398,7,/Users/ryosuke.sato/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/libstd/io/stdio.rs,Function,pub fn stdout() -> Stdout
MATCH stderr,534,7,/Users/ryosuke.sato/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/libstd/io/stdio.rs,Function,pub fn stderr() -> Stderr
```

これでOK
