source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

# get all brokers in the kafka namespace
#kubectl -n kafka get pods -o json --kubeconfig ./kubeconfig.yaml | jq '.items[].metadata.name | select (. | startswith("kafka"))' | wc -w

# 03/02 NH
kubectl -n kafka get pods -o json --field-selector=status.phase==Running --kubeconfig ./kubeconfig.yaml | jq '.items[].metadata.name | select (. | startswith("kafka"))' | wc -w
