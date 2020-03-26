#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kustomize build zookeeper-3.4.14 |\
kubectl apply -f - --kubeconfig ./kubeconfig.yaml
