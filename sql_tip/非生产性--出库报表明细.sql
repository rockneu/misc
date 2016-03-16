SELECT Mt.Attribute1 ���ⵥ��,
       to_char(Mt.Transaction_Date,'YYYY-MM-DD') ��������,
       m.Segment1 ���ϱ���,
       m.Description ��������,
       Mtt.Transaction_Type_Name ����,
       Ms.Description �ӿ��,
        
        CIC.Description ��������,
        CID.Description ���쳵��,
               m.attribute2 ��������,

       Abs(Mt.Primary_Quantity) ����,
       Mt.Actual_Cost ����ɱ�,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost ���,
              m.attribute1 �Ƿ����,
       m.attribute5 �й�����,
       m.attribute6  ��ڲ���,
       m.attribute4  �Ƿ�ֱ��,
       m.attribute7  �Ƿ�Σ��

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
   AND Ms.Description  LIKE '�ۺϲ��ӿ�%'

--   AND Mtt.Transaction_Type_Name='�ǹ�������'
--   AND Ms.Attribute1 = '2'
--AND  m.Segment1='290020030004'  
 ORDER BY 1
