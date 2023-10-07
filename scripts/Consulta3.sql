-- TOTAL DE VENTAS PARA EL PRIMER SEMESTRE POR ESTADO CIVIL SOLTERO O SOLTERA
WITH CONSULTA_VENTAS_EC AS (
SELECT 
    F.totalVenta,
    dt.semestre,
    dp.nomProducto,
    du.Pais,
    dp.categoria,
    dc.estadoCivil
    FROM datawh.FacVentaOnline F
    INNER JOIN datawh.Dim_Cliente dc
        on F.clienteKey= dc.clienteKey
    INNER JOIN datawh.Dim_Producto dp 
        on F.productoKey=dp.productoKey
    INNER JOIN datawh.Dim_Ubicacion du 
        ON F.ubicacionKey=du.ubicacionKey 
    INNER JOIN datawh.Dim_Tiempo dt 
        on F.dateKey=dt.dateKey
)
SELECT  
SUM(totalVenta),
semestre,
nomProducto,
Pais,
categoria,
estadoCivil
FROM CONSULTA_VENTAS_EC 
WHERE estadoCivil IN('Soltera','Soltero')
GROUP BY semestre,
    nomProducto,
    Pais,
    categoria,
    estadoCivil;
