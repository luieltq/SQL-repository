WITH Tabla (última, Bucket, TasaCDV)
AS
(
	SELECT DISTINCT
		convert(date,Fecha, 103) as última,
	CASE
		WHEN (días > 20 AND Días <= 40) THEN '1M'           
		WHEN (días > 50 AND Días <= 70) THEN '2M'              
		WHEN (días > 80 AND Días <= 100) THEN '3M'   
		ELSE '6M' 
		END AS Bucket,
		tasa as TasaCDV
		FROM dbo.BD_CDV 
)

SELECT DISTINCT
	   a.Bucket, 
	   b.últimatrans,
	   a.TasaCDV
FROM Tabla a

JOIN (SELECT Bucket, MAX(última) AS últimatrans FROM Tabla GROUP BY Bucket) b
ON a.Bucket = b.Bucket
AND b.últimatrans = a.última

ORDER BY Bucket, últimatrans DESC;


