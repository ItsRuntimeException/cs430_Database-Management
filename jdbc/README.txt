Author:	Run Dong Lin
Date:	April 28, 2019
Class:	CS430/630

1.)	JdbcCheckup_pe07.txt works successfully for both oracle and mysql in the school directory.
	However the JdbcCheckup_devsys.txt shows me that oracle can connect, but mysql has problems with connection to port 3333 and 3306.

2.)	My query below, as for how to read the time difference:
	+000000000 	is probably meant for Time zones which I don't think we have to implement.
	12:00:00.000000 The 12 is hour, 00:00.000000 is mm:ss.millisec

	SELECT f.flno as Flight_num, f.distance as Distance_trvl, (f.arrives - f.departs) as timeDiff
	FROM flights f
	WHERE f.origin='Los-Angeles' AND f.destination='Chicago';

FLIGHT_NUM DISTANCE_TRVL
---------- -------------
TIMEDIFF
--------------------------------------
	13	    1749
+000000000 12:00:00.000000

3.)	Quite difficult to do on oracle because errors keep yelling at me, so I decided to go with mysql.
	Mainly because of the implementation of the distance example.
	
	Decided to go with mysql's shortened distance query for readability, and nested my distance query in the where clause.
	Lastly,I noticed that a business can have multiple ids in yelp_db.category, so I decided to say "select distinct".

Result:
+---------------------------+-------+--------------+
| name                      | stars | review_count |
+---------------------------+-------+--------------+
| Rachel's Kitchen          |   3.5 |          252 |
| LULU Hawaiian BBQ 2       |   3.5 |           56 |
| Arby's                    |   2.5 |           35 |
| Port of Subs              |     3 |           34 |
| Timbers - Durango         |   2.5 |           90 |
| Market Grille Cafe        |     4 |          428 |
| El Pollo Loco             |   2.5 |           62 |
| Babystacks Cafe           |     4 |          437 |
| China One                 |   3.5 |          200 |
| Popeyes Louisiana Kitchen |     2 |           88 |
+---------------------------+-------+--------------+
10 rows in set (0.17 sec)

4.) N/A... 

README DONE...
[Timestamp: Apr 29 1:53 AM]