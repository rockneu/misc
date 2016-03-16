
USE SZMETROOA
SELECT createtime, archivedate, archivename,archivecode, wftype,opername
 FROM SZMETROOA.DBO.OA_ARCHIVE where archivestate=2 and convert(varchar(20), createtime, 20) like '2013%';


SELECT DISTINCT(LEFT(ARCHIVECODE,4))  FROM SZMETROOA.DBO.OA_ARCHIVE
SELECT count(*) FROM SZMETROOA.DBO.OA_ARCHIVE where archivestate=2 and convert(varchar(20), createtime, 20) like '2014%';

SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE where archivestate=2 and convert(varchar(20), createtime, 20) like '2014%'

SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE where archivestate=0 and convert(varchar(20), createtime, 20) like '2014%'
--and  archivename in ('关于提供市轨道交通近期线网P+R相关资料的函（相城区）');

--update szmetrooa.dbo.oa_archive set archivestate=0 where archivestate=2 and convert(varchar(20), createtime, 20) like '2014%';


/*
SELECT *
	--archivename
 FROM OA_ARCHIVE where ArchiveDate >= '2013-01-01' -- and createtime<'2013-01-01'	
	and archivestate=2 
	
--	and archivename='关于对相门段古城墙项目部分设计方案进行审核的函'
 ORDER BY CREATETIME;
*/


--WHERE ARCHIVENAME LIKE '%审查回复%';
-- 关于同意轨道集团公司第一次团员大会选举结果的批复 archived

-- ArchiveState=2 archived, -1 removed, 0 not archived
-- -1 removed, -3, 0 not archived, 
--  1, 2 archived, 3
--select distinct archivestate from  SZMETROOA.DBO.OA_ARCHIVE

--SELECT * FROM OA_ARCHIVE 

--SELECT * FROM OA_ARCHIVE order by archivedate where createtime >='2013-01-01'

-- forced terminated 

--select * from OA_ARCHIVE where createtime like '2013-08-21%';
-- naturally terminated
/*
SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE 
where ArchiveDate >= '2013-01-01' -- and createtime<'2013-01-01'	
	and archivestate=2
*/

--SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE where archivename like'%市委办公室 市政府办公室%';
SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE 
where archivename ='关于表彰2012年度先进集体和先进个人的决定';
	
--2013  所有保管期限	256
--2012  所有保管期限 档号 GDJT2013 256
--需确认 错误档号的文 进入2012 or 2013

--SELECT * FROM SZMETROOA.DBO.OA_ARCHIVE where archivestate=-3;



