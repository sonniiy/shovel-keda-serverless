#!/bin/bash

az aks get-credentials -g $RG_NAME -n $AKS_NAME

helm repo add kedacore https://kedacore.github.io/charts
helm repo update

echo "creating keda namespace in kubernetes"
kubectl create namespace keda
echo
echo 'Installing KEDA using Helm 3'

helm install keda kedacore/keda --namespace keda
echo
echo 'DONE'