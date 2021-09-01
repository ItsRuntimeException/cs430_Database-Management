CREATE OR REPLACE FUNCTION apartment_stats(listing INTEGER, category VARCHAR2) RETURN NUMBER IS
 countOf NUMBER;
BEGIN
    SELECT distinct count(*) into countOf
    FROM yelp_db.business b, yelp_db.apartments a, yelp_db.category c
    WHERE b.review_count >= 10 AND b.city = 'Las Vegas' AND b.state = 'NV'
    AND b.id = c.business_id AND c.category = 'Restaurants' AND a.listing = 120
    AND 200 >= (select geo_distance(a.longitude, a.latitude, b.longitude, b.latitude) from dual);
    
    RETURN countOf;
END;
/
show errors;

SELECT apartment_stats(25, 'Restaurants') from dual;
SELECT apartment_stats(25, 'Grocery') from dual;