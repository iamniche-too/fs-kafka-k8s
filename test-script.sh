#! /bin/bash

COMMAND="kubectl -n kafka get service external-service-0 -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' --kubeconfig ./deploy/gcp/kubeconfig.yaml"

while [ -z "`kubectl -n kafka get service external-service-0 -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' --kubeconfig ./deploy/gcp/kubeconfig.yaml`" ]; do echo "waiting for IP..."; sleep 10; done

IP=`kubectl -n kafka get service external-service-0 -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' --kubeconfig ./deploy/gcp/kubeconfig.yaml`

echo $IP
