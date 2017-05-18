# sample-blog
[公式ドキュメントのBlog Tutorial](http://padrinorb.com/guides/getting-started/blog-tutorial/)をよんで雰囲気をつかむ。

## Padrinoを起動するまで
1. Padrinoをインストール: `gem install padrino`
1. プロジェクトを生成する。今回はActiveRecordを使い、MySQLにテーブルを作成する。

    ```bash
    $ padrino g project sample_blog -t rspec -e haml -d activerecord -a mysql
    ```
1. Gemfileを書き換える。書き換えないと `bundle exec rake db:migrate` でエラーになる。

   ```
   gem 'activerecord', '3.2.22', :require => 'active_record'
   gem 'mysql2', '0.3.14'
   ```
   
1. データベースのマイグレーション.

   ```bash
   $ bundle exec rake db:migrate
   $ bundle exec rake db:seed
   ```

1. 起動してレスポンスを確認してみる。

   ```bash
   $ bundle exec padrino s
   $ http http://localhost:3000 | jq
   {
      "message": "Hello, SampleBlog!"
   }
   $ http http://localhost:3000/about_us | jq
   {
      "message": "This is a sample blog created to demonstorate how Padrino works"
   }
   ```
