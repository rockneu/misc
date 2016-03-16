



-- ebs端物流消耗错误信息
SELECT transaction_source_name, error_explanation, error_code, mti.* 
FROM mtl_transactions_interface mti
where /*error_explanation= '事务处理日期不能为将来日期' and*/
  to_char(last_update_date, 'yyyy-mm-dd' ) like '2015%' 
  and mti.transaction_source_name='WO:2837020'
--  order by last_update_date desc
  ;


-- maximo端工单消耗接口信息  
select mi.binnum, mi.itemnum,mi.c_dept,
       mi.c_status, rowid,mi.actualdate, mi.transdate
--       mi.*
from maxora.MXMATUSETRANS_IFACE mi 
where c_status is not null and c_status <>'0' 
and refwo in ('2910158')       
--      and itemnum='010093110001'
order by actualdate desc;

-- be carefull
-- update  maxora.MXMATUSETRANS_IFACE 
set c_status='' , transdate=sysdate-1 where c_status is not null and 
    c_status <>'0' and refwo in ('2910158') and itemnum='230023170008'
;    


