#!/bin/bash
source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

# apply prometheus patch 
kubectl -n kafka patch statefulset kafka --patch "$(cat ./prometheus/kafka-prometheus-sidecar.yaml )" --kubeconfig ./deploy/gcp/kubeconfig.yaml
