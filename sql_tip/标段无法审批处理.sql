/*
SELECT PLAN_CODE,
       SEGMENT_NUM,
       ITEM_NUM,
       ITEM_DESC,
       ITEM_CATEGORY,
       PRIMARY_UNIT_OF_MEASURE,
       PLAN_QUANTITY1,
       PLAN_QUANTITY2,
       PLAN_QUANTITY3,
       PLAN_QUANTITY4,
       PLAN_QUANTITY,
       LIST_PRICE,
       PLAN_AMOUNT,
       YEAR1,
       YEAR2,
       YEAR3,
       YEAR4,
       YEAR_ALL,
       STATUS
  FROM CUX_PO_PACKAGE_V
 WHERE (SEGMENT_NUM = '2201502120001')
 order by SEGMENT_NUM, PLAN_CODE, ITEM_NUM
 ;*/
 
 
select * from cux_po_package WHERE PLAN_CODE='JH201501290011'  --(SEGMENT_NUM = '2201502120001') 
order by status;
-- update cux_po_package set status='' WHERE PLAN_CODE='JH201501290011'

select * from cux_approve_actions where header_id in ('201501290011')
-- delete from cux_approve_actions where header_id in ('201501290011')



