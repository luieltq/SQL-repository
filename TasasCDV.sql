WITH Tabla (�ltima, Bucket, TasaCDV)
AS
(
	SELECT DISTINCT
		convert(date,Fecha, 103) as �ltima,
	CASE
		WHEN (d�as > 20 AND D�as <= 40) THEN '1M'           
		WHEN (d�as > 50 AND D�as <= 70) THEN '2M'              
		WHEN (d�as > 80 AND D�as <= 100) THEN '3M'   
		ELSE '6M' 
		END AS Bucket,
		tasa as TasaCDV
		FROM dbo.BD_CDV 
)

SELECT DISTINCT
	   a.Bucket, 
	   b.�ltimatrans,
	   a.TasaCDV
FROM Tabla a

JOIN (SELECT Bucket, MAX(�ltima) AS �ltimatrans FROM Tabla GROUP BY Bucket) b
ON a.Bucket = b.Bucket
AND b.�ltimatrans = a.�ltima

ORDER BY Bucket, �ltimatrans DESC;


