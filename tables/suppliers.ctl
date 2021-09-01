--
-- Oracle Bulk Loader Contol File
--
-- 	This is used to instruct oracle to bulk load data. It is 
-- automatically run by the installation script.
--
-- Version 0.1.0.0 2002/04/06 by: David Warden.
-- Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
--
-- eoneil added OPTIONALLY ENCLOSED BY '"' to capture quoted strings

load data
infile suppliers.txt
replace
into table Suppliers
fields terminated by ',' OPTIONALLY ENCLOSED BY '"'
(sid,sname,address)