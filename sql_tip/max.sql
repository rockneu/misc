

-- maximo故障单数据
select remote,c_signinbegindate, c_signinfinishdate, s.* 
from sr s where ticketid in ('SD629663','');

select * from schedul.sdsr_iface where c_ticketid='SD333563';

-- 测试环境
select * from maximo.sdsr_iface where c_ticketid='SD333602';
--select * from maximo.sdsrin_iface where c_ticketid='SD333602';
select * from maximo.sdsrout_iface where c_ticketid='SD333602';

SELECT * FROM schedul.sdwo_iface where wonum in ('1619606','1619605','1840278')
order by wonum;


SELECT  -- C_WORKCONTENTCODE,DESCRIPTION ,PERSONGROUP, REPORTDATE  
*
FROM schedul.sdwo_iface where PERSONGROUP LIKE 'W%' 
ORDER BY REPORTDATE DESC
;


SELECT DISTINCT class FROM schedul.sdsr_iface
/*1	NEWSD       2	CAN        3	CLOSED       4	BZCOM   5	NEW   6	已修复 */

select * from mxin_inter_trans 
;

--select * from org_organization_definitions order by set_of_books_id, operating_unit, ORGANIZATION_CODE

-- 固定资产、列管物资 出库传maximo， 触发器 Cux_Mmt_Pre_Asset_Trg
--           20151105

select * from Cux_Pre_Delivery_Asset pa where pa.attribute8 in ('CK201602180044','CK201602180045')
;

select * from MAXORA.MXTDETAIL_IFACE  r where r.itemnum = '28001003000100002'
;

select * from MAXORA.MXTDETAIL_IFACE  r where r.issuenum in ('CK201602180045', 'CK201602180044')
;

--apps.cux_mmt_max_item_trg
-- 列管物资出库传maximo
select * from maxora.Mxmanagitem_Iface where itemnum='280010030001'
;
select * from maxora.Mxmanagitem_Iface where issuenum='CK02201511050001'
;
select * from maxora.Mxmanagitem_Iface where price is null
order by issuedate desc;

select * from maxora.Mxmanagitem_Iface where crewgroup is not null;

select * from Maxora.Mxmanagitem_Iface s where s.price is null;

SELECT NNT.ACTUAL_COST,
       NNT.ATTRIBUTE1,
       MMT.SEGMENT1,
       NNT.Transaction_Action_Id,
       NNT.Transaction_Source_Type_Id,
       NNT.Attribute10,
       NNT.organization_id,
       NNT.*
  FROM MTL_MATERIAL_TRANSACTIONS NNT, MTL_SYSTEM_ITEMS_B MMT
 WHERE NNT.INVENTORY_ITEM_ID = MMT.INVENTORY_ITEM_ID
   AND MMT.ORGANIZATION_ID = NNT.ORGANIZATION_ID
   AND EXISTS (select 1
          from Maxora.Mxmanagitem_Iface s
         where S.ITEMNUM = MMT.SEGMENT1
           AND S.ISSUENUM = NNT.ATTRIBUTE1
           AND s.price is null)
;
