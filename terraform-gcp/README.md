# Terraform GCP Modular Environment

This repository provides a modular, multi-environment Terraform setup for Google Cloud Platform (GCP).

## Structure

- `modules/` — Reusable modules for network, compute, storage, and IAM
- `envs/` — Environment-specific configurations (dev, staging, prod)
- `scripts/` — Helper scripts
- `Makefile` — Automation for init/plan/apply/clean

## Usage

1. Edit `envs/<env>/terraform.tfvars` for your GCP project and region/zone.
2. Run `make init` to initialize all environments.
3. Run `make plan` to see the plan for all environments.
4. Run `make apply` to deploy all environments.

Each environment is isolated and can be managed independently.
