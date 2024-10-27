@description('create plan before creating function app')
param appServicePlanName string

@description('this is the functio app name')
param appServiceName string

@description('The location for the resource')
param location string = resourceGroup().location

module functionAppPlan '1-FunctionAppServicePlan.bicep' = {
  name: 'deploy-function-app-plan'
  params: {
    appServicePlanName: appServicePlanName
    location: location
  }
}

module functionApp '2-FunctionAppService.bicep' = {
  name: 'deploy-function-app'
  params: {
    appServicePlanName: appServiceName
    location: location
    functionPlanId: appServicePlanName
  }
}
