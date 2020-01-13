diff   <(kustomize build 5-brokers)   <(kustomize build 7-brokers) > tmp
cat tmp
rm tmp
