@description('this instance name for the database')
param flexibleServers_metabasereport_name string

@description('The location for the storage account')
param location string = resourceGroup().location

module postgre '1-postgres.bicep' = {
  name: 'deploy postgres'
  params: {
    flexibleServers_metabasereport_name: flexibleServers_metabasereport_name
    location: location
  }
}

module containerRegistry '2-ContainerRegistry.bicep' = {
  name: 'deploy container registry'
  params: {
    flexibleServers_metabasereport_name: flexibleServers_metabasereport_name
    location: location
  }
}
