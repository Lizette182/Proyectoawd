-- TOTAL DE BICICLETAS VENDIDAS EN ESTADOS UNIDOS PARA EL MES DE f

WITH CONSULTA_TOTAL_VENTAS AS (
SELECT 
    F.totalVenta,
    dt.dateValue,
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
    WHERE du.Pais='United States' AND 
    dp.categoria='Bikes' AND 
    dt.dateValue BETWEEN DATE_FORMAT('2014-02-01', '%Y-%m-%d') AND DATE_FORMAT('2014-02-28', '%Y-%m-%d')
)
SELECT SUM(totalVenta) AS totalventa,
    -- dateValue,
    -- nomProducto,
    Pais,
    categoria
FROM CONSULTA_TOTAL_VENTAS
GROUP BY -- dateValue, 
    -- nomProducto,
    Pais,
    categoria;