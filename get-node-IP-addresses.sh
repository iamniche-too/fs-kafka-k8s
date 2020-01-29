export GOOGLE_APPLICATION_CREDENTIALS=./deploy/gcp/terraform-test-262517-b4ff2f611b21.json

kubectl -n kafka describe node --kubeconfig ./deploy/gcp/kubeconfig.yaml | grep "IP:"
