import os
from flask import Flask

app = Flask(__name__)

@app.get("/")
def home():
    return {"message": "Hello from simple web application!"}

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
