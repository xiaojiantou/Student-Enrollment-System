CREATE DEFINER=`root`@`localhost` FUNCTION `new_department_code`(department_name varchar(32)) RETURNS varchar(4) CHARSET utf8
BEGIN
	DECLARE dcode VARCHAR(4);
	SET dcode = UPPER(SUBSTR(department_name,1,4));
    
RETURN dcode;
END