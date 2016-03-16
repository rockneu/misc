
--SELECT * FROM C

SELECT 
       MO_TYPE,
       --SOURCE_LINE_ID,
       REQUESTNUM,
       item_type,
--       DEPT_ID,
--       LINEWAY_ID,
       ORGANIZATION_ID,
       TRANSACTION_TYPE_ID,
--       INVENTORY_ITEM_ID,
--       PRIMARY_UOM_CODE,
--       TRANSACTION_SOURCE_ID,
--       DISTRIBUTION_ACCOUNT_ID,
       FROM_SUBINV_DESC,
       FROM_LOCATOR_ID,
--       TRANSFER_ORGANIZATION_ID,
       TO_SUBINV_DESC,
--       TO_LOCATOR_ID,
       BACK_TRANSACTION_TYPE_ID,
       BACK_SUBINV_DESC,
--       BACK_SUBINV_LOCATOR_TYPE,
--       BACK_LOCATOR_ID,
--       PROJECT_ID,
--       TASK_ID,
--       PA_EXPENDITURE_ORG_ID,
--       Transaction_Source_Name,
       MO_CODE,
       LINE_NUM,
       TRANSACTION_TYPE_NAME,
       ITEM_NUM,
       OUT_NUMBER,
--       TRANSACTION_ID,
       TRANSACTION_DATE,
       ITEM_DESC,
       PRIMARY_UNIT_OF_MEASURE,
       Dept_Name,
--       ACCOUNT_FLEX,
       FROM_SUBINV_CODE,
--       FROM_LOCATOR_SEG,
--       LOT_NUMBER,
--       SERIAL_NUMBER,
       TO_SUBINV_CODE,
--       TO_LOCATOR_SEG,
       QUANTITY_OUT,
--       QUANTITY_BACK,
       QUANTITY_AVA,
       TRANSACTION_QUANTITY,
       TRANSACTION_COST,
       BACK_TRANSACTION_TYPE_NAME,
       BACK_SUBINV_CODE
       /* ,
       BACK_LOCATOR_SEG,
       PROJECT_NUM,
       PROJECT_NAME,
       TASK_NUMBER,
       TASK_NAME,
       EXPENDITURE_TYPE
       */
  FROM cux_inv_rtn_lines_v2
 WHERE organization_id = 969
   AND - 1 = -1
   and (MO_TYPE in ( '需求申请','领料申请','工单'))
   and (ORGANIZATION_ID = 969)
   and MO_CODE IN (/*'SQ02201511100022',*/ 'LY02201512290005','')
 order by OUT_NUMBER DESC
;
