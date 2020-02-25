./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka describe pod kafka-$1 --kubeconfig ./deploy/gcp/kubeconfig.yaml
