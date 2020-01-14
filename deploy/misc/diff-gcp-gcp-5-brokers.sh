diff   <(kustomize build 5-brokers)   <(kustomize build gcp-5-brokers) > tmp
cat tmp
rm tmp
