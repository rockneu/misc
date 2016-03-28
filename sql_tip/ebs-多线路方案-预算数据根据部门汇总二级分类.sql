/*
seleCT SUM(TTL.预算), SUM(TTL.冻结), SUM(TTL.暂扣), SUM(TTL.实扣),
       (SUM(TTL.预算)-SUM(TTL.冻结)-SUM(TTL.暂扣)-SUM(TTL.实扣)) rest
from       
(
*/
SELECT 
       TRS.ORGANIZATION_ID,
       TRS.BUD_YEAR,
       TRS.Center_Name,
--       TRS.BUD_TYPE,
       TRS.ITEM_CAT2,
       TRS.ITEM_CAT2_DESC,

       SUM(NVL(TRS.BUD_AMOUNT, 0)) 预算, --预算金额
       SUM(NVL(TRS.RSV_AMOUNT, 0)) 冻结, --冻结金额 
       SUM(NVL(TRS.USE_AMOUNT, 0)) 暂扣, --暂扣金额 
       SUM(NVL(TRS.FINAL_AMOUNT, 0)) 实扣, --实扣金额 
       SUM(NVL(TRS.BUD_AMOUNT, 0) - NVL(TRS.RSV_AMOUNT, 0) -
           NVL(TRS.USE_AMOUNT, 0) - NVL(TRS.FINAL_AMOUNT, 0)) 可用 ---可用金额
  FROM (SELECT ITEM_CAT2,
               ITEM_CAT2_DESC,
               BUD_YEAR,
               BUD_TYPE,
               Center_Name,
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
 GROUP BY Center_Name, ITEM_CAT2, ITEM_CAT2_DESC, BUD_YEAR, BUD_TYPE, ORGANIZATION_ID
 order by 1,2
 
 --)  TTL
 
;
