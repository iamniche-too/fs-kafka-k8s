#!/bin/bash
source ./export-gcp-credentials.sh

kubectl get serviceaccounts --kubeconfig=./kubeconfig.yaml
