#!/usr/bin/env bash
set -euo pipefail

# IMPORTANT:
# Replace YOUR_GITHUB_USERNAME/YOUR_REPOSITORY below with your real repository.
REPO_URL="${REPO_URL:-https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY.git}"

sed "s#REPLACE_REPO_URL#$REPO_URL#g" argocd/application.yaml | kubectl apply -f -

echo
echo "Argo CD Application created."
kubectl get application -n argocd
