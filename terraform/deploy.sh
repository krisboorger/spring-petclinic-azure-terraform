#!/bin/bash

cd terraform
./create_cluster.sh
./get_kubeconfig.sh
cd ..
./terraform/init_k8s.sh
kubectl get svc -n spring-petclinic
