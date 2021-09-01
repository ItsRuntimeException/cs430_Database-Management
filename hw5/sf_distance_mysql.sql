-- mysql distance between example points
-- result: 1354.5044320629338
-- drop function geo_distance;
-- do this delimiter command before source sp_distance_mysql.sql:
-- delimeter //

create or replace function geo_distance_mysql(lo1 float, lat1 float, lo2 float, lat2 float)return float IS
 distance_var float;
begin

select ST_Distance_Sphere( point(lo1, lat1), point(lo2, lat2) ) into distance_var from dual;

return distance_var;
end;
/

delimiter ;

select geo_distance(151.20208, -33.883741, 151.195986, -33.87266) from dual;
