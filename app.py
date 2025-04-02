# app.py
from flask import Flask
import os
import datetime

app = Flask(__name__)

@app.route('/')
def hello_world():
    # Get current time for dynamism
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    # Example of reading an environment variable (useful later)
    app_version = os.environ.get('APP_VERSION', '1.0.0') 
    return f"<h1>Hello World!</h1><p>Version: {app_version}</p><p>Served at: {now}</p>"

if __name__ == '__main__':
    # Runs the app on localhost, port 5000 by default
    # Use host='0.0.0.0' to make it accessible outside the container later
    app.run(debug=True, host='0.0.0.0', port=5000)