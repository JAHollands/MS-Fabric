CREATE PROCEDURE raw.p_get_filtered_contacts 
@customer_cityId INT
AS
BEGIN
SELECT * FROM raw.hubspot_contacts
WHERE customer_city_id = @customer_cityId
END