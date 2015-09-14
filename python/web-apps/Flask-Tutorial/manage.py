# Flaskrを起動して実行するためのファイル
from flaskr import app, db
from flask.ext.script import Manager

manager = Manager(app)


@manager.command
def init_db():
    db.create_all()

if __name__ == "__main__":
    manager.run()
