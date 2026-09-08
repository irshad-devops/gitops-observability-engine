import os
import time
from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "portfolio")
DB_USER = os.getenv("DB_USER", "portfolio")
DB_PASSWORD = os.getenv("DB_PASSWORD", "portfolio123")


def get_db():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
    )


@app.get("/")
def home():
    return jsonify(
        service="GitOps Observability API",
        version=os.getenv("APP_VERSION", "dev"),
        message="Hello from Kubernetes GitOps!",
    )


@app.get("/health")
def health():
    return jsonify(status="healthy")


@app.get("/db")
def db_check():
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()[0]
        cur.close()
        conn.close()
        return jsonify(status="connected", database="postgresql", version=version)
    except Exception as exc:
        return jsonify(status="error", error=str(exc)), 500


@app.get("/slow")
def slow():
    time.sleep(2)
    return jsonify(status="completed")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
