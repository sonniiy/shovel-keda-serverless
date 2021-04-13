#!/bin/bash

ACR_NAME=[INSERT ACR NAME]

docker build . -t $ACR_NAME.azurecr.io/message-transformer-b:0.0.1 -t $ACR_NAME.azurecr.io/message-transformer-b:latest

az acr login -n $ACR_NAME

docker push $ACR_NAME.azurecr.io/message-transformer-b:0.0.1
docker push $ACR_NAME.azurecr.io/message-transformer-b:latest

az acr repository show-tags -n $ACR_NAME --repository message-transformer



