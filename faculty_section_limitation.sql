CREATE DEFINER=`root`@`localhost` FUNCTION `faculty_section_limitation`(uni varchar(12)) RETURNS tinyint(1)
BEGIN
    DECLARE limitation tinyint(1);
    
    IF ((SELECT count(*) FROM `faculty_schedule` WHERE `faculty_schedule`.`uni`=uni)>=3) THEN
		SET limitation = 1;
	ELSE
		SET limitation = 0;
	END IF;
    
RETURN limitation;
END
