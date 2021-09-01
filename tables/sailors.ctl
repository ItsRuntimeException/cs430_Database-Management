load data
infile sailors.txt
replace
into table sailors
fields terminated by ','
(sid,sname,rating,age)