kubectl create -f kafka-config.yaml
kubectl create -f kafka-headless-service.yaml
kubectl create -f kafka-statefulset.yaml
kubectl create -f kafka-pdb.yaml
kubectl create -f kafka0-external-service.yaml
kubectl create -f kafka1-external-service.yaml
kubectl create -f kafka2-external-service.yaml
