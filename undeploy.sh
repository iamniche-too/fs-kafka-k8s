#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl delete clusterrole node-reader --kubeconfig ./kubeconfig.yaml
kubectl delete clusterrolebinding kafka-node-reader --kubeconfig ./kubeconfig.yaml

# Explicitly delete external services (might not be required)
#kubectl -n kafka delete service external-service-0 --kubeconfig ./kubeconfig.yaml
#kubectl -n kafka delete service external-service-1 --kubeconfig ./kubeconfig.yaml
#kubectl -n kafka delete service external-service-2 --kubeconfig ./kubeconfig.yaml

kubectl delete ns kafka --kubeconfig ./kubeconfig.yaml
