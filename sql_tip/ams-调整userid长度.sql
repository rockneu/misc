
--  scheckinuser

SELECT d.CHAR_LENGTH,d.* FROM DBA_TAB_COLUMNS d
WHERE COLUMN_NAME='SCHECKINUSER' /*AND OWNER='SEAS' */
--and table_name='PLIB43273_1'
ORDER BY d.char_length -- DATA_LENGTH
;
--PLIB37739_1
--PLIB43273_1
--PLIB119506_1

--alter table PDESCRIPTOR modify scheckinuser VARCHAR2(50);
--alter table PLIB44644_1 modify scheckinuser VARCHAR2(50);
--alter table PPOLICY modify scheckinuser VARCHAR2(50);

--purge recyclebin;
/*
select * from plib35401_1;
select * from plib35401_2;
select * from plib35401_3;*/

 -- plib[id]_1, _2 对应案卷、文件级
--SELECT * FROM PLIB32742_1;

