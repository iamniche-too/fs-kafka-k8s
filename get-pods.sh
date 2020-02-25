./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka get pods --kubeconfig ./deploy/gcp/kubeconfig.yaml
