diff   <(kustomize build .)   <(kustomize build gcp) > tmp
cat tmp
rm tmp
