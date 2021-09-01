-- accepts two cities (Los-Angeles and Chicago for example) 
-- and finds the flights from the first to the second 
-- in the flights table. For the selected flights, 
-- print out the flight number, distance, and duration of the flight, 
-- computed by time difference (and displayed in hours:min:sec).
SET echo ON

SELECT f.flno as Flight_num, f.distance as Distance_trvl, (f.arrives - f.departs) as timeDiff
FROM flights f
WHERE f.origin='Los-Angeles' AND f.destination='Chicago';