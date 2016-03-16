

-- get the seq_id
--  select max(seq_id) from CUX_ITEM_BUD_FINAL_T_new where organization_id = 102

-- 实扣临时表数据
select 
        -- st.*
         hr.demand_code,hr.attribute1,st.*
  from CUX_ITEM_BUD_FINAL_T_new st ,cux_inv_demand_headers hr 
 where st.organization_id = 102   -- 1358-352, 102-301
    and st.seq_id = 43080   -- 请求id 最大值
   --and st.demand_no != 'SQ2Y201501200005' 
   and hr.demand_code =st.demand_no 
   and hr.attribute1 = '年度'
 order by st.seq_id desc
 ;
 
 
 -- money consumed by yearly demand
 select sum(ft.unit_price * ft.qty)
        -- st.*
        -- hr.demand_code,hr.attribute1,st.*
  from CUX_ITEM_BUD_FINAL_T_new ft ,cux_inv_demand_headers hr 
 where ft.organization_id = 102   -- 1358-352, 102-301
    and ft.seq_id = 43080   -- 请求id 最大值
   --and st.demand_no != 'SQ2Y201501200005' 
   and hr.demand_code =ft.demand_no 
   and hr.attribute1 = '年度'
 order by st.seq_id desc
 
 
 
