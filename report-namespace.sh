#!/bin/bash

source ./export-gcp-credentials.sh

kubectl api-resources --verbs=list --namespaced -o name --kubeconfig=./kubeconfig.yaml | xargs -n 1 kubectl get --show-kind --ignore-not-found -n kafka --kubeconfig=./kubeconfig.yaml 
