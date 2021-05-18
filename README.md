# Shovels using KEDA and Azure Functions

This project provides a sample solution for implementing a message shovel with [Azure Service Bus](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview) and Azure Functions. A shovel moves messages from one queue or topic to another queue or topic. There is a great shovel integration for [RabbitMQ](https://www.rabbitmq.com/shovel.html). For companies which want to increase operational effort by using PaaS services instead of hosting the shovel solution themselves, this repository is a great start. 

How does it work?
The sender sends a message to a service bus queue. The queue triggers an Azure functions. Besides the normal serverless Azure Functions in Azure, the function can also be hosted in a Kubernetes cluster. This repository provides both solutions.

[Kubernetes-based Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-kubernetes-keda) provides the Functions runtime in a Docker container with event-driven scaling through [KEDA](https://keda.sh/). KEDA can scale in to 0 instances (when no events are occurring) and out to n instances. It does this by exposing custom metrics for the Kubernetes autoscaler (Horizontal Pod Autoscaler). Using Functions containers with KEDA makes it possible to replicate serverless function capabilities in any Kubernetes cluster. 

Routing decisions can be made based on entries in a routing database (in this case using Azure Redis Cache). 

![Image of Architecture](https://github.com/sonniiy/shovel-keda-serverless/blob/main/ArchitekturDiagramm.png)

## Deployment and Sample Code

Infrastructure Code: 
If you want to deploy the shovel with normal Azure Functions, please review the CLI script and ARM templates available under the ```/Infrastructure-Serverless``` folder.

If you want to host the Azure Functions in AKS, please review CLI scripts and ARM templates available undert the ```/Infrastructure-AKS``` folder.

Application Code:

The Docker File to build the Azure Function as a container is available under the ```/FunctionCode``` folder.

Clients to test the routing are available under the ```/MessageClients``` folder.

## Further Resources

For more information on Azure Service Bus event based messaging patterns and samples, see:

https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-federation-overview

For more samples, see:

https://github.com/Azure-Samples/azure-messaging-replication-dotnet
