SELECT Mt.Attribute1 出库单号,
       m.Segment1 物料编码,
       m.Description 物料描述,
       Mtt.Transaction_Type_Name 类型,
       Ms.Description 子库存,
       Abs(Mt.Primary_Quantity) 数量,
       Mt.Actual_Cost 出库成本,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost 金额
  FROM Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       Mtl_Transaction_Types     Mtt,
       Mtl_Secondary_Inventories Ms
 WHERE Mt.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mt.Organization_Id = m.Organization_Id
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
   AND m.Organization_Id = 102
   /*
   AND Mt.Transaction_Date >=
       To_Date('25-09-2012 00:00:00', 'DD-MM-YYYY HH24:MI:SS')
   AND Mt.Transaction_Date <=
       To_Date('25-10-2012 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
       */
   AND Mt.Attribute1 LIKE 'CK%'
   AND Ms.Description NOT LIKE '%综合部子库%'
   AND Mtt.Transaction_Type_Name='非工单发料'
   AND Ms.Attribute1 = '2'	--二级库
   --AND  m.Segment1='290020030004'
 ORDER BY Mt.Attribute1
