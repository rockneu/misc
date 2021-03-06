/*
seleCT SUM(TTL.Ԥ��), SUM(TTL.����), SUM(TTL.�ݿ�), SUM(TTL.ʵ��),
       (SUM(TTL.Ԥ��)-SUM(TTL.����)-SUM(TTL.�ݿ�)-SUM(TTL.ʵ��)) rest
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

       SUM(NVL(TRS.BUD_AMOUNT, 0)) Ԥ��, --Ԥ����
       SUM(NVL(TRS.RSV_AMOUNT, 0)) ����, --������ 
       SUM(NVL(TRS.USE_AMOUNT, 0)) �ݿ�, --�ݿ۽�� 
       SUM(NVL(TRS.FINAL_AMOUNT, 0)) ʵ��, --ʵ�۽�� 
       SUM(NVL(TRS.BUD_AMOUNT, 0) - NVL(TRS.RSV_AMOUNT, 0) -
           NVL(TRS.USE_AMOUNT, 0) - NVL(TRS.FINAL_AMOUNT, 0)) ���� ---���ý��
  FROM (SELECT ITEM_CAT2,
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
         WHERE ORGANIZATION_ID = 969         -- 102 LINE1, 1359 �ܴ��ޣ�969 ������303
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
 GROUP BY Center_Name, ITEM_CAT2, ITEM_CAT2_DESC, BUD_YEAR, BUD_TYPE, ORGANIZATION_ID
 order by 1,2
 
 --)  TTL
 
;
