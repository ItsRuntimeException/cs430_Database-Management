set echo ON

-- a. Find parts (pids, pnames and colors) that are supplied by all suppliers.
SELECT p.pid, p.pname, p.color
FROM parts p
WHERE NOT EXISTS ( -- look for sid(s) unconnected via c to this pid
(SELECT s.sid FROM suppliers s)
MINUS -- ones connected via c to p.sid
(SELECT c.sid FROM catalog c  WHERE c.pid=p.pid)
);

-- b. Find parts (pids, pnames and colors) that are supplied by all suppliers with names starting with 'A' (use sname >= 'A' and sname < 'B' for RA, LIKE for SQL).
SELECT p.pid, p.pname, p.color
FROM parts p, suppliers s1
WHERE s1.sname LIKE 'A%' and 
NOT EXISTS ( -- look for bid(s) unconnected via c to this pid
    (SELECT s.sid FROM suppliers s)
    MINUS -- ones connected via c to p.sid
    (SELECT c.sid FROM catalog c  WHERE c.pid=p.pid)
);

-- c. Find employees (eid and salary) certified for all aircraft of cruising range under 2000.
SELECT distinct e.eid, e.salary
FROM employees e, certified c, aircraft a
WHERE e.eid=c.eid and a.cruisingrange<2000;

-- d. Among employees (eid and salary) certified for all aircraft of cruising range under 2000, find the one(s) with maximal salary (SQL only).
SELECT distinct e.eid, e.salary
FROM employees e, certified c, aircraft a
WHERE e.eid=c.eid and a.cruisingrange<2000 and e.salary=(
    SELECT MAX(e2.salary)
    FROM employees e2
);