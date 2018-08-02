CREATE DEFINER=`root`@`localhost` FUNCTION `gen_uni`(last_name VARCHAR(32), 
	first_name VARCHAR(32)) RETURNS varchar(12) CHARSET utf8
BEGIN
	DECLARE c1 varchar(2);
    DECLARE c2 CHAR(2);
    DECLARE prefix CHAR(5);
    DECLARE uniCount INT;
    DECLARE newuni VARCHAR(12);
    
    SET c1 = LOWER(SUBSTR(last_name,1,2));
    SET c2 = LOWER(SUBSTR(first_name,1,2));
    SET prefix = CONCAT(c1,c2,"%");
    
    IF EXISTS (SELECT `UNI` FROM `Person` WHERE UNI LIKE prefix) THEN
		SET uniCount = (SELECT MAX(SUBSTR((SELECT `UNI` FROM `Person` WHERE UNI LIKE prefix), 5)));
	ELSE
		SET uniCount = (SELECT count(*) FROM Person WHERE uni LIKE prefix);
    END IF;
    
    SET newuni = CONCAT(c1,c2,uniCount+1);

RETURN newuni;
END
