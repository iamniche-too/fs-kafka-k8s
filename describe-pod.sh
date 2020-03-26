source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka describe pod $1 --kubeconfig ./kubeconfig.yaml
