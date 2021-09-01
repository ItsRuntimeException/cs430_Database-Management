set echo ON

-- c. Query the view ManagerSummary to retrieve the set of distinct salaries of managers who manage a department called “Sales”. Put this SQL in queryview1.sql.
-- variables: ManagerSummary(DeptName, MgrID, MgrName, MgrSalary, empCount)

SELECT DISTINCT ms.MgrSalary
FROM ManagerSummary ms
WHERE ms.DeptName = 'Sales';