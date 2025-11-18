# Deployment Environments: Staging & Production

This project uses GitHub Actions to automate deployments to two environments:

- **staging**: For pre-production testing and validation.
- **production**: For live, user-facing releases.

## Environment Setup in GitHub

1. Go to your repository on GitHub.
2. Navigate to **Settings → Environments**.
3. Create environments named `staging` and `production`.
4. For each environment, you can add:
    - **Secrets** (for sensitive values, e.g., API keys, tokens)
    - **Variables** (for non-sensitive config, e.g., ENVIRONMENT name)

### Example Secrets and Variables

**Secrets:**

- `GHCR_PAT`: GitHub Container Registry Personal Access Token (required for Docker image push)

**Variables:**

- `ENVIRONMENT`: Set to `staging` or `production` as appropriate

These are referenced in the workflow as `${{ secrets.GHCR_PAT }}` and `${{ vars.ENVIRONMENT }}`.

## Deployment Workflow

The workflow in `.github/workflows/cd.yml` will:

1. Build and push a Docker image to GHCR.
2. Deploy to **staging** (manual approval required).
3. Deploy to **production** (manual approval required, after staging).

Each environment can have its own secrets and variables, which are securely injected during deployment.
# BhealthDemo

Hi — this is my Bhealth demo project. It's a small web application I'm using to experiment with features, CI/CD, and local development workflows.

## Quick Start (Local)

Start the app and a local Postgres instance (recommended):
```bash
docker compose -f bhealthdemo/docker-compose.yml up --build
```

Or build the image and run it directly:
```bash
docker build -t bhealthdemo:local -f bhealthdemo/Dockerfile .
docker run --rm -p 3000:3000 bhealthdemo:local
```

## Project Structure

- `bhealthdemo/` — Main application with Docker, compose, and Makefile helpers
- `simple-webapp/` — Flask web app (containerized, Cloud Run ready)
  - `apps/` — Flask application source
  - `README.md` — Build and run instructions
- `.github/workflows/` — GitHub Actions CI/CD pipelines

## CI/CD Pipelines

### CI Workflow (`.github/workflows/ci.yml`)
Runs on every push and pull request:
- **Lint** — Checks Node projects if `package.json` exists
- **Test** — Runs tests and uploads coverage artifacts
- **Build** — Builds Node projects if present

### CD Workflow (`.github/workflows/cd.yml`)
Runs on push to `main` (requires manual approval):
1. **Build & Push** — Builds Docker images and pushes to GHCR (GitHub Container Registry)
   - Uses matrix strategy to support multiple apps
   - Images tagged with SHA and `latest`
2. **Deploy to Staging** — ⏳ **Requires manual approval**
   - Mock deployment (ready for gcloud/kubectl integration)
3. **Deploy to Production** — ⏳ **Requires manual approval** (after staging succeeds)
   - Mock deployment (ready for gcloud/kubectl integration)

## Setting Up Deployment Approvals

To enable manual approval gates for deployments:

### 1. Configure GitHub Environments

Go to your GitHub repository:
1. **Settings** → **Environments**
2. Create `staging` environment:
   - Click **New environment**
   - Name: `staging`
   - Add **Required reviewers** (people who can approve staging deployments)
   - Optional: Set **Deployment branches** to `main` only
3. Create `production` environment:
   - Click **New environment**
   - Name: `production`
   - Add **Required reviewers** (can be different from staging, e.g., team leads)
   - Optional: Set **Deployment branches** to `main` only

### 2. Approve Deployments

When a workflow runs and reaches a deployment job:
1. Go to **Actions** tab in your GitHub repo
2. Click the workflow run that's paused (shows "⏳ Awaiting approval")
3. Click **Review deployments** button
4. Select the environment (staging/production)
5. Choose **Approve** or **Reject**
6. If approved, the deployment job runs

Example approval flow:
```
main branch push
    ↓
Build & Push (automatic)
    ↓
⏳ Deploy to Staging (waiting for approval)
    ↓
[Reviewer approves in GitHub]
    ↓
Deploy to Staging (runs mock deployment)
    ↓
⏳ Deploy to Production (waiting for approval)
    ↓
[Reviewer approves in GitHub]
    ↓
Deploy to Production (runs mock deployment)
```

## Deploying to Cloud Run

The `simple-webapp` Flask app is ready for Google Cloud Run:

### Prerequisites
```bash
# Install gcloud CLI
brew install google-cloud-sdk

# Authenticate
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### Deploy from GHCR (after approval)
```bash
gcloud run deploy simple-webapp \
  --image ghcr.io/atnafudargaso/simple-webapp:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 8080
```

### To automate Cloud Run deployment in CD workflow:
Replace the mock deployment steps with actual `gcloud run deploy` commands in `.github/workflows/cd.yml`.

## Notes

- GitHub Actions workflows require authentication (GHCR_PAT secret) to push images
- The app reads the `PORT` environment variable for Cloud Run compatibility
- Images are pushed to GHCR with both SHA tags (for immutability) and `latest` tag
- Support for multiple apps via matrix strategy — add new apps to the matrix in `cd.yml`

For more details on each component, see `simple-webapp/README.md` and `simple-webapp/apps/README.md`.
