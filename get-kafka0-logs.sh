./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka logs kafka-$1 --kubeconfig ./deploy/gcp/kubeconfig.yaml
