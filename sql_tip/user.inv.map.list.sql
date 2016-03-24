
SELECT  
     -- ORGANIZATION_ID, 
      USER_NAME, FULL_NAME,
      CENTER_NAME,dept_name, SUB_DEPT_NAME, 
      INV_SUB,/*INV_SUB_DESC,*/
      attribute1
FROM CUX_INV_USER_DEPT_MAP_V  
where --user_name in ('CLZX001','CLZX009','CLZX010','CLZX011','CLZX012','CLZX013')
      1=1
AND organization_id in (102,/*102, 429*/ 969) 
AND CENTER_NAME IN ('客运营销中心','供电机电中心','工务通号中心','车辆中心')
--AND INV_SUB LIKE 'L02CL01%'
ORDER BY ORGANIZATION_ID , dept_name
;

--CUX_DEPT_HR_LINK
--select * from CUX_INV_USER_DEPT_MAP_V
