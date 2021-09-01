--Run Lin
--start up script on topcat or pe07
--connect to dbs3 using sqlplus
--use "set echo on", then run this by "@problem5.sql" 
--exit from sqlplus, then exit again to finish typescript
--"mv typescript problem5.txt" to rename it for delivery
-- Note: all-caps for SQL keywords is not needed
-- But we need to capitalize color names in table parts to match data

--Suppliers(sid: integer, sname: string, address: string)
--Parts(pid: integer, pname: string, color: string)
--Catalog(sid: integer, pid: integer, cost: real)

--[5.2 part1] Find the pnames of parts for which there is some supplier.
SELECT DISTINCT p.pname
FROM parts p, catalog c
WHERE p.pid=c.pid;

--[5.2 part4] Find the pnames of parts supplied by Acme Widget Suppliers and no one else.
-- try (not exist)
SELECT p.pname
FROM parts p, catalog c1, suppliers s1
WHERE p.pname='Acme Widget Suppliers' AND p.pid=c1.pid AND c1.sid=s1.sid
AND NOT EXISTS (SELECT * FROM catalog c2, suppliers s2
WHERE p.pid=c2.pid AND c2.pid=s2.sid AND s2.sname<>'Acme Widget Suppliers');

--[5.2 part5] Find the sids of suppliers who charge more for some part than
-- the average cost of that part (averaged over all the suppliers who supply that part).
SELECT DISTINCT c1.sid
FROM catalog c1
WHERE c1.cost>(SELECT AVG(c2.cost) FROM catalog c2
WHERE c2.pid=c1.pid);

--[5.2 part7] Find the sids of suppliers who supply only red parts.
-- can do without subquery (lecture06_Slide19) [Use EXCEPT or NOT IN]
SELECT c1.sid
FROM catalog c1, parts p1
WHERE p1.pid=c1.pid AND p1.color='Red'
AND c1.sid NOT IN (
SELECT c2.sid
FROM catalog c2, parts p2
WHERE p2.pid=c2.pid AND p2.color<>'Red');
