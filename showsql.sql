column username format a15 word_wrapped
column module format a15 word_wrapped
column action format a15 word_wrapped
column client_info format a15 word_wrapped
column status format a10
column sid_serial format a15 

set feedback off
set serveroutput on

select username, ''''||sid||','||serial#||'''' sid_serial,
	status, module, action, client_info
  from v$session
 where username is not null
/

column username format a20
column sql_text format a90 word_wrapped

set serveroutput on size 1000000
declare
	x number;
	procedure p (p_str in varchar2)
	is
		l_str long := p_str;
	begin
		loop
			exit when l_str is null;
			dbms_output.put_line(substr(l_str,1,250));
			l_str := substr(l_str,251);
		end loop;
	end;
begin
	for x in (select username||'('||sid||','||serial#||
			') ospid = '||process||' program = '||program username,
			to_char(LOGON_TIME,' Day HH24:MI') logon_time,
			to_char(sysdate,' Day HH24:MI') current_time,
			sql_address, LAST_CALL_ET
		    from v$session
		   where status = 'ACTIVE'
		     and rawtohex(sql_address)<>'00'
		     and username is not null
		   order by last_call_et)
	loop
		dbms_output.put_line('--------------------------------');
		dbms_output.put_line(x.username);
		dbms_output.put_line(x.logon_time || ' ' || x.current_time ||
					' last et = ' || x.LAST_CALL_ET);
		for y in (select sql_text from v$sqltext_with_newlines
			   where address = x.sql_address order by piece)
		loop
			p(y.sql_text);
		end loop;
	end loop;
end;
/

