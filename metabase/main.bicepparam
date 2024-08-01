using './main.bicep'

//param resourceGroupName = 'my-dev'
param flexibleServers_metabasereport_name = '-your-database-name'
param dbType = 'postgres'
param dbPort = '5432' // default port
param dbUsername = 'your-db-username'
param dbPassword = 'your-db-password'
param dbHost = '${flexibleServers_metabasereport_name}.postgres.database.azure.com'

param containerRegistryName = 'your-container-registry-name' // optional, see main bicep
param containerEnvironmentName = 'your-container-environment-name'
param containerName = 'your-docker-metabase-container-name'
param containerIngressPort = 3000 // default port
param metabaseImage = 'metabase/metabase:latest' // metabase image to deploy
param metabaseCpuCores = 1
param metabaseMemoryInGb = 2
