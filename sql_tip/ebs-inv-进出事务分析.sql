
-- 库存事务类型查询
SELECT M.DESCRIPTION, M.TRANSACTION_TYPE_NAME,

       M.TRANSACTION_TYPE_ID,
       M.TRANSACTION_ACTION_ID, 
              M.TRANSACTION_SOURCE_TYPE_ID
FROM MTL_TRANSACTION_TYPES M
ORDER BY 3
;

-- 二级库消耗退库， 消耗减少, 即工单发料退回
  SELECT M.ORGANIZATION_ID,
            M.ATTRIBUTE1,  M.ATTRIBUTE2, M.INVENTORY_ITEM_ID,
            
         M.TRANSACTION_SOURCE_NAME, 
         M.TRANSACTION_TYPE_ID, M.TRANSACTION_ACTION_ID,
         M.TRANSACTION_SOURCE_TYPE_ID, M.TRANSACTION_SOURCE_ID
         ,M.SUBINVENTORY_CODE        DST_INV
         ,M.TRANSFER_SUBINVENTORY    SRC_INV
         ,M.PRIMARY_QUANTITY
--         , M.*
  from MTL_MATERIAL_TRANSACTIONS M
  WHERE 1=1
        and m.TRANSACTION_SOURCE_NAME is not null
       -- and m.subinventory_code='Z01DJ07'
        and m.attribute1 in ('TK201601210002','TK201601210003')
--        and m.attribute2='SQ01201502030019'
--          and m.attribute1='CK01201602050011'  --TK201511270004
--        and M.TRANSACTION_ID=10882917
  ;
  
  
  SELECT M.ORGANIZATION_ID,
          M.ATTRIBUTE1,  M.ATTRIBUTE2,
         M.TRANSACTION_SOURCE_NAME, 
         M.TRANSACTION_TYPE_ID, M.TRANSACTION_ACTION_ID,
         M.TRANSACTION_SOURCE_TYPE_ID, M.TRANSACTION_SOURCE_ID
         ,M.SUBINVENTORY_CODE        DST_INV
         ,M.TRANSFER_SUBINVENTORY    SRC_INV
         ,M.PRIMARY_QUANTITY
--         , M.*
  from MTL_MATERIAL_TRANSACTIONS M
  WHERE 1=1
       -- and m.subinventory_code='Z01DJ07'
        and m.attribute2='SQ201301140004'
        AND M.INVENTORY_ITEM_ID=39157
  ;
  
  
