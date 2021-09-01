load data
infile reserves.txt
replace
into table reserves
fields terminated by ','
(sid,bid,day DATE 'MM/DD/YYYY')
