@description('this instance name for the database')
param flexibleServers_metabasereport_name string

@description('Container Registry Name')
param containerRegistryName string

@description('Container Registry Name')
param containerEnvironmentName string

@description('Name for the container group')
param containerName string

@description('Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials.')
param metabaseImage string

@description('Port to open on the container and the public IP address.')
param containerIngressPort int

@description('The number of CPU cores to allocate to the container.')
param metabaseCpuCores int

@description('The amount of memory to allocate to the container in gigabytes.')
param metabaseMemoryInGb int

@description('The location for the storage account')
param location string = resourceGroup().location

param dbType string
param dbPort string
param dbUsername string

@secure()
param dbPassword string
param dbHost string

module postgre '1-postgres.bicep' = {
  name: 'deploy-postgres'
  params: {
    flexibleServers_metabasereport_name: flexibleServers_metabasereport_name
    location: location
    dbUsername: dbUsername
    dbPassword: dbPassword
  }
}

// This step is optional, if you are using your own container registry to host your own docker images
// you can deploy metabase to container registry and then create containers from this registry
// this is not covered in this example.
// ---------------------------Optional----------------------------------------------------------------
// module containerRegistry '2-ContainerRegistry.bicep' = {
//   name: 'deploy-container-registry'
//   params: {
//     containerRegistryName: containerRegistryName
//     location: location
//   }
// }

module containerEnvResource '3-ContainerEnvironment.bicep' = {
  name: 'deploy-container-environment'
  params: {
    containerEnvironmentName: containerEnvironmentName
    location: location
    metabaseCpuCores: metabaseCpuCores
    metabaseImage: metabaseImage
    metabaseMemoryInGb: metabaseMemoryInGb
    dbHost: dbHost
    dbPassword: dbPassword
    dbPort: dbPort
    dbType: dbType
    dbUsername: dbUsername
    containerIngressPort: containerIngressPort
    containerName: containerName
  }
}
