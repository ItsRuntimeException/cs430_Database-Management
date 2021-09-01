CREATE OR REPLACE PROCEDURE delete_listing(listing NUMBER) IS
 num NUMBER;
BEGIN
    num := listing;
    INSERT INTO rented_apartments
    SELECT * FROM apartments A
    WHERE A.listing = num;

    DELETE FROM apartments A
    WHERE A.listing = num;
END;
/
show errors;

CALL delete_listing(120);