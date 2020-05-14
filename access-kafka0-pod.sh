#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka exec -it kafka-0 --kubeconfig ./kubeconfig.yaml -- /bin/bash
