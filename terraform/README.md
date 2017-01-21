# TerraformでInfrastructure as Codeを体感しよう
Infrastructure as Codeを標榜する[Terraform](https://www.terraform.io)を用いてAWSのインスタンス環境等をコード化してみます．

## Terraformってなんぞや?
![Terraform-logo](https://www.hashicorp.com/images/blog/terraform/big-f32f627f.png)

TerraformはVagrantやPackerを公開しているHashiCorpが作っているインフラをコード化できるものです．

多くの場合, クラウドのインスタンスの作成やネットワークの構成等はWebのコンソールでポチポチしたりAPIなどを直接叩いて構成するみたいな形式が多いのではないでしょうか．(よく知りませんが)

TerraformではそれをJSONっぽい記法で書き，Gitで管理できるようにしインフラ構築までを自動化してしまおうというようなプロジェクトです．

トップページには次のように書かれています.

> Terraform enables you to safely and predictably create, change, and improve production infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can be shared amongst team members, treated as code, edited, reviewed, and versioned.

プロバイダーとして様々な業者がサポートされているので乗り換え等も簡単かもしれませんw

* [AWS](https://aws.amazon.com/jp/)
* [DigitalOcean](https://www.digitalocean.com/)
* [Google Cloud Platform](https://cloud.google.com/)
* [Microsoft Azure](https://azure.microsoft.com/ja-jp/)
* [SoftLayer](http://www.softlayer.com/jp)
* [VMware vSphere](http://www.vmware.com/jp/products/vsphere.html)

また，今回作成した設定例は[GitHub](https://github.com/jtwp470/my-programming-learning-book/tree/master/terraform)に公開してあるので参考にして下さいませ．:pray:

## ゴール :checkered_flag:
今回のゴールは以下のような感じ．

* VPCを設定
* EC2インスタンスを生成する
* セキュリティグループを設定
* Ansibleといい感じに組み合わせる (おまけ)

## はじめに
まず自分のマシンにTerraformをインストールします．MacでHomebrewが入っていればすぐにインストールできます．

```bash
$ brew install terraform
```

また，AWSのIAMからアクセスキーを生成します．

## クレデンシャル情報の切り出し :key:
AWSのアクセスキーとシークレットキーが漏れると

* [初心者がAWSでミスって不正利用されて$6,000請求、泣きそうになったお話。](http://qiita.com/mochizukikotaro/items/a0e98ff0063a77e7b694)

のような不幸なこと:sob:になりかねないのでしっかりGit管理外に追い出します．

Terraformでは[公式ドキュメント](https://www.terraform.io/intro/getting-started/variables.html)にあるように`*.tfvars`というファイルに変数を定義して保存しておくことができるらしいので，`terraform.tfvars`というファイルを作成しそこにAWSのクレデンシャル情報を保存しておきましょう．

次のような感じにしました．

```
access_key = "<YOUR_AWS_ACCESS_KEY>"
secret_key = "<YOUR_AWS_SECRET_KEY>"
```

**勿論そのファイル自体は`.gitignore`に追記しておきます．**

今回の場合，[gibo](https://github.com/simonwhitaker/gibo)を使ってTerraform用のgitignoreファイルを作成してから先程のファイルを無視するようにしました．

```bash
$ gibo terraform > .gitignore
$ echo terraform.tfvars >> .gitignore
```

## TFファイルの作成 :pencil2:
基本的にTerraformの設定は拡張子`tf`のファイルに書いていきます
今回はファイルをわけず1つのファイルに書いていきます．

まず，AWSを使うのでAWSの設定を次のように書きます．
リージョンは何も考えずに東京にしましたが他のリージョンを使いたい場合は自分で書き換えて下さい．

```
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "ap-northeast-1"
}
```

アクセスキーやシークレットキーは既に変数として定義しているのでTerraform内で変数を参照するルールを確認しておきましょう．

Terraformでは`${var.<variable_name>}`のようにして変数に参照できます．
詳しくは[ドキュメント](https://www.terraform.io/docs/configuration/variables.html)を読みましょう．

## SSH鍵の登録 :secret:
インスタンスにログインするためのSSH公開鍵を登録します．
今回公開鍵はvariable.tfに保存することとします．
このファイル名にしておくと`terraform plan`等をするときに`--var-file`を指定せずとも自動で読み出されるので便利です．


```
variable "public-ssh-key" {
  default = "<公開鍵>"
}
```

これをAWSに登録するためには`aws_key_pair`を使います．

```
resource "aws_key_pair" "admin-key" {
  key_name = "admin-key"
  public_key = "${var.public-ssh-key}"
}
```


## インスタンスの定義 :desktop:
インスタンスの定義は[aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html)を用いてインスタンスを定義します．

今回はUbuntu Server 16.04 LTS (HVM)を使うことにしました．
インスタンスサイズは無料枠の`t2.micro`にしました．

```
resource "aws_instance" "server" {
  ami = "ami-be4a24d9"  # Ubuntu Server 16.04 LTS (HVM) SSD
  instance_type = "t2.micro"
  key_name = "admin-key"
  tags {
    Name = "terraform"
  }
}
```

key_nameを指定すれば先程の公開鍵を使ってSSHログインできるようになります．更にTagをつけておくことでAWSのコンソール側で今回設定したものをフィルタできます．

## VPCとサブネットの作成
AWSではVPCを使ってセキュリティを向上させているようです．
このあたりはタダWebコンソールを使ってインスタンスを生成しているとあまり意識していない点ですがコードで書く以上，定義しておかないといけないようです．

今回はVPCのアドレス範囲として`10.0.0.0/16`を割り当てます．

```
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "terraform"
  }
}
```

また，サブネットを作成します．

```
resource "aws_subnet" "subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.10.0/24"

  tags {
    Name = "terraform"
  }
}
```

## インターネットゲートウェイとルートテーブルの作成
インターネットゲートウェイを作成します．その名の通りこれを作ることでインターネットに接続できるようになります．

```
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "terraform"
  }
}
```

また，先ほど作成したサブネットをインターネット接続できるようにして上げる必要があります．

```
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "terraform"
  }
}

resource "aws_route_table_association" "vpc-rta" {
  subnet_id = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}
```

## ネットワークの設定をインスタンスに紐付ける
今の状態では上記の設定を紐付けることが出来ていません．
そこでインスタンスの項目に戻り追記します．

```
resource "aws_instance" "server" {
  ...
  subnet_id = "${aws_subnet.subnet.id}"
  associate_public_ip_address = true
  ...
}
```


## セキュリティグループの設定
AWSではセキュリティグループというファイアウォールのようなものがあります．
これを設定してあげないとインターネット側からはアクセスすることが出来ないようです．

今回は，80, 443をすべてのIPアドレスから，22のSSHポートだけは自宅のIPアドレスからのみアクセスを可能にすることにします．

```
resource "aws_security_group" "terraform-asg" {
  name = "terraform-asg"
  vpc_id = "${aws_vpc.main.id}"
  description = "Default security group"

  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.permit_ip_list}"
  }

  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform"
  }
}
```

自宅のIPアドレスをGit管理下に置くのは気がひけるので今回はAWSのアクセスキーとシークレットキーを書いた`terraform.tfvars`に追記しました．

```
access_key = "<YOUR_AWS_ACCESS_KEY>"
secret_key = "<YOUR_AWS_SECRET_KEY>"
permit_ip_list = ["8.8.8.8"]
```

更に気をつけないといけないのは`egress`を設定しないといけないということです．
AWSではデフォルトのセキュリティグループの設定でOutboundはすべてを許可しているのですがTerraformはセキュリティのためにこの規則を消してしまうそうです．
ですので特に問題がない場合，`egress`を追加しておきます．

ここで設定したセキュリティグループの設定をインスタンスに紐付けましょう．

```
resource "aws_instance" "server" {
  ...
  vpc_security_group_ids = [
    "${aws_security_group.terraform-asg.id}"
  ]
  ...
}
```

## dry-runする
ここまで来たらDry-Runをして実際にこれを適用するとどうなるか見てみましょう．

```bash
$ terraform plan
# いっぱい表示される
```

## 実行する
問題なさそうなら，これを実行してみましょう．そうすることで今までポチポチとWebコンソールで設定していたものをコード化出来，Infrastructure as Codeを体感できます.

```bash
$ terraform apply
```

以上です．こんな感じでインフラの構成もコードに落とし込むことができるようになりました．
これを使えばインフラの属人化を防ぐことができるようになるだけでなく，インフラプロパイダーを変えようというときなどにも比較的簡単に移行できるのではないでしょうか? (やったことがないのでなんとも言えませんが)
