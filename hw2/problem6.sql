--Run Lin
--start up script on topcat or pe07
--connect to dbs3 using sqlplus
--use "set echo on", then run this by "@problem6.sql" 
--exit from sqlplus, then exit again to finish typescript
--"mv typescript problem6.txt" to rename it for delivery
-- Note: all-caps for SQL keywords is not needed
-- But we need to capitalize color names in table parts to match data

--Student(snum: integer, sname: string, major: string, standing: string, age: integer)
--Class(cname: string, meets_at: time, room: string, fid: integer)
--Enrolled(snum: integer, cname: string)
--Faculty (fid: integer, fname: string, deptid: integer)

--[Q6 part A] Find the major and the average age of students for that major, for each major. List major and average age.
SELECT s.major, AVG(s.age)
FROM student s
GROUP BY s.major;

--[Q6 part B] For each room that has a class, find how many different departments use that room for classes.
--List room and count of departments. 
--Use the class's faculty's deptid as the department using a room. Don't report null room values.
SELECT c.room, COUNT(f.deptid)
FROM faculty f, class c
WHERE c.fid=f.fid
AND c.room IS NOT NULL
AND f.deptid IS NOT NULL
GROUP BY c.room;

--[Q6 part C] Display results from b. only for rooms used by 2 or more departments. (HAVING clause).
SELECT c.room, COUNT(f.deptid)
FROM faculty f, class c
WHERE c.fid=f.fid
AND c.room IS NOT NULL
AND f.deptid IS NOT NULL
GROUP BY c.room
HAVING COUNT(f.deptid)>=2;