diff   <(kustomize build .)   <(kustomize build 5-brokers) > tmp
cat tmp
rm tmp
