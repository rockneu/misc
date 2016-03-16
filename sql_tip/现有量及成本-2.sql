SELECT b.Segment1 物料编码,
       b.Description 物料描述,
       b.Primary_Uom_Code 单位,
       d.Attribute1 总库二级库,      
       ms.description 库房,
       o.Subinventory_Code 库房,
       e.segment1  货位,
       SUM(o.Transaction_Quantity) 数量,
       Round(c.Item_Cost, 3) 成本，
       
       b.attribute2 所属大类,
       b.attribute1 是否固资,
       b.attribute5 列管消耗,
       b.attribute6  归口部门,
       b.attribute4  是否直发,
       b.attribute7  是否危化
       
  FROM Mtl_Onhand_Quantities     o,
       Mtl_System_Items_Vl       b,
       Cst_Item_Costs            c,
       Mtl_Secondary_Inventories d,
       MTL_ITEM_LOCATIONS    e,
       Mtl_Secondary_Inventories Ms
       
 WHERE o.Inventory_Item_Id = b.Inventory_Item_Id
   AND o.Organization_Id = b.Organization_Id
   AND o.Inventory_Item_Id = c.Inventory_Item_Id
   AND o.Organization_Id = c.Organization_Id
   AND o.Subinventory_Code = d.Secondary_Inventory_Name
   AND o.SUBINVENTORY_CODE=e.subinventory_code(+)
   AND o.LOCATOR_ID=e.inventory_location_id(+)
   
   and        o.Subinventory_Code = Ms.Secondary_Inventory_Name
--   AND d.Attribute1 = 1 ---1为一级库， 2为二级库
   AND o.Subinventory_Code <> 'FZH0001'
      AND o.Subinventory_Code='Z02LT01'
--      AND O.ORGANIZATION_ID=969
      --AND b.Description LIKE '%螺母%'
      -- AND  b.Segment1=300030150002
      -- AND  b.Segment1 LIKE '34%'
      --AND b.ATTRIBUTE2='劳保用品'
      -- AND b.INVENTORY_ITEM_ID=4498
      --AND b.attribute1='是'
   AND d.Organization_Id = 969 -- 969 FOR 303, 101 FOR 301
         and ms.organization_id=d.organization_id
 GROUP BY b.Segment1,
          b.Description,
          b.Primary_Uom_Code,
          ms.description,
          o.Subinventory_Code,
--          o.Subinventory_Code,
          e.segment1,
          c.Item_Cost,
          d.Attribute1,
          b.attribute2 ,
       b.attribute1 ,
       b.attribute5 ,
       b.attribute6  ,
       b.attribute4  ,
       b.attribute7  
