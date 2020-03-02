source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka get pods -o jsonpath={.spec.containers[*].name} --kubeconfig ./deploy/gcp/kubeconfig.yaml

