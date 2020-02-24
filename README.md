# fs-kafka-k8s

Getting started with Kafka on GCP K8S

source ./deploy/gcp/export-google-credentials.sh
./deploy/gcp/deploy.sh

Getting started with Kafka on local K8S (i.e. minikube).

## QuickStart

Install minikube then

```
$> minikube start\n
...
🏄  Done! kubectl is now configured to use "minikube"
```

```
$> cd fs-kafka-k8s
$> ./deploy/minikube/deploy-minikube.sh
namespace/kafka created
clusterrole.rbac.authorization.k8s.io/node-reader created
clusterrolebinding.rbac.authorization.k8s.io/kafka-node-reader created
service/zoo0 created
persistentvolumeclaim/zoo0-claim0 created
persistentvolumeclaim/zoo0-claim1 created
deployment.apps/zoo0 created
configmap/kafka-config created
service/kafka-service created
statefulset.apps/kafka created
poddisruptionbudget.policy/kafka-pdb created
service/external-service-0 created
service/external-service-1 created
service/external-service-2 created

$> ./deploy/minikube/expose-external-services.sh
http://192.168.99.108:32400
http://192.168.99.108:32401
http://192.168.99.108:32402
```

These URLs are the Kafka broker endpoints. Make a note of them for later on.

This will start both the Zookeeper instance and the Kafka brokers.

Ensure it is all running as expected using:

```
$> kubectl -n kafka get pods
NAME                    READY   STATUS    RESTARTS   AGE
kafka-0                 1/1     Running   1          15s
kafka-1                 1/1     Running   0          11s
kafka-2                 1/1     Running   0          7s
zoo0-74f64c4578-qwb7f   1/1     Running   0          16s
```

To send a test message to/from the brokers, use the following:

Note - the IP:port list is the Kafka broker endpoints noted earlier.

```
cd ~/workspace/kafka_2.12-2.3.0/bin

./kafka-console-producer.sh --broker-list 192.168.99.108:32400,192.168.99.108:32401,192.168.99.108:32402 --topic test1

(type) This is a message

./kafka-console-consumer.sh --bootstrap-server 192.168.99.108:32400,192.168.99.108:32401,192.168.99.108:32402 --topic test1 --from-beginning

This is a message
```

IMPORTANT NOTE: Kafka will error with LEADER_NOT_AVAILABLE if the topic does not exist. But it still should work ;) You could always create the topic first.

To used the (throttled) python consumer and producers use the following:

```
cd fs-python
source env/bin/activate
python consumer.py (in one terminal)
python producer.py (in another terminal)
```

You should see the following output:

```
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
Throughput in window: 75 MB/s
```
