--  SELECT * FROM DBA_DATA_FILES order by tablespace_name, file_id;


select 
       --sum (round(total, 1))
       a.TABLESPACE_NAME,
       round(total, 1) Total_M,
       round(free) Free_M,
       round(total-free) Used_M,
       round(100 * (1 - free / total), 1) Usage
  from (select TABLESPACE_NAME, sum(BYTES) / (1024 * 1024) total
          from dba_data_files
         group by TABLESPACE_NAME) a,
       (select TABLESPACE_NAME, sum(BYTES) / (1024 * 1024) free
          from dba_free_space
         group by TABLESPACE_NAME) b
 where a.TABLESPACE_NAME = b.TABLESPACE_NAME(+)
 order by usage DESC
 ;


--SELECT * FROM DBA_data_files order by 3,1;

--alter tablespace APPS_UNDOTS1 add datafile '/ebsdata/db/apps_st/data/undo25.dbf' size 2G;
                                           --/ebsdata/db/apps_st/data/undo07.dbf
--alter tablespace APPS_UNDOTS1 add datafile '/ebsdata/db/apps_st/data/undo09.dbf' size 2G;
--alter tablespace APPS_UNDOTS1 add datafile '/ebsdata/db/apps_st/data/undo10.dbf' size 2G;
-- alter tablespace MAXDATA add datafile '+MAXDB/maximo/datafile/maxdata03.dbf' size 6G;
-- alter tablespace APPS_UNDOTS1 add datafile '/ebsdata/db/apps_st/data/undo35.dbf' size 2G;

-- alter tablespace SYSAUX add datafile '/ebsdata/db/apps_st/data/sysaux14.dbf' size 2G;
-- alter tablespace MAXORA add datafile '/ebsdata/db/apps_st/data/maxora02.dbf' size 1G;
--alter tablespace SYSTEM add datafile '+HRDB/ykchr/datafile/system03.dbf' size 2G;

--for maximo db
--alter tablespace maxdata add datafile '+MAXDB/maximo/datafile/maxdata12.dbf' size 2G;
 
 
