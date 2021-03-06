SELECT M.ORGANIZATION_ID,
       Rt.Rma_Reference  入库单号,
       PH.SEGMENT1       订单号,
--       F.USER_NAME     ,
       hr.full_name    ,
       ph.Attribute1     合同编号,
--       pv.SEGMENT1       供应商编号,
       PV.VENDOR_NAME    供应商,
       to_char(Rt.Transaction_Date,'yyyy-mm-dd') 入库时间,
       mt.subinventory_code,
--       mt.locator_id,
--       mt.transfer_subinventory,
       m.Segment1   物料编码,
        m.ITEM_TYPE,
       m.Description  物料描述,
       Mt.Primary_Quantity 数量,
       Mt.Actual_Cost 入库单价,
       Mt.Primary_Quantity * Mt.Actual_Cost 金额,

       m.attribute2 所属大类,
       m.attribute1 是否固资,
       m.attribute5 列管消耗,
       m.attribute6  归口部门,
       m.attribute4  是否直发,
       m.attribute7  是否危化
       
  FROM Rcv_Transactions          Rt,
       PO_HEADERS_ALL            PH,
       PO_VENDORS                PV,
       Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m
       ,FND_USER                 F
       ,hr_employees             hr
       
 WHERE Rt.Transaction_Id = Mt.Rcv_Transaction_Id
   AND Mt.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mt.Organization_Id = m.Organization_Id
   
   AND RT.PO_HEADER_ID=PH.PO_HEADER_ID
   AND RT.VENDOR_ID=PV.VENDOR_ID
   
   AND F.USER_ID=PH.CREATED_BY
   and f.employee_id=hr.employee_id
--   AND m.Organization_Id = 102
--   AND m.ITEM_TYPE='WZ'
   AND m.Organization_Id IN (102,103,969)
   AND m.ITEM_TYPE IN ('ST','WZ','NWZ')
   and substr(Rt.Rma_Reference,1,1)='6'
   AND PH.AUTHORIZATION_STATUS='APPROVED'
    AND PH.CANCEL_FLAG='N'
--  and to_char(PH.APPROVED_DATE,'yyyy-mm-dd')>='2013-01-01'
--  and Rt.Rma_Reference='600001283'
--   and PH.SEGMENT1=980050000049
                   --980050000095
--   and ph.TYPE_LOOKUP_CODE='BLANKET'
 ORDER BY 1 DESC            
 --          
