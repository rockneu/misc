
--SELECT * FROM Mtl_Material_Transactions WHERE TRANSACTION_ID IN (9706451,9706478, 9706483);
--SELECT * FROM Mtl_Transaction_Types
SELECT 

--        sum(Abs(Mt.Primary_Quantity)), sum(Abs(Mt.Primary_Quantity) * Mt.Actual_Cost)
--        sum(Mt.Primary_Quantity), sum((Mt.Primary_Quantity) * Mt.Actual_Cost)
        to_char(Mt.transaction_date,'yyyy-mm-dd HH24:MI:SS') 出库日期，
       Mt.Attribute1 出库单号,       
       m.Segment1 物料编码,
       m.Description 物料描述,
       Mtt.Transaction_Type_Name 类型,
       Ms.Attribute1 总库二级库,
       Ms.Description 子库存,
       (Mt.Primary_Quantity) 数量,
       Mt.Actual_Cost 单价,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost 金额,
       -- dept, workshop
/*        CIC.Description 申领中心,
        CID.Description 申领车间,*/
       m.attribute2 所属大类,
       m.attribute1 是否固资,
       m.attribute5 列管消耗,
       m.attribute6  归口部门,
       m.attribute4  是否直发,
       m.attribute7  是否危化
  FROM Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       Mtl_Transaction_Types     Mtt,
       Cux_Inv_Depts_v       cid,
       Cux_Inv_Centers_v     cic,
       Mtl_Secondary_Inventories Ms

 WHERE Mt.Inventory_Item_Id = m.Inventory_Item_Id 
   AND Mt.Organization_Id = m.Organization_Id
   AND m.Organization_Id = 429
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
   and mt.attribute6=cid.Flex_Value_Id
--   and substr(cid.Flex_Value,1,4)= substr(cic.flex_value,1,4)
   
/*   AND Mt.Transaction_Date >=
       To_Date('01-05-2014 00:00:00', 'DD-MM-YYYY HH24:MI:SS')
   AND Mt.Transaction_Date <=
       To_Date('01-06-2014 23:59:59', 'DD-MM-YYYY HH24:MI:SS')*/
       
--   AND Mtt.Transaction_Type_Name IN ='非工单发料' '工单发料退回'
    AND Mtt.Transaction_Type_ID IN (121,124 ) -- 121非工单发料 124非工单发料退回
   AND SUBSTR(Mt.Attribute1,1,2) IN ('CK','TK')
   and mt.attribute1='CK201504030008' 
   AND Ms.Description NOT LIKE '%综合部子库%'
   AND Ms.Attribute1 = '1'
   --AND  m.Segment1='290020030004'
-- ORDER BY  --Mt.Attribute1 desc;
          
