DELIMITER //
CREATE PROCEDURE check_time (IN javaStart varchar(30), IN javaEnd varchar(30), IN javaDept varchar(30))
BEGIN
    DECLARE P_start_day  INT;
    DECLARE P_end_day INT;
    DECLARE P_start_time INT;
    DECLARE P_end_time INT;
    DECLARE D_dept VARCHAR(30);
    DECLARE D_start_day INT;
    DECLARE D_end_day INT;
    DECLARE maxIndex INT; 
    DECLARE cnt INT; 
    DECLARE timeDoctorID INT;
    DECLARE D_start_time_DB varchar(20);
    DECLARE D_end_time_DB varchar(20);
    
    

    SET P_start_day = dayofweek(javaStart);
    SET P_end_day = dayofweek(javaEnd);
    SET P_start_time = TIME(javaStart);
    SET P_end_time = TIME(javaEnd);
	SET D_dept = javaDept;
    
    IF(P_start_day > P_end_day) THEN
         SET P_start_day = P_start_day -7;
         
    END IF;

    SET maxIndex = (select MAX(chartID) from charts);
    SET cnt = 1;
 
    CREATE temporary Table IF NOT EXISTS  timeTable(ID INT, st INT, stTime varchar(20), ed INT, edTime varchar(20)) ; 

    WHILE cnt <= maxIndex DO
    SET D_start_day = (select startDay from charts where chartID = cnt);
    SET D_end_day = (select endDay from charts where chartID = cnt);
    SET timeDoctorID = (select doctorID from charts where chartID = cnt);
    SET D_start_time_DB = (select startTime from charts where chartID = cnt);
    SET D_end_time_DB = (select endTime from charts where chartID = cnt);
 
    IF(D_start_day > D_end_day) THEN 
         SET D_start_day = D_start_day -7; 
         
    END IF;
    
    SET cnt = cnt +1;

    IF (P_start_day = D_start_day and P_end_day = D_end_day and P_start_time >= D_start_time_DB and P_end_time <= D_end_time_DB) THEN 
                    insert INTO timeTable(ID, st, stTime, ed, edTime) values (timeDoctorID, D_start_day, D_start_time_DB, D_end_day, D_end_time_DB);
                    
    ELSEIF (P_start_day = D_start_day and P_end_day != D_end_day and P_start_time >= D_start_time_DB) THEN
                    insert INTO timeTable(ID, st, stTime, ed, edTime) values (timeDoctorID, D_start_day, D_start_time_DB, D_end_day, D_end_time_DB);
                    
    ELSEIF (P_start_day != D_start_day and P_end_day = D_end_day and P_end_time <= D_end_time_DB) THEN
                    insert INTO timeTable(ID, st, stTime, ed, edTime) values (timeDoctorID, D_start_day, D_start_time_DB, D_end_day, D_end_time_DB);
                    
    ELSEIF (P_start_day > D_start_day and P_end_day < D_end_day) THEN
                    insert INTO timeTable(ID, st, stTime, ed, edTime) values (timeDoctorID, D_start_day, D_start_time_DB, D_end_day, D_end_time_DB);
    END IF;

    END WHILE;

   select d.* from timeTable t, doctors d  where t.ID = d.doctorID and d.department = D_dept group by ID;
    #select ID INTO returnID from timeTable where P_start_day >= st and P_end_day <= ed GROUP BY ID ORDER BY rand() LIMIT 1 ;

   DROP TEMPORARY TABLE IF EXISTS timeTable ;
    
END //
DELIMITER ;
DROP PROCEDURE IF EXISTS check_time;
CALL check_time('2019-04-07 09:00:00', '2019-04-07 10:00:00', '안과');
SELECT(@returnID);