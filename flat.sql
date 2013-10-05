set wrap off
set linesize 100
set feedback off
set pagesize 0
set verify off
set termout off
spool _flat&1..sql
prompt select
select lower(column_name)||'||chr(44)||'
  from user_tab_columns
 where table_name = upper('&1')
   and column_id != (select max(column_id)
                       from user_tab_columns
                      where table_name = upper('&1'))
/
select lower(column_name)
  from user_tab_columns
 where table_name = upper('&1')
   and column_id = (select max(column_id)
                       from user_tab_columns
                      where table_name = upper('&1'))
/
prompt from &1
prompt /
spool off
set termout on
set verify on
@_flat&1..sql
//host rm _flat&1..sql
