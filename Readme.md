
# How to deploy metabase instance with MS Azure 
### Azure Postgres DB, Azure Container Apps, Docker

**Build Bicep**
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