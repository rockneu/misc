--SELECT * FROM po_distributions_all

-- 需求需重新审批状态，部分需求行已被采购下单
/*SELECT l.attribute1
									,nvl(SUM(l.req_quantity * l.list_price), 0) req_amount
							FROM cux_inv_demand_lines l
                   ,cux_inv_demand_headers h
						 WHERE l.header_id = 7396  --in_header_id
               AND l.header_id = h.header_id
               AND l.attribute1 =  '23.003'
               AND h.status IN ('REJECTED','REAPPROVAL','INCOMPLETE')
               AND NOT EXISTS \*不存在订单*\
               (
                 SELECT 1 FROM cux_inv_plan_lines       pl
                              ,po_requisition_lines_all prl
                              ,po_req_distributions_all prd
                              ,po_distributions_all     pod
                         WHERE l.line_id = pl.demand_line_id
                           AND pl.requisition_line_id = prl.requisition_line_id --计划行到申请行
                           AND prl.requisition_line_id = prd.requisition_line_id --申请行到申请分配行
                           AND prd.distribution_id = pod.req_distribution_id-- 申请分配行到采购分配行
               )
						 GROUP BY l.attribute1;
*/             

--  cux_inv_bud_pkg

--冻结 get_bud_rsv

SELECT 
       h.demand_code,
         h.status,
         l.req_quantity,
         l.list_price,
         msib.segment1,
         msib.description
       --SUM(nvl(l.req_quantity, 0) * nvl(l.list_price, 0))

  FROM cux_inv_demand_lines   l,
       mtl_system_items_b     msib,
       cux_inv_demand_headers h
 WHERE l.header_id = h.header_id
--   AND l.attribute1 = '30.018' --大类.中类
   AND h.bud_year = '2014'
   AND h.center_id = 70585  -- celiang 70585
      --AND h.demand_type = p_bud_type
   AND decode(h.demand_type,
              '劳保物资',
              '生产性',
              '固定资产',
              '生产性',
              h.demand_type) = '生产性' --
   AND h.organization_id = 102
   AND msib.organization_id = l.organization_id
   AND msib.inventory_item_id = l.inventory_item_id
      --AND decode(nvl(msib.item_type,msib.item_type),'WZ','生产性','非生产性')=p_bud_type
   AND ( h.status in ('IN PROCESS' /*,'REAPPROVAL'*/) OR
                (h.status in ('APPROVED')AND(l.attribute11 = 'RETURN' OR nvl(l.return_flag, 'N') = 'Y')))
   AND l.attribute12 is null     -- PO代表已下订单，此处表示需求行未被下单                           
   
   
   AND NOT EXISTS (
           SELECT 1 FROM
      cux_inv_plan_lines       pl
      ,po_requisition_lines_all prl
      ,po_req_distributions_all prd
      ,po_distributions_all     pod
      WHERE 1=1
       AND l.line_id = pl.demand_line_id
       AND pl.requisition_line_id = prl.requisition_line_id --计划行到申请行
       AND prl.requisition_line_id = prd.requisition_line_id --申请行到申请分配行
       AND prd.distribution_id = pod.req_distribution_id-- 申请分配行到采购分配行
       AND pod.req_distribution_id IS NOT NULL
      )

   
   
   ;
   
   --SELECT DISTINCT attribute12 FROM CUX_INV_DEMAND_LINES;
   
  /* SELECT dh.organization_id,DH.DEMAND_CODE, DH.STATUS, DL.ATTRIBUTE12,dl.line_num
   FROM CUX_INV_DEMAND_HEADERS DH
        ,CUX_INV_DEMAND_LINES DL
   where DH.HEADER_ID=DL.HEADER_ID
         and dl.attribute12 is not null
         AND DH.DEMAND_CODE='SQ201406110002'
         order by 2 desc, 5 asc
         ;*/
         
--暂扣 get_bud_
   
   
   
--实扣 get_bud_final

/*
       SELECT
        --sum(ROUND((nvl(l.req_quantity, 0) * nvl(pol.market_price\*unit_price*\, 0)),2))amt
         h.demand_code,
         h.status,
         l.req_quantity,
         l.list_price,
         l.attribute12,
         msib.segment1,
         msib.description,
         poh.segment1,
         poh.authorization_status,
         pra.release_num,
         pra.approved_flag,
         pol.quantity,
         pol.market_price
        
          FROM cux_inv_demand_lines     l,
               mtl_system_items_b       msib,
               cux_inv_demand_headers   h,
               cux_inv_plan_lines       pl,
               po_requisition_lines_all prl,
               po_req_distributions_all prd,
               po_distributions_all     pod,
               po_line_locations_all    pll,
               po_lines_all             pol,
               po_headers_all           poh,
               po_releases_all          pra
         WHERE l.header_id = h.header_id
           AND l.attribute1 = '18.001' --'28.007'--大类.中类
           AND h.bud_year = '2014' --'2013'--
           AND h.center_id = 70587 --70585-- 中心部门
           AND decode(h.demand_type,
                      '劳保物资',
                      '生产性',
                      '固定资产',
                      '生产性',
                      h.demand_type) = '生产性' --'生产性'--
           AND h.organization_id = 102 --102-- 
           AND msib.organization_id = l.organization_id
           AND msib.inventory_item_id = l.inventory_item_id
              --AND decode(nvl(msib.item_type,msib.item_type),'WZ','生产性','非生产性')=p_bud_type
              -- AND h.status = 'APPROVED'
              -- AND l.attribute12 = 'PO'
           AND l.line_id = pl.demand_line_id
           AND pl.requisition_line_id = prl.requisition_line_id --计划行到申请行
           AND prl.requisition_line_id = prd.requisition_line_id --申请行到申请分配行
           AND prd.distribution_id = pod.req_distribution_id -- 申请分配行到采购分配行
           AND pod.line_location_id = pll.line_location_id -- 申请分配行到采购分配发运行
           AND pod.po_line_id = pol.po_line_id --采购分配行到采购订单行
           AND pol.po_header_id = poh.po_header_id
           AND pod.po_release_id = pra.po_release_id(+)
              --AND poh.AUTHORIZATION_STATUS = 'APPROVED'
           AND nvl(pra.authorization_status,
                   nvl(poh.authorization_status, '-1')) = 'APPROVED' ;
*/
