/*
SELECT SUM(TTL.PRICE)
FROM 
(
*/
SELECT
--       TRS.ORGANIZATION_ID,
--       TRS.BUD_YEAR,
 TRS.Center_Name
 --       TRS.BUD_TYPE,
, TRS.ITEM_CAT2
 
--, TRS.ITEM_CAT2_DESC,
   
,     NVL(TRS.BUD_AMOUNT,0) 预算
,     NVL(TRS.RSV_AMOUNT,0) 冻结
,     NVL(TRS.USE_AMOUNT,0) 暂扣
,     NVL(TRS.FINAL_AMOUNT,0) 实扣                                   
,     (NVL(TRS.BUD_AMOUNT,0) - NVL(TRS.RSV_AMOUNT,0) - NVL(TRS.USE_AMOUNT,0) - NVL(TRS.FINAL_AMOUNT,0)) 可用
, '''' || min(msiv.CONCATENATED_SEGMENTS) as iTEM_NUM
, '1' QTY
,     (NVL(TRS.BUD_AMOUNT,0) - NVL(TRS.RSV_AMOUNT,0) - NVL(TRS.FINAL_AMOUNT,0)) PRICE -- 暂扣+可用
, '备注--预算数据迁移' 备注

  FROM mtl_system_items_vl MSIV,
       (SELECT ITEM_CAT2,
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
         WHERE ORGANIZATION_ID = 969 -- 102 LINE1, 1359 架大修，969 二号线303
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
 WHERE 1 = 1
   AND MSIV.ORGANIZATION_ID = TRS.ORGANIZATION_ID
   AND MSIV.ORGANIZATION_ID = 969
   AND MSIV.inventory_item_status_code = 'Active'
   AND SUBSTR(MSIV.CONCATENATED_SEGMENTS, 1, 5) =
       Substr(TRS.ITEM_CAT2, 1, 2) || substr(TRS.ITEM_CAT2, 4, 3)
--      AND 
 GROUP BY TRS.Center_Name,
          TRS.ITEM_CAT2,
          Substr(msiv.CONCATENATED_SEGMENTS, 1, 5),
           TRS.BUD_AMOUNT, --预算金额
     TRS.RSV_AMOUNT, --冻结金额
     TRS.USE_AMOUNT, --暂扣金额
     TRS.FINAL_AMOUNT --, --实扣金额 
 order by TRS.Center_Name, iTEM_NUM
;
