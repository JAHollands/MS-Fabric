CREATE PROCEDURE raw.p_insert_new_location
@customer_country_id INT,
@customer_city_id INT,
@customer_country_name VARCHAR(50),
@customer_city_name VARCHAR(50)
AS
BEGIN 
INSERT INTO raw.hubspot_locations_lookup
VALUES(@customer_country_id, @customer_city_id, @customer_country_name, @customer_city_name)
END