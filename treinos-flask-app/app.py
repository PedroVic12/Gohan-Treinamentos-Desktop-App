from flask import Flask, render_template
from api import api_bp

app = Flask(__name__)
app.register_blueprint(api_bp, url_prefix="/api")


@app.route("/")
def index():
    return render_template("index.html")


if __name__ == "__main__":
    print("Iniciando o servidor Flask em http://localhost:5000")
    app.run(debug=True, port=5000)
