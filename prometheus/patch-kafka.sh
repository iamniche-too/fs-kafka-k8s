export GOOGLE_APPLICATION_CREDENTIALS=../deploy/gcp/terraform-test-262517-b4ff2f611b21.json
(cd .. && ./deploy/gcp/generate-cluster-connection-yaml.sh)

# apply prometheus patch 
kubectl -n kafka patch statefulset kafka --patch "$(cat ./kafka-prometheus-sidecar.yaml )" --kubeconfig ../deploy/gcp/kubeconfig.yaml
