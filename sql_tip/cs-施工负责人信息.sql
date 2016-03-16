
USE SZMETROCS;
SELECT * FROM WT_MEMBERWORK;

/*
SELECT * FROM SP_SUPPLIER;
SELECT * FROM SP_SUPPLIERWORKTEAM;
*/
select * from sys_workchargeruserdept;


select username, usercode, userdeptname, usefullifedateto 
from sys_workchargeruser
where status= 'enabled'
order by usefullifedateto desc
;