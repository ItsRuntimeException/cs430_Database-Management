#
#	Database Loading Script
#
#	Version 0.1.0.0 2002/04/05 by: David Warden.
#	Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
#
#	This script will load the sample data for use with the book 
# Database Management Systems by Raghu Ramakrishnan and Johannes Gehrke.
#
#
#	Usage
#
#    To ensure this script is executable type: "chmod 700". Then type 
#    "sh dbbook.sh" to run the script, on host dbs2.cs.umb.edu.
#    Note: Make sure sqlplus is available first. You may need to
#    edit your .cshrc if you haven't already. See the cs634 web page.
#
#	
#	Requirements
#
#	This script requires a Unix system, with the Oracle executables in
# your PATH statement. Your account and Oralce must be properly configured. 
# See the information on configuring your account for more informaion.
#
#	Get Password Informaion
#
printf "Enter your Oracle username: "
read ORACLE_USERNAME 
stty -echo
printf "Enter your Oracle password: "
read ORACLE_PASSWORD 
stty echo
#
# Removing any old *.bad files from previous loads
rm -f *.bad
#
#	Setup Tables
#
	echo
	echo "Creating Tables." 
	sqlplus $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 < createdb.sql > create.log
	echo "Created Tables, next will load table student." 
#
#	Bulk Load Data
#
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=student.ctl  silent='(all)' log=student.log
#
#	Check for Error
#	
	if [ $? -ne 0 ]; then
		echo "There was an error connecting to Oracle or loading table."
		echo "Please verify your configuration, username, and password."
		echo "Look at student.log for more details."
		exit 127
	fi
#
#   Remainder of Data
#			
	echo "Bulk Loading Data. This may take a few moments."
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=faculty.ctl  silent='(header,feedback)' log=faculty.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=class.ctl  silent='(header,feedback)' log=class.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3\
		control=enrolled.ctl  silent='(header,feedback)' log=enrolled.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=emp.ctl  silent='(header,feedback)' log=emp.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=dept.ctl  silent='(header,feedback)' log=dept.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=works.ctl  silent='(header,feedback)' log=works.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=parts.ctl  silent='(header,feedback)' log=parts.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=suppliers.ctl  silent='(header,feedback)' log=suppliers.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=catalog.ctl  silent='(header,feedback)' log=catalog.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=aircraft.ctl  silent='(header,feedback)' log=aircraft.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=employees.ctl  silent='(header,feedback)' log=employees.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=flights.ctl  silent='(header,feedback)' log=flights.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=certified.ctl  silent='(header,feedback)' log=certified.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=sailors.ctl  silent='(header,feedback)' log=sailors.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=boats.ctl  silent='(header,feedback)' log=boats.log
	sqlldr $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 \
		control=reserves.ctl  silent='(header,feedback)' log=reserves.log


# mysql has poor support for load of null values, so use insert
# for this row of class that has null fields, for both DBs 
# (Oracle would load nulls properly in this case)
# In general, the insert syntax is specified by the SQL standard,
# but the load syntax is not, so tends to be non-portable

sqlplus $ORACLE_USERNAME/$ORACLE_PASSWORD@//dbs3.cs.umb.edu/dbs3 <<EOF
insert into class values ('Artificial Intelligence',null,'UP328',null);
EOF

#		
#
#	Remove Password From Memory.
#
unset ORACLE_USERNAME

echo "Done. The sample data is now loaded in Oracle."
echo "Checking for *.bad to see if any rows were rejected"
ls -l *.bad

#
#
#	End Program
#
exit 0
