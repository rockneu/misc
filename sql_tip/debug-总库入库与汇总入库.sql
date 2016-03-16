
				SELECT h.demand_code,l.return_flag，l.*
					--INTO ln_reserved_amount
					FROM cux_inv_demand_lines   l
							,cux_inv_demand_headers h
				 WHERE l.header_id = h.header_id
					 AND l.attribute1 = '30.009' --大类.中类
					 AND h.bud_year = '2014'
					 AND h.center_id = 70587
					 AND h.demand_type = '生产性'
					 AND h.organization_id = 102
					 AND (h.status in  ('IN PROCESS'/*,'REAPPROVAL'*/) 
           OR 
           (h.status in  ('APPROVED') AND (l.attribute11 = 'RETURN' OR nvl(l.return_flag,'N') = 'Y'))
           )    ;
           
	SELECT h.demand_code,l.attribute11,l.return_flag,l.*
     -- INTO ln_reserved_amount
  FROM cux_inv_demand_lines     l
      ,cux_inv_demand_headers   h
      ,cux_inv_plan_lines       pl
      ,po_requisition_lines_all prl
      ,po_req_distributions_all prd
      ,po_distributions_all     pod
      ,po_headers_all   poh
      ,po_releases_all pra
 WHERE l.header_id = h.header_id
					 AND l.attribute1 = '30.009' --大类.中类
					 AND h.bud_year = '2014'
					 AND h.center_id = 70587
					 AND h.demand_type = '生产性'
					 AND h.organization_id = 102
   AND h.status = 'APPROVED'
   AND (nvl(l.attribute11,'-1') <> 'RETURN' and nvl(l.return_flag,'N') <> 'Y') -- 退回的行算暂扣
   --AND l.attribute12 = 'PO'
   AND l.line_id = pl.demand_line_id(+)
   AND pl.requisition_line_id = prl.requisition_line_id(+) --计划行到申请行
   AND prl.requisition_line_id = prd.requisition_line_id(+) --申请行到申请分配行
   AND prd.distribution_id = pod.req_distribution_id(+)-- 申请分配行到采购分配行
   AND pod.po_header_id = poh.po_header_id(+)
   AND pod.po_release_id = pra.po_release_id(+)
   AND nvl(pra.authorization_status,nvl(poh.authorization_status,'-1')) <> 'APPROVED'-- 如果已审批，且没有采购订单生成，且状态为已审批，则为暂扣金额
   --AND h.demand_code = 'SQ201303290002'
;
Cux_Inv_Total_Count_Pkg.Total_Count;
Cux_Inv_Reprot_Pkg.Receive_Report

CUX_INV_TRX_SUMMARY_PKG.MAIN

SELECT t.transaction_type_id,T.transaction_type_name,t.item_type,t.subinv_level,sum(t.trx_qty)
  FROM CUX_INV_TRX_DETAILS_V t
 where transaction_date between to_date('20140424', 'yyyymmdd') and
       to_date('20140522', 'yyyymmdd')/* + 0.99999*/
   and t.subinv_level = 1
   and t.item_type = 'WZ'
   --and t.transaction_type_id in (122/*,162*/,121,31)
   group by t.transaction_type_id,t.item_type,t.subinv_level,T.transaction_type_name;
 
select  to_date('20140424', 'yyyymmdd') , to_date('20140424', 'yyyymmdd')+0.99999 from dual;

SELECT * FROM Mtl_Secondary_Inventories;
SELECT * FROM Mtl_System_Items_b;

             
select * from mtl_transaction_types where transaction_type_id in (18, 41, 36, 124)   ;
     
     

SELECT  --distinct s.Transaction_Type_Id
       S.PRIMARY_QUANTITY,S.*
--       SUM(s.Primary_Quantity) Item_Qty, Round(SUM(s.Actual_Cost * s.Primary_Quantity), 2) Item_Amount
        FROM Mtl_Material_Transactions s,
             Mtl_Secondary_Inventories Msi,
             Mtl_System_Items_b        Msb
       WHERE Msi.Attribute1 = '1'
         AND s.Subinventory_Code = Msi.Secondary_Inventory_Name
         AND s.Organization_Id = Msi.Organization_Id
         AND s.Organization_Id = 102
--         AND s.Transaction_Type_Id IN (18, 41, 36, 124)
         and s.Transaction_Type_Id IN (/*18 , 41, 36*/ 124)
         AND s.Inventory_Item_Id = Msb.Inventory_Item_Id
         AND s.Organization_Id = Msb.Organization_Id
         AND Msb.Item_Type = 'WZ'
         --AND (Msb.Attribute2 = p_Catagory OR p_Catagory IS NULL)
         AND s.Subinventory_Code <> 'FZH0001'
         and s.transaction_date between to_date('20140424', 'yyyymmdd') and to_date('20140522', 'yyyymmdd') + 0.99999
         /*AND Trunc(s.Transaction_Date) >=
             Trunc(To_Date('2014/04/24', 'yyyy/mm/dd hh24:mi:ss'))
         AND Trunc(s.Transaction_Date) <=
             Trunc(To_Date('2014/05/22', 'yyyy/mm/dd hh24:mi:ss'))*/
         --and s.primary_quantity<0
         ;

      SELECT SUM(s.Primary_Quantity) Item_Qty,
             Round(SUM(s.Actual_Cost * s.Primary_Quantity), 2) Item_Amount
        FROM Mtl_Material_Transactions s,
             Mtl_Secondary_Inventories Msi,
             Mtl_System_Items_b        Msb
       WHERE Msi.Attribute1 = '1'
         AND s.Subinventory_Code = Msi.Secondary_Inventory_Name
         AND s.Organization_Id = Msi.Organization_Id
         AND s.Organization_Id = 102
         AND s.Transaction_Type_Id IN (18, 41, 36/*, 124*/)  -- commented type 124 by liuwei 20140528
         AND s.Inventory_Item_Id = Msb.Inventory_Item_Id
         AND s.Organization_Id = Msb.Organization_Id
         AND Msb.Item_Type = 'WZ'
--         AND (Msb.Attribute2 = p_Catagory OR p_Catagory IS NULL)
         AND s.Subinventory_Code <> 'FZH0001'
         AND Trunc(s.Transaction_Date) >=
             Trunc(To_Date('20140424', 'yyyy/mm/dd hh24:mi:ss'))
         AND Trunc(s.Transaction_Date) <=
             Trunc(To_Date('20140522', 'yyyy/mm/dd hh24:mi:ss'));
             

SELECT 
--*
NVL(SUM(T.trx_qty),0) QTY           ,NVL(SUM(T.AMOUNT),0) AMOUNT          ,COUNT(DISTINCT(T.ITEM)) ITEM_COUNT          ,COUNT(DISTINCT(T.TRANSACTION_SOURCE)) LOT_COUNT
--    INTO L_ITEM_QTY_LEVEL1_IN,L_ITEM_AMOUNT_LEVEL1_IN,L_ITEM_COUNT_LEVEL1_IN,L_LOT_LEVEL1_IN
--    FROM CUX_INV_TRX_DETAILS_TEMP T
    from CUX_INV_TRX_DETAILS_V t
   WHERE T.Organization_Id = 102
--     AND T.TRANSACTION_DATE >= To_Date('2014/04/24', 'yyyy/mm/dd hh24:mi:ss') --L_DATE_FROM
--     AND T.TRANSACTION_DATE >= To_Date('2014/04/24', 'yyyy/mm/dd hh24:mi:ss') --L_DATE_FROM
--     AND T.TRANSACTION_DATE <= To_Date('2014/05/22', 'yyyy/mm/dd hh24:mi:ss')  --L_DATE_TO
       and t.transaction_date between to_date('20140424', 'yyyymmdd') and to_date('20140522', 'yyyymmdd') + 0.99999
     AND t.trx_type = '一级库采购入库'  --18 , 36
     and t.item_type='WZ'
     GROUP BY T.TRX_TYPE;        
     
     
     
     
     