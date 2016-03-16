SELECT
 dh.demand_code ���󵥺�,
  msib.organization_id,
 dh.demand_name ��������,
 dh.status      ״̬,
 dh.demand_type ��������,
 dh.attribute1	��������,
 dp1.Description ��������,
 dp2.Description ���복��,
 dp3.Description �������,
 to_char(dh.creation_date,'YYYY-MM-DD') ����ʱ��,
 dl.line_num  �к�,
 msib.segment1 ���ϱ���,
 msib.description ��������,
 msib.primary_uom_code  ��λ,
 dl.list_price ���㵥��,
 dl.req_quantity ����,
 dl.attribute4 �����������,
 dl.req_quantity*dl.list_price ���,
 dl.attribute3 �ο�Ʒ��,
 msib.attribute2 ��������,
 msib.attribute1 �Ƿ����,
 msib.attribute5 �й�����,
 msib.attribute6  ��ڲ���,
 msib.attribute7  �Ƿ�Σ��

FROM 
CUX_INV_DEMAND_HEADERS dh,
Cux_Inv_Demand_Lines dl ,
cux_inv_centers_v   dp1 ,
cux_inv_depts_v   dp2 ,
cux_inv_sub_depts_v dp3 ,
mtl_system_items_b  msib
WHERE dh.header_id=dl.header_id
AND  dh.center_id =dp1.Flex_Value_Id
AND  dh.dept_id =dp2.Flex_Value_Id
AND  dh.sub_dept_id=dp3.Flex_Value_Id(+)
AND  dl.inventory_item_id=msib.inventory_item_id
AND msib.organization_id in ('102','969')
--and dH.status='APPROVED'
--AND  msib.segment1 LIKE '28002%'
--AND  dp1.Description='����ͨ������'
--AND  to_char(dh.creation_date,'YYYY-MM-DD') >='2013-01-01'
--and msib.segment1 = '300030200001'
--and  dl.attribute4 like '%.%';
--AND dh.demand_code='SQ201308090004'
--order by dh.demand_code , dl.line_num 9 asc;
