#!/usr/bin/env bash
set -euo pipefail

POLICY_REPO="git::https://github.com/surath-majumdar/platform-governance-policies.git//policies/app"
IMAGE_TAG="${1:-1.0.0}"

echo "1. Running Centralized App Security & Repo Standardization Front-Gate (OPA/Conftest)..."
conftest test Dockerfile catalog-info.yaml --update "$POLICY_REPO"

echo "2. Policies Passed! Building Docker Image (dual-repo-hello-world-3:${IMAGE_TAG})..."
docker build -t "dual-repo-hello-world-3:${IMAGE_TAG}" .
echo "Build complete."