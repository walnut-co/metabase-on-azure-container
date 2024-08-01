@description('this instance name for the container environment')
param containerEnvironmentName string

@description('The location for the resource')
param location string

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

param dbType string

@description('db port number')
param dbPort string

param dbUsername string

@secure()
param dbPassword string
param dbHost string

resource containerEnvironmentName_resource 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: containerEnvironmentName
  location: location
  properties: {
    zoneRedundant: false
    kedaConfiguration: {}
    daprConfiguration: {}
    customDomainConfiguration: {}
    peerAuthentication: {
      mtls: {
        enabled: false
      }
    }
    peerTrafficConfiguration: {
      encryption: {
        enabled: false
      }
    }
  }
}

resource containerApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: containerName
  location: location
  properties: {
    managedEnvironmentId: containerEnvironmentName_resource.id
    configuration: {
      ingress: {
        external: true
        targetPort: containerIngressPort
        transport: 'auto'
        allowInsecure: false
      }
    }
    template: {
      containers: [
        {
          name: containerName
          image: metabaseImage
          resources: {
            cpu: metabaseCpuCores
            memory: '${metabaseMemoryInGb}Gi'
          }
          env: [
            {
              name: 'MB_DB_TYPE'
              value: 'postgres'
            }
            {
              name: 'MB_DB_DBNAME'
              value: dbType
            }
            {
              name: 'MB_DB_PORT'
              value: dbPort
            }
            {
              name: 'MB_DB_USER'
              value: dbUsername
            }
            {
              name: 'MB_DB_PASS'
              value: dbPassword
            }
            {
              name: 'MB_DB_HOST'
              value: dbHost
            }
            {
              name: 'MB_DB_SSL'
              value: 'true'
            }
            {
              name: 'MB_DB_SSLMODE'
              value: 'require'
            }
            {
              name: 'MB_LOG_LEVEL'
              value: 'debug'
            }
          ]
        }
      ]
    }
  }
}
