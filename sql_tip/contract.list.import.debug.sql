/*
begin
  fnd_global.APPS_INITIALIZE(USER_ID      => 1501,
                             RESP_ID      => 50689,
                             RESP_APPL_ID => 201);
  mo_global.init('M');
end;*/

-- get the target INV organization_id of PR lines

   select * from po_requisition_headers_all
select * from  po_requisition_headers_all;
 
 select prl.destination_organization_id , prl.org_id
        ,prl.* 
 from po_requisition_lines_all prl
 where requisition_header_id in (select requisition_header_id from po_requisition_headers_all 
                                        where segment1='JH01201507170003')
;                                        

-- get the relationship between PR and contract code

select * from Org_Organization_Definitions

-- CONTRACT INTERFACE header info
--0 --初始状态,     1 --导入中，2 --导入成功,     3 --导入错误  

SELECT *
FROM CUX_PO_PC_BLANKET_H_INT
WHERE  contract_code In ('','SZGY05MM600000047' )
;
-- get the INV organization_id in the interface from contract to ebs
select  M.concatenated_segments ,M.DESCRIPTION, l.organization_id
        ,l.* 
from  Cux_Po_Pc_Blanket_l_Int l
      ,mtl_system_items_vl     M
where l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c
                                     WHERE contract_code In ('','SZGY05MM600000047' ) 
                                           /*and org_id=82*/) 
          AND M.INVENTORY_ITEM_ID=L.INVENTORY_ITEM_ID     
          AND M.ORGANIZATION_ID=L.organization_id         
;
