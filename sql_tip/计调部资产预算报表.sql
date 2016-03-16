SELECT b.bud_year,
       b.organization_id,
       b.bud_type,
       b.comments,
       b.status,
       c.Description ����,
        d.Description ����,
       b.attribute1 ����,
       l.attribute1,
       msiv.concatenated_segments ���ϱ���,
       msiv.description ��������,
       l.bud_quantity,
       l.list_price,
       msiv.attribute1 �Ƿ�̶��ʲ�,
       msiv.attribute2 ��������,
       msiv.attribute4 �Ƿ��ܿ�ֱ������,
       msiv.ATTRIBUTE5 �й�����,
       msiv.ATTRIBUTE6 ��ڲ���,
       msiv.ATTRIBUTE7 �Ƿ�Σ��
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
