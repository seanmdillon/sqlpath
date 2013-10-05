create or replace procedure print_table(p_query in varchar2)
authid current_user
is
	l_thecursor	integer default dbms_sql.open_cursor;
	l_columnvalue varchar2(4000);
	l_status	integer;
	l_desctbl	dbms_sql.desc_tab;
	l_colcnt	number;
begin
	execute immediate 'alter session set nls_date_format=
				''dd-mon-yyyy hh24:mi:ss'' ';

	dbms_sql.parse(l_thecursor, p_query, dbms_sql.native);
	dbms_sql.describe_columns(l_thecursor, l_colcnt, l_desctbl);

	for i in 1 .. l_colcnt loop
		dbms_sql.define_column(
			l_thecursor, i, l_columnvalue, 4000);
	end loop;

	l_status := dbms_sql.execute(l_thecursor);

	execute immediate 'alter session set nls_date_format=
				''dd-MON-rr'' ';

	while (dbms_sql.fetch_rows(l_thecursor) > 0) loop
		for i in 1..l_colcnt loop
			dbms_sql.column_value(l_thecursor, i, l_columnValue);
			dbms_output.put_line(rpad(l_desctbl(i).col_name,30) ||
				': ' || l_columnvalue);	
		end loop;
		dbms_output.put_line('------------------------------');
	end loop;

	execute immediate 'alter session set nls_date_format=''dd-MON-rr'' ';
exception
	when others then
		execute immediate 'alter session set nls_date_format=''dd-MON-rr'' ';
		raise;
end;
/
