use univ;
# 'DB'는 수강하고 'OS'는 수강하지 않는 학생의 이름, 학과를 검색하라
select s.sname, s.dept
from student s
where s.sno in (select sno
			from enrol 
            where cno = 'DB' and cno <> 'DM'
            );
# 정답
select s.sname, s.dept
from student s
where s.sno in (select sno
			from enrol 
            where cno = 'DB'
            )
and s.sno not in (select sno
			from enrol
			where cno = 'DM'
            );
select * from enrol where cno = 'DB';
select * from enrol where cno <> 'DM';

            
# 그냥 이렇게 써도 되네 
select * from enrol where sno = 100 or sno =600;
select * from enrol where sno in (100, 600);

# 조인으로 
select sname, dept
from enrol e, cno c
where e.sno = c.sno and e.cno = 'DB' and e.cno <> 'OS';

# 200번의 모든 기말 성적보다 기말성적이 높고, DB를 수강하는 학생을 출력하라 
select sno, cno, final
from enrol
where final > all (select final from enrol where sno = 200)
and sno in (select sno from enrol where cno = 'DB') # 없어도 된다. 같다는 것 같다.
and cno = 'DB';

# OS를 수강하는 학생 중에서 DB를 수강하는 학생들의 모든 기말 성적보다 높은 기말고사 성적을 받은 학생의 이름과 학과
select sname, dept
from enrol
where final > all
	(select final
    from enrol
    where cno = 'DB')
and
	cno = 'OS';
    
# 문자열 검사
select *
from student
where sname like '%2';
select *
from course
where cname like '%데';
select *
from course
where cno like 'D_';

# exist의 반환은 참 혹은 거짓이며 튜플단위로 반환된다.
select sname
from student s
where exists (select 1 from enrol e
			where e.sno = s.sno
			and e.cno = 'DB');
           
# in 으로
select sname 
from student s 
where sno in (select sno from enrol e where e.cno = 'DB';

# 
select sname 
from student s, enrol e
where s.sno = e.sno and e.cno = 'DB';

# DB를 수강하지 않는 학생의 
select sname
from student s
where not exists (select 1 from enrol e
			where e.sno = s.sno
			and e.cno = 'DB');

select sname 
from student s 
where sno not in (select sno from enrol e where e.cno = 'DB';

# 조인으로는 표현이 불가능 DB말고 다른 것을 수강하는 학생
select sname 
from student s, enrol e
where s.sno = e.sno and e.cno <> 'DB';

# union 합집합이므로 중복 제거 된다.
select sno
from student
where year = 2
union
select sno
from enrol
where cno = 'DB';

# join 으로 할 때, s, e에서 각각 나오니까 중복 존재
select sno
from student s, enrol e
where s.sno = e.sno and ( s.year = 2 or e.cno = 'DB');
select distinct sno
from student s, enrol e
where s.sno = e.sno and ( s.year = 2 or e.cno = 'DB');
select distinct sno
from student s join enrol e on (s.sno = e.eno)
where s.year = 2 or e.cno = 'DB';

# update
update course
set credit = credit + 1
where cno = 'DB'

# join update : join 을 이용한다.
# 소프트웨어 학생들의 기말고사 성적을 10점씩 올려라.
update enrol e, student s
join student s on e.sno = s.sno
set e.final = e.final + 10
where s.dept = 'SW'

 