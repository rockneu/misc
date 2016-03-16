SELECT Mt.Attribute1 出库单号,
       to_char(Mt.Transaction_Date,'YYYY-MM-DD') 出库日期,
       m.Segment1 物料编码,
       m.Description 物料描述,
       Mtt.Transaction_Type_Name 类型,
       Ms.Description 子库存,
        
        CIC.Description 申领中心,
        CID.Description 申领车间,
               m.attribute2 所属大类,

       Abs(Mt.Primary_Quantity) 数量,
       Mt.Actual_Cost 出库成本,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost 金额,
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
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
         and mt.attribute6=cid.Flex_Value_Id
   and substr(cid.Flex_Value,1,4)= substr(cic.flex_value,1,4)
   
   AND m.Organization_Id = 102
   AND Mt.Attribute1 LIKE 'CK%'
   AND Ms.Description  LIKE '综合部子库%'

--   AND Mtt.Transaction_Type_Name='非工单发料'
--   AND Ms.Attribute1 = '2'
--AND  m.Segment1='290020030004'  
 ORDER BY 1
