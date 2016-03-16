SELECT b.Segment1  ���ϱ���,
       b.Description  ��������,
       SUM(o.Transaction_Quantity) ������
       b.PRIMARY_UOM_CODE  ��λ��
       o.Subinventory_Code �ӿ��,
       round(c.Item_Cost,3)  �ɱ�
  FROM Mtl_Onhand_Quantities o,
       Mtl_System_Items_Vl   b,
       Cst_Item_Costs        c��
       mtl_secondary_inventories d
        WHERE o.Inventory_Item_Id = b.Inventory_Item_Id
   AND o.Organization_Id = b.Organization_Id
   AND o.Inventory_Item_Id = c.Inventory_Item_Id
   AND o.Organization_Id = c.Organization_Id
   AND o.SUBINVENTORY_CODE=d.secondary_inventory_name
   AND d.attribute1=2     ---1Ϊһ���⣬ 2Ϊ������
   AND o.Subinventory_Code <> 'FZH0001'
   --AND o.Subinventory_Code='L01GT01'
   --AND b.Description LIKE '%��ĸ%'
  -- AND  b.Segment1=300030150002
   -- AND  b.Segment1 LIKE '34%'
   --AND b.ATTRIBUTE2='�ͱ���Ʒ'
   -- AND b.INVENTORY_ITEM_ID=4498
   --AND b.attribute1='��'
   AND  d.organization_id=102
 GROUP BY b.Segment1,
          b.Description,
          b.PRIMARY_UOM_CODE��
          o.Subinventory_Code,
          c.Item_Cost
