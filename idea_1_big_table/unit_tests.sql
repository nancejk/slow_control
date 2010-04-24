-- All rows where the value is not within limits.
select('Grabbing all rows where the value is outside thresholds');
explain analyze select meas_id,data.chan_id,dt,value,min_value,max_value from data inner join channel_limits on data.chan_id=channel_limits.chan_id where (data.value < channel_limits.min_value or data.value > channel_limits.max_value);

