source ./scripts/fun_dim_tiempo.sql

INSERT INTO Dim_Tiempo(
    dateKey,
    dateValue,
    numMes,
    semestre,
    mesNom,
    numYear,
    yearMesNumber
)

WITH fechas AS (
    SELECT DISTINCT DATE(OrderDate) AS fechaPedido
    FROM adw.Sales_SalesOrderHeader
)
SELECT
    TO_DAYS(fechaPedido)  AS dateKey,
    fechaPedido  AS dateValue,
    MONTH(fechaPedido)  AS numMes,
    datawh.DeterminarSemestre(fechaPedido) as semestre,
    MONTHNAME(fechaPedido)  AS mesNom,
    YEAR(fechaPedido) AS numYear,
    DATE_FORMAT(fechaPedido, '%Y-%m')  AS yearMesNumber
FROM fechas;