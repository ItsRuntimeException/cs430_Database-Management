#
#	Database Loading Script
#
#	Version 0.1.0.0 2002/04/05 by: David Warden.
#	Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
#
#		This script will load the sample data for use with the book 
# Database Management Systems by Raghu Ramakrishnan and Johannes Gehrke.
# ported to mysql by eoneil
#
#	Usage
#
#    To ensure this script is executable type: "chmod +x dbbook_mysql.sh". Then type 
#    "sh dbbook_mysql.sh" to run the script, on host topcat.cs.umb.edu.
#    First, make a file .my.cfg in your login directory with your
#    mysql password, like this (the parts after the # marks, and
#    xxxx replaced by your password and yyyy by your mysql database name.  
#    This way, you can use "mysql -u username" to login to your database.
#[client]
#password=xxxx
#[mysql]
#database=yyyy

#   The .my.cnf file should be protected: "chmod og-r .my.cnf"
#	
printf "This script assumes you have $HOME/.my.cnf set up with your mysql password\n"
printf "Enter your mysql username: "
read MYSQL_USERNAME 
printf "Enter your mysql database: "
read MYSQL_DB
# area on topcat-local disk that mysql can access due to special config
#LOAD_DATA_DIR=/var/local/cs634/data
LOAD_DATA_DIR=/var/lib/mysql-files
#
#
#	Setup Tables
#
	echo
	echo "Creating Tables." $MYSQL_USERNAME $MYSQL_PASSWORD $HOME
	echo "expect flights table to fail here"
	mysql -u $MYSQL_USERNAME -D $MYSQL_DB --force -v < createdb.sql > createdb.log
	echo "redoing flights table using modified sql_mode (workaround)"
	mysql -u $MYSQL_USERNAME -D $MYSQL_DB --force -v < crflights_mysql.sql > createdb.log
	echo "flights table created"
	echo "Created Tables, next will load table student." 
#
#	Bulk Load Data
#       Ubuntu Linux is guarding files so that mysql can't read or write anything
#         except what is specified in a system file. I've made /var/local/cs634
#         accessible to mysql, and put the input data in /var/local/cs634/data
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR student
#
#   Remainder of Data
#			
	echo "Bulk Loading Data. This may take a few moments."
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR faculty
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR class
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR enrolled
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR emp
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR dept
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR works
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR parts
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR suppliers
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR catalog
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR aircraft
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR employees
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR flights
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR certified
#	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB sailors
#     sailors.txt has an empty rating value which can be handled by special load syntax:
	sh load_sailors.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR 
	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR boats
#	sh load_mysql.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR reserves
	sh load_reserves.sh $MYSQL_USERNAME $MYSQL_DB $LOAD_DATA_DIR
#
# mysql has poor support for load of null values, so use insert:
# In general, the insert syntax is specified by the SQL standard,
# but the load syntax is not, so tends to be non-portable
#  This could be special-cased like sailors above

	mysql --defaults-file=$HOME/.my.cnf -u $MYSQL_USERNAME -D $MYSQL_DB -v <<EOF
	insert into class values ('Artificial Intelligence',null,'UP328',null);
EOF

echo "Done. The sample data is now loaded in mysql."
#
#
#	End Program
#
exit 0
