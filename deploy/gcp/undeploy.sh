./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl delete clusterrole node-reader --kubeconfig ./deploy/gcp/kubeconfig.yaml
kubectl delete clusterrolebinding kafka-node-reader --kubeconfig ./deploy/gcp/kubeconfig.yaml

# Explicitly delete external services (might not be required)
#kubectl -n kafka delete service external-service-0 --kubeconfig ./deploy/gcp/kubeconfig.yaml
#kubectl -n kafka delete service external-service-1 --kubeconfig ./deploy/gcp/kubeconfig.yaml
#kubectl -n kafka delete service external-service-2 --kubeconfig ./deploy/gcp/kubeconfig.yaml

kubectl delete ns kafka --kubeconfig ./deploy/gcp/kubeconfig.yaml
