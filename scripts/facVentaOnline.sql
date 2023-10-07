
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
    LEFT JOIN datawh.Dim_Producto dimP -- DIM_PRODUCTO
        ON detailorder.ProductID = dimP.ProductID
    LEFT JOIN datawh.Dim_Ubicacion dimU -- DIM_UBICACION
        ON orderhead.TerritoryID = dimU.TerritoryID
    LEFT JOIN datawh.Dim_Cliente dimC -- DIM_CLIENTE
        ON orderhead.CustomerID = dimC.CustomerID
    WHERE orderhead.OnlineOrderFlag = 1 -- FILTRAMOS LAS VENTAS ONLINE
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