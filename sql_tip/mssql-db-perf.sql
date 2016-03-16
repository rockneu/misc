USE SZMETROCS;
Select * from sys.dm_exec_connections; 	--此命令可以看到有多少人在连

--USE SZMETROOA;
--Select * from sys.dm_exec_connections; 	--此命令可以看到有多少人在连

--Select * from sys.dm_exec_sessions; 		--此命令可以看到有多少会话，一个连接可以有多个会话




select host_name,program_name,count(*) as sl 
from sys.dm_exec_sessions group by host_name,program_name ORDER BY SL DESC;

select * from sys.dm_exec_sessions
where host_name='yyapsvr'
 group by host_name,program_name ORDER BY SL DESC;


SELECT --   [DBID]
*
FROM 
   [Master].[dbo].[SYSDATABASES] 
WHERE    NAME='SZMETROCS'

EXEC SP_WHO 'cs-yy'; --'loginName'  yyapsvr
EXEC SP_WHO;
EXEC SP_WHO2;
