

select *
--to_number( substr(msiv.CONCATENATED_SEGMENTS,1,2))
--from   mtl_system_items_vl msiv 
from   MTL_SYSTEM_ITEMS_B msiv
--where to_number( substr(msiv.CONCATENATED_SEGMENTS,1,2),'9') 
where substr(msiv.segment1,1,2) between '01' and '34'
         and       msiv.attribute1 = '是'
         and       msiv.ATTRIBUTE6 = '无'
               AND MSIV.ITEM_TYPE IN ('WZ'/*,'NWZ','ST'*/)
               and msiv.INVENTORY_ITEM_STATUS_CODE='Active'
--               and msiv.inventory_item_id=8023
--               and msiv.ORGANIZATION_ID in (95,102, 969)
;


-- update MTL_SYSTEM_ITEMS_B msiv set ATTRIBUTE6='生产性固定资产' where substr(msiv.segment1,1,2) 
                   between '01' and '34'
         and       msiv.attribute1 = '是'
         and       msiv.ATTRIBUTE6 = '无'
               AND MSIV.ITEM_TYPE IN ('WZ'/*,'NWZ','ST'*/)
               and msiv.INVENTORY_ITEM_STATUS_CODE='Active'
--               and msiv.inventory_item_id=8023
              
;
/*
select * from MTL_SYSTEM_ITEMS_B_KFV              
select * from MTL_SYSTEM_ITEMS_TL     
*/         
--select * from  MTL_SYSTEM_ITEMS_B
