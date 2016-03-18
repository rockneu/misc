SELECT 

       -- ʵ�۽��
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
       cidv.DEMAND_QUANTITY ��������,
       cidv.list_price     ��
--       INVENTORY_ITEM_ID,

--       QUANTITY_OUT          �ѷ�������,--��������
--       QUANTITY_BACK,         
       

--PO info
         cidv.agent_name      �ɹ�Ա,
       cidv.PO_NUM,
--       PH.APPROVED_FLAG,
       cidv.PO_STATUS_DESC,
       cidv.PO_TYPE,
       cidv.PO_QUANTITY   ��������,
       UNIT_PRICE      �����۸�,

       cidv.VENDOR_NAME,

--       SHIP_QUANTITY      ����������,
       cidv.QUANTITY_RECEIVED  ��������,
       cidv.QUANTITY_DELIVERED �������

 FROM cux_inv_details2_v cidv
      
 WHERE (ORGANIZATION_ID = 102)

     and cidv.demand_code like 'SQ2013%'
   and cidv.item_num like '24%'
   and cidv.demand_center_name ='�����������'
   and demand_dept_name in ('����������Ĺ���һ����')
   and demand_sub_dept_name in ('����������Ĺ���һ����Ӵ���ά������')
--   and po_status_desc='��׼'
--   order by po_status_desc, last_update_date asc;
     order by 2;
-- ORDER BY DEMAND_CODE, DEMAND_LINE_NUM;       
