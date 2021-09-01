SELECT distinct b.name, b.stars, b.review_count
FROM yelp_db.business b, yelp_db.apartments a, yelp_db.category c
WHERE b.review_count >= 10 AND b.city = 'Las Vegas' AND b.state = 'NV'
AND b.id = c.business_id AND c.category = 'Restaurants' AND a.listing = 120
AND 200 >= (select ST_Distance_Sphere( point(a.longitude,a.latitude), point(b.longitude,b.latitude))
from dual);