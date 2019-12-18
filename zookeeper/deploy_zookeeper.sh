kubectl create -f zookeeper/zoo0-service.yaml
kubectl create -f zookeeper/zoo0-claim0-persistentvolumeclaim.yaml
kubectl create -f zookeeper/zoo0-claim1-persistentvolumeclaim.yaml
kubectl create -f zookeeper/zoo0-deployment.yaml
