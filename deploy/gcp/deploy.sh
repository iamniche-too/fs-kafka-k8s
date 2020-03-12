#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

# generate the stateful set with the specified number of partitions
./kafka-statefulset-generate.sh $1 

kustomize build gcp |\
kubectl apply -f - --kubeconfig ./kubeconfig.yaml
