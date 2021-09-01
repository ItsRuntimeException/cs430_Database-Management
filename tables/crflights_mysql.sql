-- Thanks to Jocof Robins for finding this workaround
-- Modify runtime flags to minimize timestamp checking (avoiding mysql 5.7 bug)
set @@sql_mode="";
create table flights(
	flno int primary key,
	origin varchar(20) not null,
	destination varchar(20) not null,
	distance int,
	departs timestamp,
	arrives timestamp,
	price decimal(7,2)
	);
