#!/bin/bash

echo 'Creating Azure Kubernetes Service' $AKS_NAME
az aks create -n $AKS_NAME -g $RG_NAME -l $LOCATION --node-count 1 --generate-ssh-keys --attach-acr $ACR_NAME 
echo
echo
echo 'DONE'