
SELECT  
        -- * 
        SUM(COST), INV
FROM
(
  SELECT 
         SUM(o.Transaction_Quantity) * round(c.item_cost,3) as COST 
         ,MS.SECONDARY_INVENTORY_NAME                       AS INV

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

--      and  ms.secondary_inventory_name='Z02LT01'
           AND d.Organization_Id = 969 -- 102 for 301, line1 , 1558 326,301-line2, 969 FOR 303
           and d.attribute1 = 1        -- 1为一级库， 2为二级库
        and ms.organization_id=d.organization_id
        and c.organization_id=d.organization_id

   GROUP BY C.ITEM_COST,
            MS.SECONDARY_INVENTORY_NAME
   order by ms.secondary_inventory_name   
 ) 
GROUP BY INV 
ORDER BY 1       
;
