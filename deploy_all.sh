kubectl apply -f kafka-namespace.yaml
kubectl apply -f kafka-cluster-role.yaml

cd zookeeper && ./deploy_zookeeper.sh
cd ..
cd kafka && ./deploy_kafka.sh

./expose_external_services.sh
