CREATE DEFINER=`root`@`localhost` FUNCTION `year_converter`(time TIMESTAMP) RETURNS int(5)
BEGIN

	DECLARE year int(5);
    
	IF month(time)>=9 and month(time)<=12 THEN
		SET year = year(time);
	ELSEIF month(time)>=1 and month(time)<=8 THEN
		SET year = year(time)-1;
	ELSE 
		SIGNAL SQLSTATE '45123'
			SET MESSAGE_TEXT='Invalid time';
    END IF;

RETURN year;
END