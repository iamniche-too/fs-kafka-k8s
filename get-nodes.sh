./generate-cluster-connection-yaml.sh
source ./export-gcp-credentials.sh

kubectl get nodes -owide --kubeconfig ./kubeconfig.yaml
