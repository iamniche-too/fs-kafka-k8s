kubectl delete -f kafka-headless-service.yaml
kubectl delete -f kafka-statefulset.yaml
kubectl delete persistentvolumeclaim data-kafka-0 
kubectl delete persistentvolumeclaim data-kafka-1 
kubectl delete persistentvolumeclaim data-kafka-2 
