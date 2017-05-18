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

## モデルの作成
1. コマンドで作成する。

   ```bash
   $ bundle exec padrino g model post title:string  body:text
       apply  orms/activerecord
       apply  tests/rspec
      create  models/post.rb
      create  spec/models/post_spec.rb
      create  db/migrate/002_create_posts.rb
   ```

1. データベースのマイグレーション。ただしさっきと少しだけ異なる。

   ```bash
   $ bundle exec rake ar:migrate
     DEBUG -   (0.2ms)  SELECT `schema_migrations`.`version` FROM `schema_migrations`
      INFO -  Migrating to CreateAccounts (1)
      INFO -  Migrating to CreatePosts (2)
     ==  CreatePosts: migrating ====================================================
 -- create_table(:posts)
    DEBUG -   (10.7ms)  CREATE TABLE `posts` (`id` int(11) DEFAULT NULL auto_increment PRIMARY KEY, `title` varchar(255), `body` text, `created_at` datetime NOT NULL, `updated_at` datetime NOT NULL) ENGINE=InnoDB
   -> 0.0153s
     ==  CreatePosts: migrated (0.0154s) ===========================================

     DEBUG -   (0.3ms)  INSERT INTO `schema_migrations` (`version`) VALUES ('2')
     DEBUG -   (0.1ms)  SELECT `schema_migrations`.`version` FROM `schema_migrations`
   ```

1. 次にコントローラーを作成する。単純に見るだけの機能をつくる。

   ```bash
   $ bundle exec padrino g controller posts get:index get:show
      create  app/controllers/posts.rb
      create  app/views/posts
       apply  tests/rspec
      create  spec/app/controllers/posts_controller_spec.rb
      create  app/helpers/posts_helper.rb
       apply  tests/rspec
      create  spec/app/helpers/posts_helper_spec.rb
   ```

1. `app/controllers/posts.rb` をかき、ビューをよしなに作成。

1. Padrinoのコマンドで管理者用のページを作成する。

   ```bash
   $ bundle exec padrino g admin_page post
      create  admin/views/posts
      create  admin/controllers/posts.rb
      create  admin/views/posts/_form.haml
      create  admin/views/posts/edit.haml
      create  admin/views/posts/index.haml
      create  admin/views/posts/new.haml
      insert  admin/app.rb
   ```

1. `padrino rake routes` コマンドでアプリケーションのルートが見える。(便利)

   ```bash
   $ bundle exec padrino rake routes
    => Executing Rake routes ...
    Application: SampleBlog::Admin
        URL                           REQUEST  PATH
        (:accounts, :index)             GET    /admin/accounts

    Application: SampleBlog::App
        URL                 REQUEST  PATH
        (:about)              GET    /about_us
        (:posts, :index)      GET    /posts
        (:posts, :show)       GET    /posts/show/:id
   ```

## JSON API化しだす。
1. 先程のコントローラー部を書き換え、ビューとしていたHAMLファイルを削除。
1. ビューが消えたので全部JSONで返ってくる。

   ```bash
   $ http http://localhost:3000/posts/
   [
       {
           "body": "テキストが色々書けるよー",
           "created_at": "2017-05-18T05:35:48Z",
           "id": 1,
           "title": "タイトルだよ",
           "updated_at": "2017-05-18T05:35:48Z"
       }
   ]

   $ http http://localhost:3000/posts/1
   {
       "body": "テキストが色々書けるよー",
       "created_at": "2017-05-18T05:35:48Z",
       "id": 1,
       "title": "タイトルだよ",
       "updated_at": "2017-05-18T05:35:48Z"
   }
   ```

