
INSERT INTO datawh.Dim_Ubicacion(
    TerritoryID,
    continente,
    pais,
    estado,
    ciudad
)
SELECT 
t.TerritoryID
,t.Group AS continente
,cr.Name as pais
,s.Name as estado
,a.City as ciudad
FROM adw.Sales_SalesTerritory t
inner JOIN  adw.Person_CountryRegion cr
	ON t.CountryRegionCode = cr.CountryRegionCode
inner JOIN  adw.Person_StateProvince s
    ON t.TerritoryID = s.TerritoryID
inner JOIN  adw.Person_Address a
    ON s.StateProvinceID = a.StateProvinceID;


