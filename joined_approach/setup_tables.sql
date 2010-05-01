-- Fill the table channel_names with our fictitious channels
insert into channel_names (chan_id,hname) values (1,'Test Channel 1');
insert into channel_names (chan_id,hname) values (2,'Test Channel 2');
insert into channel_names (chan_id,hname) values (3,'Test Channel 3');
insert into channel_names (chan_id,hname) values (4,'Test Channel 4');
insert into channel_names (chan_id,hname) values (5,'Test Channel 5');
insert into channel_names (chan_id,hname) values (6,'Test Channel 6');
insert into channel_names (chan_id,hname) values (7,'Test Channel 7');
insert into channel_names (chan_id,hname) values (8,'Test Channel 8');
insert into channel_names (chan_id,hname) values (9,'Test Channel 9');
insert into channel_names (chan_id,hname) values (10,'Test Channel 10');
	
-- Now we need some thresholds in there
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (1,-1,1);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (2,-2,2);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (3,-3,3);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (4,-4,4);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (5,-5,5);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (6,6.6,7.7);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (7,1.24,1.88);	
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (8,4.33,9.93);	
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (9,1.0,3.0);
insert into channel_thresholds (chan_id,min_thresh,max_thresh) values (10,-8.2,2.44);