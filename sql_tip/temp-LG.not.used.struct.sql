
SELECT DISTINCT DEPT_ID FROM CUX_INV_DEMAND_HEADERS ORDER BY 1;
SELECT DISTINCT SUB_DEPT_ID FROM CUX_INV_DEMAND_HEADERS ORDER BY 1;

SELECT * FROM CUX_INV_DEMAND_HEADERS;

SELECT * FROM CUX_INV_CENTERS_V;
SELECT * FROM CUX_INV_DEPTS_V;
SELECT * FROM CUX_INV_SUB_DEPTS_V;

-- QUERY to get the org info who has not submit material application
SELECT * FROM CUX_INV_DEPTS_V 
WHERE FLEX_VALUE_ID NOT IN (SELECT DISTINCT DEPT_ID FROM CUX_INV_DEMAND_HEADERS)
      AND FLEX_VALUE LIKE '01%';
      
SELECT DISTINCT FLEX_VALUE_ID FROM CUX_INV_sub_DEPTS_V where  FLEX_VALUE LIKE '01%';
      
SELECT * FROM CUX_INV_sub_DEPTS_V 
WHERE FLEX_VALUE_ID NOT IN (SELECT DISTINCT sub_dept_id FROM CUX_INV_DEMAND_HEADERS)
      AND FLEX_VALUE LIKE '01%';   
      
SELECT * FROM CUX_INV_sub_DEPTS_V 
WHERE FLEX_VALUE_ID NOT IN (SELECT DISTINCT sub_dept_id FROM CUX_INV_DEMAND_HEADERS where sub_dept_id is not null)
AND FLEX_VALUE LIKE '01%';       
      
SELECT * FROM CUX_INV_sub_DEPTS_V 
WHERE (FLEX_VALUE_ID) NOT IN (SELECT DISTINCT to_number(attribute12) from Mtl_Material_Transactions)
      AND FLEX_VALUE LIKE '01%';  
          

-- attribute6 - dept, attribute12 - sub_dept      
select distinct attribute6 from Mtl_Material_Transactions       ;
SELECT distinct flex_value_id FROM CUX_INV_sub_DEPTS_V where FLEX_VALUE LIKE '01%';
select distinct attribute12 from Mtl_Material_Transactions      ;



select ''''||a.dept_num,a.dept_name,a.hr_dept_num,a.hr_dept_name
 from CUX_DEPT_HR_LINK a 
 where a.dept_num not in (select center_code from cux_inv_demand_headers_v where center_code is not null)
 and a.dept_num not in (select dept_code from cux_inv_demand_headers_v where dept_code is not null)
 and a.dept_num not in (select sub_dept_code from cux_inv_demand_headers_v where sub_dept_code is not null)
 order by a.dept_num£»
 
 select * from CUX_DEPT_HR_LINK;



