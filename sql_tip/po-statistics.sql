SELECT  
        SUM(Mt.Primary_Quantity * Mt.Actual_Cost) 金额
        ,sum(Mt.Primary_Quantity)       数量          
        ,count(distinct( m.Segment1))   物料编码种类数
        ,count(distinct(Rt.Rma_Reference)) 入库单数量
       
  FROM Rcv_Transactions          Rt,
       PO_HEADERS_ALL            PH,
       PO_VENDORS                PV,
       Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m
       
 WHERE Rt.Transaction_Id = Mt.Rcv_Transaction_Id
   AND Mt.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mt.Organization_Id = m.Organization_Id
   
   AND RT.PO_HEADER_ID=PH.PO_HEADER_ID
   AND RT.VENDOR_ID=PV.VENDOR_ID
   
   AND m.Organization_Id = 102
   AND m.ITEM_TYPE='WZ'
   and substr(Rt.Rma_Reference,1,1)='6'
   AND PH.AUTHORIZATION_STATUS='APPROVED'
    AND PH.CANCEL_FLAG='N'
  and to_char(PH.APPROVED_DATE,'yyyy-mm-dd')>='2013-01-01'
--   and PH.SEGMENT1=400000389
--   and ph.TYPE_LOOKUP_CODE='BLANKET'
 ORDER BY 1 DESC
