
-- get org info
select * from cux_inv_demand_headers where DEMAND_CODE='SQ2Y201511090004'
;
-- get codeID
select * from cux_inv_demand_lines where header_id=22162
;


SELECT rowid, c.* FROM Cux_Inv_Demand_By_Year  c
where year=2016 
      and center_id=429481 and dept_id=429482
--      and sub_dept_id= 437472
      and inventory_item_id= 181572
      ;

/*
SELECT c.Description 申领中心,
       d.Description 申领车间,
       s.Description 申领班组,
       
       m.Segment1 物料编码,
       m.Description 物料描述,
       dy.year,
       dy.year_quantity,
       dy.source_id,
       dy.creation_date,
       dy.last_update_date
        ,      DY.*
FROM 
       Cux_Inv_Centers_v c,
       Cux_Inv_Depts_v d,
       cux_inv_sub_depts_v s,
       --Mtl_Material_Transactions Mt,
       Mtl_System_Items_Vl       m,
       
       cux_inv_demand_by_year  DY
       
WHERE DY.dept_id=d.Flex_Value_Id
      and dy.center_id=c.Flex_Value_Id
      and dy.subdept_id=s.flex_value_id(+)
      and m.inventory_item_id=dy.inventory_item_id
      and m.Organization_Id = 102
      and m.SEGMENT1='270120800002'   --9326
      and dy.year=2015
      --
      --and d.Description='工务通号中心工务一车间';
      
      
      
-- 年度数量被消耗情况查询      
SELECT CH.DEMAND_CODE,CH.ATTRIBUTE1 ,CL.*
FROM CUX_INV_DEMAND_HEADERS CH,
     CUX_INV_DEMAND_LINES   CL
WHERE CL.HEADER_ID=CH.HEADER_ID
      AND CH.center_id=429516 and CH.dept_id=429517           
      AND CH.BUD_YEAR=2015 AND CH.STATUS='APPROVED'
      AND CL.INVENTORY_ITEM_ID=9326
      ;      
