SELECT 
--m.Organization_Id,
--Rt.Rma_Reference  入库单号,
       PH.SEGMENT1       订单号,
--       ph.Attribute1     合同编号,
--       pv.SEGMENT1       供应商编号,
       PV.VENDOR_NAME    供应商,
       to_char(Rt.Transaction_Date,'yyyy-mm-dd') 入库时间,
       m.Segment1   物料编码,
       st2.description       物料类别,
       m.Description  物料描述,
--物料类别
          MT.TRANSACTION_UOM 单位,
       Mt.Primary_Quantity 数量,
       Mt.Actual_Cost 入库单价,
       Mt.Primary_Quantity * Mt.Actual_Cost 金额
       
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
   AND st2.description IN ('肉类','蔬菜')
--   and PH.SEGMENT1=400000389
--   and ph.TYPE_LOOKUP_CODE='BLANKET'
 ORDER BY 1 DESC;
 
 
