CREATE PROCEDURE raw.p_merge_customer_locations
@customer_country_id INT,
@customer_city_id INT,
@customer_country_name VARCHAR(50),
@customer_city_name VARCHAR(50)
AS
IF EXISTS (SELECT 1 FROM raw.hubspot_locations_lookup WHERE customer_city_id = @customer_city_id)
BEGIN
UPDATE raw.hubspot_locations_lookup
SET customer_country_id = customer_country_id, @customer_country_name = customer_country_name , @customer_city_name = customer_city_name
WHERE customer_city_id = @customer_city_id
END
ELSE
BEGIN
INSERT INTO raw.hubspot_locations_lookup
VALUES(@customer_country_id , @customer_city_id , @customer_country_name , @customer_city_name)
END