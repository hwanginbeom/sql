-- 1.select.sql
/*학습내용
1. 존재하는 table 기반으로 검색
2. sql 문장 종류
	1. Query[DQL] 
		- 검색 , 질의 , select 문자형
	2. 데이터 조작 언어 [DML]
		- insert/update/delete
3. select 문자형
	1단계 - 단순 sql문장
		select 절[컬럼명 1 , 컬럼명2,..]
		from 절 [table명]
		- 실행 우선 순위 : from절 -> select절
	2단계 - 검색 되는 컬럼에 별칭 부여
		select 절[컬럼명 1 별칭, 컬럼명2 as 별칭]
		from 절 [table명]	
		
	3단계 - 검색 된 데이터 기준으로 정렬 가능
		select절
		form절
		order by 절
		
		-실행 순서 : from절 -> select절 -> order by 절
	4단계 - 검색시 조건문 적용 (where)
		select 절
		from 절
		where  절
			- 실행 순서 :from절 -> where절 -> select 절



--1. sqlplus창 보기 화면 여`백 조절 편집 명령어
	-- 영구 저장 안됨. sqlplus 실행시마다 해 줘야 함
	-- sql명령어가 아니라 sqlplus만의 설정 명령어
set linesize 200
set pagesize 200


--2. 해당 계정의 모든 table 목록 검색
	-- emp : 사원정보 table
	-- dept : 부서정보 table
	  -- emp table의 부서번호(deptno)는 반드시 dept의 deptno에 존재해야 함
	  /* table 간에도 주종(상하=부모자식)관계
		1. 부모(주) table : dept
		2. 자식(종) table : emp   */
select * from tab;

--dept table 의 모든 데이터 검색
select * from dept;


--3. emp table의 모든 정보 검색
select * from emp;

--4. emp table의 구조 검색[묘사]
desc emp;

--5. emp table의 사번(empno)과 이름(ename)만 검색

-- 표준 sql 문장은 대문자 , 가변적이 컬럼명 , table명들은 소문자 권장 

select empno , ename from emp;
SELECT empno , ename from emp;

-- 검색 컬럼명 별칭 부여 방법 : 
	--방법1. 컬럼명 별칭,  방법2. 컬럼명 as 별칭
 SELECT empno 사번 , ename as 사원명 FROM emp;	
 
 
-- as 키워드 생략 가능
-- 별칭은 보안 고려한 검색시 권장


--6. emp table의 입사일(hiredate) 검색
	-- 검색 결과 : 날짜 타입 yy[년]/mm[월]/dd[일], 차후에 함수로 가공
	select hiredate from emp;


--7. emp table의 검색시 칼럼명 empno를 사번이란 별칭으로 검색 

select empno as 사번 from emp;

--8. 부서번호(deptno) 검색시 중복 데이터 제거후 검색 
-- 키워드 : 중복제거 키워드 - distinct
	-- 사원들이 소속된 부서 번호(deptno)만 검색

	select distinct deptno from emp;

--9. 데이터를 오름차순(asc)으로 검색하기(순서 정렬)
-- 키워드 : 정렬 키워드 - order by
--		asc : 오름차순, desc : 내림차순

	select distinct deptno 
	from emp
	order by deptno asc;



-- 10.emp table 에서 deptno 내림차순 정렬 적용해서 ename과 deptno 검색하기

--  ? 실행 순서에 대해서 입증 가능한 sql 문장 구성해보기..
select ename 사원명, deptno
from emp
order by deptno desc , 사원명 desc;

	-- 검색된 데이터를 기준으로 부서별 이름들도 내림차순 정렬 검색




-- 11. 입사일(date 타입의 hiredate) 검색, date 타입은 
		--정렬가능 따라서 경력자(입사일이 오래된 직원 : asc)부터 검색

-- cmd창에서 드래그 하고 enter 누르면 복사 된다.



-- *** 연산식 ***
-- oracle db의 참고 및 유용한 table(잉여 table , dui) : dual 



--12. emp table의 모든 직원명(ename), 월급여(sal), 연봉(sal*12) 검색
-- 단 sal 컴럼값은 comm을 제외한 sal만으로 연봉 검색


-- 13. 모든 직원의 연봉 검색(sal *12 + comm) 검색
-- comm은 년에 1회 지급이라 가정
	-- *** 검색 실패 : null에 대한 처리 필수
	-- null은 연산 불가

	--null 에 대한 해결책 : null 에 대해 연산 가능학 값으로 대체 
	--연산 따라서 null 값을 유효한 표현식인 0 으로 대체 	
	-- nvl (comm ,  0 ) : 오라클 내장함수 
	select ename , sal ,(sal*12+nvl(comm , 0)) 연봉 , comm from emp;


-- 해결책 : comm이 null인 직원들은 수치 연산이 가능하게 0값으로 대체
	-- nvl(null보유컬럼명, 변경하고자하는수치값) : 오라클 db자체의 함수 



-- *** 조건식 ***
-- where
--14. comm이 null인 사원에 대한 검색(ename, comm)
	-- sql 연산식 : is or is not
select ename , comm from emp;

select ename,comm
from emp 
where comm is null;


--15. comm이 null이 아닌 사원에 대한 검색(ename, comm)


select ename,comm
from emp 
where comm is not null;


--16. ename, 전체연봉... comm 포함 연봉 검색
-- nvl(null값 보유 컬럼명, null인경우 변환하고자하는 기본값)

select ename , (sal*12+nvl(comm,0)) 전체연봉 from emp;

--17. emp table에서 deptno 값이 20인(조건식: deptno =20) 직원 정보 모두 출력하기 
select empno , deptno
from emp
where deptno=20;

select deptno , ename
from emp
where ename ='smith';


--18. emp table에서 ename이 smith(SMITH)에 해당하는 deptno값 검색
-- 문자형 표현 : ' '
-- * 데이터는 대소문자 매우매우 중

요
-- 스미스 철자 확인 
select deptno ename
from emp;
where enmae = 'SMAITH'

--19. sal가 900이상(>=)인 직원들의 이름(ename), sal 검색

select ename , sal
from emp
where sal >= 900;
--sql 문장의 정상 여부 확인을 위한 조건 없이 모두 다 검색

--20. deptno가 10이고(and) job이 메니저인 사원이름 검색 
-- 조건식 두가지 모두 true인 경우 and 연산자 활용 
--job 이 매니저인 사원존재 
select job from emp;

select ename
from emp
where deptno= 10 and job = 'MANAGER';


-- 21. ?deptno가 10이거나(or) job이 메니저(MANAGER)인 사원이름(ename) 검색
-- or 연산자

select ename ,job ,deptno
from emp
where deptno = 10 or job = 'MANAGER';



-- 22. deptno가 10이 아닌 모든 사원명(ename) 검색
-- 아니다 : not 부정 연산자, !=, <>

select ename
from emp
where NOT deptno =10;
where deptno != 10;
where deptno <> 10;


--23. sal이 2000 이하(sal<=2000)이거나(or) 3000이상인(sal>=3000) 사원명(ename) 검색

select ename ,sal
from emp
where sal<=2000 or sal>=3000;


--24. comm이 300 or 500 or 1400인 사원명, comm 검색
-- in 연산자 활용
	-- 다수의 데이터값 표현에 적합
	
	select ename ,comm
	from emp
	where comm in (300,500,1400);


--25. ?comm이 300 or 500 or 1400이 아닌(not) 사원명, comm 검색

	select ename ,comm
	from emp
	where not comm in  (300,500,1400);
	
	where comm not in (300,500,1400);



-- 26. 81년도에 입사한 사원 이름 검색
	-- * oracle db 날짜타입인 date 타입은 대소비교 가능, 값 표현시 ' ' 처리
	-- 함수로 포멧 변경 예정
	-- 81년 1월 1일 ~ 81년 12월 31일까지 범위 
	-- oracle의 date 타입도 대소 비교 연산자 적용 
-- between ~ and
-- 입사년도 확인

select ename
from emp
where hiredate between '81/01/01' and '81/12/31';



-- 27. ename이 M으로 시작되는 모든 사원번호, 이름 검색  
-- 연산자 like : 한음절 _ , 음절 개수 무관하게 검색할 경우 % 음절 상관없음 !

select deptno,ename
from emp
where ename like 'M%';



--28. ename이 M으로 시작되는 전체 자리수가 두음절의 사원번호, 이름 검색

select deptno,ename
from emp
where ename like 'M_';



-- 29. 두번째 음절의 단어가 M인 모든 사원명 검색 


select deptno,ename
from emp
where ename like '_M%';


-- 30. 단어가 M을 포함한 모든 사원명 검색 

select deptno,ename
from emp
where ename like '%M%';
