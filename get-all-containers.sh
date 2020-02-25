./deploy/gcp/generate-cluster-connection-yaml.sh

kubectl -n kafka get po -o jsonpath='{range .items[*]}{"pod: "}{.metadata.name}{"\n"}{range .spec.containers[*]}{"\tname: "}{.name}{"\n\timage: "}{.image}{"\n"}{end}' --kubeconfig ./deploy/gcp/kubeconfig.yaml
