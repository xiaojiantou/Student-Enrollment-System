CREATE DEFINER=`root`@`localhost` PROCEDURE `new_student_procedure`(last_name 
	VARCHAR(32), first_name VARCHAR(32), school VARCHAR(32), year INT(5), email varchar(45))
BEGIN
	DECLARE new_uni VARCHAR(12);
    
	SET new_uni = `gen_uni`(last_name, first_name);
    
    IF (year<2015) OR (year>2018) THEN
		SIGNAL SQLSTATE '04022';
	ELSE
		INSERT INTO `Person` (last_name, first_name, UNI, type) VALUES (last_name, first_name, new_uni , 'S');
		INSERT INTO `Student` (UNI, school, year, email) VALUES (new_uni , school, year, email);
    END IF;
END