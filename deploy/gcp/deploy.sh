export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/sturdy-shelter-259721-badaf880d3b4.json
export KUBECONFIG=./deploy/gcp/gke-sturdy-shelter-259721.yaml

kustomize build gcp |\
kubectl apply -f - 
