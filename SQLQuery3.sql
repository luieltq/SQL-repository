SELECT CASE
		WHEN (días > 20 AND Días <= 40) THEN '1M'
-- Use the same syntax here             
		WHEN (días > 50 AND Días <= 70) THEN '2M'
-- Use the same syntax here               
		 WHEN (días > 80 AND Días <= 100) THEN '3M'
-- Specify a value      
		ELSE '6M' 
		END AS Bucket,
		 fecha,
		 tasa as TasaCDV

FROM dbo.BD_CDV
