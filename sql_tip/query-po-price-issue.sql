SELECT h.status,l.attribute11,l.attribute12,h.demand_code ������,h.center_id,ctr.DESCRIPTION,l.attribute1,h.bud_year
      ,h.demand_name ��������
      ,h.demand_type ��������
      ,l.line_num
      /*,ph.plan_code �ɹ��ƻ����
      ,ph.plan_name �ɹ��ƻ�����
      ,PL.LINE_NUM \*plan_line_num*\ �ɹ��ƻ��к�
      ,prh.segment1 \*req_num*\ �ɹ�������
      ,prl.line_num \*req_line_num*\ �ɹ������к�
      ,prd.distribution_id \*req_dist_id*\ �ɹ��������ID
      ,prd.distribution_num \*req_dist_num*\ �ɹ���������к�*/
      ,poh.segment1 �ɹ�������
      ,pod.po_distribution_id /*po_dist_id*/ �ɹ�����ID
      ,pod.distribution_num /*po_dist_num*/ �ɹ������к�
      ,pra.release_num
      ,l.req_quantity ��������
      ,l.list_price ����۸�
      ,pol.quantity �ɹ�����
      ,pol.unit_price ����˰
      ,pol.market_price �ɹ��۸�
      ,pol.market_price/pol.unit_price
  FROM cux_inv_demand_lines       l
      ,cux_inv_demand_headers     h
      ,cux_inv_plan_lines         pl
      ,cux_inv_plan_headers       ph
      ,po_requisition_lines_all   prl
      ,po_req_distributions_all   prd
      ,po_requisition_headers_all prh
      ,po_distributions_all       pod
      ,po_lines_all               pol
      ,po_line_locations_all pll
      ,po_headers_all             poh
      ,po_releases_all          pra
      ,Fnd_Flex_Values_Vl ctr
 WHERE l.header_id = h.header_id
   /*AND l.attribute1 = '30.020' --'28.007'--����.����
   AND h.bud_year = '2013' --'2013'--
   AND h.center_id = 70586 --70585-- ���Ĳ���
   AND h.demand_type = '������' --'������'--*/
   AND h.organization_id = 102 --102-- 
   /*AND (  h.status IN ('IN PROCESS', 'REAPPROVAL') OR
         (h.status IN ('APPROVED') AND (l.attribute11 = 'RETURN' OR nvl(l.return_flag, 'N') = 'Y')))*/
   --AND l.attribute12 IS NULL
      AND h.center_id = ctr.FLEX_VALUE_ID(+)
   AND l.line_id = pl.demand_line_id(+)
   AND pl.Header_Id = ph.header_id(+)
   AND pl.requisition_line_id = prl.requisition_line_id(+) --�ƻ��е�������
   AND prl.requisition_line_id = prd.requisition_line_id(+) --�����е����������
   AND prl.requisition_header_id = prh.requisition_header_id(+)
   AND pod.line_location_id = pll.line_location_id(+)
   AND prd.distribution_id = pod.req_distribution_id(+)
   AND pod.po_header_id = poh.po_header_id(+)
   AND pod.po_line_id = pol.po_line_id(+)   
   AND pll.creation_date > to_date('20140702','yyyymmdd')
   AND pod.po_release_id = pra.po_release_id(+)
--   and poh.authorization_status='APPROVED'
   order by poh.segment1;
   
   
   
   
   SELECT poh.segment1
      ,pr.release_num
      ,pol.line_num
      ,pol.market_price
      ,pol.unit_price
      ,pll.price_override
      ,t.transaction_type
      ,t.*
  FROM rcv_transactions      t
      ,po_line_locations_all pll
      ,po_lines_all          pol
      ,po_headers_all        poh
      ,po_releases_all       pr
 WHERE t.po_header_id = poh.po_header_id
   AND t.po_line_id = pol.po_line_id
   AND t.po_line_location_id = pll.line_location_id
--   AND t.po_release_id = pr.po_release_id
   AND pll.creation_date > to_date('20140702','yyyymmdd')
     and poh.segment1 in ('40200000178')
   ;

   
   