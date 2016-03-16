SELECT
 dh.demand_code 需求单号,
  msib.organization_id,
 dh.demand_name 需求名称,
 dh.status      状态,
 dh.demand_type 需求类型,
 dh.attribute1	需求性质,
 dp1.Description 申请中心,
 dp2.Description 申请车间,
 dp3.Description 申请班组,
 to_char(dh.creation_date,'YYYY-MM-DD') 申请时间,
 dl.line_num  行号,
 msib.segment1 物料编码,
 msib.description 物料描述,
 msib.primary_uom_code  单位,
 dl.list_price 估算单价,
 dl.req_quantity 数量,
 dl.attribute4 年度需求数量,
 dl.req_quantity*dl.list_price 金额,
 dl.attribute3 参考品牌,
 msib.attribute2 所属大类,
 msib.attribute1 是否固资,
 msib.attribute5 列管消耗,
 msib.attribute6  归口部门,
 msib.attribute7  是否危化

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
--AND  dp1.Description='工务通号中心'
--AND  to_char(dh.creation_date,'YYYY-MM-DD') >='2013-01-01'
--and msib.segment1 = '300030200001'
--and  dl.attribute4 like '%.%';
--AND dh.demand_code='SQ201308090004'
--order by dh.demand_code , dl.line_num 9 asc;
