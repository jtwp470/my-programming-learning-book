# ブログの一覧と投稿画面
# 投稿画面はログインしているときのみ操作できる
from flask import request, redirect, url_for, render_template, flash
from flaskr import app, db
from flaskr.models import Entry


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
