
SELECT to_char(Mt.transaction_date,'yyyy-mm-dd') �������ڣ�
       Mt.Attribute1 ���ⵥ��,       
       m.Segment1 ���ϱ���,
       m.Description ��������,
       Mtt.Transaction_Type_Name ����,
       Ms.Attribute1 �ܿ������ ,
       ms.description �ܿ�,
--       mt.transfer_subinventory ������,
       (SELECT description 
               FROM Mtl_Secondary_Inventories 
               WHERE Secondary_Inventory_Name=mt.transfer_subinventory ) Ŀ�������,
       --Ms.Description �ӿ��,
       Abs(Mt.Primary_Quantity) ����,
       Mt.Actual_Cost ����,
       Abs(Mt.Primary_Quantity) * Mt.Actual_Cost ���,
       -- dept, workshop
                CIC.Description ��������,
        CID.Description ���쳵��,
        CIS.DESCRIPTION ���칤��,
        
        
       m.attribute2 ��������,
       m.attribute1 �Ƿ����,
       m.attribute5 �й�����,
       m.attribute6  ��ڲ���,
       m.attribute4  �Ƿ�ֱ��,
       m.attribute7  �Ƿ�Σ��
       ,mt.*
  FROM Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       Mtl_Transaction_Types     Mtt,
       Cux_Inv_Depts_v       cid,
       Cux_Inv_Centers_v     cic,
       CUX_INV_SUB_DEPTS_V   cis,
       Mtl_Secondary_Inventories Ms

 WHERE Mt.Inventory_Item_Id = m.Inventory_Item_Id 
   AND Mt.Organization_Id = m.Organization_Id
   AND m.Organization_Id = 969 -- L1 102, L2 969 , WY 429
   AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
--   AND Mt.transfer_subinventory=Ms.Secondary_Inventory_Name
   AND Mt.Transaction_Type_Id = Mtt.Transaction_Type_Id
   and mt.TRANSACTION_ACTION_ID=2 and mt.transaction_type_id=122  --�ܿ�����������

   and mt.attribute6=cid.Flex_Value_Id(+)
   and mt.attribute12=cis.Flex_Value_Id(+)
   and substr(cid.Flex_Value,1,length(cid.Flex_Value)-4)= substr(cic.flex_value,1,length(cid.Flex_Value)-4)
--   and substr(cid.Flex_Value,1,5)= substr(cic.flex_value,1,5)
--   and substr(cis.Flex_Value,1,5)=substr(cic.flex_value,1,5)
   AND Ms.Attribute1 = '1'         --�ܿ�
   and m.SEGMENT1='270010270010'
--   AND Mt.Attribute1='CK201501120011'   
 ORDER BY Mt.Attribute1
 ;
 
 
 /*
       SELECT \*MT.attribute6,MT.attribute12*\ 
--        mt.*
        mt.attribute1, mt.attribute6,mt.attribute12, mt.subinventory_code,mt.inventory_item_id
 FROM Mtl_Material_Transactions MT
      ,       Mtl_Secondary_Inventories Ms
      ,       Cux_Inv_Depts_v           CID
      ,       CUX_INV_SUB_DEPTS_V       CIS
 WHERE MT.Attribute1='CK201501120011'
 AND MT.ORGANIZATION_ID=429
    and mt.TRANSACTION_ACTION_ID=2 and mt.transaction_type_id=122
    AND Mt.Subinventory_Code = Ms.Secondary_Inventory_Name
    AND Ms.Attribute1 = '1' 
    AND MT.ATTRIBUTE6= cid.Flex_Value_Id  -- ����
    and mt.attribute12=cis.Flex_Value_Id(+)
 ;
 
 select length(flex_value) from Cux_Inv_Depts_v where flex_value_id=385939
 ;select * from Cux_Inv_Centers_v 
 */

