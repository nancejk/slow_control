-- This stores the human names (hnames) of the individual channels by chan_id.
create table channel_names (chan_id integer primary key, hname varchar);

-- The main data table
-- Note that there are multiple primary keys.
create table data (meas_id serial, 
					chan_id integer references channel_names, 
					dt timestamp,
					value real,
					constraint chan_dt_unique primary key (chan_id,dt) );
	
-- This stores the value limits on a given channel.
create table channel_limits (chan_id integer primary key references channel_names, min_value real, max_value real);	
