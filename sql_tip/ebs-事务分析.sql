
-- select * from mtl_transaction_types order by 1 ;




SELECT m.creation_date,m.transaction_date
       ,m.*
FROM MTL_MATERIAL_TRANSACTIONS M
WHERE  1=1
       --M.TRANSACTION_ID IN (10562138 )
--/*AND*/ M.Subinventory_Code='Z01HW01'
--        and m.primary_quantity=-6
--        and m.inventory_item_id= 226203
        and m.transaction_type_id=36        -- 36-退货到供应商, 123-工单发料退回
--        and to_char(m.transaction_date,'yyyy-mm-dd') between '2015-10-01' and '2015-12-01'
        and m.organization_id=102
order by m.transaction_date desc        
--ROWID = 'AAAdg8AANAAAP4RAAN'
;

SELECT M.ATTRIBUTE4,M.ATTRIBUTE1,m.attribute2, M.TRANSACTION_SOURCE_NAME
       ,m.*
FROM MTL_MATERIAL_TRANSACTIONS M
WHERE 1=1
AND M.ATTRIBUTE4 IS not NULL
AND m.transaction_type_id=123  -- 工单消耗退回
AND M.ORGANIZATION_ID=102
ORDER BY M.TRANSACTION_DATE DESC
;
select * FROM MTL_MATERIAL_TRANSACTIONS M 
where m.attribute1 in ('TK201408280001','TK201408130004')
;
SELECT m.attribute4, m.* 
FROM MTL_MATERIAL_TRANSACTIONS M
WHERE --M.TRANSACTION_ID IN (10823834,10892725)    
      attribute2 in ('3352983','3777282')       
order by --TRANSACTION_ID
      m.transaction_source_name, m.transaction_date
;      
--10823834  WO:3352983 TK201601210002  attribute4 10809721     WZBL01WZ
--10892725  WO:3777282  TK201603040001  attribute4 null        ANONYMOUS

-- 2629 WZBL01WZ,  -1 ANONYMOUS, 1112 scm, 1178 shenyan
;

select rowid, p.c_status,p.refwo,p.c_dept,itemnum,p.storeloc,to_char(TRANSDATE, 'yyyy-mm-dd hh24:mi:ss'),p.*
from maxora.MXMATUSETRANS_IFACE p
where refwo in ('2821475','')
AND ITEMNUM IN ('230023170008','300030780003')
order by p.refwo, p.itemnum; 


SELECT * FROM FND_USER WHERE USER_ID IN (2629, -1,1112,0,1178)
;   
