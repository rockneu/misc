USE SZMETROCS

select hostname ,loginame, count(0 ) 
from master.dbo.sysprocesses
where --loginame='sa' and
 	dbid=( SELECT [DBID] FROM [Master] .[dbo]. [SYSDATABASES] WHERE NAME='SZMETROCS' )
--	AND SPID > 50
group by hostname, loginame order by count( 0) desc;

SELECT * FROM master.dbo.sysprocesses
WHERE LOGINAME='cs-yy'
;

SELECT DISTINCT STATUS FROM master.dbo.sysprocesses;

select * from master.dbo.sysprocesses
WHERE	SPID>50  AND 
		dbid=( SELECT [DBID] FROM [Master] .[dbo]. [SYSDATABASES] WHERE NAME='SZMETROCS' );

SELECT * FROM master.dbo.sysprocesses 
WHERE loginame IS not NULL	and
 	dbid=( SELECT [DBID] FROM [Master] .[dbo]. [SYSDATABASES] WHERE NAME='SZMETROCS' );
	
use master
go
exec sp_who_lock