create or replace function test(t_row ent, out test real) as $$
begin
	test := t_row.value;
end $$ language plpgsql;