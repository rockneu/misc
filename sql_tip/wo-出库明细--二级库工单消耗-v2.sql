SELECT to_char(Mt.transaction_date,'yyyy-mm-dd') 出库日期，
       Mt.Attribute1 出库单号,    
       MT.TRANSACTION_SOURCE_NAME 工单号  , 
       m.Segment1 物料编码,
       m.Description 物料描述,
       Mtt.Transaction_Type_Name 类型,
       Ms.Attribute1 总库二级库,
       ms.SECONDARY_INVENTORY_NAME,
       Ms.Description 子库存,
       Abs(Mt.Primary_Quantity) 数量,
       Mt.Actual_Cost 单价,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost 金额,
       -- dept, workshop
        
               CIC.Description 申领中心,
        CID.Description 申领车间,
        CIS.DESCRIPTION 申领工班,
        
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
       CUX_INV_SUB_DEPTS_V   cis,
       Mtl_Secondary_Inventories Ms

 WHERE Mt.Inventory_Item_Id = m.Inventory_Item_Id 
   AND Mt.Organization_Id = m.Organization_Id
   AND m.Organization_Id = 969  -- line1 102 , line2 969
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
--   and mt.attribute6=cid.Flex_Value_Id
--   and substr(cid.Flex_Value,1,4)= substr(cic.flex_value,1,4)
   
      and mt.attribute6=cid.Flex_Value_Id
  and mt.attribute12=cis.Flex_Value_Id(+)
   and substr(cid.Flex_Value,1,4)= substr(cic.flex_value,1,4)
  -- and (substr(cis.Flex_Value,1,4)=substr(cic.flex_value,1,4) OR mt.attribute12 IS NULL)
   
--   AND MS.SECONDARY_INVENTORY_NAME='L01KY05'
   
       
--   AND Mtt.Transaction_Type_Name='工单发料'
   AND Mt.Attribute1 LIKE 'CK%'
--   and Ms.Description='1-车辆中心-检修一车间'
--   AND Ms.Description NOT LIKE '%综合部子库%'
   
   --and to_char(Mt.transaction_date,'yyyy-mm-dd')>='2013-04-12'
   AND Ms.Attribute1 = '2'
   and   MT.TRANSACTION_SOURCE_NAME in ('WO:1955257'/*,'WO:45047','WO:383550','WO:426669'*/)
--   and    Mt.Attribute1 in ('CK201310160022','')
--     and mt.attribute1 like 'CK20130703%'
--AND  m.Segment1='300040430017'
   ORDER BY  1 DESC;
   --Mt.Attribute1, mt.TRANSACTION_SOURCE_NAME;
 
