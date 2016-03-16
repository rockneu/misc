select t.*, Cux_Inv_Bud_Pkg.Get_Bud_dem(t.Organization_Id,
                                   t.Bud_Year,
                                   t.Bud_Type,
                                   t.Center_Id,
                                   t.Item_Cat2) Bud_dem,Cux_Inv_Bud_Pkg.Get_Bud_po(t.Organization_Id,
                                   t.Bud_Year,
                                   t.Bud_Type,
                                   t.Center_Id,
                                   t.Item_Cat2) Bud_po from CUX_INV_BUD_ITEM_CAT_V t
where item_cat2 in ('23.003')
      and bud_year='2014'
      and center_id='70587' ;