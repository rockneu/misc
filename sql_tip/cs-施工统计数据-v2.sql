USE SZMETROCS;

select wpv.WorkType,    
            		   SUBSTRING(CONVERT(char,(case when SUBSTRING(CONVERT(char,wpv.WorkPlanBeginDt,8),1,5)<'06:00' then DATEADD(d,-1,wpv.WorkPlanBeginDt) else wpv.WorkPlanBeginDt end),20),1,10) WorkDate,     
            		   wc.WorkContentCode,    
            		   wc.SuperviseDeptID,    
            		   (case when so.Name not like '%车间%' then so.Name else '' end) SuperviseDeptCenter,    
            		   (case when so.Name like '%车间%' then so.Name else '' end) SuperviseDeptShop,    
            		   wc.WorkDeptID,    
            		   o.Name WorkDeptName,    
            		   wc.WorkSubject,    
            		   wc.WorkAreaDescription,    
            		   wc.PowerAreaDescription,    
            		   (select o.Name+':'+cd.RequestContent,'; ' from CO_CoordinateDeptment cd,SEC_Organization o where cd.DepartmentID=o.ID and cd.InvokeFormID=wc.WorkContentID FOR XML PATH('')) CoordinateDeptmentDesc,    
            		   wc.ApplyMan,    
            		   ApplyMan.Name+' '+ wc.ApplyManPhone ApplyManDesc,    
            		   wc.GuardRequest,    
            		   wc.Remark,    
            		   wpv.WorkPlanBeginDt,    
            		   wpv.WorkPlanEndDt,    
            		   DateDiff(s,wpv.WorkPlanBeginDt,wpv.WorkPlanEndDt)/60 PlanUseTime,    
            		   record.SigningDt,    
            		   orders.OrderDate as OrderBlockDate,    
            		   orders2.OrderDate as OrderDeBlockDate,    
            		    (SELECT top 1 FinishTime FROM WF_WORK_ITEMS A INNER JOIN WF_PROC_INST B ON A.ProcID = B.ProcID WHERE A.TaskID=1 AND B.DataLocator=wpa.WorkPointApplyID) AS WorkBeginTime,    
                        ISNULL((SELECT top 1 ReceTime FROM WF_WORK_ITEMS A INNER JOIN WF_PROC_INST B ON A.ProcID = B.ProcID WHERE A.CurrentActi ='主站销点本线行调审批' AND B.DataLocator=wpa.WorkPointApplyID),wpa.WorkFinishTime) AS WorkFinishTime,    
            		   wpa.AllowWorkBeginTime, --wpa.WorkFinishTime,   
            		    WorkBeginApproveTime,WorkEndApproveTime,   
            		   DateDiff(s,wpv.WorkPlanBeginDt,wpa.WorkBeginTime)/60 SignUseTime,    
            		   DateDiff(s,wpa.WorkBeginTime,wpa.WorkBeginApproveTime)/60 PrepareUseTime,    
            		   wpa.AllowFinalEndTime,    
            		   DateDiff(s,wpv.WorkPlanEndDt,wpa.AllowFinalEndTime)/60 DelayTime,    
            		   DateDiff(s,WorkBeginApproveTime,WorkEndApproveTime)/60 InfactUseTime,    
            		   (case when isnull(DateDiff(s,wpv.WorkPlanBeginDt,wpv.WorkPlanEndDt),0)=0 then null else  DateDiff(s,WorkBeginApproveTime,WorkEndApproveTime)*1.0/DateDiff(s,wpv.WorkPlanBeginDt,wpv.WorkPlanEndDt) end) WorkTimeUseRate,      
                    (case when wpv.Status='Canceled' then (select top 1 CancelReason from PL_WorkPlanCancel where WorkPlanVersionID=wpv.WorkPlanVersionID) else wpa.LateStartReason+' '+wpa.WorkHourUtilizedLowReason end) ExceptionReason,     
                     pw.CompleteDate,    
                    wpv.Status     
            	from PL_WorkPlan wp    
            	inner join PL_WorkPlanVersion wpv on wpv.WorkPlanVersionID=wp.CurrentWorkPlanVersionID    
            	inner join WC_WorkContent wc on wc.WorkPlanVersionID=wpv.WorkPlanVersionID    
            	inner join SEC_Organization o on o.Id=wc.WorkDeptID    
            	left join SEC_Organization so on so.Id=wc.SuperviseDeptID    
            	left join PT_WorkPointApply wpa on wpa.WorkPlanID = wp.WorkPlanID  and wpa.Status!='Invalid'  
            	inner join sec_user CreatedBy on wpv.CreatedBy=CreatedBy.Id    
            	inner join sec_user ApplyMan on wc.ApplyMan=ApplyMan.Id    
            	LEFT JOIN (SELECT MIN(SigningDt) AS SigningDt,InvokeFormID FROM CO_SigningRecord WHERE RoleName='施工负责人' GROUP BY InvokeFormID) record ON record.InvokeFormID=cast (wpa.WorkPointApplyID as varchar (38))  
            	left join DO_DispatcherOrder orders on wc.WorkContentCode=orders.WorkCode and CONVERT(varchar(7) , wpa.WorkBeginTime , 20 )=CONVERT(varchar(7) ,orders.OrderDate, 20 ) and orders.type like '%封锁%' 
            	left join DO_DispatcherOrder orders2 on wc.WorkContentCode=orders2.WorkCode and CONVERT(varchar(7) , wpa.WorkBeginTime , 20 )=CONVERT(varchar(7) ,orders2.OrderDate, 20 ) and orders2.type like '%解封%' 
            	LEFT JOIN CO_MatchPointApply co ON co.WorkPointApplyID=wpa.WorkPointApplyID 
            	LEFT JOIN PW_PowerApply pw ON pw.PowerApplyID=co.InvokeFormID 
            	where wpv.Status in ('Approved','Ordered','Begin','Canceling','Canceled','Changing','Finish')     
        
            	      AND wpv.WorkPlanBeginDt >= '2015-03-26 06:00'   
            	      AND wpv.WorkPlanBeginDt <= '2015-04-25 06:00'