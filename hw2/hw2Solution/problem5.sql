-- 1. Find the pnames of parts for which there is some supplier.

-- there are different pid's with the same part name
select distinct p.pname
from parts p, catalog c
where p.pid = c.pid;

-- 4. Find the pnames of parts supplied by Acme Widget Suppliers and no one
-- else.

select DISTINCT p.pname
from suppliers s, parts p, catalog c
where s.sid = c.sid AND c.pid = p.pid 
      AND s.sname = 'Acme Widget Suppliers'
      AND p.pid NOT IN 
          (select p2.pid
          from suppliers s2, parts p2, catalog c2
          where s2.sid = c2.sid AND c2.pid = p2.pid
                AND s2.sname <> 'Acme Widget Suppliers');

-- 5 Find the sids of suppliers who charge more for some part than the average cost of that
-- part (averaged over all the suppliers who supply that part).
-- First think about average for part xpid:
-- select avg(c1.cost) from catalog c1
-- where c1.pid = xpid
-- Since we have a FK from catalog to suppliers, we don't need to join to suppliers here
--  but it's OK to do so.

select distinct sid from catalog c
where c.cost > (select avg(c1.cost) from catalog c1 where c1.pid = c.pid);

-- 7. Find the sids of suppliers who supply only red parts.
-- Again, joins to suppliers don't hurt.
-- and using INTERSECT is another way

select distinct c.sid from catalog c, parts p
where c.pid = p.pid and p.color = 'Red'
and c.sid not in
(select c1.sid from catalog c1, parts p1
where c1.pid = p1.pid and p1.color <> 'Red');
