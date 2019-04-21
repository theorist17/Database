
CREATE TABLE enrol
(
	Sno INTEGER NOT NULL,
	Cno CHAR(6) NOT NULL,
	Grade INTEGER,
	PRIMARY KEY(Sno, Cno),
	FOREIGN KEY(Sno) REFERENCES STUDENT(Sno)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY(Cno) REFERENCES ENROL(Cno)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CHECK(Grade >= 0 and Grade < 0)
);


create database university;
use university;

create table student (
	sno int primary key, # primary key 자체가 not null
    sname varchar(30) not null,
    syear int,
    email varchar(50) unique, # 대체 키
    enter_date datetime default now() #이 튜플이 입련된 시간
);

create table course (
	cno char(2) primary key,
    cname varchar(20) not null,
    credit int not null,
    dept varchar(20),
    enter_date datetime default now()
);

create table enrol (
	sno int,
    cno char(2),
    grade char(1),
    final int,
    midterm int,
    enter_date datetime default now(),
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno)
);

select * from student;
select * from course;
select * from enrol;

insert into student (sno, sname, syear, email) values (1, "이홍인", 3, "theorist17@gmail.com");
insert into student (sno, sname, syear, email) values 
(100, 'Mike', 3, 'hong@konkuk.ac.kr'), 
(200, 'Mike2', 1, 'mike2@konkuk.ac.kr'), 
(300, 'Mike3', 4, 'mike3@konkuk.ac.kr'), 
(400, 'Mike4', 2, 'mike4@konkuk.ac.kr')
;

insert into course (cno, cname, credit, dept)
values
('DB', '데이터베이스', 3, '소프트웨어학과'),
('OS', '운영체제', 3, '컴퓨터공학과'),
('PL', '프로그래밍언어', 2, '소프트웨어학과'),
('DM', '데이터마이닝', 4, '경영학과');


insert into enrol (sno, cno, grade, final, midterm)
values
(100, 'DB', 'A', 100, 95), #1000은 들어가지 않는다
(200, 'DB', 'B', 90, 85),
(300, 'DB', 'A', 95, 90),
(300, 'OS', 'A', 89, 90),
(400, 'OS', 'C', 70, 75),
(100, 'PL', 'B', 90, 80),
(300, 'PL', 'A', 85, 95),
(200, 'DM', 'C', 70, 80),
(400, 'DM', 'B', 85, 80);

alter table enrol
add score float default 0.0;

# DISTINCT : project without duplicate
select * from enrol;
select grade from enrol;
select distinct grade from enrol;

# ORDER BY : 
select * from enrol;
select * from enrol order by sno;
select * from enrol order by sno asc;
select * from enrol order by sno desc;
select * from enrol order by sno desc, cno asc;

# CONDITIONAL SELECT
select * from enrol where final >= 85 and midterm >= 85;
select * from enrol where final >= 85 or midterm >= 85;
select * from enrol where not ( final >= 85 ); # parentheses for not-clause 

# DECORATION OF SELECT
select '학번이 ', sno, '인 학생은, 중간고사 성적이 ', midterm, '점이다.' # adding new fields
from enrol 
where cno = 'DB';
select sno as 학번, '중간시험 = ' as 시험, midterm + 3 as 점수 # as a new attributes # adding 3 to field value
from enrol
where cno = 'DB';

# NESTED SELECT
select * 
from (select sno, midter from enrol) X;




# CARTESIAN PRODUCT
select * 
from student, enrol; # no meaningful information 

# EQUIJOIN
select *
from student s, enrol e
where s.sno = e.sno;

# LEFT JOIN
select s.*
from student s, enrol e
where s.sno = e.sno;

# TRIPPLE JOIN
select *
from student s, enrol e, course c
where s.sno = e.sno and e.cno = c.cno;

select s.sno, s.sname, c.cno, c.cname, e.grade # selective attribute
from student s, enrol e, course c
where s.sno = e.sno and e.cno = c.cno;

#'DB'를 수강하는 학생들의 학번, 이름 기말고사 정보를 기말고사의 내림차순으로 검색하라.
select s.sno, s.sname, e.final
from student s, enrol e
where e.sno = s.sno and e.cno = 'DB'
order by e.final desc;

# JOIN THE SAME TABLE TWICE
select * 
from student s1, student s2;
select * 
from student s1, student s2
where s1.sno = s2.sno;
select * 
from student s1, student s2
where s1.syear = s2.syear;

