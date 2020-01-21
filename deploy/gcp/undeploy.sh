export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/sturdy-shelter-259721-9cf582f8534a.json
export KUBECONFIG=./deploy/gcp/sturdy-shelter-259721.yaml

kubectl delete clusterrole node-reader
kubectl delete clusterrolebinding kafka-node-reader
kubectl delete ns kafka 
