
-- 09.003 的二级分类描述不一致
select segment1,segment2,segment3, rowid, description from Mtl_Categories_Vl 
where segment1=09 and segment2=003 order by segment3 ;-- and segment3=001;

--select * from Mtl_Categories_Vl

/*
SELECT CENTER_NAME,
       ITEM_CAT2,
       ITEM_CAT2_DESC,
       BUD_YEAR,
       BUD_TYPE,
       BUD_AMOUNT,
       CENTER_CODE,
       ORGANIZATION_ID,
       CENTER_ID
  FROM CUX_INV_BUD_ITEM_CAT_V
 WHERE ORGANIZATION_ID = 102
   AND Cux_Inv_Access_Pkg.Center_Access(ORGANIZATION_ID, center_id) = 'Y'
   AND - 1 = -1
 order by CENTER_CODE;
*/ 
 