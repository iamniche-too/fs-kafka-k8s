source ./export-gcp-credentials.sh
./deploy/gcp/generate-cluster-connection-yaml.sh

# get all brokers in the kafka namespace
kubectl -n kafka get pods -o json --kubeconfig ./deploy/gcp/kubeconfig.yaml | jq '.items[].metadata.name | select (. | startswith("kafka"))' | wc -w
