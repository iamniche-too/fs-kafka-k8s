#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl delete clusterrole node-reader --kubeconfig ./kubeconfig.yaml
kubectl delete clusterrolebinding kafka-node-reader --kubeconfig ./kubeconfig.yaml

kubectl delete ns kafka --kubeconfig ./kubeconfig.yaml
