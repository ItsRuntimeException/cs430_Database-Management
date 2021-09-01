
create or replace function add_two (a int, b int) return int is
begin
 return a+b;
end;
/
show errors;

DECLARE
   SUM2 INT;
BEGIN
   SUM2 := ADD_TWO(10, 20);
   DBMS_OUTPUT.PUT_LINE('Sum = '|| SUM2);
END;
/


select add_two(10, 20) from dual;
select * from sailors where age = add_two(10, 20);
