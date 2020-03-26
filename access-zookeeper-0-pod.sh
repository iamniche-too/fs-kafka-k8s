./generate-cluster-connection-yaml.sh
source ./export-gcp-credentials.sh

kubectl -n kafka exec -it zookeeper-0 --kubeconfig ./kubeconfig.yaml -- /bin/sh
