INSERT INTO datawh.Dim_Producto(
	ProductID,
	nomProducto,
	categoria,
	subcategoria,
	tipoProceso,
	clase,
	modelo,
	linea,
	genero,
	color,
	estadoBodega
)
SELECT
p.ProductID
,p.Name-- as nomProducto
,pc.Name-- as categoria
,ps.Name-- as subCategoria
,(case 
	when p.MakeFlag = 1 then 'Comprado' 
	else 'Fabricado' end)-- as tipoProceso
,(case 
	when p.Class = 'H' then 'Alta'
	when p.Class = 'M' then 'Media'
	when p.Class = 'L' then 'Baja'
	else 'Sin Definir' end) as clase
,pm.Name-- as modelo
,(case 
	when p.ProductLine = 'R' then 'Carretera'
	when p.ProductLine = 'S' then 'Estándar'
	when p.ProductLine = 'M' then 'Montaña'
	when p.ProductLine = 'T' then 'Paseo'
	else 'Sin Clasificación' end )-- as linea
,(case 
	when p.Style = 'W' then 'Femenino'
	when p.Style = 'M' then 'Maculino'	
	else 'Unixes' end)-- as Genero
,(case 
	when p.Color is null then 'Sin Definir'
	else p.Color end)-- as Color
,(case 
	when p.SafetyStockLevel < p.ReorderPoint then 'Poco Sotck'
	else 'Buen Stock' end )-- as estadoBodega
FROM adw.Production_Product p
LEFT JOIN adw.Production_ProductModel pm
	ON p.ProductModelID = pm.ProductModelID
LEFT JOIN adw.Production_ProductSubcategory ps
	ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN adw.Production_ProductCategory pc
	ON ps.ProductCategoryID = pc.ProductCategoryID;



