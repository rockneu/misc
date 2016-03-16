
-- fixed: bug �̶��ʲ������󣬴�����Ҫ��������ʱ SQ201402260012, �ж������ڵ�������,ʵ���޷������� 
SELECT '����' TYPE,
       h.demand_code,
       h.status,
       l.line_num,
       msib.segment1,
       l.req_quantity,
       l.list_price,
       poh.segment1,
       pra.release_num,
--       h.status,
       l.attribute1,
       l.return_flag,
       poh.authorization_status ����״̬,
       pra.authorization_status ����״̬,
       case
         when (h.status in ('IN PROCESS' /*,'REAPPROVAL'*/ --uncomment REAPPROVAL by liuwei
              ) OR
              (h.status in ('APPROVED') AND
              (l.attribute11 = 'RETURN' OR nvl(l.return_flag, 'N') = 'Y'))) AND
              l.attribute12 is null then
          '����'
         when nvl(pra.authorization_status,
                  nvl(poh.authorization_status, '-1')) = 'APPROVED' then
          'ʵ��'
         when h.status = 'APPROVED' AND
              (nvl(l.attribute11, '-1') <> 'RETURN' OR
              nvl(l.return_flag, 'N') <> 'Y') then
          '�ݿ�'
         when h.status = 'REAPPROVAL' AND
              nvl(pra.authorization_status,
                  nvl(poh.authorization_status, '-1')) = 'APPROVED' then
          'ʵ��'       
       end ״̬,
       pol.market_price,
       pll.quantity,
       ROUND(nvl(l.req_quantity, 0) * nvl(pol.market_price, 0), 2) amt
  FROM cux_inv_demand_lines     l,
       mtl_system_items_b       msib,
       cux_inv_demand_headers   h,
       cux_inv_plan_lines       pl,
       po_requisition_lines_all prl,
       po_req_distributions_all prd,
       po_distributions_all     pod,
       po_line_locations_all    pll,
       po_headers_all           poh,
       po_lines_all             pol,
       po_releases_all          pra
 WHERE l.header_id = h.header_id
   AND l.attribute1 = &p_item_cat --'28.007'--����.����
   AND h.bud_year = &p_bud_year --'2013'--
   AND h.center_id = &p_center_id --70587 gdjdzx, 70588 KYYX -- ���Ĳ���
   AND decode(h.demand_type,
              '�ͱ�����',
              '������',
              '�̶��ʲ�',
              '������',
              h.demand_type) = &p_bud_type --'������'--
      --AND h.demand_type = p_bud_type--'������'--
   AND msib.organization_id = l.organization_id
   AND msib.inventory_item_id = l.inventory_item_id
      --AND decode(nvl(msib.item_type,msib.item_type),'WZ','������','��������')=p_bud_type
   AND h.organization_id = &p_organization_id --102-- 
   AND h.status IN ('APPROVED','REAPPROVAL')
   AND (nvl(l.attribute11, '-1') <> 'RETURN' OR
       nvl(l.return_flag, 'N') <> 'Y') -- �˻ص������ݿ�
      --AND l.attribute12 = 'PO'
   AND l.line_id = pl.demand_line_id
   AND pl.requisition_line_id = prl.requisition_line_id --�ƻ��е�������
   AND prl.requisition_line_id = prd.requisition_line_id --�����е����������
   AND prd.distribution_id = pod.req_distribution_id -- ��������е��ɹ�������
   AND pod.line_location_id = pll.line_location_id -- ��������е��ɹ����䷢����
   AND pod.po_line_id = pol.po_line_id --�ɹ������е��ɹ�������
   AND pod.po_header_id = poh.po_header_id
   AND pod.po_release_id = pra.po_release_id(+)
   --added by liuwei for po status
   and poh.authorization_status='APPROVED'
/*AND nvl(pra.authorization_status, nvl(poh.authorization_status, '-1')) NOT IN
       ('APPROVED', '-1')*/

UNION ALL

SELECT '�޶���' TYPE,
       h.demand_code,
       h.status,
       l.line_num,
       msib.segment1,
       l.req_quantity,
       l.list_price,
       poh.segment1,
       pra.release_num,
--       h.status,
       l.attribute1,
       l.return_flag,
       poh.authorization_status ����״̬,
       pra.authorization_status ����״̬,
       case
         when (h.status in ('IN PROCESS' /*,'REAPPROVAL'*/
              ) OR
              (h.status in ('APPROVED') AND
              (l.attribute11 = 'RETURN' OR nvl(l.return_flag, 'N') = 'Y'))) AND
              l.attribute12 is null then
          '����'
         when nvl(pra.authorization_status,
                  nvl(poh.authorization_status, '-1')) = 'APPROVED' then
          'ʵ��'
         when h.status = 'APPROVED' AND
              (nvl(l.attribute11, '-1') <> 'RETURN' OR
              nvl(l.return_flag, 'N') <> 'Y') then
          '�ݿ�'
       end ״̬
       
      ,
       pol.market_price,
       pll.quantity,
       ROUND(nvl(l.req_quantity, 0) * nvl(l.list_price, 0), 2) amt

  FROM cux_inv_demand_lines     l,
       mtl_system_items_b       msib,
       cux_inv_demand_headers   h,
       cux_inv_plan_lines       pl,
       po_requisition_lines_all prl,
       po_req_distributions_all prd,
       po_distributions_all     pod,
       po_line_locations_all    pll,
       po_headers_all           poh,
       po_lines_all             pol,
       po_releases_all          pra
 WHERE l.header_id = h.header_id
   AND l.attribute1 = &p_item_cat --'28.007'--����.����
   AND h.bud_year = &p_bud_year --'2013'--
   AND h.center_id = &p_center_id --70585-- ���Ĳ���
   AND decode(h.demand_type,
              '�ͱ�����',
              '������',
              '�̶��ʲ�',
              '������',
              h.demand_type) = &p_bud_type --'������'--
      --AND h.demand_type = p_bud_type--'������'--
   AND msib.organization_id = l.organization_id
   AND msib.inventory_item_id = l.inventory_item_id
      --AND decode(nvl(msib.item_type,msib.item_type),'WZ','������','��������')=p_bud_type
   AND h.organization_id = &p_organization_id --102-- 
   AND h.status = 'APPROVED'
   AND (nvl(l.attribute11, '-1') <> 'RETURN' OR
       nvl(l.return_flag, 'N') <> 'Y') -- �˻ص������ݿ�
      --AND l.attribute12 = 'PO'
   AND l.line_id = pl.demand_line_id(+)
   AND pl.requisition_line_id = prl.requisition_line_id(+) --�ƻ��е�������
   AND prl.requisition_line_id = prd.requisition_line_id(+) --�����е����������
   AND prd.distribution_id = pod.req_distribution_id(+) -- ��������е��ɹ�������
   AND pod.line_location_id = pll.line_location_id(+) -- ��������е��ɹ����䷢����
   AND pod.po_line_id = pol.po_line_id(+) --�ɹ������е��ɹ�������
   AND pod.po_header_id = poh.po_header_id(+)
   AND pod.po_release_id = pra.po_release_id(+)
   AND pod.req_distribution_id IS NULL         --��Ч״̬PO�Ľ��������ݿ�
   AND nvl(pra.authorization_status, nvl(poh.authorization_status, '-1')) = '-1'