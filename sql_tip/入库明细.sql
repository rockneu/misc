SELECT Rt.Rma_Reference  入库单号,
       m.Segment1   物料编码,
       m.Description  物料描述,
       Mt.Primary_Quantity 数量,
       Mt.Actual_Cost 入库单价,
       Mt.Primary_Quantity * Mt.Actual_Cost 金额,
       Rt.Transaction_Date 入库时间
  FROM Rcv_Transactions          Rt,
       Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m
 WHERE Rt.Transaction_Id = Mt.Rcv_Transaction_Id
   AND Mt.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mt.Organization_Id = m.Organization_Id
   AND m.Organization_Id = 102
  AND Rt.Transaction_Date>=
       TO_DATE('20-09-2012 00:00:00', 'DD-MM-YYYY HH24:MI:SS')
   AND Rt.Transaction_Date<=
       TO_DATE('20-10-2012 23:59:59', 'DD-MM-YYYY HH24:MI:SS')
   AND m.ITEM_TYPE='WZ'
/*   AND Rt.Rma_Reference IN (600000071,
                            600000083)*/
 ORDER BY 1
