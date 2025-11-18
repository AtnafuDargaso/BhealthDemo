# simple-webapp

A tiny Flask-based web app packaged into a Docker image.

## Prerequisites

- Docker (or a Docker-compatible runtime such as Colima)

## Build (local)

From the `simple-webapp` directory:

```zsh
# build image (local tag)
docker build -t simple-webapp .

# or use Makefile target (uses registry tag configured in Makefile)
make build
```

## Run (local)

```zsh
# run the image and map port 8080
docker run --rm -p 8080:8080 simple-webapp

# or using Makefile target
make run
```

Then open http://localhost:8080 in your browser.

## Notes

- The Dockerfile uses `apps/` as the application directory. If you change the folder name, update the Dockerfile accordingly.
- To avoid the legacy builder deprecation message, install Docker Buildx/BuildKit or run `docker buildx install`.

## Pushing to a registry

If you want the image pushed to a registry, update the image name in `Makefile` (or tag locally) and run:

```zsh
docker tag simple-webapp yourregistry/yourrepo/simple-webapp:tag
docker push yourregistry/yourrepo/simple-webapp:tag
```
