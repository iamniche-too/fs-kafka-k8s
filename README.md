# fs-kafka-k8s

Getting started with Kafka on (local) K8S.

#QuickStart
Install minikube then
$> minikube start

...

🏄  Done! kubectl is now configured to use "minikube"

$> cd fs-kafka-k8s

$> ./deploy_all.sh

service/zoo0 created

persistentvolumeclaim/zoo0-claim0 created

persistentvolumeclaim/zoo0-claim1 created

deployment.apps/zoo0 created

service/kafka-service created

statefulset.apps/kafka created

This will start both the Zookeeper instance and 3x Kafka brokers.

Ensure it is all running correctly using:

$> kubectl get pods

NAME                    READY   STATUS    RESTARTS   AGE

kafka-0                 1/1     Running   1          15s

kafka-1                 1/1     Running   0          11s

kafka-2                 1/1     Running   0          7s

zoo0-74f64c4578-qwb7f   1/1     Running   0          16s

