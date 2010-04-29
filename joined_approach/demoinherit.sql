-- Example hierarchy.  Let's say we have some master table, called here simply
-- 'parent', and we have several child tables that inherit from that parent. 
-- As a result of the inheritance, each child will have the columns 
-- (id, value, time).
create table parent(id serial primary key, value real, time timestamp default now());
create table child1() inherits(parent);
create table child2() inherits(parent);
create table child3() inherits(parent);

-- The idea is that the child tables are essentially hidden from the user. 
-- Queries are never made directly on the child tables, but rather on the 
-- parent table.  In order to decipher which table the values came from, a
-- join is performed on pg_class to get that information.
-- So now we create the view that contains the tablenames:
create view named as select id, time, value, pg_class.relname as tablename from parent left outer join pg_class on parent.tableoid=pg_class.oid;

-- And insert some values:
insert into child1 (value) values(1.023);   
insert into child3 (value) values(-293.3);     
insert into child1 (value) values(-1.21);
insert into child2 (value) values(182.1);
insert into child3 (value) values(2.08);  
insert into child2 (value) values(23.12);
insert into child3 (value) values(7.42);
insert into child1 (value) values(45.1);
insert into child2 (value) values(54.56);
insert into child2 (value) values(9.87);
insert into child1 (value) values(-8.16);
insert into child3 (value) values(4.5);
insert into child1 (value) values(10.22);
insert into child3 (value) values(3.33);
insert into child2 (value) values(-23.2);
insert into child3 (value) values(9.231);
  
-- Now we can query all of this good stuff.
select * from named;

-- Child specific query:
select id, time, value from named where tablename='child1';

-- Get avg, min, max from children
select tablename, min(value), max(value), avg(value) from named group by tablename;
  
-- Drop the tables.
drop table parent cascade;