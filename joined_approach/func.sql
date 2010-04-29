create or replace function ensure_table_routing(interface) returns record as $$
	declare
		year integer   = extract(year from $1.time)::integer;
		month integer  = extract(month from $1.time)::integer;  
		tablename text = $1.channel || 'y' || year || 'm' || month;
		c record; 
	begin
	    execute 'insert into ' 
			|| tablename 
			|| '(value, time) '
			|| 'values ('
			|| $1.value 
			|| ','
			|| quote_literal($1.time)
			|| ')';
			return c;
	end
$$ language plpgsql;

create or replace rule interface_insert 
	as on insert to interface do instead
		select ensure_table_routing(new.*);