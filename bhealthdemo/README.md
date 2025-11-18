# BhealthDemo — Run & deploy (my notes)

I keep the local runtime and deployment helpers here so my local setup matches CI as closely as possible.

- `bhealthdemo/Dockerfile` — multi-stage Node image: build step + small runtime image.
- `bhealthdemo/docker-compose.yml` — local stack (web + Postgres) for development.
- `bhealthdemo/Makefile` — quick commands I use: `make build`, `make up`, `make test`.

Typical commands I run:

- Build the local image:
  - `docker build -t bhealthdemo:local -f bhealthdemo/Dockerfile .`
- Start local services:
  - `docker compose -f bhealthdemo/docker-compose.yml up --build`
- Convenience targets:
  - `make -C bhealthdemo build`
  - `make -C bhealthdemo up`
  - `make -C bhealthdemo test`

Adjust ports or entrypoint if your project differs — the Dockerfile assumes `dist/server.js` after build.
