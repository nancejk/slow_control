create table alpha(letter text);
create table numeric(numeral integer);
create view alphanumeric as select letter, numeral from alpha, numeric;

insert into alpha values('a');
insert into numeric values('1');
insert into alphanumeric values('b',2);

select * from alphanumeric;
-- cleanup
drop table alpha, numeric cascade; 