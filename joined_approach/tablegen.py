numchan = 10 
years = 5
beginyear = 2010
 
print("create sequence measurement_ids;\n")
print("create table channel_names(chan_id integer primary key, hname varchar);\n")
print("create table channel_thresholds(chan_id integer references channel_names, min_thresh real, max_thresh real);\n")
print("create table master(meas_id bigint default nextval('measurement_ids'), chan_id integer references channel_names, value real, dt timestamp, constraint id_dt_pkey primary key (meas_id,dt));\n")
for channel in range(numchan):
	print("create table Channel{0}(constraint correct_channel check(chan_id = {0})) inherits(master);\n".format(channel))
   	for year in range(years):
		for month in range(1,13):
			print("create table Channel{0}y{1}m{2}(\n\tconstraint correct_month check(\n\t\textract(month from dt)={2}\n\t),\n\tconstraint correct_year check(\n\t\textract(year from dt)={1}\n\t)\n) inherits(Channel{0});\n".format(channel,beginyear + year, month,channel))
			print("create index Channel{0}y{1}m{2}_index_on_date on Channel{0}y{1}m{2}(dt);\n".format(channel,beginyear + year, month))
	

#print("create view interface as \n\tselect id, time, value, pg_class.relname as channel \n\tfrom master left outer join pg_class \n\ton master.tableoid=pg_class.oid;")
