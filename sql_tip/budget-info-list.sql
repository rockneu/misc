/*select * from cux_inv_depts_v;
select * from cux_inv_centers_v;
select * from Cux_Inv_Bud_Headers;*/


SELECT c.description, d.Description ,b.attribute1,b.* FROM 
       Cux_Inv_Bud_Headers   b
       ,cux_inv_depts_v      d
       ,cux_inv_centers_v    c
WHERE 
      d.Flex_Value_Id=b.dept_id and
      c.flex_value_id=b.center_id  and
      c.description='����ͨ������'      
      and b.bud_year='2013'
--CENTER_ID= 70585 ORDER BY TO_NUMBER(ATTRIBUTE1);
ORDER BY d.Description, B.ATTRIBUTE1;


-- budget submition data based on 2nd category
SELECT   D. DESCRIPTION, bh.header_id,
         BH.STATUS,BH.TOTAL_BUD_AMOUNT, BH.COMMENTS, BH.attribute1
         ,BL.ATTRIBUTE1, BL.CREATION_DATE 
FROM Cux_Inv_Bud_Headers BH
     ,CUX_INV_BUD_LINES BL
     ,  cux_inv_depts_v D
     ,cux_inv_centers_v    c
WHERE BH.HEADER_ID=BL.HEADER_ID
      AND BL.ATTRIBUTE1= '27.005'
      AND BH.DEPT_ID=D.FLEX_VALUE_ID
      AND BH.CENTER_ID=C.Flex_Value_Id
      AND D.Description LIKE '����ͨ������%'
ORDER BY 1;  

  select * from cux_inv_bud_center_hd_v where center_name like '����Ӫ��%' order by attribute1 asc;
  SELECT * FROM  Cux_Inv_Bud_Appr_v
  where attribute1 ='27.005' ;
  --budget consuming info
  SELECT * FROM  CUX_INV_BUD_ITEM_CAT_V where item_cat2='30.012' --and bud_rsv is not null ;
  
/*
  ��Ӫ�������̶��ʲ�Ԥ�㱨��
*/
SELECT b.bud_year,
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
 order by b.attribute1;