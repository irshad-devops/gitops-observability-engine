#!/usr/bin/env bash
set -euo pipefail

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --namespace argocd \
  --for=condition=available deployment/argocd-server \
  --timeout=300s

echo
echo "Argo CD installed."
echo "Get the initial admin password with:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
echo
echo "Open Argo CD locally with:"
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443"
