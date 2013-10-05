set define off
create or replace package manage_emps as
	procedure add_emps(p_ename 	varchar2,
                           p_empno 	number,
                           p_mgr 	number,
                           p_sal 	number,
                           p_comm 	number,
                           p_deptno 	number);
end manage_emps;
/
	procedure add_emps(p_ename 	varchar2,
                           p_empno 	number,
                           p_mgr 	number,
                           p_sal 	number,
                           p_comm 	number,
                           p_deptno 	number)
	is
	begin
		insert into emp (fename, empno, mgr, hiredate, sal, comm, deptno)
		values (p_ename, p_empno, p_mgr, sysdate, p_sal, p_comm, p_deptno);
	end add_emps;
end manage_emps;
/
set define on
