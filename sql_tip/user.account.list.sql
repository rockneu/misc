
SELECT  
      ORGANIZATION_ID, CENTER_NAME,dept_name, SUB_DEPT_NAME, 
      USER_NAME, FULL_NAME, INV_SUB,INV_SUB_DESC, attribute1
FROM CUX_INV_USER_DEPT_MAP_V  
where organization_id in (102)
ORDER BY ORGANIZATION_ID , dept_name;

--CUX_DEPT_HR_LINK
--select * from CUX_INV_USER_DEPT_MAP_V
