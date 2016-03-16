
select * from mtl_transaction_types order by 1 ;




SELECT m.primary_quantity, m.prior_cost
FROM MTL_MATERIAL_TRANSACTIONS M
WHERE  1=1
       --M.TRANSACTION_ID IN (10562138 )
--/*AND*/ M.Subinventory_Code='Z01HW01'
--        and m.primary_quantity=-6
--        and m.inventory_item_id=38240
        and m.transaction_type_id=36        -- 36 - 退货到供应商
        and to_char(m.transaction_date,'yyyy-mm-dd') between '2015-10-01' and '2015-12-01'
        and m.organization_id=102
--ROWID = 'AAAdg8AANAAAP4RAAN'
;
