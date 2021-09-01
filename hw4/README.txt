Author:	Run Dong Lin
Date:	April 28, 2019
Class:	CS430/630

1.)	JdbcCheckup_pe07.txt works successfully for both oracle and mysql in the school directory.
	However the JdbcCheckup_devsys.txt shows me that oracle can connect, but mysql has problems with connection to port 3333 and 3306.

2.)	Some modifications include hardcoded user credentials for connecting to jdbc to dbs3.cs.umb.edu:1521
	My query below, as for how to read the time difference:
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

3.)	Hardcoded my connection to jdbc instead of user entry for less typos and more convenience.
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runlindb", "runlin", "runlin");

	Problem 3 was quite difficult to do on oracle because errors keep yelling at me, so I decided to go with mysql.
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

4.)	By studying some of the functions in EmailList.java, I was able to build the logics for EditUser.java
	
	Modifications:
		In the jdbc readEntry connection strings.
		I got rid of them, and hardcoded them with my user credentials for my convenience.
		I also did that for problem 2 and 3 (hardcoded user credentials).
	Use of functions:
		UserDB.delete(user), UserDB.insert(user).
	Issue:
		The issue that I came across is when I do the if-statement to identify nullstring input from readEntry
		for LastName; 'Lastname != null' does not work.
	Solution:
		I then imported java.lang.String; and used lastName.isEmpty() for the if-statements' logic.

README DONE
	[Timestamp: Apr 29 1:53 AM] for HW4 problem 1~3
	[Timestamp: Apr 29 6:07 PM] for HW4 problem 4
I had some issues with connecting to jdbc with problem 1, thus delaying the rest of the problems.
I decided to stick with using dbs3.cs.umb.edu later for both oracle and mysql instead of localhost 
because my localhost has issues with mysql in problem3 in my devsys.