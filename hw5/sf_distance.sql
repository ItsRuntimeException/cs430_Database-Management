CREATE OR REPLACE FUNCTION geo_distance(long1 FLOAT, lat1 FLOAT, long2 FLOAT, lat2 FLOAT) RETURN FLOAT IS
 distance_m FLOAT;
BEGIN
    SELECT sdo_geom.sdo_distance
    (
        sdo_geometry
        (
            2001, 4326, null, sdo_elem_info_array(1, 1, 1), sdo_ordinate_array(long1, lat1)
        ),
	    sdo_geometry
        (
            2001, 4326, null, sdo_elem_info_array(1, 1, 1), sdo_ordinate_array(long2, lat2)
        ),
            1,  'unit=M'
    ) into distance_m from dual;

    RETURN distance_m;
END;
/

SELECT geo_distance(151.20208, -33.883741, 151.195986, -33.87266) from dual;