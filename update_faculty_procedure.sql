CREATE DEFINER=`root`@`localhost` PROCEDURE `update_faculty_procedure`(
uni VARCHAR(12), last_name VARCHAR(32), first_name VARCHAR(32), pay_grade int(1), title VARCHAR(32), department VARCHAR(50))
BEGIN
	IF EXISTS (SELECT * FROM `Faculty` WHERE `Faculty`.`UNI` = uni) THEN
		UPDATE `Faculty` SET `Faculty`.`pay_grade`=pay_grade, `Faculty`.`title`=title , `Faculty`.`department`=department WHERE `Faculty`.`UNI`=uni;
		UPDATE `Person` SET `Person`.`last_name`=last_name, `Person`.`first_name`=first_name WHERE `Person`.`UNI`=uni;
    ELSE
		SIGNAL SQLSTATE  '45100';
	END IF;
END