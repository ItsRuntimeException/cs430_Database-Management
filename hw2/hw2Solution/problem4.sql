--CS 630 hw 2 Solutions: Problem 4.3 of R&G
--Jinghui Zhou  (student name)
--start up script on topcat or pe07
--connect to dbs3 using sqlplus
--use "set echo on", then run this by "@problem4.sql"
--exit from sqlplus, then exit again to finish typescript
--"mv typescript problem4.txt" to rename it for delivery
-- Note: all-caps for SQL keywords is not needed
-- But we need to capitalize color names in table parts to match data
--[4.3 part1] Find the names of suppliers who supply some red part.
SELECT DISTINCT s.sname
FROM suppliers s, parts p, catalog c

WHERE p.color='Red' AND c.pid=p.pid AND c.sid=s.sid;

--Problem 2
-- 2. Find the sids of suppliers who supply some red or green part.

SELECT DISTINCT s.sid FROM suppliers s, catalog c, parts p
where s.sid=c.sid and c.pid=p.pid and (p.color='Red' or p.color='Green');

--Problem 3
-- 3. Find the sids of suppliers who supply some red part or are at 221 Packer
-- Street.

SELECT DISTINCT s.sid FROM suppliers s, catalog c, parts p
where s.sid=c.sid and c.pid=p.pid and p.color='Red'
UNION
SELECT DISTINCT s.sid FROM suppliers s
where s.address='221 Packer Ave';

--Problem 4
-- 4. Find the sids of suppliers who supply some red part and some green part.

SELECT DISTINCT s.sid FROM suppliers s, catalog c, parts p
 where s.sid=c.sid and c.pid=p.pid and p.color='Red'
 INTERSECT
 SELECT DISTINCT s.sid FROM suppliers s, catalog c, parts p
 where s.sid=c.sid and c.pid=p.pid and p.color='Green';


--Problem 9
-- 9. Find pairs of sids such that the supplier with the first sid charges
-- more for some part than the supplier with the second sid.

SELECT DISTINCT c1.sid, c2.sid from catalog c1, catalog c2
WHERE c1.sid<>c2.sid and c2.pid=c1.pid and c1.cost > c2.cost;

--Problem 10
-- 10. Find the pids of parts supplied by at least two different suppliers.

SELECT DISTINCT c1.pid from catalog c1, catalog c2
WHERE c1.sid!=c2.sid and c2.pid=c1.pid;

--Problem 11
-- 11. Find the pids of the most expensive parts supplied by suppliers named
-- Yosemite Sham.
SELECT c.pid from catalog c, suppliers s
Where s.sname='Yosemite Sham' and c.sid=s.sid
INTERSECT
Select c1.pid from catalog c1, catalog c2
where c1.pid=c2.pid and c1.pid>c2.pid;
