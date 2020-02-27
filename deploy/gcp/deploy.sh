#!/bin/bash
source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

kustomize build gcp |\
kubectl apply -f - --kubeconfig ./deploy/gcp/kubeconfig.yaml
