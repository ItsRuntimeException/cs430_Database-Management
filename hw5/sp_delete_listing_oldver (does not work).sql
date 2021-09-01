CREATE OR REPLACE PROCEDURE delete_listing(listing INTEGER) IS
BEGIN
    num := listing;
    INSERT INTO rented_apartments
    SELECT * FROM apartments A
    WHERE A.listing = listing;

    DELETE FROM apartments A
    WHERE A.listing = listing;
END;
/
show errors;

CALL delete_listing(120);