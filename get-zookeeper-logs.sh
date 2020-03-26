#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

stern --namespace=kafka zookeeper.* --kubeconfig kubeconfig.yaml
#kubectl -n=kafka logs zookeeper-1 -c init-config --kubeconfig kubeconfig.yaml
#kubectl -n=kafka logs zookeeper-0 --kubeconfig kubeconfig.yaml
