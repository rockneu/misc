SELECT 
       sum(Cidl.Req_Quantity * Pla.Market_Price)
/*       Cidh.Center_Name,
       cidh.dept_name,
       Cidh.Demand_Code   需求申请, --申请号
       Cidl.Item_Num, --物料
       Cidl.Req_Quantity 需求数量，--需求数量
       Cidl.List_Price, --更新的需求价格
       Pla.Market_Price  采购价格, --采购订单含税价
--       Pla.Unit_Price, --采购订单不含税价
       Pha.Segment1      采购订单--采购订单号
       ,pha.approved_date
       ,    Pha.Authorization_Status
--       ,    pha.approved_flag
       ,    pha.cancel_flag*/
  FROM Cux_Inv_Demand_Headers_v Cidh,
       Cux_Inv_Demand_Lines_v   Cidl,
       Cux_Inv_Plan_Lines       Cipl,
       Po_Requisition_Lines_All Prla,
       Po_Req_Distributions_All Prda,
       Po_Headers_All           Pha,
       Po_Lines_All             Pla,
       Po_Line_Locations_All    Plla,
       Po_Distributions_All     Pda
 WHERE Cidl.Header_Id = Cidh.Header_Id
   AND Cipl.Demand_Line_Id = Cidl.Line_Id
   AND Prla.Requisition_Line_Id = Cipl.Requisition_Line_Id
   AND Prda.Requisition_Line_Id = Prla.Requisition_Line_Id
   AND Pda.Req_Distribution_Id = Prda.Distribution_Id
   AND Plla.Line_Location_Id = Pda.Line_Location_Id
   AND Pla.Po_Line_Id = Plla.Po_Line_Id
   AND Pla.Po_Header_Id = Pha.Po_Header_Id

   and Pha.Authorization_Status='APPROVED'
   and pha.cancel_flag='N'
       
   AND Cidl.Attribute1 = '25.004' --大类.中类
   AND Cidh.Bud_Year = '2013'--年
--   AND Cidh.Center_Name = '供电机电中心'--中心  工务通号中心
   AND Cidh.Center_Name = '客运营销中心'            --中心

   AND Cidh.Demand_Type = '生产性'              --类别
   AND Cidh.Organization_Id = 102               --库存组织
   AND Cidh.Status = 'APPROVED'                 --需求审批通过
   AND Cidl.Attribute12 = 'PO'                  --已更新订单价格
--   and item_num like '13006%'
