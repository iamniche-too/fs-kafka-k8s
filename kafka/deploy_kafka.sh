kubectl create -f kafka-headless-service.yaml
kubectl create -f kafka-statefulset.yaml
kubectl create -f kafka-pdb.yaml
kubectl create -f kafka-external-service.yaml
