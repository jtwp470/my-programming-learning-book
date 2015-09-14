# FlaskとプラグインのSQLAlchemyを生成
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config.from_object('flaskr.config')
app.debug = True

db = SQLAlchemy(app)

import flaskr.views
