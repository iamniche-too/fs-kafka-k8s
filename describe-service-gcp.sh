./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka describe service internal-service-0 --kubeconfig ./deploy/gcp/kubeconfig.yaml
