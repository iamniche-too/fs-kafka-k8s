source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka get pods -o jsonpath={.spec.containers[*].name} --kubeconfig ./kubeconfig.yaml

