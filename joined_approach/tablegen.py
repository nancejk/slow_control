numchan = 100 
years = 5
beginyear = 2010
 
fout = open("tablegen.sql","w")
fout.write("create table master(id bigserial primary key, value real, time timestamp default now());\n")
for channel in range(numchan):
	fout.write("create table Channel{0}() inherits(master);\n".format(channel))
   	for year in range(years):
		for month in range(1,13):
			fout.write("create table Channel{0}y{1}m{2}(\n\tconstraint correct_month check(\n\t\textract(month from time)={2}\n\t),\n\tconstraint correct_year check(\n\t\textract(year from time)={1}\n\t)\n) inherits(Channel{0});\n".format(channel,beginyear + year, month))
fout.write("create view interface as \n\tselect id, time, value, pg_class.relname as channel \n\tfrom master left outer join pg_class \n\ton master.tableoid=pg_class.oid;")
fout.close()     
