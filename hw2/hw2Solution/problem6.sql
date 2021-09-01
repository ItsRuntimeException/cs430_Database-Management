-- Problem 6a
-- Find the major and the average age of students for that major, for each
-- major. List major and average age.

select s.major, AVG(s.age)
from student s
group by s.major;

-- Problem 6b
-- For each room that has a class, find how many different departments use
-- that room for classes.List room and count of departments.
-- Don't report null room values.

-- count the number of departments asociated with each room

select c.room, COUNT(DISTINCT f.deptid)
from class c, faculty f
where c.fid = f.fid and c.room is not null
group by c.room;

-- Problem 6c
-- Display results from c. only for rooms used by 2 or more departments.
select c.room, COUNT(DISTINCT f.deptid) AS ct
     from class c, faculty f
     where c.fid = f.fid and c.room is not null
     group by c.room
     having count(distinct f.deptid) > = 2;

-- Alternatively, 

select *
from (select c.room, COUNT(DISTINCT f.deptid) AS ct
     from class c, faculty f
     where c.fid = f.fid and c.room is not null
     group by c.room)
where ct >= 2;

