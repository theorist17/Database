 use univ;

SELECT 
    s.sno, s.sname
FROM
    student s
WHERE
    'A' = ALL (SELECT 
            e.grade
        FROM
            enrol e
        WHERE
            s.sno = e.sno);

SELECT distinct
	s.sno, s.sname
FROM student s, enrol e
WHERE
	'A' = AlL ( select grade from enrol where sno = s.sno)
    and s.sno = e.sno;
    
select distinct s.sno, s.sname
from student s, enrol e
where
	s.sno in (select sno from enrol where grade = 'A')
    and s.sno not in (select sno from enrol where grade <> 'A');

    
SELECT 
    s.sno, s.sname, e.cno, c.cname, e.grade
FROM
    student s,
    course c,
    enrol e
WHERE
    s.sno = e.sno AND e.cno = c.cno;

insert into student 
values (600, '이홍인', 3, '소프트웨어');

SELECT 
    s.sname
FROM
    student s
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            enrol e
        WHERE
            s.sno = e.sno AND e.grade = 'A');

select s.sno, s.sname, c.cname, e.grade
from student s, course c, enrol e
where s.sno = e.sno and c.cno = e.cno
and s.sno in ( select sno from enrol where grade = 'A');

select s.sno, s.sname, c.cname, e.grade
from student s, course c, enrol e
where s.sno = e.sno and c.cno = e.cno
and e.grade = 'A';

# from 절에 바로 그냥 () temp쳐도 된다.
select temp.*, s.sname
from (
select sno, avg(final)
from enrol
group by sno
having count(*) > 1
order by sno) temp, student s
where temp.sno = s.sno;
