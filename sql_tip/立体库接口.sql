

--SELECT ATTRIBUTE1 FROM Mtl_Material_Transactions MT WHERE SUBSTR(ATTRIBUTE1,1 ,22) IN ('CK' ,'TK') ;
 
SELECT * FROM CUX_MTL_SUBINVENTORY 
--test repository
SELECT SUM(TRANSACTION_QUANTITY) 
FROM cux_mtl_material_transactions
WHERE SUBINVENTORY_CODE='Z01LT01'
      AND ITEM_NUMBER='300010010043'
      AND ORGANIZATION_ID=102;
      
SELECT c.subinventory_code,c.transfer_subinventory,
       to_char(c.transaction_date,'yyyymmdd hh24:mi:ss') ,   
       c.item_number, c.transaction_type_name  ,c.transaction_quantity
         ,c.* 
FROM cux_mtl_material_transactions c
where TO_CHAR(TRANSACTION_DATE,'YYYYMMDD')='20140514'
/*subinventory_code='Z01LT01'*/ AND ITEM_NUMBER='300010010041'
;

select * from mtl_material_transactions
where TO_CHAR(TRANSACTION_DATE,'YYYYMMDD')='20140514'
      and inventory_item_id=160367

--subinventory_code, transfer_subinventory
SELECT distinct reason_desc FROM cux_mtl_material_transactions;

Select * from CUX_WMS_FLEX_VALUES;