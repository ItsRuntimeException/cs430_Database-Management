set echo ON

-- b. Create a view ManagerSummary that lists for every department the department name, manager ID
-- and manager name, manager salary and the number of employees in that department.
-- The view will have five columns with headings: DeptName, MgrID, MgrName, MgrSalary and EmpCount. 
-- Put this SQL in createview.sql and drop-view in dropview.sql. 

CREATE VIEW ManagerSummary(DeptName, MgrID, MgrName, MgrSalary, empCount) AS
SELECT d.dname, d.managerid, e.ename, e.salary, COUNT(e.eid)
FROM dept d, emp e
WHERE d.managerid=e.eid
GROUP BY d.dname, d.managerid, e.ename, e.salary;