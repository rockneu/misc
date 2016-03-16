
SELECT to_char(Mt.transaction_date,'yyyy-mm-dd') 出库日期，
       Mt.Attribute1 出库单号,       
       m.Segment1 物料编码,
       m.Description 物料描述,
       Mtt.Transaction_Type_Name 类型,
       Ms.Attribute1 总库二级库 ,
       ms.description 总库,
--       mt.transfer_subinventory 二级库,
       (SELECT description 
               FROM Mtl_Secondary_Inventories 
               WHERE Secondary_Inventory_Name=mt.transfer_subinventory ) 目标二级库,
       --Ms.Description 子库存,
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
       ,mt.*
  FROM Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       Mtl_Transaction_Types     Mtt,
       Cux_Inv_Depts_v       cid,
       Cux_Inv_Centers_v     cic,
       CUX_INV_SUB_DEPTS_V   cis,
       Mtl_Secondary_Inventories Ms

 WHERE Mt.Inventory_Item_Id = m.Inventory_Item_Id 
   AND Mt.Organization_Id = m.Organization_Id
   AND m.Organization_Id = 969 -- L1 102, L2 969 , WY 429
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
--   AND Mt.transfer_subinventory=Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
   and mt.TRANSACTION_ACTION_ID=2 and mt.transaction_type_id=122  --总库移至二级库

   and mt.attribute6=cid.Flex_Value_Id(+)
   and mt.attribute12=cis.Flex_Value_Id(+)
   and substr(cid.Flex_Value,1,length(cid.Flex_Value)-4)= substr(cic.flex_value,1,length(cid.Flex_Value)-4)
--   and substr(cid.Flex_Value,1,5)= substr(cic.flex_value,1,5)
--   and substr(cis.Flex_Value,1,5)=substr(cic.flex_value,1,5)
   AND Ms.Attribute1 = '1'         --总库
   and m.SEGMENT1='270010270010'
--   AND Mt.Attribute1='CK201501120011'   
 ORDER BY Mt.Attribute1
 ;
 
 
 /*
       SELECT \*MT.attribute6,MT.attribute12*\ 
--        mt.*
        mt.attribute1, mt.attribute6,mt.attribute12, mt.subinventory_code,mt.inventory_item_id
 FROM Mtl_Material_Transactions MT
      ,       Mtl_Secondary_Inventories Ms
      ,       Cux_Inv_Depts_v           CID
      ,       CUX_INV_SUB_DEPTS_V       CIS
 WHERE MT.Attribute1='CK201501120011'
 AND MT.ORGANIZATION_ID=429
    and mt.TRANSACTION_ACTION_ID=2 and mt.transaction_type_id=122
    AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
    AND Ms.Attribute1 = '1' 
    AND MT.ATTRIBUTE6= cid.Flex_Value_Id  -- 科室
    and mt.attribute12=cis.Flex_Value_Id(+)
 ;
 
 select length(flex_value) from Cux_Inv_Depts_v where flex_value_id=385939
 ;select * from Cux_Inv_Centers_v 
 */

