./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka get pods $1 -o jsonpath={.spec.containers[*].name} --kubeconfig ./deploy/gcp/kubeconfig.yaml

