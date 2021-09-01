--
-- 	Database Table Creation for cs430/630
--
--		This file will create the tables for use with the book 
--  Database Management Systems by Raghu Ramakrishnan and Johannes Gehrke.
--  It is run automatically by the installation script.
--
--	Version 0.1.0.0 2002/04/05 by: David Warden.
--	Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
--
-- Converted to portable SQL by eoneil
-- number(x,0) --> int
-- number(x, non-0) --> decimal(x,non-0)
-- varchar2 --> varchar
-- foreign key always lists foreign column, for mysql

-- Also, added "not null" to all clearly expected attribute columns
-- added "not null unique" to apparently natural keys
 
-- Usage:
-- sqlplus user/pw@//dbs3.cs.umb.edu/dbs3 < createdb.sql
-- mysql -u user -D userdb -p --force < createdb.sql
--   --force allows mysql to keep going when a command fails
--   set up ~/.my.cnf to supply password and drop -p above
-- standing has values FR, SO, JR, SR
create table student(
	snum int primary key,
	sname varchar(30) not null,
	major varchar(25),
	standing varchar(2),
	age int   -- birthdate is better in a real DB
	);
create table faculty(
	fid int primary key,
	fname varchar(30) not null,
	deptid int not null
	);
create table class(
	name varchar(40) primary key,
	meets_at varchar(20),
	room varchar(10),
	fid int,
	foreign key(fid) references faculty(fid)
	);
-- note that snum and cname are implicitly not null since part of the PK
create table enrolled(
	snum int,
	cname varchar(40),
	primary key(snum,cname),
	foreign key(snum) references student(snum),
	foreign key(cname) references class(name)
	);
create table emp(
	eid int primary key,
	ename varchar(30) not null,
	age int,
	salary decimal(10,2)
	);
create table dept(
	did int primary key,
	dname varchar(20) not null unique,
	budget decimal(10,2),
	managerid int,
	foreign key(managerid) references emp(eid)
	);
create table works(
	eid int,
	did int,
	pct_time int,
	primary key(eid,did),
	foreign key(eid) references emp(eid),
	foreign key(did) references dept(did)
	);
-- flights departs: 2005-04-12-08:45:00 for example
create table flights(
	flno int primary key,
	origin varchar(20) not null,
	destination varchar(20) not null,
	distance int,
	departs timestamp,
	arrives timestamp,
	price decimal(7,2)
	);
create table aircraft(
	aid int primary key,
	aname varchar(30) not null,
	cruisingrange int not null
	);
create table employees(
	eid int primary key,
	ename varchar(30) not null,
	salary decimal(10,2)
	);
create table certified(
	eid int,
	aid int,
	primary key(eid,aid),
	foreign key(eid) references employees(eid),
	foreign key(aid) references aircraft(aid)
	);
create table suppliers(
	sid int primary key,
	sname varchar(30) not null unique,
	address varchar(50)
	);
create table parts(
	pid int primary key,
	pname varchar(40) not null,
	color varchar(15),
	unique(pname, color)
	);
create table catalog(
	sid int,
	pid int,
	cost decimal(10,2),
	primary key(sid,pid),
	foreign key(sid) references suppliers(sid),
	foreign key(pid) references parts(pid)
	);
create table sailors(
	sid int primary key,
	sname varchar(30) not null,
	rating int,
	age real
	);
create table boats(
	bid int primary key,
	bname varchar(20) not null,
	color varchar(10)
	);
-- Note no PK here, or in text pg. 166
create table reserves(
	sid int not null,
	bid int not null,
	day date,
	foreign key (sid) references sailors(sid),
	foreign key (bid) references boats(bid)
	);
