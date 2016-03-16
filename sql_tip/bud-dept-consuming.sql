/*begin
fnd_global.APPS_INITIALIZE(
  USER_ID=>1501 ,
  RESP_ID=>50689 ,
  RESP_APPL_ID=>201 );
  mo_global.init('M' );
end;
*/

SELECT 
       CENTER_NAME,
       ITEM_CAT2,
       ITEM_CAT2_DESC,
       BUD_YEAR,
       BUD_TYPE,
       BUD_AMOUNT,
              bud_rsv,
       bud_usr,
       bud_final,
       CENTER_CODE,
       ORGANIZATION_ID,
       CENTER_ID


--       *
  FROM CUX_INV_BUD_ITEM_CAT_V
 WHERE ORGANIZATION_ID = 102
   AND Cux_Inv_Access_Pkg.Center_Access(ORGANIZATION_ID, center_id) = 'Y'
   AND - 1 = -1
   and (ITEM_CAT2 like '34%')
   and (BUD_TYPE = 'ЩњВњад')
   and (CENTER_ID = 70587)
 order by CENTER_CODE