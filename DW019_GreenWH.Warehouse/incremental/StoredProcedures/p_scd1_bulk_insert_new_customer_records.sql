CREATE PROCEDURE [incremental].[p_scd1_bulk_insert_new_customer_records] AS
DROP TABLE IF EXISTS temp.inserted_scd1_customers
-- Get inserted values and create a temp table
CREATE TABLE temp.inserted_scd1_customers AS (
SELECT em_cus.*
FROM DW018_BronzeLH.dbo.em_customers em_cus
LEFT JOIN DW019_GreenWH.incremental.customers_scdtype1 scd_cus
    ON em_cus.customer_id = scd_cus.customer_id
WHERE scd_cus.customer_id IS NULL
)

-- Merge inserted values into the green layer
IF EXISTS(SELECT 1 FROM temp.inserted_scd1_customers)
    DECLARE @MaxID AS BIGINT;

    IF EXISTS(SELECT * FROM DW019_GreenWH.incremental.customers_scdtype1)
        SET @MaxID = (SELECT MAX(customer_surrogate_key) FROM DW019_GreenWH.incremental.customers_scdtype1)
    ELSE
        SET @MaxID = 0;
    
    INSERT INTO DW019_GreenWH.incremental.customers_scdtype1
    SELECT
        @MaxID + ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS customer_surrogate_key
        ,customer_id
        ,customer_name
        ,customer_email
        ,modified
    FROM temp.inserted_scd1_customers

DROP TABLE temp.inserted_scd1_customers