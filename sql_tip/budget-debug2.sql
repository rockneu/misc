SELECT 
    --ROUND(sum(nvl(pll.quantity, 0) * nvl(pol.market_price/*unit_price*/, 0)),2)
      ROUND(SUM(nvl(pll.quantity,nvl(l.req_quantity, 0)) * nvl(pol.market_price,nvl(l.list_price, 0))),2)
/*
     h.demand_code,l.line_num,l.req_quantity,l.list_price,
     msib.description,pll.quantity,pol.market_price,pll.line_location_id
     */
  FROM cux_inv_demand_lines     l
       ,mtl_system_items_b msib
      ,cux_inv_demand_headers   h
      ,cux_inv_plan_lines       pl
      ,po_requisition_lines_all prl
      ,po_req_distributions_all prd
      ,po_distributions_all     pod
      ,po_line_locations_all pll
      ,po_headers_all   poh
      ,po_lines_all pol
      ,po_releases_all pra
 WHERE l.header_id = h.header_id
   AND l.attribute1 = '30.015' --'28.007'--大类.中类
   AND h.bud_year = '2014'--'2013'--
   AND h.center_id =  70586--70585-- 中心部门
   AND decode(h.demand_type,'劳保物资','生产性','固定资产','生产性',h.demand_type) = '生产性'--'生产性'--
   --AND h.demand_type = p_bud_type--'生产性'--
   AND msib.organization_id = l.organization_id
   AND msib.inventory_item_id = l.inventory_item_id
   --AND decode(nvl(msib.item_type,msib.item_type),'WZ','生产性','非生产性')=p_bud_type
   AND h.organization_id = 102--102-- 
   AND h.status = 'APPROVED'
   AND (nvl(l.attribute11,'-1') <> 'RETURN' OR nvl(l.return_flag,'N') <> 'Y') -- 退回的行算暂扣
   --AND l.attribute12 = 'PO'
   AND l.line_id = pl.demand_line_id(+)
   AND pl.requisition_line_id = prl.requisition_line_id(+) --计划行到申请行
   AND prl.requisition_line_id = prd.requisition_line_id(+) --申请行到申请分配行
   AND prd.distribution_id = pod.req_distribution_id(+)-- 申请分配行到采购分配行
   AND pod.line_location_id = pll.line_location_id(+) -- 申请分配行到采购分配发运行
   AND pod.po_line_id = pol.po_line_id(+)--采购分配行到采购订单行
   AND pod.po_header_id = poh.po_header_id(+)
   AND pod.po_release_id = pra.po_release_id(+)
   AND nvl(pra.authorization_status,nvl(poh.authorization_status,'-1')) <> 'APPROVED'-- 如果已审批，且没有采购订单生成，且状态为已审批，则为暂扣金额
   --AND h.demand_code = 'SQ201303290002'
;
--cux_inv_bud_pkg
