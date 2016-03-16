SELECT b.Segment1 ���ϱ���,
       b.Description ��������,
       b.Primary_Uom_Code ��λ,
       d.Attribute1 �ܿ������,      
       ms.description �ⷿ,
       o.Subinventory_Code �ⷿ,
       e.segment1  ��λ,
       SUM(o.Transaction_Quantity) ����,
       Round(c.Item_Cost, 3) �ɱ���
       
       b.attribute2 ��������,
       b.attribute1 �Ƿ����,
       b.attribute5 �й�����,
       b.attribute6  ��ڲ���,
       b.attribute4  �Ƿ�ֱ��,
       b.attribute7  �Ƿ�Σ��
       
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
--   AND d.Attribute1 = 1 ---1Ϊһ���⣬ 2Ϊ������
   AND o.Subinventory_Code <> 'FZH0001'
      AND o.Subinventory_Code='Z02LT01'
--      AND O.ORGANIZATION_ID=969
      --AND b.Description LIKE '%��ĸ%'
      -- AND  b.Segment1=300030150002
      -- AND  b.Segment1 LIKE '34%'
      --AND b.ATTRIBUTE2='�ͱ���Ʒ'
      -- AND b.INVENTORY_ITEM_ID=4498
      --AND b.attribute1='��'
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
