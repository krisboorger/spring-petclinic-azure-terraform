#!/bin/bash

az aks get-credentials --name k8s --resource-group petclinic-k8s
kubectl apply -f k8s/init-namespace/
kubectl apply -f k8s/init-services/

export REPOSITORY_PREFIX=springcommunity
./scripts/deployToKubernetes.sh
