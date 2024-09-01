
# How to deploy metabase instance with MS Azure 
### Azure Postgres DB, Azure Container Apps, Docker

**Build Bicep**
main.bicep call 3 other bicep files including bicep for postgres database, container registry (optional) and container environment.

Executing the main bicep will deploy the required azure services for metabase docker and if everything right you will not need anything else and metabase instance will be operational.

```
az bicep build --file main.bicep
az bicep build --file main.bicep --outdir ..\.build
```

**How to execute from local system**
```
az login
az account list --output table
az account set --subscription "your-subscription-id"
```

***validate***
```
az deployment group what-if --resource-group my-dev --template-file main.bicep --parameters main.bicepparam
```

***deploy / create resources***
```
az deployment group create --resource-group my-dev --template-file main.bicep --parameters main.bicepparam
```