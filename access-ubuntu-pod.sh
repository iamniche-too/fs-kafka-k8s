source ./export-gcp-credentials.sh
./generate-cluster-connection-yaml.sh

kubectl -n kafka run access --rm -ti --image ubuntu /bin/bash --kubeconfig ./kubeconfig.yaml
