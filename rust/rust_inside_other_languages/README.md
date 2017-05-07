# 他言語と共存する
See the [documentation](https://rust-lang-ja.github.io/the-rust-programming-language-ja/1.6/book/rust-inside-other-languages.html).

まだドキュメントが英語のままなので、軽く日本語に訳したものを以下に載せておきます。

## Rust Inside Other Languages
組織の成長においてますますたくさんのプログラミング言語に依存するようになっています。
様々なプログラミング言語には様々な長所と短所があり、多言語のスタックにおいてはその強みが意味をなさない言語とそれが弱いところで別の言語を利用することができるでしょう。

多くのプログラミング言語にとって共通する部分としてはプログラムのランタイムパフォーマンスが弱いという点があります。
しばしば、遅い言語ではありますが、プログラマーの生産性を向上させる言語を使用することは価値のあるトレードオフとなります。
これらを共存させるための手助けとして、あなたのシステムをC言語で書く機能を提供し、高水準言語で書かれたかのようにそれらのC言語コードを呼び出すことができます。
これは、「Foreign Function Interface」とよび、短く「FFI」と呼びます。

RustではこのFFIを2つの方法で利用することができます。1つ目はCコードを簡単に呼び出すことができますが、Cの内部で呼び出すときと同様にかんたんに呼び出すことができます。
Rustのガベージコレクタの欠如とランタイム要件の低さが相まって、Rustは他の言語の中に組み込む言語として素晴らしい候補になります。

## The Problem
多くの言語では一貫性のために数値はスタック上よりもヒープ上に配置されます。
特にオブジェクト指向プログラミングとガベージコレクションを利用する言語に焦点を当ててみると、ヒープ配置はデフォルトです。
ときには最適化により特定の数値をスタックに割り当てることもできますが、オプティマイザに頼るというよりは何らかのオブジェクト型ではなくプリミティブ型を常に使用していると保証したい場合があります。

2番めに多くの言語では多くの条件下で並行性を制限する「グローバルインタープリターロック」(GIL)を持っています。
これは安全の名目で行われており、肯定的な効果を持ちますが、同時に行うことのできる作業量の制限をしてしまう点においては大きなマイナス要因となっています。

これら2つの側面を強調するために、これら2つの側面を大きく使用する小さなプロジェクトを作成します。

> 10個のスレッドを始動する。それぞれのスレッド内で1から500万まで数え上げる。10個のスレッドが終了したら'done'と印字する。

Rubyでこのプログラムを作成すると[次のようになる](./example.rb)。

```ruby
#!/usr/bin/env ruby
threads = []

10.times do
  threads << Thread.new do
    count = 0
    5_000_000.times do
      count += 1
    end

    count
  end
end

threads.each do |t|
  puts "Thread finished with count = #{t.value}"
end
puts "done!"
```

これを実際にMacBook Pro上で実行してみると結果としては次のようになった。

```bash
$ time ruby example.rb
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
done!
ruby example.rb  2.15s user 0.02s system 98% cpu 2.190 total
```

`top`のようなプロセス監視ツールで見てみると、マシンの1コアのみしか利用されていない。これはGILが効いているということである。

Rustで同じ処理を書き、Ruby側で呼び出してみると次のようになる。

```bash
$ time ruby embed.rb
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
Thread finished with count = 5000000
done!
ruby embed.rb  0.07s user 0.01s system 86% cpu 0.095 total
```

というわけで約0.07秒で実行が終了する。

ちなみにPythonでは約0.02秒で実行が終了した。(早いw)
