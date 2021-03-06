SELECT ORGANIZATION_ID,
      
       demand_center_name,
       demand_dept_name,
       demand_sub_dept_name,
       DEMAND_CODE,
       DEMAND_NAME,
       DEMAND_STATUS_DESC,
              DEMAND_STATUS,
--       DEMAND_LINE_NUM,
       
       ITEM_NUM,
       ITEM_DESC,
--       PRIMARY_UNIT_OF_MEASURE,
       item_type,
       DEMAND_QUANTITY,
       demand_list_price,


--       DEMAND_HEADER_ID,
--       DEMAND_LINE_ID,

--       INVENTORY_ITEM_ID,
--       QUANTITY_OUT,
--       QUANTITY_BACK,
--       PLAN_HEADER_ID,
--       PLAN_LINE_ID,
/*       PLAN_STATUS,
       REQ_STATUS,
       AUCTION_STATUS,
       AWARD_STATUS,
       SEALED_AUCTION_STATUS,*/

       
/*       PLAN_CODE,
       PLAN_NAME,
       PLAN_STATUS_DESC,
       PLAN_LINE_NUM,
       PLAN_QUANTITY,
       REQ_NUM,
       REQ_STATUS_DESC,
       REQ_LINE_NUM,
       REQ_QUANTITY,
       AUCTION_HEADER_ID,
       AUCTION_TITLE,
       AUC_STATUS_DESC,
       AUC_LINE_NUM,
       AUC_QUANTITY,*/
       
       PO_STATUS,
       PO_QUANTITY,
       po_line_price,
       
       PO_NUM,
       PO_TYPE,
--     PO_LINE_NUM,

       PO_STATUS_DESC,
       VENDOR_NAME,

       SHIP_QUANTITY,
       --       LINE_LOCATION_ID,
       QUANTITY_ACCEPTED,
       QUANTITY_BILLED,
       
       QUANTITY_RECEIVED,
       QUANTITY_DELIVERED
  FROM CUX_INV_DETAILS_V2
 WHERE (ORGANIZATION_ID = 102)
   and (demand_center_name = '客运营销中心')
   and (ITEM_NUM LIKE '25004%')
   and (item_type = '生产性')
   AND DEMAND_CODE LIKE 'SQ2013%'