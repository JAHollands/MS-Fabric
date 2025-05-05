CREATE PROCEDURE incremental.p_scd2_bulk_delete_customer_records AS
DROP TABLE IF EXISTS temp.deleted_scd2_customers

CREATE TABLE temp.deleted_scd2_customers AS 
SELECT target.customer_id
FROM incremental.customers_scdtype2 target
LEFT JOIN DW018_BronzeLH.dbo.em_customers source
    ON target.customer_id = source.customer_id
WHERE source.customer_id IS NULL
AND target.is_current = 1


IF EXISTS(SELECT 1 FROM temp.deleted_scd2_customers)
    UPDATE DW019_GreenWH.incremental.customers_scdtype2
    SET valid_to = GETDATE(),
        is_current = 0,
        is_deleted = 1
    FROM incremental.customers_scdtype2 target
    INNER JOIN temp.deleted_scd2_customers source
        ON source.customer_id = target.customer_id
    WHERE target.is_current = 1


DROP TABLE temp.deleted_scd2_customers