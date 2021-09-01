/*[i] Find the maximum cool count in the reviews.
Find the number of reviews containing the word 'dirty'.
Separately, containing the word 'clean'. */
set timing ON

SELECT MAX(r.cool)
FROM yelp_db.review r;

SELECT count(*) AS countDirty
FROM yelp_db.review r
WHERE r.text LIKE '%dirty%';

SELECT count(*) AS countClean
FROM yelp_db.review r
WHERE r.text LIKE '%clean%';

/* [ii] Find the number of users (#unique user ids) reviewing businesses in 'NV', the state of Nevada. */

SELECT DISTINCT count(r.user_id) AS userNV
FROM yelp_db.review r, yelp_db.business b
WHERE b.state='NV' AND r.id=b.id;

/* [iii] Find the number of users with cool count over 10 reviewing businesses in 'NV'. Note that both reviews and users have cool counts.
A user's cool count gets incremented when one of their reviews is marked "cool". */

SELECT DISTINCT count(r.user_id) userNVcool
FROM yelp_db.review r, yelp_db.business b
WHERE b.state='NV' AND r.cool > 10 AND r.id=b.id;