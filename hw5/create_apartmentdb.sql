create table apartments as (
    SELECT * 
    FROM yelp_db.apartments
);
alter table apartments add PRIMARY KEY(listing);

create table rented_apartments as
(
    SELECT *
    FROM yelp_db.apartments
    WHERE 1 = 0
);
alter table rented_apartments add PRIMARY KEY(listing);