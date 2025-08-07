from flask import Flask, Response
import requests
import os

app = Flask(__name__)

API_KEY = os.environ.get("OWM_API_KEY")
CITY = "Tallinn"
URL = f"http://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric"

@app.route("/metrics")
def metrics():
    try:
        response = requests.get(URL)
        data = response.json()
        temp = data["main"]["temp"]
        metric = f"tallinn_temperature_celsius {temp}\n"
        return Response(metric, mimetype="text/plain")
    except Exception as e:
        return Response(f"# Error: {str(e)}\n", mimetype="text/plain")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
