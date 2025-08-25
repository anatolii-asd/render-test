from flask import Flask
from datetime import datetime
import os

app = Flask(__name__)

@app.route('/')
def get_current_time():
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S UTC")
    return f"current time is {current_time}"

@app.route('/health')
def health_check():
    return "OK", 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)
