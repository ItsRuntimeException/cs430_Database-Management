--Run Lin
--start up script on topcat or pe07
--connect to dbs3 using sqlplus
--use "set echo on", then run this by "@problem7.sql" 
--exit from sqlplus, then exit again to finish typescript
--"mv typescript problem7.txt" to rename it for delivery
-- Note: all-caps for SQL keywords is not needed
-- But we need to capitalize color names in table parts to match data

--Emp(eid: integer, ename: string, age: integer, salary: real)
--Works(eid: integer, did: integer, pct time: integer)
--Dept(did: integer, dname: string, budget: real, managerid: integer)

--[Q7 part1] Print the names and ages of each employee who works in both the Hardware department and the Software department.
-- (Do a double search, and print ename if both requirements met).
SELECT e.ename, e.age
FROM emp e, dept d1, works w1, dept d2, works w2
WHERE d1.dname='Hardware' AND e.eid=w1.eid AND w1.did=d1.did
AND d2.dname='Software' AND e.eid=w2.eid AND w2.did=d2.did;

--[Q7 part3] Print the name of each employee whose salary exceeds the budget of all of the departments that he or she works in.
SELECT e.ename
FROM emp e
WHERE e.salary > ALL (
    SELECT d.budget
    FROM dept d, works w
    WHERE e.eid=w.eid AND w.did=d.did);

--[Q7 part6] If a manager manages more than one department, he or she controls the sum of all the
--budgets for those departments. Find the managerids of managers who control more than
--$5 million (total budget).
SELECT d1.managerid
FROM dept d1
WHERE (
    SELECT SUM(d2.budget)
    FROM dept d2
    WHERE d2.managerid=d1.managerid) > 5000000;