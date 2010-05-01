--create or replace function ensure_table_routing(interface) returns record as $$
--	declare
--		year integer   = extract(year from $1.time)::integer;
--		month integer  = extract(month from $1.time)::integer;  
--		tablename text = $1.channel || 'y' || year || 'm' || month;
--		c record; 
--	begin
--	    execute 'insert into ' 
--			|| tablename 
--			|| '(value, time) '
--			|| 'values ('
--			|| $1.value 
--			|| ','
--			|| quote_literal($1.time)
--			|| ')';
--			return c;
--	end
--$$ language plpgsql;
--
--create or replace rule interface_insert 
--	as on insert to interface do instead
--		select ensure_table_routing(new.*);

create or replace function ensure_table_routing() 
returns trigger as $$
	declare
		year integer   = extract(year from NEW.dt)::integer;
		month integer  = extract(month from NEW.dt)::integer;  
		tablename text = 'Channel' || NEW.chan_id || 'y' || year || 'm' || month;
	begin
	    execute 'insert into ' 
			|| tablename 
			|| '(chan_id, value, dt) '
			|| 'values ('
			|| NEW.chan_id
			|| ','
			|| NEW.value 
			|| ','
			|| quote_literal(NEW.dt)
			|| ')';
	    return null;
	end
$$ language plpgsql;

create trigger master_insert 
	before insert on master
	for each row execute procedure ensure_table_routing();
