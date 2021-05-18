# Shovels using KEDA and Azure Functions

This project provides a sample solution for implementing a message shovel with Azure Service Bus and Azure Functions. A shovel moves messages from one queue or topic to another queue or topic. There is a great shovel integration for [RabbitMQ](https://www.rabbitmq.com/shovel.html). For companies which want to increase operational effort by using PaaS instead of hosting the shovel solution themselves, this repository is a great start. 

How does it work?
The sender sends a message to a service bus queue. The queue triggers an Azure functions. Besides the normal serverless Azure Functions in Azure, the function can also be hosted in a Kubernetes cluster. This repository provides both solutions.
[Kubernetes-based Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-kubernetes-keda) provides the Functions runtime in a Docker container with event-driven scaling through [KEDA](https://keda.sh/). KEDA can scale in to 0 instances (when no events are occurring) and out to n instances. It does this by exposing custom metrics for the Kubernetes autoscaler (Horizontal Pod Autoscaler). Using Functions containers with KEDA makes it possible to replicate serverless function capabilities in any Kubernetes cluster. 
Routing decisions can be made based on entries in a routing database (in this case using Azure Redis Cache). 

![Image of Architecture](https://github.com/sonniiy/shovel-keda-serverless/blob/main/ArchitekturDiagramm.png)




This project provides a sample solution for an [Azure Service Bus](https://azure.microsoft.com/de-de/services/service-bus) based messaging solution, integrated in AKS using [KEDA](https://keda.sh/).  

It uses [KEDA](https://keda.sh/) to manage the runtime for the routing component, which routes messages between the message queues belonging to different services.

Routing decisions can be made based on entries in a routing database (in this case using [Azure Redis Cache](https://azure.microsoft.com/services/cache)

For more information on Azure Service Bus event based messaging patterns and samples, see:

https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-federation-overview

For more samples, see:

https://github.com/Azure-Samples/azure-messaging-replication-dotnet

## Deployment and Sample Code

Please review the CLI script and ARM templates available under the ```/Infrastructure-Serverless``` folder.

A sample YAML file to deploy the functions to AKS is avialable under the ```/Infrastructure-AKS``` folder.

The Docker File to build the Azure Function as a container is available under the ```/FunctionCode``` folder.

Clients to test the routing are available under the ```/MessageClients``` folder.