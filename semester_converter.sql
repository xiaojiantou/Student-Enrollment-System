CREATE DEFINER=`root`@`localhost` FUNCTION `semester_converter`(time TIMESTAMP) RETURNS int(1)
BEGIN

	DECLARE semester int(1);
    
	IF month(time)>=9 and month(time)<=12 THEN
		SET semester = 1;
	ELSEIF month(time)>=1 and month(time)<=4 THEN
		SET semester=2;
	ELSEIF month(time)>=4 and month(time)<=6 THEN
		SET semester=3;
	ELSEIF month(time)>=7 and month(time)<=8 THEN
		SET semester=4;
	ELSE 
		SIGNAL SQLSTATE '45123'
			SET MESSAGE_TEXT='Invalid time';
    END IF;

RETURN semester;
END