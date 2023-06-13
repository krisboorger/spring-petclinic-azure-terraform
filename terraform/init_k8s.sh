#!/bin/bash

az aks get-credentials --name  cluster-mature-toad --resource-group rg-picked-piranha
kubectl apply -f k8s/init-namespace/
kubectl apply -f k8s/init-services/
