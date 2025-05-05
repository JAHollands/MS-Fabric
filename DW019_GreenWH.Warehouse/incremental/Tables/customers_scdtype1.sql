CREATE TABLE [incremental].[customers_scdtype1] (

	[customer_surrogate_key] int NOT NULL, 
	[customer_id] int NOT NULL, 
	[customer_name] varchar(200) NULL, 
	[customer_email] varchar(200) NULL, 
	[modified] datetime2(6) NULL
);