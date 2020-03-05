source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl get namespaces --kubeconfig=./kubeconfig.yaml
