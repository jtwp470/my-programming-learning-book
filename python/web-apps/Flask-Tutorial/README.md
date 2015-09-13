## Flaskチュートリアル
PythonでWebアプリケーションを作成してみたいのでとりあえず最初にFlask公式チュートリアルをそのままなぞったブログアプリというものを作成してみる.

http://study-flask.readthedocs.org/ja/latest/02.html

## 一応動かし方とか
まずデータベースを作成する.

```bash
$ python
>>> from flaskr.models import init
>>> init()

$ python manage.py
```

すると`http://127.0.0.1:5000`に動く.
