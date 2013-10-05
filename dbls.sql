column object_name format a30
column tablespace_name format a30
column object_type format a20
column status format a1

break on object_type skip 1

select object_type, object_name,
	decode(status,'INVALID','*','') status,
	decode(object_type,
		'TABLE',
			(select tablespace_name from user_tables
			  where table_name = object_name),
		'TABLE PARTITION',
			(select tablespace_name from user_tab_partitions
			  where partition_name = subobject_name),
		'INDEX',
			(select tablespace_name from user_indexes
			  where index_name = object_name),
		'INDEX PARTITION',
			(select tablespace_name from user_ind_partitions
			  where partition_name = object_name),
		'LOB',
			(select tablespace_name from user_segments
			  where segment_name = object_name),
		null) tablespace_name
  from user_objects a
 order by object_type, object_name
/

column status format a10

