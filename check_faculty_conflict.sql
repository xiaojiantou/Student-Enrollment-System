CREATE DEFINER=`root`@`localhost` FUNCTION `check_faculty_conflict`(uni varchar(12), section_call_no char(5)) RETURNS tinyint(1)
BEGIN
    DECLARE conflict tinyint(1);
    
    IF EXISTS ( SELECT * FROM `faculty_schedule` WHERE (
    `faculty_schedule`.`uni`=uni AND
    `faculty_schedule`.`year`=(SELECT `year` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `faculty_schedule`.`semester`=(SELECT `semester` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `faculty_schedule`.`start_time`<=(SELECT `start_time` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `faculty_schedule`.`end_time`>=(SELECT `end_time` FROM `sections` WHERE `sections`.`call_no`=section_call_no)
    ))THEN
		SET conflict = 1;
	ELSE
		SET conflict = 0;
	END IF;
    
RETURN conflict;
END
