

USE SZMETROUUV

--SELECT USERCODE FROM UUV_ADUSER HAVING COUNT(CHSNAME)>1

SELECT --accountname --usercode,status,accountname, dept,position 
	USERCODE
--	*
FROM UUV_ADUSER 
WHERE --usercode in ('400250','410024' )
	usercode like '4%'
group by usercode --,status,accountname, dept,position 
having count(chsname)=2


--order by UUV_ADUSER 
	--accountname like 'lingyang%' ;
	--chsname like '%实习%'



SELECT * FROM UUV_ADUSER   WHERE  CHSNAME LIKE '邹小英%';--USERCODE IN ('400039');

--SELECT * FROM UUV_ADUSER  WHERE usercode in ('400250','410024' )

--可在UUV手工修改
--update UUV_ADUSER  set ACCOUNTNAME= 'licengceng', emailaddress= 'licengceng@sz-mtr.com', chsspell='licengceng', sipaddress='licengceng@sz-mtr.com'  
 --  where usercode='400283'
--update uuv_aduser set status='disabled' where usercode='200002';
--select * from uuv_aduser where status='disabled';


select u1.usercode, u2.usercode, u1.dept,u1.position , u2.dept,u2.position , u1.chsname,u2.chsname, u1.status, u2.status
from UUV_ADUSER u1, UUV_ADUSER u2
where u1.usercode<>u2.usercode
and u1.chsname=u2.chsname
and u1.usercode like '40%' 
and u2.usercode like '41%'
order by u2.usercode

