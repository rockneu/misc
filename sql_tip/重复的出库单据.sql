
--select * from Mtl_Material_Transactions where attribute1='CK01201509240001';

SELECT MMT.attribute1 --,MMT.SUBINVENTORY_CODE
FROM Mtl_Material_Transactions MMT
     ,Mtl_Secondary_Inventories msi
WHERE MMT.attribute1 LIKE 'CK%2015%'
      and mmt.subinventory_code=msi.secondary_inventory_name
      and msi.attribute1='2'                  -- 查找二级库，否则混入一级库直发
      and MMT.transaction_quantity<0              -- 出库（移库或消耗）
      and MMT.transfer_subinventory is null       -- 目标库为空代表二级库消耗，而不是移库
GROUP BY  MMT.attribute1 --,  MMT.SUBINVENTORY_CODE
HAVING COUNT(distinct SUBINVENTORY_CODE)>1    -- 此处特指二级库代码
order by 1;
;

--select *   FROM Mtl_Material_Transactions MMT

select organization_id, mmt.transaction_source_name, mmt.transaction_date
        , SUBINVENTORY_CODE, transfer_subinventory
       ,attribute1,attribute2

       ,attribute6, attribute12
       ,mmt.transaction_quantity, mmt.actual_cost
       , mmt.*
  FROM Mtl_Material_Transactions MMT
where attribute1='CK01201509240001'
      and primary_quantity<0     -- negative as 出库（移库和消耗）
      order by mmt.SUBINVENTORY_CODE
;

