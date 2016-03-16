
--get budget general info
select t.*,t.BUD_AMOUNT-nvl(t.冻结,0)-nvl(t.暂扣,0)-nvl(t.实扣,0) 可用 
from(
    SELECT CENTER_NAME,
           ITEM_CAT2,
           ITEM_CAT2_DESC,
           BUD_YEAR,
           BUD_TYPE,
           CENTER_CODE,
           ORGANIZATION_ID,
           CENTER_ID,
           BUD_AMOUNT,
           cux_inv_bud_pkg.get_bud_rsv(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)冻结,
           cux_inv_bud_pkg.get_bud_usr(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)暂扣,
           cux_inv_bud_pkg.get_bud_final(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)实扣
      FROM CUX_INV_BUD_ITEM_CAT_V t
     WHERE ORGANIZATION_ID = 102
       --AND Cux_Inv_Access_Pkg.Center_Access(ORGANIZATION_ID, center_id) = 'Y'
       AND - 1 = -1
       and bud_year='2014'
       and center_name='客运营销中心'
       and item_cat2='30.013'
     order by CENTER_CODE)t
order by t.BUD_AMOUNT-nvl(t.冻结,0)-nvl(t.暂扣,0)-nvl(t.实扣,0) asc     
;




-- get the sum of negative available budget. -682201.581305 on 2014-07-10
/*select sum(t.BUD_AMOUNT-nvl(t.冻结,0)-nvl(t.暂扣,0)-nvl(t.实扣,0))
from(
    SELECT CENTER_NAME,
           ITEM_CAT2,
           ITEM_CAT2_DESC,
           BUD_YEAR,
           BUD_TYPE,
           CENTER_CODE,
           ORGANIZATION_ID,
           CENTER_ID,
           BUD_AMOUNT,
           cux_inv_bud_pkg.get_bud_rsv(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)冻结,
           cux_inv_bud_pkg.get_bud_usr(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)暂扣,
           cux_inv_bud_pkg.get_bud_final(t.Organization_Id,t.Bud_Year,'生产性',t.Center_Id,t.Item_Cat2)实扣
      FROM CUX_INV_BUD_ITEM_CAT_V t
     WHERE ORGANIZATION_ID = 102
       --AND Cux_Inv_Access_Pkg.Center_Access(ORGANIZATION_ID, center_id) = 'Y'
       AND - 1 = -1
       and bud_year='2014'
--       and 
     order by CENTER_CODE)t
where t.BUD_AMOUNT-nvl(t.冻结,0)-nvl(t.暂扣,0)-nvl(t.实扣,0)<0     */
--order by t.BUD_AMOUNT-nvl(t.冻结,0)-nvl(t.暂扣,0)-nvl(t.实扣,0) asc     
;