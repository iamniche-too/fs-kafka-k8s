#!/bin/bash
source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

# generate the stateful set with the specified number of partitions and number of brokers
./kafka/kafka-statefulset-generate.sh $1 $2

# apply kafka
kubectl apply -f ./kafka/local-provisioner.yaml --kubeconfig ./kubeconfig.yaml
kubectl apply -f ./kafka/local-storage.yaml --kubeconfig ./kubeconfig.yaml
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
