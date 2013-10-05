set echo off
set serveroutput on size 1000000
define _editor=vi

alter session set nls_date_format = 'dd-MON-yyyy hh24:mi:ss';

column version format a10 word_wrapped
column owner format a30 word_wrapped
column userid format a30 word_wrapped
column object_name format a30
column segment_name format a30
column file_name format a30
column name format a30
column what format a30 word_wrapped
column tablespace_name format a30 word_wrapped
column default_tablespace format a30 word_wrapped
column temporary_tablespace format a30 word_wrapped

column created_by format a20 word_wrapped

set trimspool on
set long 5000
set linesize 110
set pagesize 9999

column global_name new_value gname
set termout off
select lower(user) || '@' || global_name global_name
  from global_name;
set termout on
set sqlprompt '&gname> '

