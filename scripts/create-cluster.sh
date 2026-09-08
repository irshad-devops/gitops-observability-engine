#!/usr/bin/env bash
set -euo pipefail

kind delete cluster --name gitops-lab 2>/dev/null || true
kind create cluster --config kind/kind-config.yaml

kubectl cluster-info
kubectl get nodes
