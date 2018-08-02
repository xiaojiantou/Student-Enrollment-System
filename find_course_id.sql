CREATE DEFINER=`root`@`localhost` FUNCTION `find_course_id`(section_call_no CHAR(5)) RETURNS varchar(12) CHARSET latin1
BEGIN

	SET @course_id = (SELECT `course_id` FROM `sections` where `sections`.`call_no`= section_call_no);
	
RETURN @course_id;
END
