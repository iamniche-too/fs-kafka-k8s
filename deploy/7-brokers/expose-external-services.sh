for i in 0 1 2 3 4 5 6; do minikube service external-service-$i -n kafka --url; done
