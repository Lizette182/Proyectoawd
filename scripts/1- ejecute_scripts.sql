-- ********************************************
--      CREAMOS BASE DE DATOS
-- ********************************************
source ./scripts/adw_datawh.sql

-- ********************************************
--      CREAMOS LA DIMENSION PRODUCTO
-- ********************************************
source ./scripts/dim_producto.sql

-- ********************************************
--      CREAMOS LA DIMENSION UBICACION
-- ********************************************
source ./scripts/dim_ubicacion.sql


-- ********************************************
--      CREAMOS LA DIMENSION TIEMPO
-- ********************************************
source ./scripts/dim_tiempo.sql

-- ********************************************
--      CREAMOS LA DIMENSION CLIENTE
-- ********************************************
source ./scripts/dim_cliente.sql
