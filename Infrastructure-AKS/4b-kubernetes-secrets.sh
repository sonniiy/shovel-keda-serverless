#!/bin/bash

NAMESPACE=customerb

# create the k8s demo namespace
kubectl create namespace $NAMESPACE

# Secret for KEDA scaler

# grab connection string from Azure Service Bus
KEDA_SCALER_CONNECTION_STRING=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_INB \
  -n keda-scaler \
  --query "primaryConnectionString" \
  -o tsv)

# create the kubernetes secret
kubectl create secret generic workload-keda-auth \
  --from-literal KedaScaler=$KEDA_SCALER_CONNECTION_STRING \
  --namespace $NAMESPACE


# Secret for function

AZFN_TRIGGER_CONNECTION_STRING=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_INB \
  -n azfn-trigger \
  --query "primaryConnectionString" \
  -o tsv)

AZFN_OUTPUT_BINDING_CONNECTION_STRING_A=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name receivera \
  -n azfn-binding \
  --query "primaryConnectionString" \
  -o tsv)

AZFN_OUTPUT_BINDING_CONNECTION_STRING_B=$(az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name receiverb \
  -n azfn-binding \
  --query "primaryConnectionString" \
  -o tsv)

# create the secret
kubectl create secret generic workload-func-auth \
  --from-literal InboundQueue=${AZFN_TRIGGER_CONNECTION_STRING%EntityPath*} \
  --from-literal receivera=${AZFN_OUTPUT_BINDING_CONNECTION_STRING_A%EntityPath*} \
  --from-literal receiverb=${AZFN_OUTPUT_BINDING_CONNECTION_STRING_B%EntityPath*} \
  --namespace $NAMESPACE


kubectl delete secret workload-func-auth -n workload