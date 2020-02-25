./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka get services --kubeconfig ./deploy/gcp/kubeconfig.yaml
