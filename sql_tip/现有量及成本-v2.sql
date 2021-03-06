SELECT b.Segment1 物料编码,
       d.Organization_Id,
--       ms.organization_id,
--       b.INVENTORY_ITEM_ID,
       b.ITEM_TYPE 物料类别,
       b.Description 物料描述,
       b.Primary_Uom_Code 单位,
       d.Attribute1 总库二级库,
       ms.description 库房,
       ms.secondary_inventory_name,
       o.Subinventory_Code 库房,
       e.segment1 货位,
       SUM(o.Transaction_Quantity) 数量,
       Round(c.Item_Cost, 3) 单价,
       b.attribute2 所属大类,
       b.attribute1 是否固资,
       b.attribute5 列管消耗,
       b.attribute6 归口部门,
       b.attribute4 是否直发,
       b.attribute7 是否危化

  FROM Mtl_Onhand_Quantities     o,
       Mtl_System_Items_Vl       b,
       Cst_Item_Costs            c,
       Mtl_Secondary_Inventories d,
       MTL_ITEM_LOCATIONS        e,
       Mtl_Secondary_Inventories Ms

 WHERE o.Inventory_Item_Id = b.Inventory_Item_Id
   AND o.Organization_Id = b.Organization_Id
   AND o.Inventory_Item_Id = c.Inventory_Item_Id
   AND o.Organization_Id = c.Organization_Id
   AND o.Subinventory_Code = d.Secondary_Inventory_Name
   AND o.SUBINVENTORY_CODE = e.subinventory_code(+)
   AND o.LOCATOR_ID = e.inventory_location_id(+)
      
   and o.Subinventory_Code = Ms.Secondary_Inventory_Name

         AND d.Attribute1 = 1 ---1为一级库， 2为二级库
         AND o.Subinventory_Code = 'Z02DC01'
      --   AND o.Subinventory_Code <> 'FZH0001'
      -- 1-供电机电-机电车间通风空调工班         L01GJ06
      -- 1-供电机电-机电车间给排水工班          L01GJ09
      -- 1-供电机电-机电车间电扶梯工班          L01GJ08
      --  ---> 1-供电机电-机电车间低压供电工班  L01GJ07
      
      
      -- 1-供电机电-机电车间FAS工班             L01GJ02
      -- --->  1-供电机电-机电车间BAS工班             L01GJ03
      
--      and b.segment1 in ('010083110001', '') --='300030250001'
--      and  ms.secondary_inventory_name='L01GJ06'
         AND d.Organization_Id = 969 -- 102 for 301, line1 , 1558 for 326,301-line2, 969 FOR 303, 1358 FOR 352, 1618 for 326
      and ms.organization_id=d.organization_id
      and c.organization_id=d.organization_id

 GROUP BY b.Segment1,
           d.Organization_Id,
--           ms.organization_id,
          --b.INVENTORY_ITEM_ID,
          b.ITEM_TYPE,
          b.Description,
          b.Primary_Uom_Code,
          ms.description,
           ms.secondary_inventory_name,
          o.Subinventory_Code,
          e.segment1,
          c.Item_Cost,
          d.Attribute1,
          b.attribute2,
          b.attribute1,
          b.attribute5,
          b.attribute6,
          b.attribute4,
          b.attribute7
