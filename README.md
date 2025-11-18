# BhealthDemo

Hi — this is my Bhealth demo project. It's a small web application I'm using to experiment with features, CI/CD, and local development workflows.

Quick start (local):

- Start the app and a local Postgres instance (recommended):
	- `docker compose -f bhealthdemo/docker-compose.yml up --build`
- Or build the image and run it directly:
	- `docker build -t bhealthdemo:local -f bhealthdemo/Dockerfile .`
	- `docker run --rm -p 3000:3000 bhealthdemo:local`

Notes:

- Check the `bhealthdemo/` folder for Docker, compose, and Makefile helpers.
- GitHub Actions workflows are in `.github/workflows/` — CI runs lint/test/build, and CD builds & pushes container images.

If you want me to wire up deployment to a cloud or add a `.env.example`, tell me what provider or env vars you need.
