source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl version --kubeconfig ./kubeconfig.yaml
