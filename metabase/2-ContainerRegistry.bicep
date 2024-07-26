@description('this instance name for the database')
param flexibleServers_metabasereport_name string

@description('The location for the storage account')
param location string

resource flexibleServers_metabasereport_name_resource 'Microsoft.DBforPostgreSQL/flexibleServers@2023-12-01-preview' = {
  name: flexibleServers_metabasereport_name
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    replica: {
      role: 'Primary'
    }
    storage: {
      iops: 120
      tier: 'P4'
      storageSizeGB: 32
      autoGrow: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Enabled'
    }
    dataEncryption: {
      type: 'SystemManaged'
    }
    authConfig: {
      activeDirectoryAuth: 'Disabled'
      passwordAuth: 'Enabled'
    }
    version: '15'
    administratorLogin: flexibleServers_metabasereport_name
    availabilityZone: '1'
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    maintenanceWindow: {
      customWindow: 'Disabled'
      dayOfWeek: 0
      startHour: 0
      startMinute: 0
    }
    replicationRole: 'Primary'
  }
}

// add additional configuration for metabase application to work with postgres db
resource flexibleServers_metabasereport_name_azure_extensions 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2023-12-01-preview' = {
  parent: flexibleServers_metabasereport_name_resource
  name: 'azure.extensions'
  properties: {
    value: 'CITEXT' // this is important
    source: 'user-override'
  }
}

resource flexibleServers_metabasereport_name_require_secure_transport 'Microsoft.DBforPostgreSQL/flexibleServers/configurations@2023-12-01-preview' = {
  parent: flexibleServers_metabasereport_name_resource
  name: 'require_secure_transport'
  properties: {
    value: 'ON'
    source: 'user-override'
  }
}

resource flexibleServers_metabasereport_name_AllowAllAzureServicesAndResourcesWithinAzureIps_2024_7_2_9_42_36 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2023-12-01-preview' = {
  parent: flexibleServers_metabasereport_name_resource
  name: 'AllowAllAzureServicesAndResourcesWithinAzureIps_2024-7-2_9-42-36'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}
