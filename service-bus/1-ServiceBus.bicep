@description('this is the service bus resource name')
param serviceBusName string

@description('multiple queue name, create more than one queue name')
param queueNames array

@description('authname')
param serviceBusAuthName string

@description('queue access for the read and write')
param authRules array

@description('The location for the resource')
param location string = resourceGroup().location

resource serviceBus_resource 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: serviceBusName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource serviceBusQueues 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = [
  for queueName in queueNames: {
    parent: serviceBus_resource
    name: '${queueName}'
    properties: {
      maxDeliveryCount: 10
      deadLetteringOnMessageExpiration: true
    }
  }
]

resource serviceBus_SAS 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2021-11-01' = {
  parent: serviceBus_resource
  name: serviceBusAuthName
  properties: {
    rights: authRules
  }
}
