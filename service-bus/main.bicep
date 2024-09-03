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

module postgre '1-ServiceBus.bicep' = {
  name: 'deploy-service-bus'
  params: {
    serviceBusName: serviceBusName
    location: location
    queueNames: queueNames
    serviceBusAuthName: serviceBusAuthName
    authRules: authRules
  }
}
