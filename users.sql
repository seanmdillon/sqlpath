col username a30
col default_tablespace a45

select username, default_tablespace, temporary_tablespace
  from dba_users
 order by 1
/
