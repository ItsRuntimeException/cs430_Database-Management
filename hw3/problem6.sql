set echo ON

-- Make a script problem6.sql of dropping and then creating the view,
-- then doing the two queries. Supply the output in problem6.txt.

DROP VIEW ManagerSummary;

CREATE VIEW ManagerSummary(DeptName, MgrID, MgrName, MgrSalary, empCount) AS
SELECT d.dname, d.managerid, e.ename, e.salary, COUNT(e.eid)
FROM dept d, emp e
WHERE d.managerid=e.eid
GROUP BY d.dname, d.managerid, e.ename, e.salary;