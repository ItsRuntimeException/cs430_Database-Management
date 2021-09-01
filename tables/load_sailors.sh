# Load sailors table from CSV data, and arrange that nullstring
# rating values in the data file turn into null values in the table
# Here @vrating is a local variable holding the incoming column value, and
# rating is the column being loaded, snf nullif is a standard SQL function:
#   nullif(x,y) returns null iff x=y using the SQL = operator
echo Loading sailors
mysql -u $1 -D $2 --execute="LOAD DATA INFILE '$3/sailors.txt' INTO TABLE sailors 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
(sid, sname, @vrating, age)
SET rating = nullif(@vrating,'');
SHOW ERRORS; SHOW WARNINGS" 
