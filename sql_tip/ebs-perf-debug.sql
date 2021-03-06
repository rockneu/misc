/*
select * from V$SYSSTAT order by value desc;

select FUNCTION_ID, FUNCTION_NAME from v$iostat_function
order by FUNCTION_ID;
*/
SELECT ses.sid,  
            ses.serial#  
       FROM v$session ses,  
            v$process pro  
           WHERE ses.paddr = pro.addr  
                AND pro.spid IN (SELECT oracle_process_id  
                                   FROM fnd_concurrent_requests
                                  WHERE request_id = &request_id);
--alter system kill session 'sid,serial#';


SELECT d.sid, d.serial# ,d.osuser,d.process
FROM apps.fnd_concurrent_processes b,
     v$process c, 
     v$session d
WHERE c.pid = b.oracle_process_id
      AND b.session_id=d.audsid
      AND d.process IN ('17564210','7799254','10748120');
      --17564210

SELECT * FROM V$SESSION ;

select group_or_subplan from dba_rsrc_plan_directives 
where plan = 'MIXED_WORKLOAD_PLAN'; 
select * from dba_rsrc_plan_directives ;
      