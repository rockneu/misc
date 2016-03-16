
 SELECT t.request_id,t.logfile_name,t.outfile_name
        --*
 FROM   fnd_concurrent_requests t
 WHERE  t.request_id in ( 10603870,10603888)
 ;
 
-- select * from V$NLS_PARAMETERS where parameter='NLS_CHARACTERSET';
