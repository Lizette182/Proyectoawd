/********************************************************************************
***************   FUNCION PARA VALIDAR EL SEMESTRE DE UNA FECHA   ***************
*******************************************************************************/
DELIMITER //
CREATE FUNCTION datawh.DeterminarSemestre(fecha DATE)
RETURNS VARCHAR(80)
DETERMINISTIC
NO SQL
READS SQL DATA
BEGIN
    DECLARE semestre VARCHAR(20);
    DECLARE anio VARCHAR(4);
    
    SET anio = YEAR(fecha);
    
    IF MONTH(fecha) BETWEEN 1 AND 6 THEN
        RETURN CONCAT('Primer Semestre ', anio);
    ELSE
        RETURN CONCAT('Segundo Semestre ', anio);
    END IF;
    
END;
//
DELIMITER ;