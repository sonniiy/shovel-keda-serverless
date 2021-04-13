#!/bin/bash

# Setting up infrstructure for second customer

QUEUENAME_INB=senderB
QUEUENAME_OUTB=receiverB
AZFN_TRIGGER_RULE="azfn-trigger"
AZFN_BINDING_RULE="azfn-binding"
KEDA_SCALER_RULE="keda-scaler"
PUBLISHER_RULE="publisher-app"


echo 'Creating Azure Service Bus Queue (inbound)'
# Create inbound Queue
az servicebus queue create -n $QUEUENAME_INB --namespace-name $SBN_NAME -g $RG_NAME
echo
echo 'Creating Azure Service Bus Queue (outbound)'
# Create outbound queue
az servicebus queue create -n $QUEUENAME_OUTB --namespace-name $SBN_NAME -g $RG_NAME
echo
echo 'Creating Azure Service Bus Authorization Rules'
# Create Authorization Rule for Azure ServiceBus Queue
az servicebus queue authorization-rule create --namespace-name $SBN_NAME -g $RG_NAME --queue-name $QUEUENAME_INB --rights Listen Send Manage -n $KEDA_SCALER_RULE
az servicebus queue authorization-rule create --namespace-name $SBN_NAME -g $RG_NAME --queue-name $QUEUENAME_INB --rights Listen -n $AZFN_TRIGGER_RULE
az servicebus queue authorization-rule create --namespace-name $SBN_NAME -g $RG_NAME --queue-name $QUEUENAME_OUTB --rights Send -n $AZFN_BINDING_RULE
az servicebus queue authorization-rule create --namespace-name $SBN_NAME -g $RG_NAME --queue-name $QUEUENAME_INB --rights Send -n $PUBLISHER_RULE
echo
echo "Generated all Authorization Rules"
# you can print the connection string using
echo 'Connection String for KEDA SCALER:'
echo $(az servicebus queue authorization-rule keys list -g $RG_NAME --namespace-name $SBN_NAME --queue-name $QUEUENAME_INB -n $KEDA_SCALER_RULE --query "primaryConnectionString" -o tsv)
echo
echo 'Connection String for Azure Functions Trigger:'
echo $(az servicebus queue authorization-rule keys list -g $RG_NAME --namespace-name $SBN_NAME --queue-name $QUEUENAME_INB -n $AZFN_TRIGGER_RULE --query "primaryConnectionString" -o tsv)
echo
echo 'Connection String for Azure Functions Output Binding:'
echo $(az servicebus queue authorization-rule keys list -g $RG_NAME --namespace-name $SBN_NAME --queue-name $QUEUENAME_OUTB -n $AZFN_BINDING_RULE --query "primaryConnectionString" -o tsv)
echo
echo 'Connection String for .NET Core Publisher App:'
echo $(az servicebus queue authorization-rule keys list -g $RG_NAME --namespace-name $SBN_NAME --queue-name $QUEUENAME_INB -n $PUBLISHER_RULE --query "primaryConnectionString" -o tsv)
echo