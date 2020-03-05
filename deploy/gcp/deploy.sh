#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kustomize build gcp |\
kubectl apply -f - --kubeconfig ./kubeconfig.yaml
