SELECT b.Segment1  物料编码,
       b.Description  物料描述,
       o.Subinventory_Code 子库存,
       d.description   子库描述,
       SUM(o.Transaction_Quantity) 数量，
       b.ATTRIBUTE4  是否直发，
       round(c.Item_Cost,3)   成本
            
  FROM Mtl_Onhand_Quantities o,
       Mtl_System_Items_Vl   b,
       Cst_Item_Costs        c，
       mtl_secondary_inventories d

 WHERE o.Inventory_Item_Id = b.Inventory_Item_Id
   AND o.Organization_Id = b.Organization_Id
   AND o.Inventory_Item_Id = c.Inventory_Item_Id
   AND o.Organization_Id = c.Organization_Id
   AND o.SUBINVENTORY_CODE=d.secondary_inventory_name
   AND d.attribute1=2
   --AND o.Subinventory_Code <> 'FZH0001'
   --AND o.SUBINVENTORY_CODE LIKE '%KY%'
   --AND o.SUBINVENTORY_CODE  IN ('L01GT01','L01GT02')
   AND d.organization_id=102

 GROUP BY b.Segment1,
          b.Description,
          o.Subinventory_Code,
          d.description ,
          b.ATTRIBUTE4，
          c.Item_Cost
     ORDER BY o.Subinventory_Code
