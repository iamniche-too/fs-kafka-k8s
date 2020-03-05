source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka scale statefulsets kafka --replicas=$1 --kubeconfig ./deploy/gcp/kubeconfig.yaml
