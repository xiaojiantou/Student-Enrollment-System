CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_faculty_procedure`(uni VARCHAR(12))
BEGIN
	IF EXISTS (SELECT * FROM `Faculty` WHERE `Faculty`.`UNI` = uni) THEN
		DELETE FROM `Faculty` WHERE `Faculty`.`UNI` = uni;
		DELETE FROM `Person` WHERE `Person`.`UNI` = uni;
	ELSE
		SIGNAL SQLSTATE  '45100';
    END IF;
END