#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

stern --namespace=kafka kafka.* --kubeconfig kubeconfig.yaml
#kubectl -n kafka logs kafka-2 --kubeconfig kubeconfig.yaml
