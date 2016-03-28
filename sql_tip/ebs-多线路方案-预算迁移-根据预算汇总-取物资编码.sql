
SELECT 
      '''' || min(msiv.CONCATENATED_SEGMENTS)
      ,substr(msiv.CONCATENATED_SEGMENTS,1,5)
      --msiv.CONCATENATED_SEGMENTS  --),substr(msiv.CONCATENATED_SEGMENTS,1,5)
FROM mtl_system_items_vl MSIV
WHERE 1=1
      AND MSIV.ORGANIZATION_ID=969
      AND MSIV.inventory_item_status_code='Active'
      AND SUBSTR(MSIV.CONCATENATED_SEGMENTS,1,5) IN       
        (
            SELECT 
                   substr(TRS.ITEM_CAT2,1,2) || substr(TRS.ITEM_CAT2,4,3) TRSITEM5
                 
                     
            FROM (SELECT ITEM_CAT2,
                         ITEM_CAT2_DESC,
                         BUD_YEAR,
                         BUD_TYPE,
                         BUD_AMOUNT, --预算金额
                         ORGANIZATION_ID,
                         CUX_INV_BUD_PKG.GET_BUD_RSV(ORGANIZATION_ID,
                                                     BUD_YEAR,
                                                     BUD_TYPE,
                                                     CENTER_ID,
                                                     ITEM_CAT2) RSV_AMOUNT, --冻结金额
                         CUX_INV_BUD_PKG.GET_BUD_USR(ORGANIZATION_ID,
                                                     BUD_YEAR,
                                                     BUD_TYPE,
                                                     CENTER_ID,
                                                     ITEM_CAT2) USE_AMOUNT, --暂扣金额
                         CUX_INV_BUD_PKG.GET_BUD_FINAL(ORGANIZATION_ID,
                                                       BUD_YEAR,
                                                       BUD_TYPE,
                                                       CENTER_ID,
                                                       ITEM_CAT2) FINAL_AMOUNT --实扣金额                                   
                  
                    FROM CUX_INV_BUD_ITEM_CAT_V
                   WHERE ORGANIZATION_ID = 969         -- 102 LINE1, 1359 架大修，969 二号线303
                     AND BUD_YEAR = '2016'
                     AND EXISTS
                   (SELECT 1
                            FROM CUX_INV_USER_DEPT_MAP DM
                           WHERE DM.ORGANIZATION_ID = ORGANIZATION_ID
                             AND DM.USER_ID = 1110
                             AND DM.ENABLED_FLAG = 'Y'
                             AND (DM.CENTER_ID = CENTER_ID OR DM.CENTER_ID IS NULL))
                     AND - 1 = -1
                     AND (BUD_TYPE = '生产性')) TRS
           GROUP BY ITEM_CAT2, ITEM_CAT2_DESC, BUD_YEAR, BUD_TYPE, ORGANIZATION_ID
--   order by TRS.ITEM_CAT2
           )
   group by substr(msiv.CONCATENATED_SEGMENTS,1,5) --,msiv.CONCATENATED_SEGMENTS
--   having count(substr(msiv.CONCATENATED_SEGMENTS,1,5))=1           
   order by 1
   ;
