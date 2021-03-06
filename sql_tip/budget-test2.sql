SELECT 

       -- 实扣金额
       --sum(cidv.DEMAND_QUANTITY * Unit_Price)
       cidv.ORGANIZATION_ID,
       /*,
       DEMAND_HEADER_ID,
       DEMAND_LINE_ID,*/       
--       DEMAND_STATUS,

--request info       
       cidv.DEMAND_CODE,
       cidv.item_type,
--       cidv.DEMAND_NAME,
       cidv.demand_center_name,
       cidv.demand_dept_name,
       cidv.demand_sub_dept_name,
       cidv.DEMAND_STATUS_DESC,
       demand_creation_date,
       cidv.last_update_date,
--       DEMAND_LINE_NUM,
       cidv.ITEM_NUM,
       cidv.ITEM_DESC,
       cidv.PRIMARY_UNIT_OF_MEASURE,
       cidv.DEMAND_QUANTITY 需求数量,
       cidv.list_price     ，
--       INVENTORY_ITEM_ID,

--       QUANTITY_OUT          已发放数量,--需求数量
--       QUANTITY_BACK,         
       

--PO info
         cidv.agent_name      采购员,
       cidv.PO_NUM,
--       PH.APPROVED_FLAG,
       cidv.PO_STATUS_DESC,
       cidv.PO_TYPE,
       cidv.PO_QUANTITY   订单数量,
       UNIT_PRICE      订单价格,

       cidv.VENDOR_NAME,

--       SHIP_QUANTITY      订单行数量,
       cidv.QUANTITY_RECEIVED  接收数量,
       cidv.QUANTITY_DELIVERED 入库数量

 FROM cux_inv_details2_v cidv
      
 WHERE (ORGANIZATION_ID = 102)

     and cidv.demand_code like 'SQ2013%'
   and cidv.item_num like '24%'
   and cidv.demand_center_name ='供电机电中心'
   and demand_dept_name in ('供电机电中心供电一车间')
   and demand_sub_dept_name in ('供电机电中心供电一车间接触网维护工班')
--   and po_status_desc='批准'
--   order by po_status_desc, last_update_date asc;
     order by 2;
-- ORDER BY DEMAND_CODE, DEMAND_LINE_NUM;       

