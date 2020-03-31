./generate-cluster-connection-yaml.sh
source ./export-gcp-credentials.sh

kubectl describe nodes --kubeconfig ./kubeconfig.yaml
