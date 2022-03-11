# MyDataMesh
This is an example of a Data Mesh Architecture deployed using Azure Analytics ARM Accelerators along with use cases to create a Data Product for a given Data Domain.  To deploy additional Data Domains and create additional Data Products use the Deploy to Azure ARM templates to deploy into other Azure Regions or Resource Groups.

`Note at the time that this was first created (03/10/2022) the Purview Storage Access Policy was only available in the following Azure Regions (so you might want to use one of these for all the deployments)`
- France Central
- Canada Central
- East US2
- West EuropeCanada

[Check here to see if more regions are available](https://docs.microsoft.com/en-us/azure/purview/tutorial-data-owner-policies-storage)

![datamesh](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/datamesh.png)

## Azure Analytics ARM Accelerators

### Purpose

The purpose of this Analytics Accelerator is to help you learn and grow through Hands-on common use cases that show you how to use Azure Data Services like ADF pipelines, Azure Data Lake Storage, Databricks Notebooks, SQL scripts, Synapse pipelines, Synapse Spark Notebooks, Synapse Serverless SQL, Purview, and Power BI.

This [GitHub Repo](https://github.com/DataSnowman/MyDataMesh) along with an Azure Subscription [No Azure Subscription click here](https://azure.microsoft.com/en-us/free/) should allow you to accelerate:

* Business Value
* Time-to-insight
* Modernization
* Skilling
* Proof of Concepts
* Architecture choice
* Infrastructure as code for deployment via ARM template

### Use Case

![datalakehouse](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/datalakehouse.png)

| Deployment | Use Case Name | Use Case Type | Dataset | Description | Code | Instruction Steps |
| :------------- | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| [Azure Data Factory, Azure Databricks, Azure SQL Database, and ADLS](https://github.com/DataSnowman/MyDataMesh#deploy-azure-data-factory-azure-databricks-adls-and-azure-sql-database) | Change Data Capture | Azure Data Factory, Azure Databricks, Azure Data Lake Storage, Azure SQL Database | AdventureworksLT | Change Data Capture using ADF and Databricks Autoloader | [Code](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/landstage/code) | [Steps](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/landstage/steps/usecasesteps.md) |

### Prerequisites

- Owner to the Azure Subscription being deployed. This is for creation of a separate Analytics Accelerator Resource Group and to delegate roles necessary for this deployment.

### Step 1 - Deploy Azure Analytic Services to land, stage data

The following accelerator can be used to deploy `Azure Data Factory`, `Azure Databricks`, `Azure Data Lake Storage`, and `Azure SQL Database` into an Azure Resource Group.  It will allow you to explore some of the Data Integration, Data Lake, and Lakehouse Architecture capabilities available on Microsoft Azure.  

### Deploy Azure Data Factory, Azure Databricks, ADLS, and Azure SQL Database

`Together with Azure Data Factory, Azure Databricks, Azure Data Lake Storage Gen2, and Azure SQL Database`

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2FMyDataMesh%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json) [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2FMyDataMesh%2Fmain%2Fworkspace%2Fadb-workspace%2Fazuredeploy.json)

This template deploys the following:

- Azure Data Factory
- Azure Databricks Workspace
- Azure Data Lake Storage Gen2
- Azure SQL Database

The deployed services should look something like this:
`Note the Event Grid and Key vault services are added during the Next Steps below`

![landstagedeployment](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/landstagedeployment.png)

### Post Deployment Steps for Step 1

One you have complete the deployment please go to [Next Steps](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/landstage/steps/usecasesteps.md) to configure and run the Change Data Capture of changes made to the Azure SQL Database which ADF copies and Azure Databricks autoloads.

### Step 2 - Deploy Azure Synapse Analytics to enrich and curate data

The following accelerator can be used to deploy `Azure Synapse Analytics`, `Azure Data Lake Storage`, `Spark Pools`, `SQL Serverless`and `Dedicated SQL Pools` into an Azure Resource Group.  It will allow you to enrich and curate data that was landed and staged in Step 1 above.  This will continue your emersion into Data Integration, Data Lake, Lakehouse, and using Spark Notebooks and SQL Serverless.  

### Deploy an Azure Synapse Analytics Workspace

This template deploys necessary resources to run an Azure Synapse Analytics Workspace.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2FMyDataMesh%2Fmain%2Fworkspace%2Fsynapse-workspace%2Fazuredeploy.json) [![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FDataSnowman%2FMyDataMesh%2Fmain%2Fworkspace%2Fsynapse-workspace%2Fazuredeploy.json)

This template deploys the following:

- An Azure Synapse Workspace
  - (OPTIONAL) Allows All connections in by default (Firewall IP Addresses)
  - Allows Azure Services to access the workspace by default
  - Managed Virtual Network is Enabled
- An Azure Synapse SQL Pool
- (OPTIONAL) Apache Spark Pool
  - Auto-paused set to 15 minutes of idling
- Azure Data Lake Storage Gen2 account
  - Azure Synapse Workspace identity given Storage Blob Data Contributor to the Storage Account
    - A new File System inside the Storage Account to be used by Azure Synapse
- A Logic App to Pause the SQL Pool at defined schedule
  - The Logic App will check for Active Queries. If there are active queries, it will wait 5 minutes and check again until there are none before pausing
- A Logic App to Resume the SQL Pool at defined schedule
- Both Logic App managed identities are given Contributor rights to the Resource Group
- Grants the Workspace identity CONTROL to all SQL pools and SQL on-demand pool

The deployed services should look something like this:

![enrichcuratedeployment](https://raw.githubusercontent.com/DataSnowman/MyDataMesh/main/images/enrichcuratedeployment.png)

### Post Deployment - Important steps required to use this Analytics Accelerator

### Post Deployment Steps for Step 2

```***Remember to come back to this link above after the deployment has completed***```

[Synapse Analytics Post Deployment](https://github.com/DataSnowman/MyDataMesh/blob/main/usecases/enrichcurate/steps/postdeploy.md#post-deployment-steps)

One you have complete the deployment please go to [Next Steps](https://github.com/DataSnowman/MyDataMesh/tree/main/usecases/enrichcurate/steps/usecasesteps.md) to configure Linked Services and run Spark Notebooks and SQL Scripts.

## Training Resources
Borrowed this table from [OpenEduAnalytics](https://github.com/DataSnowman/OpenEduAnalytics/tree/main#readme)
| Resource | Description |
| --------------- | --------------- |
| [Azure Fundamentals part 1](https://docs.microsoft.com/en-us/learn/paths/az-900-describe-cloud-concepts/) | Azure fundamentals is a six-part series that teaches you basic cloud concepts, provides a streamlined overview of many Azure services, and guides you with hands-on exercises to deploy your very first services for free. | 
| [Azure Fundamentals part 2](https://docs.microsoft.com/en-us/learn/paths/az-900-describe-core-azure-services/) | Continuation of part 1 | 
| [Azure for the Data Engineer](https://docs.microsoft.com/en-us/learn/paths/azure-for-the-data-engineer/) | Explore how the world of data has evolved and how the advent of cloud technologies is providing new opportunities for business to explore. You will learn the various data platform technologies that are available, and how a Data Engineer can take advantage of this technology to an organization benefit. |
| [Realize Integrated Analytical Solutions with Azure Synapse Analytics](https://docs.microsoft.com/en-us/learn/paths/realize-integrated-analytical-solutions-with-azure-synapse-analytics/)| Learn how Azure Synapse Analytics enables you to perform different types of analytics through its’ components that can be used to build Modern Data Warehouses through to Advanced Analytical solutions. |