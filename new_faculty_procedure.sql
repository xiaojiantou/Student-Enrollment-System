CREATE DEFINER=`root`@`localhost` PROCEDURE `new_faculty_procedure`(last_name 
	VARCHAR(32), first_name VARCHAR(32), pay_grade INT(1), title VARCHAR(45), department VARCHAR(45))
BEGIN
	DECLARE new_uni VARCHAR(12);
    
	SET new_uni = `gen_uni`(last_name, first_name);
    
    INSERT INTO `Person` (last_name, first_name, UNI, type) VALUES (last_name, first_name, new_uni , 'F');
	INSERT INTO `Faculty` (UNI, pay_grade, title, department) VALUES (new_uni, pay_grade, title, department);
    
END