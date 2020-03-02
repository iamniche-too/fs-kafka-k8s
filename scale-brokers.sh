source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka scale statefulsets kafka --replicas=$1 --kubeconfig ./deploy/gcp/kubeconfig.yaml
