--到二级分类
select t.*, Cux_Inv_Bud_Pkg.Get_Bud_dem(t.Organization_Id,
                                   t.Bud_Year,
                                   t.Bud_Type,
                                   t.Center_Id,
                                   t.Item_Cat2) Bud_dem,Cux_Inv_Bud_Pkg.Get_Bud_po(t.Organization_Id,
                                   t.Bud_Year,
                                   t.Bud_Type,
                                   t.Center_Id,
                                   t.Item_Cat2) Bud_po from CUX_INV_BUD_ITEM_CAT_V t
where item_cat2 in '27.005'    
      and center_name='工务通号中心' ;
     
--到一级分类     
/*
SELECT substr(t.Item_Cat2, 1, 2) cate
,organization_id
,center_id
,bud_year
,center_code
,center_name
,sum(bud_amount) bud_amount
,sum(bud_rsv) bud_rsv
,sum(bud_usr) bud_usr
,sum(bud_final) bud_final
FROM cux_inv_bud_item_cat_v t
  group by substr(t.Item_Cat2, 1, 2)
,organization_id
,center_id
,bud_year
,center_code
,center_name;

