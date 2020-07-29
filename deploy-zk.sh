#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

# generate the zk configuration
echo "NUM_ZK=$1"
./zookeeper-3.4.14/generate-zookeeper-statefulset.sh $1

# apply namespace
kubectl apply -f ./namespace/A-kafka-namespace.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./namespace/A-kafka-cluster-role.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./namespace/A-kafka-network-policy.yaml --kubeconfig ./kubeconfig.yaml

# apply zookeeper
kubectl apply -f ./zookeeper-3.4.14/zookeeper-config.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./zookeeper-3.4.14/zookeeper-statefulset-generated.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./zookeeper-3.4.14/zookeeper-service.yaml --kubeconfig ./kubeconfig.yaml
