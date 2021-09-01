set echo ON

-- d. Query the view ManagerSummary to find the name of the manager who manages most employees.
-- If the same employee works in several departments, that employee is counted once in each of the departments.
-- The manager is included in the count the same as all other employees, i.e., based on his or her records in the Works table. Put this SQL in queryview2.sql.
-- variables: ManagerSummary(DeptName, MgrID, MgrName, MgrSalary, empCount)

SELECT ms.MgrName, ms.empCount
FROM ManagerSummary ms
WHERE ms.empCount = (
    SELECT MAX(ms2.empCount)
    FROM ManagerSummary ms2
);