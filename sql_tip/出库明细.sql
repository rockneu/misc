SELECT Mt.Attribute1 ���ⵥ��,
       m.Segment1 ���ϱ���,
       m.Description ��������,
       Mtt.Transaction_Type_Name ����,
       Ms.Description �ӿ��,
       Abs(Mt.Primary_Quantity) ����,
       Mt.Actual_Cost ����ɱ�,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost ���
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
   AND Ms.Description NOT LIKE '%�ۺϲ��ӿ�%'
   AND Mtt.Transaction_Type_Name='�ǹ�������'
   AND Ms.Attribute1 = '2'	--������
   --AND  m.Segment1='290020030004'
 ORDER BY Mt.Attribute1
