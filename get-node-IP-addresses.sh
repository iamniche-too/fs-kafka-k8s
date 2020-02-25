./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka describe node --kubeconfig ./deploy/gcp/kubeconfig.yaml | grep "IP:"
