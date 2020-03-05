#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka logs kafka-$1 --kubeconfig ./kubeconfig.yaml
