use univ;

SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM enrol;

# Selection
SELECT * FROM student WHERE sname = "홍길동";

# SJP
select s.sno, s.name, e.cno, fianl # proejction
from student s, enrol e # join
where s.sno = e.sno # selection
and s.year = 4; # selection

# Cartisan product
select *
from student s, enrol e;
# where s.sno = e.sn if no conditions, perform cartisan product, 
# no meaning ful data

# Natural join
SELECT *
FROM student s, enrol e
WHERE s.sno = e.sn; 

# Left join
SELECT s.sno
FROM student s LEFT JOIN enrol e
ON s.sno = e.sno
WHERE s.sname = "나수영";# join, if  no meaningful data

# Aggregation over entire relation
SELECT min(final), max(final), avg(final)
FROM enrol;
-- WHERE sno = 100;
-- WHERE cno = 'C413';

# Aggregation over each group
SELECT cno, count(*), min(final), max(final), avg(final)
FROM enrol
GROUP BY cno;

# Aggration on year
SELECT year, count(year)
FROM student
GROUP BY year;

# Double referencing
SELECT * # s.sname for those names who attend to "데이터베이스"
FROM student s, enrol e, course c
WHERE s.sno = e.sno AND e.cno = c.cno AND c.cname = "데이터베이스";

# SJP practice
