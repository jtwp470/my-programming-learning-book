# ブログの一覧と投稿画面
# 投稿画面はログインしているときのみ操作できる
from flask import request, redirect, url_for, render_template, flash, abort, \
    jsonify, session, g
from flaskr import app, db
from flaskr.models import Entry, User
from functools import wraps


# ログインしないと見れないようにするためのもの
# デコレーター定義
def login_required(f):
    @wraps(f)
    def decorated_view(*args, **kwargs):
        # g.userでログインしているかどうかを確認
        if g.user is None:
            return redirect(url_for('login', next=request.path))
        return f(*args, **kwargs)
    return decorated_view


# routeで追加したendpointの前に呼ばれ,
# session['user_id']に格納したuser.idからUserを取得できる
# gというFlaskのインスタンス内のグローバル変数のようなものにuserを追加する
@app.before_request
def load_user():
    user_id = session.get('user_id')
    if user_id is None:
        g.user = None
    else:
        g.user = User.query.get(session['user_id'])


@app.route('/')
def show_entries():
    entries = Entry.query.order_by(Entry.id.desc()).all()
    # 指定したHTMLテンプレートを使ってレスポンスを返す
    return render_template('show_entries.html', entries=entries)


@app.route('/add', methods=['POST'])
def add_entry():
    # request: HTTPリクエストオブジェクトmethodやフォームデータにアクセスできる
    entry = Entry(
        title=request.form['title'],
        text=request.form['text']
    )
    db.session.add(entry)
    db.session.commit()
    # メッセージを通知するための仕組み
    flash('New entry was successfully posted.')
    # redirect: 指定したURLにリダイレクトするレスポンスを返す
    # url_for:  指定したエンドポイントに対するURLを返す
    return redirect(url_for('show_entries'))


@app.route('/users/')
@login_required
def user_list():
    users = User.query.all()
    return render_template('user/list.html', users=users)


@app.route('/users/<int:user_id>/')
@login_required
def user_detail(user_id):
    user = User.query.get(user_id)
    return render_template('user/detail.html', user=user)


@app.route('/users/<int:user_id>/edit/', methods=['GET', 'POST'])
@login_required
def user_edit(user_id):
    user = User.query.get(user_id)
    if user is None:
        abort(404)
    if request.method == 'POST':
        print(user)
        user.name = request.form['name']
        user.email = request.form['email']
        user.password = request.form['password']
        # db.session.add(user)
        db.session.commit()
        return redirect(url_for('user_detail', user_id=user_id))
    return render_template('user/edit.html', user=user)


@app.route('/users/create/', methods=['GET', 'POST'])
@login_required
def user_create():
    if request.method == "POST":
        user = User(name=request.form['name'],
                    email=request.form['email'],
                    password=request.form['password'])
        db.session.add(user)
        db.session.commit()
        return redirect(url_for('user_list'))
    return render_template('user/edit.html')


@app.route('/users/<int:user_id>/delete', methods=['DELETE'])
@login_required
def user_delete(user_id):
    user = User.query.get(user_id)
    if user is None:
        response = jsonify({'status': 'Not Found'})
        response.status_code = 404
        return response
    db.session.delete(user)
    db.session.commit()
    return jsonify({'status': 'OK'})


# 実際にログイン
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == "POST":
        user, authenticated = User.authenticate(db.session.query,
                                                request.form['email'],
                                                request.form['password'])
        if authenticated:
            session['user_id'] = user.id
            flash('You were logged in')
            return redirect(url_for('show_entries'))
        else:
            flash('Invalid email or password')
    return render_template('login.html')


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))
