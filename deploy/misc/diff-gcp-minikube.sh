diff   <(kustomize build base)   <(kustomize build overlays/gcp) > tmp
cat tmp
rm tmp
