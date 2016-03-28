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
   
,     NVL(TRS.BUD_AMOUNT,0) Ԥ��
,     NVL(TRS.RSV_AMOUNT,0) ����
,     NVL(TRS.USE_AMOUNT,0) �ݿ�
,     NVL(TRS.FINAL_AMOUNT,0) ʵ��                                   
,     (NVL(TRS.BUD_AMOUNT,0) - NVL(TRS.RSV_AMOUNT,0) - NVL(TRS.USE_AMOUNT,0) - NVL(TRS.FINAL_AMOUNT,0)) ����
, '''' || min(msiv.CONCATENATED_SEGMENTS) as iTEM_NUM
, '1' QTY
,     (NVL(TRS.BUD_AMOUNT,0) - NVL(TRS.RSV_AMOUNT,0) - NVL(TRS.FINAL_AMOUNT,0)) PRICE -- �ݿ�+����
, '��ע--Ԥ������Ǩ��' ��ע

  FROM mtl_system_items_vl MSIV,
       (SELECT ITEM_CAT2,
               ITEM_CAT2_DESC,
               BUD_YEAR,
               BUD_TYPE,
               Center_Name,
               BUD_AMOUNT, --Ԥ����
               ORGANIZATION_ID,
               CUX_INV_BUD_PKG.GET_BUD_RSV(ORGANIZATION_ID,
                                           BUD_YEAR,
                                           BUD_TYPE,
                                           CENTER_ID,
                                           ITEM_CAT2) RSV_AMOUNT, --������
               CUX_INV_BUD_PKG.GET_BUD_USR(ORGANIZATION_ID,
                                           BUD_YEAR,
                                           BUD_TYPE,
                                           CENTER_ID,
                                           ITEM_CAT2) USE_AMOUNT, --�ݿ۽��
               CUX_INV_BUD_PKG.GET_BUD_FINAL(ORGANIZATION_ID,
                                             BUD_YEAR,
                                             BUD_TYPE,
                                             CENTER_ID,
                                             ITEM_CAT2) FINAL_AMOUNT --ʵ�۽��                                   
        
          FROM CUX_INV_BUD_ITEM_CAT_V
         WHERE ORGANIZATION_ID = 969 -- 102 LINE1, 1359 �ܴ��ޣ�969 ������303
           AND BUD_YEAR = '2016'
           AND EXISTS
         (SELECT 1
                  FROM CUX_INV_USER_DEPT_MAP DM
                 WHERE DM.ORGANIZATION_ID = ORGANIZATION_ID
                   AND DM.USER_ID = 1110
                   AND DM.ENABLED_FLAG = 'Y'
                   AND (DM.CENTER_ID = CENTER_ID OR DM.CENTER_ID IS NULL))
           AND - 1 = -1
           AND (BUD_TYPE = '������')) TRS
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
           TRS.BUD_AMOUNT, --Ԥ����
     TRS.RSV_AMOUNT, --������
     TRS.USE_AMOUNT, --�ݿ۽��
     TRS.FINAL_AMOUNT --, --ʵ�۽�� 
 order by TRS.Center_Name, iTEM_NUM
;
