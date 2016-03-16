SELECT 
 /*
 
 dh.demand_code 需求单号,
 dh.demand_name 需求名称,
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
-- msib.attribute2 所属大类,
 msib.attribute1 是否固资,
 msib.attribute5 列管消耗,
 msib.attribute6  归口部门,
 msib.attribute7  是否危化
 
,*/
 /*--a=max(case when msib.attribute2='工器具')
  case msib.attribute2 
       when '工器具' then '工器具111'  --as 工器具111
       when '耗材'   then '耗材222'   -- as 耗材222
       --else  as '其他333' 
  end --as xxx*/
  
  --select col1,
  dp1.Description 申请中心,
 dp2.Description 申请车间,
 dp3.Description 申请班组,
 
/* sum(dl.req_quantity(case msib.attribute2 when '工器具' then msib.attribute2 else '' end)),*/
 
  max(case msib.attribute2 when '工器具' then to_char(sum(dl.req_quantity)) else '' end) as 工器具qty,
--  max(case msib.attribute2 when '工器具' then substr(msib.attribute2,1,1) else '' end) as 工器具qty,
  max(case msib.attribute2 when '耗材' then msib.attribute2 else '' end) 耗材qty,
  max(case msib.attribute2 when '备品备件' then msib.attribute2 else '' end) 备品备件qty,
  max(case msib.attribute2 when '劳保用品' then msib.attribute2 else '' end) 劳保用品qty
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
and dh.demand_type='生产性'

group by dp1.Description ,
 dp2.Description,
 dp3.Description
-- , 工器具qty
  
--and msib.segment1 = '300030200001'
--and  dl.attribute4 like '%.%';
--AND dh.demand_code='SQ201301160004'
--order by dh.demand_code , dl.line_num;
