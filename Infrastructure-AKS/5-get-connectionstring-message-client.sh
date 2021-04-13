
#!/bin/bash

# Use this connection string for the message client

az servicebus queue authorization-rule keys list \
  -g $RG_NAME \
  --namespace-name $SBN_NAME \
  --queue-name $QUEUENAME_INA \
  -n publisher-app \
  --query "primaryConnectionString" \
  -o tsv

