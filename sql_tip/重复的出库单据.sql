
--select * from Mtl_Material_Transactions where attribute1='CK01201509240001';

SELECT MMT.attribute1 --,MMT.SUBINVENTORY_CODE
FROM Mtl_Material_Transactions MMT
     ,Mtl_Secondary_Inventories msi
WHERE MMT.attribute1 LIKE 'CK%2015%'
      and mmt.subinventory_code=msi.secondary_inventory_name
      and msi.attribute1='2'                  -- ���Ҷ����⣬�������һ����ֱ��
      and MMT.transaction_quantity<0              -- ���⣨�ƿ�����ģ�
      and MMT.transfer_subinventory is null       -- Ŀ���Ϊ�մ�����������ģ��������ƿ�
GROUP BY  MMT.attribute1 --,  MMT.SUBINVENTORY_CODE
HAVING COUNT(distinct SUBINVENTORY_CODE)>1    -- �˴���ָ���������
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
      and primary_quantity<0     -- negative as ���⣨�ƿ�����ģ�
      order by mmt.SUBINVENTORY_CODE
;

