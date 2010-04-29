create or replace function min(integer, integer) returns integer as $$
	select case when $1 < $2 then $1 else $2 end
	$$ language sql strict;                 
	
create table shoe_data (
	shoename text, -- primary key
	sh_avail integer, -- available number of pairs
	slcolor text, -- preferred shoelace color
	slminlen real, -- minimum shoelace length
	slmaxlen real, -- maximum shoelace length
	slunit text -- length unit
);

create table shoelace_data (
	sl_name text, -- primary key
	sl_avail integer, -- available number of pairs
	sl_color text, -- shoelace color
	sl_len real, -- shoelace length
	sl_unit text -- length unit
);

create table unit (
	un_name text, -- primary key
	un_fact real -- factor to transform to cm
);

create view shoe as
	select 
		sh.shoename,
		sh.sh_avail,
		sh.slcolor,
		sh.slminlen,
		sh.slminlen * un.un_fact as slminlen_cm,
		sh.slmaxlen,
		sh.slmaxlen * un.un_fact as slmaxlen_cm,
		sh.slunit
	from 
		shoe_data sh, unit un
	where 
		sh.slunit = un.un_name;

create view shoelace as
	select 
		s.sl_name,
		s.sl_avail,
		s.sl_color,
		s.sl_len,
		s.sl_unit,
		s.sl_len * u.un_fact as sl_len_cm
	from 
		shoelace_data s, unit u
	where s.sl_unit = u.un_name;

create view shoe_ready as
	select 
		rsh.shoename,
		rsh.sh_avail,
		rsl.sl_name,
		rsl.sl_avail,
		min(rsh.sh_avail, rsl.sl_avail) as total_avail
	from 
		shoe rsh, shoelace rsl
	where 
		rsl.sl_color = rsh.slcolor
	and 
		rsl.sl_len_cm >= rsh.slminlen_cm
	and 
		rsl.sl_len_cm <= rsh.slmaxlen_cm;             

insert into unit (un_name, un_fact) values ("cm"::text, 1.0);
insert into unit values (’m’, 100.0);
insert into unit values (’inch’, 2.54);
insert into shoe_data values (’sh1’, 2, ’black’, 70.0, 90.0, ’cm’);
insert into shoe_data values (’sh2’, 0, ’black’, 30.0, 40.0, ’inch’);
insert into shoe_data values (’sh3’, 4, ’brown’, 50.0, 65.0, ’cm’);
insert into shoe_data values (’sh4’, 3, ’brown’, 40.0, 50.0, ’inch’);
insert into shoelace_data values (’sl1’, 5, ’black’, 80.0, ’cm’);
insert into shoelace_data values (’sl2’, 6, ’black’, 100.0, ’cm’);
insert into shoelace_data values (’sl3’, 0, ’black’, 35.0 , ’inch’);
insert into shoelace_data values (’sl4’, 8, ’black’, 40.0 , ’inch’);
insert into shoelace_data values (’sl5’, 4, ’brown’, 1.0 , ’m’);
insert into shoelace_data values (’sl6’, 0, ’brown’, 0.9 , ’m’);
insert into shoelace_data values (’sl7’, 7, ’brown’, 60 , ’cm’);
insert into shoelace_data values (’sl8’, 1, ’brown’, 40 , ’inch’);
select * from shoelace; 

-- clean up
drop table shoe_data, shoelace_data, unit cascade;
drop function min(integer, integer);
