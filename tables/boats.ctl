load data
infile boats.txt
replace
into table boats
fields terminated by ','
(bid,bname,color)