SELECT 
 /*
 
 dh.demand_code ���󵥺�,
 dh.demand_name ��������,
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
-- msib.attribute2 ��������,
 msib.attribute1 �Ƿ����,
 msib.attribute5 �й�����,
 msib.attribute6  ��ڲ���,
 msib.attribute7  �Ƿ�Σ��
 
,*/
 /*--a=max(case when msib.attribute2='������')
  case msib.attribute2 
       when '������' then '������111'  --as ������111
       when '�Ĳ�'   then '�Ĳ�222'   -- as �Ĳ�222
       --else  as '����333' 
  end --as xxx*/
  
  --select col1,
  dp1.Description ��������,
 dp2.Description ���복��,
 dp3.Description �������,
 
/* sum(dl.req_quantity(case msib.attribute2 when '������' then msib.attribute2 else '' end)),*/
 
  max(case msib.attribute2 when '������' then to_char(sum(dl.req_quantity)) else '' end) as ������qty,
--  max(case msib.attribute2 when '������' then substr(msib.attribute2,1,1) else '' end) as ������qty,
  max(case msib.attribute2 when '�Ĳ�' then msib.attribute2 else '' end) �Ĳ�qty,
  max(case msib.attribute2 when '��Ʒ����' then msib.attribute2 else '' end) ��Ʒ����qty,
  max(case msib.attribute2 when '�ͱ���Ʒ' then msib.attribute2 else '' end) �ͱ���Ʒqty
  --from tb
  
  
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
AND msib.organization_id='102'
and dh.demand_type='������'

group by dp1.Description ,
 dp2.Description,
 dp3.Description
-- , ������qty
  
--and msib.segment1 = '300030200001'
--and  dl.attribute4 like '%.%';
--AND dh.demand_code='SQ201301160004'
--order by dh.demand_code , dl.line_num;
