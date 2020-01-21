export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/sturdy-shelter-259721-9cf582f8534a.json
export KUBECONFIG=./deploy/gcp/sturdy-shelter-259721.yaml

kustomize build gcp |\
kubectl apply -f - 
