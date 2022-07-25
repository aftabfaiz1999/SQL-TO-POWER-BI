/*these are the table data that contain file below query is use to join the table and make a merge data and load to database i have delete the t'word' containg database*/
/*select * from t1
union
select *from t9
union
select * from t10
union
select *from t11;*/



select COUNT (member_casual) from merge_data /*3307064 total member_casual*/
select * from merge_data where member_casual = 'casual';/*1379363 total casual from member_casual*/
select * from merge_data where member_casual = 'member'; /*1927701 total member from member_casual*/

/*to delete ride_ide..records remain same*/

alter table merge_data
drop column ride_id;



/*creating a trip_duration column*/
alter table merge_data 
add trip_duration bigint;

update merge_data
set trip_duration = datediff(minute,started_at,ended_at) 

/***deleting value less then 0***/
select *from merge_data where trip_duration<=0;


/*droping some tables*/


alter table merge_data
drop column start_station_id

alter table merge_data
drop column end_station_id

alter table merge_data
drop column start_lat

alter table merge_data
drop column start_lng

alter table merge_data
drop column end_lat

alter table merge_data
drop column end_lng


/*adding new column of started_at to started_day*/


alter table merge_data 
add started_day varchar(50);


update merge_data
set started_day = datename(dw,started_at)



/*new table of dates*/

alter table merge_data
add start_at varchar(50);

alter table merge_data
add end_at varchar(50);

update merge_data
set start_at = CAST(started_at as date)

update merge_data
set end_at = CAST(ended_at as date)

/*droping started_at and ended_at from  table these both contain date and time togather*/

alter table merge_data
drop column started_at

alter table merge_data
drop column ended_at


/*to delete the null values from the data for specific column*/
delete from merge_data where start_station_name ='null';
delete from merge_data where end_station_name ='null';



select*from  merge_data