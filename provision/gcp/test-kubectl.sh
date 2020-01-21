# Generate the correct JSON credentials file
gcloud container clusters get-credentials gke-kafka-cluster --zone europe-west2

export GOOGLE_APPLICATION_CREDENTIALS=sturdy-shelter-259721.json
export KUBECONFIG=sturdy-shelter-259721.yaml

kubectl get namespaces 
