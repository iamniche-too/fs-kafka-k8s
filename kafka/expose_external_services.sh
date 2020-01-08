for i in 0 1 2; do minikube service external-service-$i -n kafka --url; done
