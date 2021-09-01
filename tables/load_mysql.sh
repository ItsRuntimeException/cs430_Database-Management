# load a "CSV" file (comma-separated-value file) into mysql table
#   from /tmp/data/something.txt and show warnings
# Requires "File" privilege for user
# DBA note: On Ubuntu Linux, requires that /tmp/data be authorized
#  for mysql access by edit to /etc/appormor.d/usr.sbin.mysqld 
#  followed by restart of the apparmor daemon
#  i.e. AppArmor, the filesystem security guardian of Ubuntu Linux
echo Loading $4
mysql -u $1 -D $2 --execute="LOAD DATA INFILE '$3/$4.txt' INTO TABLE $4 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'; SHOW WARNINGS" 
