export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/terraform-test-262517-b4ff2f611b21.json
./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl delete clusterrole node-reader --kubeconfig ./deploy/gcp/kubeconfig.yaml
kubectl delete clusterrolebinding kafka-node-reader --kubeconfig ./deploy/gcp/kubeconfig.yaml
kubectl delete ns kafka --kubeconfig ./deploy/gcp/kubeconfig.yaml
