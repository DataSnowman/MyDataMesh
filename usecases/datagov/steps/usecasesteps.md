## Azure Purview Data Governance

### Step 1 If you don't have Azure resources to scan in Purview [Step 1 - Deploy Azure Analytic Services to land and stage data](https://github.com/DataSnowman/MyDataMesh#deploy-azure-data-factory-azure-databricks-adls-and-azure-sql-database)

`To get a SQL Server database and ADLS storage to scan you can Deploy Azure Data Factory, Azure Databricks, ADLS, and Azure SQL Database`

### Step 2 Scan a Azure SQL Database

If you would like to scan some data in Azure SQL Database and you deployed Step 1 above then use these [Steps](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/landstage/steps/usecasesteps.md) to create some content in ADLS

Follow the steps in [Register and scan an Azure SQL Database](https://docs.microsoft.com/en-us/azure/purview/register-scan-azure-sql-database)

### Step 3 Scan a Azure Data Lake Storage

If you would like to scan some data in ADLS and you deployed Step 1 above then use these [Steps](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/landstage/steps/usecasesteps.md) to create some content in ADLS

Then follow the steps in [Register and scan Azure Data Lake Storage Gen2](https://docs.microsoft.com/en-us/azure/purview/register-scan-adls-gen2)

To get started do the following:

1. Find Purview Studio in your Azure Purview account and click Open

![purviewaccount](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewaccount.png)

2. Go to the Data map in Azure Purview Studio and look at the Sources root collection

![purviewsources](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewsources.png)

3. Click on Collections and click + Add a collection

![purviewcollections](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewcollections.png)

4. Give the collection a Display name and Description and click Create.  In my case the data sources I want to scan and manage are in a data center region in Central Canada to I am going to call my collection Canada.

![newcollection](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/newcollection.png)

5. The collection should look like this:

![canada](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/canada.png)

6. Click on the Role assignments tab and add your user to the Policy authors and Workflow administrators roles

![collectionroles](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/collectionroles.png)

7. Return to Sources and you should see the new collection

![collectionmap](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/collectionmap.png)

8. Click on the register icon on the new collection and navigate to Azure Data Lake Gen2 and click Continue

![regadls](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/regadls.png)

9. Provide a descriptive Name (ADLS-Canada-dm1accelers tells me it is ADLS in Canada and with some or all of its storage account name), select the Azure Subscription, the Storage account name, and Enable Data use governance.  Click Register

![regsource](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/regsource.png)

10.