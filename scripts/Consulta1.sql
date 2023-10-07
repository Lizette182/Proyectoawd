-- EL COSTO PROMEDIO DE ENVIO DE UN PRODUCTO HACIA LOS ESTADOS UNIDOS

WITH CONSULTA_AVG_ENVIO AS (    
    SELECT 
    F.totalEnvio,
    dp.nomProducto,
    du.Pais,
    dp.categoria
    FROM datawh.FacVentaOnline F
    INNER JOIN datawh.Dim_Cliente dc
        on F.clienteKey= dc.clienteKey
    INNER JOIN datawh.Dim_Producto dp 
        on F.productoKey=dp.productoKey
    INNER JOIN datawh.Dim_Ubicacion du 
        ON F.ubicacionKey=du.ubicacionKey 
    INNER JOIN datawh.Dim_Tiempo dt 
        on F.dateKey=dt.dateKey
    WHERE du.Pais='United States'
)SELECT
    AVG(totalEnvio),
    nomProducto,
    Pais,
    categoria
FROM CONSULTA_AVG_ENVIO
GROUP BY nomProducto,Pais,categoria
ORDER BY categoria;