--CS 630 hw 2 Solutions: Problem 4.3 of R&G
--Run Lin
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

--[4.3 part2] Find the sids of suppliers who supply some red or green part.
SELECT c.sid
FROM parts p, catalog c
WHERE (p.color='Red' OR p.color='Green') AND c.pid=p.pid;

--[4.3 part3] Find the sids of suppliers who supply some red part or are at 221 Packer Ave.
SELECT s.sid
FROM suppliers s, parts p, catalog c
WHERE (p.color='Red' OR s.address='221 Packer Ave') AND c.sid=s.sid;

--[4.3 part4] Find the sids of suppliers who supply some red part and some green part.
SELECT c.sid
FROM parts p, catalog c
WHERE p.color='Red' AND c.pid=p.pid
INTERSECT
SELECT c.sid
FROM parts p, catalog c
WHERE p.color='Green' AND c.pid=p.pid;

--[4.3 part9] Find pairs of sids such that the supplier with the first sid charges more
-- for some part than the supplier with the second sid.
SELECT c1.sid, c2.sid
FROM catalog c1, catalog c2
WHERE c1.pid=c2.pid AND c1.sid<>c2.sid
AND c1.cost>c2.cost;

--[4.3 part10] Find the pids of parts supplied by at least two different suppliers.
SELECT c1.pid
FROM catalog c1, catalog c2
WHERE c1.pid=c2.pid AND c1.sid<>c2.sid;

--[4.3 part11] Find the pids of the most expensive parts supplied by suppliers named Yosemite Sham.
SELECT c1.pid
FROM suppliers s, catalog c1, catalog c2
WHERE s.sname='Yosemite Sham' 
AND c1.sid=s.sid
AND c2.sid<>s.sid
AND c1.cost>c2.cost;
