CREATE DEFINER=`root`@`localhost` PROCEDURE `new_participant`(UNI VARCHAR(12), section_call_no CHAR(5))
BEGIN
	
	DECLARE course_id varchar(12) DEFAULT 'NOTPICK';
	DECLARE role enum('S','F') DEFAULT 'S';
    
	SET course_id = find_course_id(section_call_no);
    SET role = (select `type` from `Person`where `Person`.`UNI`=UNI);
    
    IF role = 'S' THEN
		IF `student_enrollment_limitation`(section_call_no)=0 THEN
			IF `student_course_limitation`(UNI)=0 THEN
				IF `student_section_limitation` (UNI, section_call_no)=0 THEN
					IF `check_student_conflict`(UNI, section_call_no)=0 THEN
						IF `meet_prereq`(UNI, section_call_no) = 1 THEN
							INSERT INTO `course_participant`(UNI, section_call_no, course_id, taught_or_taken) 
							VALUES (UNI, section_call_no, course_id, 0);
						ELSE
							SIGNAL sqlstate  '45100'
							SET MESSAGE_TEXT='Find some prerequisite courses.';
						END IF;
					ELSE
						SIGNAL sqlstate  '45100'
							SET MESSAGE_TEXT='Time conflict.';
					END IF;
				ELSE
					SIGNAL sqlstate  '45100'
					SET MESSAGE_TEXT='Exceed section limitation';
				END IF;
			ELSE
				SIGNAL sqlstate  '45100'
					SET MESSAGE_TEXT='Exceed course limitation.';
			END IF;
		ELSE
        SIGNAL sqlstate  '45100'
					SET MESSAGE_TEXT='Exceed enrollment limitation';
		END IF;
        
	ELSEIF role = 'F' THEN
        
		IF EXISTS (SELECT * FROM `faculty_schedule` WHERE `faculty_schedule`.`section_call_no`= section_call_no) THEN
			SIGNAL sqlstate  '45100'
				SET MESSAGE_TEXT='This section is taught by other faculty.';
        ELSE
			IF `faculty_section_limitation`(UNI)=0 THEN
				IF `check_faculty_conflict`(UNI, section_call_no)=0 THEN
					INSERT INTO `course_participant`(UNI, role, section_call_no, course_id,taught_or_taken) VALUES (UNI, role, section_call_no, course_id, 0);
				ELSE 
					SIGNAL sqlstate  '45100'
						SET MESSAGE_TEXT='Time conflict.';
				END IF;
			ELSE
				SIGNAL sqlstate  '45100'
					SET MESSAGE_TEXT='You can not take more courses.';
			END IF;
		END IF;
	END IF;
END