SELECT CASE
		WHEN (d�as > 20 AND D�as <= 40) THEN '1M'
-- Use the same syntax here             
		WHEN (d�as > 50 AND D�as <= 70) THEN '2M'
-- Use the same syntax here               
		 WHEN (d�as > 80 AND D�as <= 100) THEN '3M'
-- Specify a value      
		ELSE '6M' 
		END AS Bucket,
		 fecha,
		 tasa as TasaCDV

FROM dbo.BD_CDV
