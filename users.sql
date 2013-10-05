col username a30
col default_tablespace a30

select username, default_tablespace, temporary_tablespace
  from dba_users
 order by 1
/
