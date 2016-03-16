
select dept_num, hr_dept_num from CUX_DEPT_HR_LINK 
group by dept_num, hr_dept_num
having(count(1)>1)
;

/*
select * from CUX_DEPT_HR_LINK
where dept_num in ('010800','')
;

SELECT T.DEPT_NUM
  FROM CUX_DEPT_HR_LINK T
 WHERE SUBSTR(T.HR_DEPT_NUM, -4) != '0000'
   AND SUBSTR(T.HR_DEPT_NUM, -2) = '00'
 GROUP BY T.DEPT_NUM
HAVING(COUNT(1) > 1);
*/
