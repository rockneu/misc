SELECT b.Segment1  物料编码,
       b.Description  物料描述,
       SUM(o.Transaction_Quantity) 数量，
       b.PRIMARY_UOM_CODE  单位，
       o.Subinventory_Code 子库存,
       round(c.Item_Cost,3)  成本
  FROM Mtl_Onhand_Quantities o,
       Mtl_System_Items_Vl   b,
       Cst_Item_Costs        c，
       mtl_secondary_inventories d
        WHERE o.Inventory_Item_Id = b.Inventory_Item_Id
   AND o.Organization_Id = b.Organization_Id
   AND o.Inventory_Item_Id = c.Inventory_Item_Id
   AND o.Organization_Id = c.Organization_Id
   AND o.SUBINVENTORY_CODE=d.secondary_inventory_name
   AND d.attribute1=2     ---1为一级库， 2为二级库
   AND o.Subinventory_Code <> 'FZH0001'
   --AND o.Subinventory_Code='L01GT01'
   --AND b.Description LIKE '%螺母%'
  -- AND  b.Segment1=300030150002
   -- AND  b.Segment1 LIKE '34%'
   --AND b.ATTRIBUTE2='劳保用品'
   -- AND b.INVENTORY_ITEM_ID=4498
   --AND b.attribute1='是'
   AND  d.organization_id=102
 GROUP BY b.Segment1,
          b.Description,
          b.PRIMARY_UOM_CODE，
          o.Subinventory_Code,
          c.Item_Cost
