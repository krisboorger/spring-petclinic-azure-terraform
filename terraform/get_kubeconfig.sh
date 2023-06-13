#!/bin/bash
echo "$(terraform output kube_config)" | grep -v EOT > ./azurek8s
export KUBECONFIG=$(pwd)/azurek8s
