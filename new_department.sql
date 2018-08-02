CREATE DEFINER=`root`@`localhost` PROCEDURE `new_department`(name varchar(32))
BEGIN
	DECLARE code varchar(4);
    
	SET code = new_department_code(name);
    
    INSERT INTO `department`(code, name) VALUES (code, name);
END