set pause off
set heading off
set feedback off
spool _compbody.sql
select 'alter package "' || object_name ||'" compile body;'
  from user_objects
 where object_type = 'PACKAGE BODY'
   and status = 'INVALID'
/
spool off
set heading on
set feedback on
@_compbody.sql
select 'show errors package body ' || object_name
  from user_objects
 where object_type = 'PACKAGE BODY'
   and status = 'INVALID'
/
host rm _compbody.sql

