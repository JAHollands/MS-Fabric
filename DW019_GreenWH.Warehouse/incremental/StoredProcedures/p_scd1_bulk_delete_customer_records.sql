CREATE PROCEDURE [incremental].[p_scd1_bulk_delete_customer_records] AS
DROP TABLE IF EXISTS temp.deleted_scd1_customers
-- Get updated values and create a temp table
CREATE TABLE temp.deleted_scd1_customers AS (
SELECT scd_cus.customer_id
FROM DW018_BronzeLH.dbo.em_customers em_cus
RIGHT JOIN DW019_GreenWH.incremental.customers_scdtype1 scd_cus
    ON em_cus.customer_id = scd_cus.customer_id
WHERE em_cus.customer_id IS NULL
)

-- Merge updated values into the green layer
IF EXISTS(SELECT 1 FROM temp.deleted_scd1_customers)
    DELETE DW019_GreenWH.incremental.customers_scdtype1
    FROM DW019_GreenWH.incremental.customers_scdtype1 target
    JOIN temp.deleted_scd1_customers AS source
        ON target.customer_id = source.customer_id



DROP TABLE temp.deleted_scd1_customers

--EXEC [incremental].[p_scd1_bulk_update_modified_customer_records]
--SELECT * FROM incremental.customers_scdtype1 WHERE customer_id = 15