--현재 계정 내에 어떤 테이블이 있는가?
select * from tab;

--테이블 구조 확인
desc employees;

--모든 컬럼 확인
--  테이블에 정리된 순서대로
select * from employees;

desc departments;

select * from departments;

select first_name,
phone_number,
hire_date,
salary from employees;

--산술 연산 사용
select 3.14*3*3 from employees; --모든 레코드를 불러와 산술 연산을 수행
select 3.14*3*3 from dual;

select first_name, salary,salary*12 from employees;

select job_id*12 from employees; --error:산술은 수치 자료형만

desc employees;

--사원의 이름,salary,comission_pct 출력
select First_name, salary, commission_pct
from employees;

--계산식에 null이있으면 항상 null이다
select first_name,
salary, salary+(salary*commission_pct)
from employees;

--nvl 함수:null-> 다은 기본 값으로 치환
select first_name,
salary + (salary  * nvl(commission_pct,0)) 돈
from employees;

--문자열의 연결 |
--변멸 이름,  as 이름, "이름" 다 가능 
select first_name || ' ' || last_name as 이름
from employees;

select first_name || ' ' ||last_name as 이름,
hire_date as 입사일,
phone_number as 전화번호,
salary as 급여,
salary*12 as 연봉
from employees;

--------
--where: 조건에 맞는 레코드 추출을 위한 조건 비교
select first_name || ' ' ||last_name as 이름,
salary*12 as 연봉
from employees where
salary >= 15000;

select first_name || ' ' ||last_name as 이름,
hire_date 입사일
from employees where
hire_date>= '07/01/01';

select first_name 이름,
salary*12 연봉,
hire_date 입사일,
department_id 부서ID
from employees where
first_name = 'Lex';

select first_name || ' ' ||last_name as 이름,
department_id 부서ID
from employees where
department_id  = 10;

--like 연산
--%는 임의의 길이 (0일수 있다)의 문자열
-- _ 1개의 문자

--이름에 am 을포함한 모든 이름
select First_name,
salary
from employees 
where first_name like '%am%';

--이름의 1번째 글자가 a인 사원
select First_name,
salary
from employees 
where first_name like '_a%';

select first_name ,
salary 급여
from employees 
where salary<=14000 or salary >=17000;

select first_name ,
department_id ,
salary
from employees 
where department_id =90 and salary>=20000;

select first_name ,salary
from employees
where salary between 14000 and 17000;

select first_name || ' ' ||last_name as 이름,
hire_date 입사일
from employees where
hire_date between '07/01/01' and '07/12/31';

select * from employees
where department_id = 10 or  department_id = 20 or department_id = 40;

select * from employees
where department_id in(10,20,40); --department_id 아이디가 10,20,40인 경우

select manager_id from employees
where manager_id = 100 or manager_id = 120 or manager_id = 147;

select manager_id from employees
where manager_id in (100,120,147);

--커미션을 받지 않는 사원 목록
select first_name,commission_pct from employees
where commission_pct is null;

--커미션 받는 사원 목록
select first_name,commission_pct from employees
where commission_pct is not null;

select department_id "부서 번호",
salary 급여, first_name|| ' ' ||last_name as 이름
from employees 
where salary>=10000 order by department_id asc--1차 정렬 기준
, salary desc;--2차 정렬기준

--------------
--단일행 함수
--개별 레코드에 적용되는 함수
--------------

--문자열 단이행 함수
select first_name,last_name,
concat(first_name,concat(' ',last_name)) name,
initcap(first_name || ' ' || last_name) name2, --각단어 처음만 대문자
lower(first_name),--전부 소문자
upper(first_name),--전부 대문자
lpad(first_name,10,'****'),
lpad(first_name,10,'****')
from employees;

--first_name에 am이 포함된 사원 출력
select first_name from employees
where first_name like '%am%';

--lower 로 am인 사람 구하는거
select first_name from employees
where lower(first_name)like '%am%';

--정제
select ' Oracle','*****Database*****'
from dual;

select ltrim('    Oracle     '),--왼쪽 빈 공간을 지움
    rtrim('     Oracle     '),--오른쪽 빈 공간을 지움
    trim('*' from '*****Database*****'),-- 문자열 내에 특징 문자를 제거
    substr('Oracle Database',8, 8),--문자열 에서 8번째 글자 부터 8문자를 추출
    substr('Oracle Database',-8, 8)--뒤에서부터 8번째 글자로 부터 8문자 추출
    from dual;
    
--수치형 단일행 함수 
select abs(-3.14),--절대값
    ceil(3.14),--올림
    round(13.141,2),--반올림
    round(13.141,0),
    round(13.141,-1),
    floor(3.14),--내림
    mod(7,3),--나눗셈 나머지
    floor(7/3), -- 나머지 몫
    power(2,4),--제곱 2의 4승
    trunc(3.5), -- 버림
    trunc(3.56789,2),--소수점 2째 자리 까지 버림
    sign(-10)--부호 함수 양수면 1 음수면 -1 0이면 0
     from dual;
     
----날짜형 단일행 함수
select sysdate from dual; --시스템 가상 테이블 1개

select sysdate from employees;

select sysdate,--시스템 날짜
add_months(sysdate,2),-- 오늘 부터 2개월후
months_between(to_date('1999-12-31','yyyy-mm-dd'),sysdate),--개월 차
next_day(sysdate,7),--오늘 이후 첫번째 금요일 1=월  7=일
round(sysdate,'month'),
trunc(sysdate,'month')
from dual;

--employees 사원들의 입사한지 얼마나 지났는지
select first_name,hire_date,
round(months_between(sysdate,hire_date),2) as months
from employees;

----------
---변화함수
----------

/*
to_char(o,fnt) 숫자 또는 날짜를 문자열로
to_number(s,fmt) 문자열을 숫자로
to_date(s,fmt) 문자열을 날짜로
*/

---tochar
select first_name,to_char(hire_date,'yyyy-mm-dd hh24:mi:ss') 입사일
from employees;

---현재 시간을 년 - 월-일 오전/오후 시:분:초 형식
select sysdate, to_char(sysdate,'yyyy-mm-dd pm hh:mi:ss')
from dual;

select first_name, 
to_char(salary*12,'$999,999,999')  연봉
from employees;

--to_number:문자열 -> 숫자
select 
to_number('$1,500,580', '$999,999,999')
from dual;

----to_date 날짜형 문자열을 ->date
select 
to_date('2021-03-16 15:07','yyyy-mm-dd hh24:mi')
from dual;

/*
날짜연산에+(-) number 경우 일수 더하거나 뺌
date -date : 두날짜 사이의 일수
date +number/24 :  날짜에 시간을 더하거나 뺄때
*/
--
--select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')"오늘",
--to_char(sysdate-8,'yyyy-mm-dd hh24:mi:ss') "8일뺀것",
--to_char(sysdate+8,'yyyy-mm-dd hh24:mi:ss') "8일더한것",
--sysdate - to_date('1999-12-31',yyyy-mm-dd'), --1999-12-31 이후 얼마나 지났나
--to_char(sysdate+12/24,'yyyy-mm-dd hh24:mi')
--from dual;

--null 관련
select first_name,
salary,
nvl(salary * commission_pct,0) commission
from employees;

select first_name,
salary,
nvl2(commission_pct,salary * commission_pct,0) commission
--commission_pct 이 null 이면 곱하는것이 아니면 0이 된다
from employees;

-----case function
-- 보너스 지급 
--ad관련 직원 ->20%,sa관련 직원 10%,it관련 직원 8%,나머지는 3%
select first_name,job_id from employees; --job_id 형태 확인

select first_name,substr(job_id ,1,2) 직종,
case substr(job_id ,1,2) 
    when 'AD' then salary *0.2--if
    when 'SA' then salary *0.1--else if
    when 'IT' then salary *0.08 --else if
    else salary * 0.03
    end bonus
from employees;

--decode
select first_name,substr(job_id ,1,2) 직종,salary,
decode(substr(job_id ,1,2), --비교값
'AD',salary*0.2, --if
'SA',salary*0.1, --if else
'IT',salary*0.08,
salary*0.03)bonus --end
from employees;


select first_name,department_id,
case when department_id>=10 and department_id<=30 then 'A-Group'
 when  department_id<=50 then 'B-Group'
  when department_id<=100 then 'C-Group'
  else 'remainder'
  end team
from employees
order by team;


select *from employees;

--문제 1
select first_name || ' '||last_name 이름,
salary 월급, phone_number 핸드폰,hire_date 입사일
from employees
order by hire_date ;

--문제2
select job_title 업무이름, max_salary 최고월급
from jobs
order by job_title asc, max_salary desc;

--문제3
select  first_name || ' '||last_name 이름,
manager_id 매니저이름,commission_pct 컴미션비율,salary 월급
from employees
where manager_id is not null and salary > 3000 and commission_pct is null
order by salary desc;
--문제 4
select job_title "업무의 이름",
max_salary 최고월급
from jobs
where max_salary>10000
order by max_salary desc;
--문제 5
select first_name 이름,salary 월급, nvl(commission_pct,0)*100 컴미션퍼센트
from employees
where salary < 14000 and salary >= 10000 order by salary desc;

--문제6 
select first_name || ' '||last_name 이름,salary 월급,TO_CHAR(hire_date,'yyyy-mm') 입사일,
department_id 부서번호
from employees
where department_id in(10,90,100);
--문제 7
select first_name || ' '||last_name 이름,salary 월급
from employees
where lower(first_name)like'%s%';
--문제 8
select *
from DEPARTMENTS
order by length(department_name) desc;
--문제 9
select upper(country_name) 나라이름
from countries
order by upper(country_name);
--문제 10
select first_name || ' '||last_name 이름, salary 월급,
replace(phone_number,'.','-') 핸드폰, hire_date 입사일
from employees
where hire_date < '03/12/31';