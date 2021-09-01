select max(cool) from yelp_db.review;
select count(*) from yelp_db.review r where r.text like '%dirty%';
select count(*) from yelp_db.review r where r.text like '%clean%';

select count(distinct user_id) from yelp_db.review r, yelp_db.business b
where r.business_id = b.id and b.state = 'NV';

select count(distinct user_id) from yelp_db.review r, yelp_db.business b, yelp_db.yuser u
where r.business_id = b.id and r.user_id = u.id and b.state = 'NV' and u.cool > 10;
