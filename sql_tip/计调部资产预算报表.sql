SELECT b.bud_year,
       b.organization_id,
       b.bud_type,
       b.comments,
       b.status,
       c.Description 部门,
        d.Description 车间,
       b.attribute1 批次,
       l.attribute1,
       msiv.concatenated_segments 物料编码,
       msiv.description 物料名称,
       l.bud_quantity,
       l.list_price,
       msiv.attribute1 是否固定资产,
       msiv.attribute2 所属大类,
       msiv.attribute4 是否总库直发物资,
       msiv.ATTRIBUTE5 列管消耗,
       msiv.ATTRIBUTE6 归口部门,
       msiv.ATTRIBUTE7 是否危化
  FROM Cux_Inv_Bud_Headers b,
       CUX_INV_BUD_LINES   l,
       cux_inv_depts_v     d,
       cux_inv_centers_v   c,
       mtl_system_items_vl msiv
 WHERE d.Flex_Value_Id = b.dept_id
   and c.flex_value_id = b.center_id
   and l.header_id = b.header_id
   and msiv.ORGANIZATION_ID = b.organization_id
   and b.organization_id = l.organization_id
   and msiv.INVENTORY_ITEM_ID = l.inventory_item_id
   and b.status = 'APPROVED'
 order by b.attribute1
