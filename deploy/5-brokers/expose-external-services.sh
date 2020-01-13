for i in 0 1 2 3 4; do minikube service external-service-$i -n kafka --url; done
