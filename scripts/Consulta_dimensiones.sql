WITH CONSULTA_AVG_ENVIO AS (    
    SELECT 
    F.totalEnvio,
    dp.nomProducto,
    du.Pais
    FROM datawh.FacVentaOnline F
    INNER JOIN datawh.Dim_Cliente dc
        on F.clienteKey= dc.clienteKey
    INNER JOIN datawh.Dim_Producto dp 
        on F.productoKey=dp.productoKey
    INNER JOIN datawh.Dim_Ubicacion du 
        ON F.ubicacionKey=du.ubicacionKey 
    INNER JOIN Dim_Tiempo dt 
        on F.dateKey=dt.dateKey
    WHERE du.Pais='United States'
)SELECT
    AVG(totalEnvio),
    nomProducto,
    Pais
FROM CONSULTA_AVG_ENVIO
GROUP BY nomProducto,
         Pais