﻿--USE master
--CREATE LOGIN [aaduser@onmicrosoft.com] FROM EXTERNAL PROVIDER;
--GRANT ADMINISTER BULK OPERATIONS TO [aaduser@onmicrosoft.com];
--USE stagingzone
--CREATE USER [aaduser@onmicrosoft.com] FROM LOGIN [aaduser@onmicrosoft.com];
-- Optional since created in CreateDatabaseAndServerlessDeltaView --CREATE SCHEMA SalesLT
-- GRANT SELECT ON SCHEMA :: SalesLT TO [aaduser@onmicrosoft.com] WITH GRANT OPTION;
--OPTIONAL --ALTER ROLE db_datareader ADD MEMBER [aaduser@onmicrosoft.com];