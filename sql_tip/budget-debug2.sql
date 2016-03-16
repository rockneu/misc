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
   AND l.attribute1 = '30.015' --'28.007'--����.����
   AND h.bud_year = '2014'--'2013'--
   AND h.center_id =  70586--70585-- ���Ĳ���
   AND decode(h.demand_type,'�ͱ�����','������','�̶��ʲ�','������',h.demand_type) = '������'--'������'--
   --AND h.demand_type = p_bud_type--'������'--
   AND msib.organization_id = l.organization_id
   AND msib.inventory_item_id = l.inventory_item_id
   --AND decode(nvl(msib.item_type,msib.item_type),'WZ','������','��������')=p_bud_type
   AND h.organization_id = 102--102-- 
   AND h.status = 'APPROVED'
   AND (nvl(l.attribute11,'-1') <> 'RETURN' OR nvl(l.return_flag,'N') <> 'Y') -- �˻ص������ݿ�
   --AND l.attribute12 = 'PO'
   AND l.line_id = pl.demand_line_id(+)
   AND pl.requisition_line_id = prl.requisition_line_id(+) --�ƻ��е�������
   AND prl.requisition_line_id = prd.requisition_line_id(+) --�����е����������
   AND prd.distribution_id = pod.req_distribution_id(+)-- ��������е��ɹ�������
   AND pod.line_location_id = pll.line_location_id(+) -- ��������е��ɹ����䷢����
   AND pod.po_line_id = pol.po_line_id(+)--�ɹ������е��ɹ�������
   AND pod.po_header_id = poh.po_header_id(+)
   AND pod.po_release_id = pra.po_release_id(+)
   AND nvl(pra.authorization_status,nvl(poh.authorization_status,'-1')) <> 'APPROVED'-- �������������û�вɹ��������ɣ���״̬Ϊ����������Ϊ�ݿ۽��
   --AND h.demand_code = 'SQ201303290002'
;
--cux_inv_bud_pkg
