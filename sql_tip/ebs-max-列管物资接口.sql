
/*select sysdate from dual;
SELECT * FROM MAXORA.mxmanagitem_iface  WHERE ISSUENUM IN ('CK201411260033','CK201411280027');

SELECT * FROM MAXORA.mxmanagitem_iface  WHERE price is not null order by issuedate desc;
*/
-- Mxmatusetrans_Iface_Insert_Trg

SELECT * FROM  SCHEDUL.SDWO_IFACE where WONUM='1487807';
-- SCHEDUL.SDWO_IFACE.C_WORKAREACODEABC
SELECT C_WORKAREACODEABC FROM  SCHEDUL.SDWO_IFACE where WONUM='1487807';

select max(C_WORKAREACODEABC)FROM SCHEDUL.SDWO_IFACE;


