CREATE DEFINER=`root`@`localhost` FUNCTION `check_student_conflict`(uni varchar(12), section_call_no char(5)) RETURNS tinyint(1)
BEGIN
    DECLARE conflict tinyint(1);
    
    IF EXISTS ( SELECT * FROM `student_schedule` WHERE (
    `student_schedule`.`uni`=uni AND
    `student_schedule`.`year`=(SELECT `year` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `student_schedule`.`semester`=(SELECT `semester` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `student_schedule`.`start_time`<=(SELECT `start_time` FROM `sections` WHERE `sections`.`call_no`=section_call_no) AND
    `student_schedule`.`end_time`>=(SELECT `end_time` FROM `sections` WHERE `sections`.`call_no`=section_call_no)
    ))THEN
		SET conflict = 1;
	ELSE
		SET conflict = 0;
	END IF;
    
RETURN conflict;
END
