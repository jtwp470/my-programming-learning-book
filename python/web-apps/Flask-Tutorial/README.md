## Flaskチュートリアル
PythonでWebアプリケーションを作成してみたいのでとりあえず最初にFlask公式チュートリアルをそのままなぞったブログアプリというものを作成してみる.

* http://study-flask.readthedocs.org/ja/latest/02.html
* http://study-flask.readthedocs.org/ja/latest/04.html

## 一応動かし方とか
まずデータベースを作成する.

```bash
$ python manage.py init_db
```

実際に動かすときは以下のような感じに指定する.

```bash
$ python manage.py runserver
```

すると`http://127.0.0.1:5000`に動く.
ただしログインするためのユーザー情報が設定されていないとログインすることができず実行ができないw
