
/*
   Update the item description in auto-creation form with the 
description from item library
*/
/*
UPDATE po_requisition_lines_all l
   SET l.item_description =
       (SELECT m.description
          FROM mtl_system_items_b m
         WHERE m.segment1 = '130070710001'
           AND m.organization_id = 102)
 WHERE l.org_id = 82
   AND l.item_id = (SELECT m.inventory_item_id
                      FROM mtl_system_items_b m
                     WHERE m.segment1 = '130070710001'
                       AND m.organization_id = 102)
   AND l.item_description <> (SELECT m.description
                                FROM mtl_system_items_b m
                               WHERE m.segment1 = '130070710001'
                                 AND m.organization_id = 102);
*/                                 
                                 


--SELECT * FROM po_requisition_lines_all WHERE org_id = 82;

--select * from Org_Organization_Definitions



     
-- get the items that hold different item descriptions
SELECT p.org_id,m.organization_id, p.item_description, m.description,p.item_id,m.inventory_item_id,m.segment1,p.last_update_date,m.last_update_date,
       p.*
FROM po_requisition_lines_all p,
     mtl_system_items_b       m
where p.org_id=82
      and m.organization_id=102
      and p.item_id=m.inventory_item_id
      and p.item_description<>m.description  
--      AND m.segment1='130043270002'                            
order by m.last_update_date desc      
;

/*
  --更新采购申请行物料描述
  -- update incorrect item descriptions with batch processing 
update PO_REQUISITION_LINES_ALL t
   set t.item_description =
       (select msi.description
          from mtl_system_items_b msi
         where msi.inventory_item_id = t.item_id
           and msi.organization_id = 102)
 where t.item_id in
       (select distinct t1.item_id
          from PO_REQUISITION_LINES_ALL t1, mtl_system_items_b t2
         where t1.item_description <> t2.description
           and t1.org_id = 82
           and t2.organization_id = 102
           and t1.item_id = t2.inventory_item_id)
           
*/           
 
/*select mt.inventory_item_id,m.inventory_item_id, mt.description,m.description 
from mtl_system_items_tl mt,
     mtl_system_items_b m
where m.organization_id=mt.organization_id
      and m.organization_id=102
      and m.inventory_item_id=mt.inventory_item_id
      and m.description<>mt.description                 
;*/
