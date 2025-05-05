CREATE PROCEDURE incremental.p_scd2_bulk_insert_new_customer_records AS
DROP TABLE IF EXISTS temp.inserted_scd2_customers
-- Get inserted values and create a temp table
CREATE TABLE temp.inserted_scd2_customers AS (
SELECT em_cus.*
FROM DW018_BronzeLH.dbo.em_customers em_cus
LEFT JOIN DW019_GreenWH.incremental.customers_scdtype1 scd_cus
    ON em_cus.customer_id = scd_cus.customer_id
WHERE scd_cus.customer_id IS NULL
)

-- Merge inserted values into the green layer
IF EXISTS(SELECT 1 FROM temp.inserted_scd2_customers)
    DECLARE @MaxID AS BIGINT;

    IF EXISTS(SELECT * FROM DW019_GreenWH.incremental.customers_scdtype2)
        SET @MaxID = (SELECT MAX(customer_surrogate_key) FROM DW019_GreenWH.incremental.customers_scdtype2)
    ELSE
        SET @MaxID = 0;
    
    INSERT INTO DW019_GreenWH.incremental.customers_scdtype2
    SELECT
        @MaxID + ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS customer_surrogate_key
        ,source.customer_id
        ,source.customer_name
        ,source.customer_email
        ,valid_from = source.modified
        ,valid_to = '9999-12-31 23:59:59'
        ,is_current = 1
        ,is_deleted = 0
    FROM temp.inserted_scd2_customers source

DROP TABLE temp.inserted_scd2_customers