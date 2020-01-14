export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/sturdy-shelter-259721-badaf880d3b4.json
export KUBECONFIG=./deploy/gcp/gke-sturdy-shelter-259721.yaml

kubectl delete clusterrole node-reader
kubectl delete clusterrolebinding kafka-node-reader
kubectl delete ns kafka 
