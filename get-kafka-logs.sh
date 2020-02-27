#!/bin/bash
source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka logs kafka-$1 -c kafka-prometheus-sidecar --kubeconfig ./deploy/gcp/kubeconfig.yaml
