-- 1. Print the names and ages of each employee who works in both the Hardware
-- department and the Software department.

select e.ename, e.age
from emp e, works w, dept d
where e.eid = w.eid AND w.did = d.did
      AND dname = 'Software'
INTERSECT
select e.ename, e.age
from emp e, works w, dept d
where e.eid = w.eid AND w.did = d.did
      AND dname = 'Hardware';

-- or to avoid INTERSECT:
select e.ename, e.age from emp e
where e.eid in
(select e.eid
from emp e, works w, dept d
where e.eid = w.eid AND w.did = d.did
      AND dname = 'Software')
AND e.eid in 
(select e.eid 
from emp e, works w, dept d
where e.eid = w.eid AND w.did = d.did
      AND dname = 'Hardware');



-- 3. Print the name of each employee whose salary exceeds the budget of all
-- of the departments that he or she works in.

-- list the budgets for all the departments that employee x works in 
-- select d.budget
-- from works w, dept d
-- where w.did = d.did and w.eid = x

-- put this together with the employees and their salaries

select e.ename
     from emp e
where e.salary > 
    (select max(d.budget) from works w, dept d
      where w.did = d.did AND w.eid = e.eid);


-- 6. If a manager manages more than one department, he or she controls the sum of all the
-- budgets for those departments. Find the managerids of managers who control more than
-- $5 million.
-- First consider one manager's (x's) total controlled budget
-- select sum(d.budget) from dept d where d.managerid = x

select d.managerid from dept d
where 5000000 <
 (select sum(d1.budget) from dept d1 where d1.managerid = d.managerid);
 
