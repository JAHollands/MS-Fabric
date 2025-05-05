CREATE TABLE [incremental].[customers_scdtype2] (

	[customer_surrogate_key] bigint NOT NULL, 
	[customer_id] int NOT NULL, 
	[customer_name] varchar(200) NULL, 
	[customer_email] varchar(200) NULL, 
	[valid_from] datetime2(6) NULL, 
	[valid_to] datetime2(6) NULL, 
	[is_current] bit NULL, 
	[is_deleted] bit NULL
);