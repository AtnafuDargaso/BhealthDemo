# apps (Flask application)

This folder contains the small Flask application used by `simple-webapp`.

## Files

- `main.py` — tiny Flask app that serves on port 8080.
- `requirements.txt` — Python dependencies (Flask 3.0.0).

## Run locally (without Docker)

Recommend creating and using a virtual environment:

```zsh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python main.py
```

The app will listen on port 8080 by default. Open http://localhost:8080 to view it.

## Notes

- Keep `requirements.txt` in sync with the Dockerfile `COPY` line used during build.
- For development, prefer `FLASK_ENV=development` and auto-reload tooling (e.g., `flask --app main --debug run`), but the simple `main.py` is sufficient for demonstration.
