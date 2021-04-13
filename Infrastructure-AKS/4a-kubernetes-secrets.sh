#!/bin/bash

CR_NAME=functions$RANDOM
NAMESPACE=customera

# create the k8s demo namespace
kubectl create namespace $NAMESPACE

# Secret for KEDA scaler

# grab connection string from Azure Service Bus
KEDA_SCALER_CONNECTION_STRING=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_INA \
  -n $KEDA_SCALER_RULE \
  --query "primaryConnectionString" \
  -o tsv)

# create the kubernetes secret
kubectl create secret generic workload-keda-auth \
  --from-literal KedaScaler=$KEDA_SCALER_CONNECTION_STRING \
  --namespace $NAMESPACE


# Secrets for function

AZFN_TRIGGER_CONNECTION_STRING=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_INA \
  -n $AZFN_TRIGGER_RULE \
  --query "primaryConnectionString" \
  -o tsv)

AZFN_OUTPUT_BINDING_CONNECTION_STRING_A=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_OUTA \
  -n azfn-binding \
  --query "primaryConnectionString" \
  -o tsv)

AZFN_OUTPUT_BINDING_CONNECTION_STRING_B=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_OUTB \
  -n $AZFN_BINDING_RUL \
  --query "primaryConnectionString" \
  -o tsv)

# create the secret
kubectl create secret generic workload-func-auth \
  --from-literal tenant-out-connection=${AZFN_TRIGGER_CONNECTION_STRING%EntityPath*} \
  --from-literal receivera=${AZFN_OUTPUT_BINDING_CONNECTION_STRING_A%EntityPath*} \
  --from-literal receiverb=${AZFN_OUTPUT_BINDING_CONNECTION_STRING_B%EntityPath*} \
  --namespace $NAMESPACE


# TODO Add Redis Connection String as secrets

