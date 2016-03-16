SELECT 
--m.Organization_Id,
--Rt.Rma_Reference  ��ⵥ��,
       PH.SEGMENT1       ������,
--       ph.Attribute1     ��ͬ���,
--       pv.SEGMENT1       ��Ӧ�̱��,
       PV.VENDOR_NAME    ��Ӧ��,
       to_char(Rt.Transaction_Date,'yyyy-mm-dd') ���ʱ��,
       m.Segment1   ���ϱ���,
       st2.description       �������,
       m.Description  ��������,
--�������
          MT.TRANSACTION_UOM ��λ,
       Mt.Primary_Quantity ����,
       Mt.Actual_Cost ��ⵥ��,
       Mt.Primary_Quantity * Mt.Actual_Cost ���
       
  FROM Rcv_Transactions          Rt,
       PO_HEADERS_ALL            PH,
       PO_VENDORS                PV,
       Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       
       (SELECT DESCRIPTION, FLEX_VALUE_MEANING FROM FND_FLEX_VALUES_TL 
WHERE FLEX_VALUE_MEANING IN
   (SELECT ITEM_CATEGORY1 || ITEM_CATEGORY2  FROM CUX_INV_REQ_ACC_MAP WHERE ORGANIZATION_ID = 103) 
   AND LANGUAGE='ZHS')           st2
       
 WHERE Rt.Transaction_Id = Mt.Rcv_Transaction_Id
   AND Mt.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mt.Organization_Id = m.Organization_Id
   
   AND RT.PO_HEADER_ID=PH.PO_HEADER_ID
   AND RT.VENDOR_ID=PV.VENDOR_ID
   
   AND m.Organization_Id = 103
   AND m.ITEM_TYPE='ST'
   and substr(Rt.Rma_Reference,1,1)='6'
   and substr(m.segment1,1,5)=st2.FLEX_VALUE_MEANING
   and to_char(Rt.Transaction_Date,'yyyy-mm-dd') BETWEEN ('2014-12-01') AND ('2014-12-31')
   AND st2.description IN ('����','�߲�')
--   and PH.SEGMENT1=400000389
--   and ph.TYPE_LOOKUP_CODE='BLANKET'
 ORDER BY 1 DESC;
 
 
