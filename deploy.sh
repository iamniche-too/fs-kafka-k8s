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

echo "Waiting 40s for ZK to start..."

sleep 40 

# generate the stateful set with the specified number of partitions
./kafka/kafka-statefulset-generate.sh $1 

# apply kafka
kubectl apply -f ./kafka/kafka-config.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/kafka-headless-service.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/kafka-pdb.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/kafka-statefulset-generated.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-0.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-1.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-2.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-3.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-4.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-5.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/internal-service-6.yaml --kubeconfig ./kubeconfig.yaml
