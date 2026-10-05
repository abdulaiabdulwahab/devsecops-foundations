from flask import Flask, request
import ipaddress
import subprocess

app = Flask(__name__)


@app.route("/")
def home():
    return "DevSecOps Security Lab"


@app.route("/ping")
def ping():
    supplied_host = request.args.get("host")

    try:
        # Only accept a valid IP address.
        host = str(ipaddress.ip_address(supplied_host))
    except ValueError:
        return "Invalid IP address", 400

    subprocess.run(
        ["ping", "-c", "1", host],
        check=False
    )

    return "Ping completed"


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=8080
    )