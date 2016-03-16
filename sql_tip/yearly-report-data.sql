
/*
SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'), S.* 
FROM  SCHEDUL.sdwo_iface S WHERE WONUM in ('3477938','')
;
*/

select count(distinct WONUM)
from SCHEDUL.sdwo_iface
where TO_CHAR(reportdate,'YYYY-MM-DD') between '2015-01-01' and '2015-12-05'
