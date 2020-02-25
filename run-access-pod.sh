./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka run access --rm -ti --image ubuntu /bin/bash --kubeconfig ./deploy/gcp/kubeconfig.yaml
