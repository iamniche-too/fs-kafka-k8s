export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/terraform-test-262517-b4ff2f611b21.json
export KUBECONFIG=./deploy/gcp/terraform-test-262517-b4ff2f611b21.yaml

kustomize build gcp |\
kubectl apply -f - 
