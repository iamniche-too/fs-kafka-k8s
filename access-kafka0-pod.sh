./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka exec -it kafka-0 --kubeconfig ./deploy/gcp/kubeconfig.yaml -- /bin/bash
