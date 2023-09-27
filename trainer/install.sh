#!/bin/bash

set -e

ARGOCD_NAMESPACE="argocd"
ARGOCD_INSTALL_FILE="argocd-install.yaml"
ARGO_CD_VERSION="v2.7.6"

# Apply the namespace configuration
kubectl apply -f ns-argocd.yaml || { echo "Failed to apply the namespace"; exit 1; }

# Install Argo CD
echo "Installing Argo CD ${ARGO_CD_VERSION}"
curl -sSL -o $ARGOCD_INSTALL_FILE "https://raw.githubusercontent.com/argoproj/argo-cd/${ARGO_CD_VERSION}/manifests/install.yaml"
kubectl apply -n $ARGOCD_NAMESPACE -f $ARGOCD_INSTALL_FILE

# Wait for Argo CD to be ready
echo "Waiting for Argo CD to be ready"
kubectl -n $ARGOCD_NAMESPACE wait --for=condition=available --timeout=600s deployment/argocd-server
echo "Argo CD is ready"

# Fetch Argo CD password
echo "Fetching Argo CD password"
password=$(kubectl -n $ARGOCD_NAMESPACE get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "Argo CD password: $password"

# Expose Argo CD server with type NodePort
echo "Exposing Argo CD server with type NodePort"
kubectl patch svc argocd-server -n $ARGOCD_NAMESPACE -p '{"spec": {"type": "NodePort"}}'


# Install repositories
echo "Installing repositories"
kubectl apply -f repositories/ -n $ARGOCD_NAMESPACE

# Install bootstrap application
echo "Installing bootstrap application"
kubectl apply -f ../bootstrap.yaml 

