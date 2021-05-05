# Shovels using KEDA and Azure Functions

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

