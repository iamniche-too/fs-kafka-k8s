source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl apply -f ./namespace/A-kafka-namespace.yaml --kubeconfig ./kubeconfig.yaml
kubectl -n kafka run access --rm -ti --image wurstmeister/kafka /bin/bash --kubeconfig ./kubeconfig.yaml
