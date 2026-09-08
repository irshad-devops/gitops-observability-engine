# GitOps & Observability Engine

A production-style Kubernetes portfolio project demonstrating:

- Dockerized Flask API
- PostgreSQL StatefulSet + PersistentVolumeClaim
- Kubernetes Deployments, Services, ConfigMap and Secret
- Helm packaging
- GitHub Actions CI/CD
- Trivy container scanning
- Argo CD GitOps continuous delivery
- NGINX Ingress
- Prometheus + Grafana observability
- Metrics Server + Horizontal Pod Autoscaler
- Kubernetes NetworkPolicies
- Kind local Kubernetes cluster

## Architecture

```text
Developer
   |
   v
GitHub
   |
   +--> GitHub Actions
   |      |- pytest
   |      |- Docker build
   |      |- Trivy scan
   |      |- Push image to Docker Hub
   |      `- Update Helm image tag
   |
   v
GitOps files in Git
   |
   v
Argo CD
   |
   v
Kind Kubernetes Cluster
   |
   +--> Ingress
   |      |
   |      +--> frontend
   |      `--> backend
   |
   +--> PostgreSQL
   |
   +--> Prometheus --> Grafana
   |
   `--> HPA
```

## Prerequisites

Ubuntu/Linux:

- Docker
- kubectl
- Kind
- Helm
- Git
- A Docker Hub account
- A GitHub repository

## Quick start

```bash
./scripts/create-cluster.sh
./scripts/install-platform.sh
./scripts/install-argocd.sh
./scripts/deploy-argocd-app.sh
```

Then:

```bash
kubectl get pods -n portfolio
kubectl get ingress -n portfolio
```

For local access, add:

```text
127.0.0.1 gitops.local
```

to `/etc/hosts`, then open:

```text
http://gitops.local
```

## GitHub Actions secrets

Create these repository secrets:

```text
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
```

The workflow builds:

```text
<DOCKERHUB_USERNAME>/gitops-demo-api:<git-sha>
```

and updates the Helm image tag.

## Important security note

The included Kubernetes Secret is for a local portfolio lab only. Never commit real production passwords, tokens, private keys or cloud credentials.

For a stronger production version, replace the demo Secret with Sealed Secrets, External Secrets Operator, or a cloud secret manager.

## Portfolio demonstrations

1. Change application code.
2. Push to GitHub.
3. GitHub Actions tests and scans the image.
4. Image is pushed to Docker Hub.
5. Workflow updates the Helm image tag.
6. Argo CD detects the Git change.
7. Argo CD deploys the new version.
8. Prometheus collects metrics.
9. Grafana displays cluster/application metrics.
10. HPA scales the API when CPU usage increases.
11. NetworkPolicies restrict unnecessary traffic.

## Useful commands

```bash
kubectl get all -n portfolio
kubectl get pvc -n portfolio
kubectl get hpa -n portfolio
kubectl get ingress -n portfolio
kubectl get networkpolicy -n portfolio
kubectl -n argocd get applications
```
