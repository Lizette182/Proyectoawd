
INSERT INTO datawh.FacVentaOnline(
    subTotalVenta,
    totalImpuestos,
    totalEnvio,
    totalVenta,
    totalDescuento,
    cantidad,
    estadoVenta,
    clienteKey,
    productoKey,
    ubicacionKey,
    dateKey
)
WITH DATOS AS (
    SELECT
    orderhead.SubTotal AS subTotalVenta,
    orderhead.TaxAmt AS totalImpuestos,
    orderhead.Freight AS totalEnvio,
    orderhead.TotalDue AS totalVenta,
    detailorder.UnitPriceDiscount AS totalDescuento,
    detailorder.OrderQty AS cantidad,
    orderhead.Status AS estadoVenta,
    dimC.clienteKey,
    dimP.productoKey,
    dimU.ubicacionKey,
    TO_DAYS(orderhead.OrderDate) AS dateKey
    FROM adw.Sales_SalesOrderHeader orderhead
    INNER JOIN adw.Sales_SalesOrderDetail detailorder 
        ON orderhead.SalesOrderID = detailorder.SalesOrderID
    INNER JOIN datawh.Dim_Producto dimP -- DIM_PRODUCTO
        ON detailorder.ProductID = dimP.ProductID
    INNER JOIN datawh.Dim_Ubicacion dimU -- DIM_UBICACION
        ON orderhead.TerritoryID = dimU.TerritoryID
    INNER JOIN datawh.Dim_Cliente dimC -- DIM_CLIENTE
        ON orderhead.CustomerID = dimC.CustomerID
    WHERE orderhead.OnlineOrderFlag = 1 -- FILTRAMOS LAS VENTAS ONLINE
    AND orderhead.OrderDate BETWEEN DATE_FORMAT('2014-08-01', '%Y-%m-%d') AND DATE_FORMAT('2014-09-30', '%Y-%m-%d')
    LIMIT 300
)
SELECT 
SUM(subTotalVenta),
SUM(totalImpuestos),
SUM(totalEnvio),
SUM(totalVenta),
SUM(totalDescuento),
COUNT(cantidad),
COUNT(estadoVenta),
clienteKey,
productoKey,
ubicacionKey,
dateKey
FROM DATOS
GROUP BY clienteKey,productoKey,ubicacionKey,dateKey;


/* SELECT orderhead.OrderDate,count(orderhead.OrderDate)
FROM adw.Sales_SalesOrderHeader orderhead
INNER JOIN adw.Sales_SalesOrderDetail detailorder 
    ON orderhead.SalesOrderID = detailorder.SalesOrderID
where orderhead.OrderDate BETWEEN DATE_FORMAT('2014-01-01', '%Y-%m-%d') AND DATE_FORMAT('2014-01-31', '%Y-%m-%d')
GROUP by orderhead.OrderDate
order by 1; */