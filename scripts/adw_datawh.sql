
CREATE DATABASE IF NOT EXISTS datawh;
USE datawh;



-- -----------------------------------------------------
-- Table Dim_Producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS datawh.Dim_Producto (
  productoKey INT NOT NULL AUTO_INCREMENT,
  ProductID INT NOT NULL,
  nomProducto VARCHAR(120) NULL,
  categoria VARCHAR(120) NULL,
  subcategoria VARCHAR(120) NULL,
  tipoProceso VARCHAR(45) NULL,
  clase VARCHAR(45) NULL,
  modelo VARCHAR(120) NULL,
  linea VARCHAR(45) NULL,
  genero VARCHAR(45) NULL,
  color VARCHAR(45) NULL,
  estadoBodega VARCHAR(45) NULL,
  PRIMARY KEY (productoKey),
  UNIQUE INDEX unk_productoID (ProductID ASC) VISIBLE
) AUTO_INCREMENT = 3000;


-- -----------------------------------------------------
-- Table Dim_Ubicacion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS datawh.Dim_Ubicacion (
  ubicacionKey INT NOT NULL AUTO_INCREMENT,
  TerritoryID INT NOT NULL,
  continente VARCHAR(70) NULL,
  pais VARCHAR(120) NULL,
  estado VARCHAR(120) NULL,
  ciudad VARCHAR(50) NULL,
  PRIMARY KEY (ubicacionKey),
  UNIQUE INDEX unk_ubicacionKey (ubicacionKey ASC) VISIBLE
)AUTO_INCREMENT = 1200;



-- -----------------------------------------------------
-- Table Dim_Tiempo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS datawh.Dim_Tiempo (
  dateKey INT NOT NULL,
  dateValue DATE NULL,
  numMes INT NULL,
  semestre VARCHAR(45) NULL,
  mesNom VARCHAR(45) NULL,
  numYear INT NULL,
  yearMesNumber VARCHAR(45) NULL,
  PRIMARY KEY (dateKey),
  UNIQUE INDEX unkdateValue (dateValue ASC) INVISIBLE
);



-- -----------------------------------------------------
-- Table Dim_Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS datawh.Dim_Cliente (
  clienteKey INT NOT NULL AUTO_INCREMENT,
  CustomerID INT NOT NULL,
  estadoCivil VARCHAR(45) NULL,
  genero VARCHAR(45) NULL,
  numHijos VARCHAR(45) NULL,
  casaPropia VARCHAR(45) NULL,
  datePrimeraCompra DATE NULL,
  edad INT NULL,
  rangoEdad VARCHAR(120) NULL,
  continente VARCHAR(120) NULL,
  pais VARCHAR(120) NULL,
  PRIMARY KEY (clienteKey),
  UNIQUE INDEX unk_clienteID (CustomerID ASC) VISIBLE
)AUTO_INCREMENT = 9999;



-- -----------------------------------------------------
-- Table FacVentaOnline
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS datawh.FacVentaOnline (
  ventasOnlineKey INT NOT NULL AUTO_INCREMENT,
  subTotalVenta DECIMAL(38,2) NOT NULL,
  totalImpuestos DECIMAL(38,2) NOT NULL,
  totalEnvio DECIMAL(38,2) NOT NULL,
  totalVenta DECIMAL(38,2) NOT NULL,
  totalDescuento DECIMAL(38,2) NOT NULL,
  cantidad INT NOT NULL,
  estadoVenta INT NULL,
  clienteKey INT NULL,
  productoKey INT NULL,
  ubicacionKey INT NULL,
  dateKey INT NULL,
  PRIMARY KEY (ventasOnlineKey),
  INDEX dimProducto_idx (productoKey ASC) VISIBLE,
  INDEX dimUbicacion_idx (ubicacionKey ASC) VISIBLE,
  INDEX dimTiempo_idx (dateKey ASC) VISIBLE,
  INDEX dimCliente_idx (clienteKey ASC) VISIBLE,
  CONSTRAINT dimProducto
    FOREIGN KEY (productoKey)
    REFERENCES Dim_Producto (productoKey)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT dimUbicacion
    FOREIGN KEY (ubicacionKey)
    REFERENCES Dim_Ubicacion (ubicacionKey)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT dimTiempo
    FOREIGN KEY (dateKey)
    REFERENCES Dim_Tiempo (dateKey)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT dimCliente
    FOREIGN KEY (clienteKey)
    REFERENCES Dim_Cliente (clienteKey)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)AUTO_INCREMENT = 3333;