#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

# apply namespace
kubectl apply -f ./namespace/A-kafka-namespace.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./namespace/A-kafka-cluster-role.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./namespace/A-kafka-network-policy.yaml --kubeconfig ./kubeconfig.yaml

# apply zookeeper
kubectl apply -f ./zookeeper-3.4.14/zookeeper-config.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./zookeeper-3.4.14/zookeeper-statefulset.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./zookeeper-3.4.14/zookeeper-service.yaml --kubeconfig ./kubeconfig.yaml
