CREATE PROCEDURE dbo.p_generate_date_dim
@start_date DATE,
@number_of_days INT
AS
BEGIN
WITH initial_date_dimension AS (
  SELECT DATEADD(DAY,value,CONVERT(DATE,@start_date)) as [date]
  FROM GENERATE_SERIES(0,@number_of_days,1)
) 

SELECT [date]
  [date],
  DAY([date]) AS day,
  MONTH([date]) AS month,
  YEAR([date]) AS year,
  CAST(CONVERT(char(8), [date], 112) AS INT) AS date_key
INTO DW019_GreenWH.dbo.date_dimension 
FROM initial_date_dimension
END