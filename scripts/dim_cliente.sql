-- creamos la funcion para calcular el rango de la edad
source ./scripts/fun_dim_cliente_edad.sql

INSERT INTO datawh.Dim_Cliente(
    CustomerID,
    estadoCivil,
    genero,
    numHijos,
    casaPropia,
    datePrimeraCompra,
    edad,
    rangoEdad,
    continente,
    pais
)

SELECT
sc.CustomerID
,(case 
    when ExtractValue(p.Demographics, '/IndividualSurvey/MaritalStatus') = 'S'  and ExtractValue(p.Demographics, '/IndividualSurvey/Gender') = 'F' then 'Soltera'
    when ExtractValue(p.Demographics, '/IndividualSurvey/MaritalStatus') = 'S'  and ExtractValue(p.Demographics, '/IndividualSurvey/Gender') <> 'F' then 'Soltero'
    when ExtractValue(p.Demographics, '/IndividualSurvey/MaritalStatus') = 'M'  and ExtractValue(p.Demographics, '/IndividualSurvey/Gender') = 'F' then 'Casada'
    else 'Casado' end) AS estadoCivil
,(case 
    when ExtractValue(p.Demographics, '/IndividualSurvey/Gender') = 'F' then 'Femanino'
    else 'Masculino' end) as genero
,ExtractValue(p.Demographics, '/IndividualSurvey/TotalChildren') as numHijos
,(case 
    when ExtractValue(p.Demographics, '/IndividualSurvey/HomeOwnerFlag') = 1 then 'Si'
    else 'NO' end) as casaPropia
,datawh.validDate(SUBSTR(ExtractValue(p.Demographics, '/IndividualSurvey/DateFirstPurchase'),1,10)) as datePrimeraCompra
,(YEAR(DATE(CONVERT_TZ(CURDATE(), 'UTC', 'America/Bogota')))-YEAR(datawh.validDate(SUBSTR(ExtractValue(p.Demographics, '/IndividualSurvey/BirthDate'),1,10)))) as edad
,datawh.CalcularEdad(SUBSTR(ExtractValue(p.Demographics, '/IndividualSurvey/BirthDate'),1,10),DATE(CONVERT_TZ(CURDATE(), 'UTC', 'America/Bogota'))) as rangoEdad
,t.Group AS continente
,cr.Name as pais
FROM adw.Sales_Customer sc
LEFT JOIN adw.Person_Person p
    ON sc.PersonID = p.BusinessEntityID
INNER JOIN adw.Sales_SalesTerritory t -- LEFT
    ON sc.TerritoryID = t.TerritoryID
INNER JOIN  adw.Person_CountryRegion cr  -- LEFT
	ON t.CountryRegionCode = cr.CountryRegionCode;












/* SELECT adw.CalcularEdad(STR_TO_DATE('2023-10-03', '%Y-%m-%d'),DATE(CONVERT_TZ(CURDATE(), 'UTC', 'America/Bogota'))) */

