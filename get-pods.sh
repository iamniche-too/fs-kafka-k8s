#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka get pods -o wide --kubeconfig ./kubeconfig.yaml
#kubectl get pods --all-namespaces -o wide --kubeconfig ./kubeconfig.yaml
