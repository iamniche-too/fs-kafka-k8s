kubectl delete -f kafka-namespace.yaml
kubectl delete -f kafka-cluster-role.yaml

cd zookeeper && ./undeploy_zookeeper.sh
cd ..
cd kafka && ./undeploy_kafka.sh
