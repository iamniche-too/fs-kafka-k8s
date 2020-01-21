export GOOGLE_APPLICATION_CREDENTIALS=./provision/gcp/sturdy-shelter-259721-badaf880d3b4.json
export KUBECONFIG=./provision/gcp/sturdy-shelter-259721.yaml

kustomize build gcp |\
kubectl apply -f - 
