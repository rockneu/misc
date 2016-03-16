
SELECT DISTINCT SUBSTR(DOCUMENT_NUMBER,1,2) FROM CUX_MTL_MATERIAL_TRANSACTIONS;


SELECT * FROM CUX_MTL_MATERIAL_TRANSACTIONS--MTL_MATERIAL_TRANSACTIONS
WHERE --TO_CHAR(CREATION_DATE,'YYYY-MM-DD') LIKE '2014-08-08%' and 
      organization_id=102
      /*and to_char(last_update_date,'YYYY-MM-DD HH:MI:SS') 
          between '2014-08-08 10:12:17' AND '2014-08-23 23:15:50'*/
--      and to_char(creation_date,'YYYY-MM-DD HH:MI:SS') between '2014-08-08 10:12:17' AND '2014-08-08 10:14:57'
--        and substr(document_number,1,1) in (/*'CK','TK',*/'6')
        and substr(document_number,1,2) in ('TK')
--        and item_number='090030040001'
      ;
select distinct transaction_type_name from  CUX_MTL_MATERIAL_TRANSACTIONs;
      
SELECT subinventory_code,transfer_subinventory, 
       item_number, item_desc, transaction_quantity, document_number
 FROM CUX_MTL_MATERIAL_TRANSACTIONS--MTL_MATERIAL_TRANSACTIONS
WHERE --TO_CHAR(CREATION_DATE,'YYYY-MM-DD') LIKE '2014-08-08%' and 
      organization_id=102
      /*and to_char(last_update_date,'YYYY-MM-DD HH:MI:SS') 
          between '2014-08-08 10:12:17' AND '2014-08-23 23:15:50'*/
--      and to_char(creation_date,'YYYY-MM-DD HH:MI:SS') between '2014-08-08 10:12:17' AND '2014-08-08 10:14:57'
--        and substr(document_number,1,1) in (/*'CK','TK',*/'6')
        and substr(document_number,1,2) in ('TK')
        and document_number in ('TK201301280007')
--        and item_number='090030040001'
        order by item_number
      ;  
      
select msiv.DESCRIPTION,msiv.CONCATENATED_SEGMENTS FROM MTL_MATERIAL_TRANSACTIONS mt
       ,mtl_system_items_vl             msiv     
WHERE TO_CHAR(mt.CREATION_DATE,'YYYY-MM-DD') LIKE '2014-08-08%'
      and mt.organization_id=102
      and msiv.ORGANIZATION_ID=mt.organization_id
      and mt.inventory_item_id=msiv.INVENTORY_ITEM_ID
      and to_char(mt.last_update_date,'YYYY-MM-DD HH:MI:SS') 
          between '2014-08-08 10:12:17' AND '2014-08-13 23:15:50'
--      and to_char(creation_date,'YYYY-MM-DD HH:MI:SS') between '2014-08-08 10:12:17' AND '2014-08-08 10:14:57'
        and msiv.CONCATENATED_SEGMENTS='090030040001'
        ;

SELECT * FROM MTL_MATERIAL_TRANSACTIONS;        
        
