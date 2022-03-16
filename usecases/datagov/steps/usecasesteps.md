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

#### Create Collection and Register Data source

1. Find Purview Studio in your Azure Purview account and click Open

![purviewaccount](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewaccount.png)

2. Go to the Data map in Azure Purview Studio and look at the Sources root collection

![purviewsources](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewsources.png)

3. Click on Collections

![purviewcollections](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewcollections.png)

4. Click on the Role assignments tab and add your user to the Policy authors and Workflow administrators

![roleassignments](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/roleassignments.png)

5. Click + Add a collection and give the collection a Display name and Description and click Create.  In my case the data sources I want to scan and manage are in a data center region in Central Canada to I am going to call my collection Canada.

![newcollection](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/newcollection.png)

6. The collection should look like this:

![canada](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/canada.png)

7. Click on the Role assignments tab and check that your user has inherited the Policy authors and Workflow administrators roles.

![collectionroles](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/collectionroles.png)

8. Return to Sources and you should see the new collection

![collectionmap](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/collectionmap.png)

9. Click on the register icon on the new collection and navigate to Azure Data Lake Gen2 and click Continue

![regadls](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/regadls.png)

10. Provide a descriptive Name (ADLS-dm2xxxetc tells me it is ADLS in storage account name), select the Azure Subscription, the Storage account name, and Enable Data use governance.  Click Register

![regsource](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/regsource.png)

11. You should now have a root Source, Canada Collection, and ADLSGen2 Data source in the Map view

![mapview](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/mapview.png)

#### Manage Security and access

1. The Deployment added a Key vault into the Resource Group where your Purview account was deployed

![purviewdep](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/purviewdep.png)

2. Open up the Key vault and go to Access policies and [for details](https://docs.microsoft.com/en-us/azure/purview/manage-credentials#option-1---assign-access-using-key-vault-access-policy)

3. Click on + Add Access Policy

![addaccesspolicy](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/addaccesspolicy.png)

4. In the Secrets permissions dropdown, select Get and List permissions.  Add the Azure Purview instance name and click Add
  
![getlist](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/getlist.png)

5. Should look something like this:

![appuser](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/appuser.png)

6. In Key vault and go to secrets

![kvsecrets](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/kvsecrets.png)

7. Click on Generate/Import and get the details you need from the Storage account (see the next item 8).  Give the Secret a Name and copy the Storage Account key from the portal as shown below.  Set activation date and click Create

![createsecret](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/createsecret.png)

8. Go to the Storage account that you want to get the Access key for

![storagekey](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/storagekey.png)

9. Go to the Management tab in Purview Studio and select Credentials and click on Manage Key Vault connections

![managekv](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/managekv.png)

10. Click on + New

![newkv](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/newkv.png)

11. Give it a Name (I used the name of the Key vault), Description, select Subscription and the Key Vault name and click Create

![kvname](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/kvname.png)

12. Click Confirm

![confirm](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/confirm.png)

13. Click Close

![close](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/close.png)

14. In Credential click on + New.  Fill out the Name, Authentication method is Account Key, Select Key Vault connection, and enter the Secret name of the secret you just created.  Click Create

![credential](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/credential.png)

This is the Credential you will use to setup the scan

#### Setup a Scan

1. Go back to the ADLSGen2 Data source in the Map view

![mapview](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/mapview.png)

2. Click on the New scan icon between the pencil and trash can on the Data source

3. Go with the default scan Name, select the Credential you just created.  Test connection. If the Connection is successful, Click Continue.

![scan](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/scan.png)

4. Choose the Scope of the scan. Click Continue

![scope](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/scope.png)

5. Select the System Default scan rule set. Click Continue

![scanruleset](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/scanruleset.png)

6. Select the Once scan trigger. Click Continue

![scantrigger](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/scantrigger.png)

7. Review your scan. Click Save and run

![saveandrun](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/saveandrun.png)

8. Ran an Full scan

![fullscan](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/fullscan.png)

9. When the scan completes it should look like this:

![scancomplete](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/scancomplete.png)

#### Create a new Data policy

1. In Purview Studio click on Data Policy on the left panel

![datapolicy](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/datapolicy.png)

2. Click on + New Policy.  Give the Policy a Name, Description, and click on New policy statement.  Select Allow, Read, and select the ADLS Gen2 Data source type, and the Asset Data source type, and Name of the Data Source.  Click Continue.

![newpolicystatement](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/newpolicystatement.png)

3. Select the data source and make sure the Recursive checkbox is selected.  Click Add

![selectds](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/selectds.png)

4. Select the Subject and select a user of Security Group.  In my case I have created a security group called "access-read-stage" and have added users into this group the I want to have read access to the data in the stagingzone container.  Click OK

![selectsubject](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/selectsubject.png)

5. Review the Policy and click Save

![savepolicy](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/savepolicy.png)

6. The new policy will show up in the Data policies grid

![publishedpolicy](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/publishedpolicy.png)

7. You can now test the policy in tools like Synapse Studio, Azure Data Studio, or Power BI.  The next section will setup a Synapse Serverless view in Synapse Studio that can be accessed in Azure Data Studio, or Power BI.

#### Create a Linked Service in Azure Synapse

1. In Synapse Studio click on Manage on the left panel and select Linked services under External connections

![linkedservices](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/linkedservices.png)

2. To connect to the data we just scanned and created a data policy for you need a new Linked service to the ADLS Storage account.  Click on + New in Linked services. Select Azure Data Lake Storage Gen2 and click Continue.

![adlslinkedservice](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/adlslinkedservice.png)

3. Enter a Name, Authentication method of Account key, select your Azure subscription, and select the Storage account name.  Test connection (note that you might need to enable Interactive authoring to test the connection).  Click Create.

![newadlslinkedservice](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/newadlslinkedservice.png)

4. The new Linked service will now showup on the list

![linkedservicelist](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/linkedservicelist.png)

5. Navigate to the Data hub on the left navigation bar in Synapse Studio.  Click on the Linked tab and navigate to 
`stagingzone/CDC/Sales/Microsoft/AdventureWorksLT/SalesLT/Address/AutoLoader/data`

![datapath](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/datapath.png)

#### Create Synapse Serverless Delta Views and Grant Access

1. In Synapse Studio click on Develop on the left panel and select + SQL Script

![sqlscript](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/sqlscript.png)

2. Download, Copy, and Modify (if needed) this SQL Script [CreateDatabaseAndServerlessDeltaView](https://github.com/DataSnowman/MyDataMesh/blob/main/usecases/datagov/code/sqlscripts/CreateDatabaseAndServerlessDeltaView.sql) and run in Synapse Studio

![sqlscriptcreatedb](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/sqlscriptcreatedb.png)

3. Download, Copy, and Modify (if needed) this SQL Script [CreateLoginGrantBulkOpsCreateUserGrantSelectOnSchema](https://github.com/DataSnowman/MyDataMesh/blob/main/usecases/datagov/code/sqlscripts/CreateLoginGrantBulkOpsCreateUserGrantSelectOnSchema.sql)and run in Synapse Studio

![sqlscriptcreatelogin](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/sqlscriptcreatelogin.png)

#### Access the Serverless Delta Views in Azure Data Studio

1. Go and get the Synapse Serverless endpoint in the Azure Portal

![serverlessendpoint](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/serverlessendpoint.png)

2. In Azure Data Studio have the user(s) you created and granted access try to connect to the Synapse Serverless Database.  Users will need the Serverless SQL endpoint and the database name (In my case it was stagingzone) to connect 

![connectiondetails](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/connectiondetails.png)

3. Here is the query in Azure Data Studio

![queryresults](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/queryresults.png)

#### Note I will fix this issue and replace the Query Results image

Right now the only way I can fix this is by adding the Security group that the use belongs to to the Storage Blob Data Contributor or using ACLS as defined [here](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/resources-self-help-sql-on-demand#query-fails-because-file-cannot-be-opened)

![sbdc](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/sbdc.png)

#### Access the Serverless Delta Views in Power BI
