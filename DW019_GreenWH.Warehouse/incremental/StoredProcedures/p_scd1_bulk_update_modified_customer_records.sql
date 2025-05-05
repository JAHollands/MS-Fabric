CREATE PROCEDURE [incremental].[p_scd1_bulk_update_modified_customer_records] AS
DROP TABLE IF EXISTS temp.updated_scd1_customers
-- Get updated values and create a temp table
CREATE TABLE temp.updated_scd1_customers AS (
SELECT em_cus.*
FROM DW018_BronzeLH.dbo.em_customers em_cus
LEFT JOIN DW019_GreenWH.incremental.customers_scdtype1 scd_cus
    ON em_cus.customer_id = scd_cus.customer_id
WHERE scd_cus.modified <> em_cus.modified
)

-- Merge updated values into the green layer
IF EXISTS(SELECT 1 FROM temp.updated_scd1_customers)
    UPDATE DW019_GreenWH.incremental.customers_scdtype1
    SET customer_name = source.customer_name,
        customer_email = source.customer_email,
        modified = source.modified
    FROM DW019_GreenWH.incremental.customers_scdtype1 target
    INNER JOIN DW019_GreenWH.temp.updated_scd1_customers source ON source.customer_id = target.customer_id



DROP TABLE temp.updated_scd1_customers