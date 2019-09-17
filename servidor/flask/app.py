from flask import Flask
from api.event import event

app = Flask(__name__)

app.register_blueprint(event)

if __name__ == '__main__':
    app.run(debug=True)