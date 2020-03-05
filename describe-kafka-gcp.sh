source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka describe pod kafka-$1 --kubeconfig ./kubeconfig.yaml
