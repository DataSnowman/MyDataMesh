USE master
GO
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'stagingzone')
BEGIN
  CREATE DATABASE stagingzone;
END;
GO
USE stagingzone
GO

-- CREATE SCHEMA SalesLT

USE stagingzone
GO
IF EXISTS (SELECT NAME FROM SYS.VIEWS WHERE NAME = 'Address_vw')
DROP VIEW SalesLT.Address_vw
GO
CREATE VIEW SalesLT.Address_vw
AS SELECT *
FROM
    OPENROWSET(
        BULK 'https://dm2accelermnyu5bcmtupw4.dfs.core.windows.net/stagingzone/CDC/Sales/Microsoft/AdventureWorksLT/SalesLT/Address/AutoLoader/data/',
        FORMAT = 'DELTA'
    ) with (
           [AddressID] [int],
           [AddressLine1] [nvarchar](60),
	         [AddressLine2] [nvarchar](60),
	         [City] [nvarchar](30),
	         [StateProvince] [nvarchar](60),
	         [CountryRegion] [nvarchar](60),
	         [PostalCode] [nvarchar](15),
	         [rowguid] [nvarchar](40),
	         [ModifiedDate] [datetime]
           ) as rows
GO