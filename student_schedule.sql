CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_schedule` AS select `course_participant`.`UNI` AS `uni`,`sections`.`course_id` AS `course_id`,`sections`.`call_no` AS `section_call_no`,`sections`.`year` AS `year`,`sections`.`semester` AS `semester`,`sections`.`day` AS `day`,`sections`.`start_time` AS `start_time`,`sections`.`end_time` AS `end_time` from (`course_participant` join `sections` on((`course_participant`.`section_call_no` = `sections`.`call_no`))) where ((`course_participant`.`role` = 'S') and (`course_participant`.`taught_or_taken` = 0))
