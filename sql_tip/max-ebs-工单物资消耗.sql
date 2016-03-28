


-- maximo端工单消耗接口信息  
select rowid, p.c_status,p.refwo,p.c_dept,itemnum,p.storeloc,
       to_char(TRANSDATE, 'yyyy-mm-dd hh24:mi:ss'),       p.*
from maxora.MXMATUSETRANS_IFACE p
where refwo in ('4163766'/*,'4163767','4163768',''*/)
--AND ITEMNUM IN ('230023170008','300030780003')
order by p.refwo, p.itemnum
;


select mi.binnum, mi.itemnum,mi.c_dept,
       mi.c_status, rowid,mi.actualdate, mi.transdate
--       mi.*
from maxora.MXMATUSETRANS_IFACE mi 
where 1=1
--  and  c_status is not null and c_status <>'0' 
  and refwo in ('4163766')      
--('WO:4163766','WO:4163767') 
--      and itemnum='010093110001'
order by actualdate desc;


-- ebs端物流消耗错误信息
SELECT transaction_source_name, error_explanation, error_code, mti.* 
FROM mtl_transactions_interface mti
where 
--     error_explanation= '事务处理日期不能为将来日期'
/*error_explanation= '事务处理日期不能为将来日期' and*/
--  to_char(last_update_date, 'yyyy-mm-dd' ) like '2015%' 
    1=1
  and mti.transaction_source_name IN ('WO:4163766' )
--  order by last_update_date desc
  ;

-- ebs 事务信息
SELECT m.attribute4, m.transaction_source_name,
       m.*
FROM MTL_MATERIAL_TRANSACTIONS M
WHERE --M.TRANSACTION_ID IN (10823834,10892725) 
      M.TRANSACTION_SOURCE_NAME IN ('WO:4163766','WO:4163767','WO:997285')   
--      attribute2 in ('4163766','4163767','3777282')       
;



-- be carefull
-- update  maxora.MXMATUSETRANS_IFACE 
set c_status='' , transdate=sysdate-1 where c_status is not null and 
    c_status <>'0' and refwo in ('2910158') and itemnum='230023170008'
;    




