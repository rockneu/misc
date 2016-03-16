USE SzMetroUUV;
SELECT   mirror.UserCode AS 工号 ,
        mirror.ChsName 姓名 ,
        mirror.DeptName 部门
FROM     ( SELECT    *
          FROM      UUV_HRUserMirror
          WHERE     LotNumber = dbo.fn_get_Lotnumber()
        ) mirror
        LEFT JOIN ( SELECT  *
                    FROM    dbo.UUV_ADUser
                    WHERE   IsMainAccount = 1
                  ) ad ON mirror.UserCode = ad.UserCode
WHERE    ad.UserID IS NULL
     AND MIRROR.USERCODE LIKE '2%'
--ORDER BY MIRROR.DEPTNAME     
order by mirror.usercode;
