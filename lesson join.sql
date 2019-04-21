use univ;

SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM enroll;

SELECT * FROM student WHERE sname = "홍길동";


select s.sno, s.name, e.cno, fianl # proejction
from student s, enrol e # join
where s.sno = e.sno # selection
and s.year = 4; # selection

select *
from student s, enroll e;
# where s.sno = e.sn if no conditions, perform cartisan product, 
# no meaning ful data

select *
from student s, enroll e
where s.sno = e.sn; # join, if ..  
# no meaning ful data

# 자신을 참조하는  join
use univ;
SELECT 
    *
FROM
    student s1,
    student s2
WHERE
    s1.dept = s2.dept;

# 가상의 테이블 eployee(eno, ename, dept, manager_id)
select *
from employee
where manager_id = 100;

# 상사의 이름이 'Mike'인 직원을 검색하라 
select ename
from employee e, employee m
where e.manager_id = m.eno # e의 외래키를 봤다면, 어떤 테이블의 기본키와 join을 해야한다.
#여기서는 e.manager_id 각각에 자신의 직원번호와 concatenate 했다.
and m.ename  ;

# Aggregate
use university;
select count(distinct cno) from enrol;
select cno from enrol;
select distinct cno from enrol;
select count(distinct sno) as st_num, avg(final) as final_avg, max(final) as final_max
from enrol
where cno = 'DB';

# 1 집계함수와 일반 애트리뷰트와 같이 Select 할수 없다 
# 2 집계함수를 알파벳에 쓸수 없다 1) avg 는 0이 나온다 2) max 아스키 코드 순이다.

select cno, count(*), avg(final) ;

# 애트리뷰트로 그루핑 한 그룹별로 보여준다.
select cno as 과목, count(*) as 학생수, avg(final) as 평균
from enrol
group by cno;
#그루핑 한 애트리뷰트만 같이 select가 가능하다. 다른 애트리뷰트는 안된다  


#having 조건을 쓰면, 그런 그룹틀만 보여준다. 그런 그룹들 중에 조건을 명세하는 것이다. 
select cno as 과목, count(*) as 학생수, avg(final) as 평균
from enrol
group by cno
having count(*) <3;
# 3개 그룹이 빠진다. 그룹을 필터링, 그룹을 선택할 수 있다.

# 처음은 테이블, 그다음은 where, 그다음 그룹, 그다음 해빙조건
select cno as 과목, count(*) as 학생수, avg(final) as 평균
from enrol
where sno < 400
group by cno
having count(*) <3;

# 따라서 join이 먼저 진행되고 그다음 그루핑-having이 진행된다. 
select cno as 과목, count(*) as 학생수, avg(final) as 평균
from enrol e, student s
where
e.sno = s.sno
and s.dept = 'SW'
group by cno
having count(*) <3;

# 마지막으로 최종 그룹을 정렬할 수 있다.
select cno as 과목, count(*) as 학생수, avg(final) as 평균
from enrol e, student s
where
e.sno = s.sno
and s.dept = 'SW'
group by cno
having count(*) > 0
order by cno;

# 2학년 학생들이 수강하는 과목들의 과목번호 과목별 기말고사 최대 최소 값을 과목번호 순으로 검색하라alter
select e.cno as 과목, count(*) as 학생수, min(e.final) as 기말고사최소값, max(e.final) as 기말고사최대값 
from enrol e, student s
where
	e.sno = s.sno
	and s.syear = 2
group by e.cno
order by e.cno;

# 숙제는 보고서로 만들어서 제시 스크린샷으로 