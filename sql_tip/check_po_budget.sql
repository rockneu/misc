
-- Created on 2015/12/10 by ADMINISTRATOR 
declare 
  -- Local variables here
  v_error varchar2(8000);
  i integer;
begin
  for i in(SELECT DISTINCT cidl.line_id,
                                     cidl.header_id
                       FROM cux_inv_demand_lines     cidl,
                            cux_inv_plan_lines       cipl,
                            po_requisition_lines_all prla,
                            po_req_distributions_all prda,
                            po_lines_all             pla,
                            po_line_locations_all    plla,
                            po_distributions_all     pda
                      WHERE cipl.demand_line_id = cidl.line_id
                        AND prla.requisition_line_id = cipl.requisition_line_id
                        AND prda.requisition_line_id = prla.requisition_line_id
                        AND pda.req_distribution_id = prda.distribution_id
                        AND plla.line_location_id = pda.line_location_id
                        AND pla.po_line_id = plla.po_line_id
                           --AND Nvl(Plla.Quantity_Received, 0) > 0
                        and exists(select 1
                                     from po_headers_all pha , po_lines_all pla 
                                     where pha.po_header_id = pla.po_header_id 
                                      and pha.org_id = 82                       -- param1
                                     and pha.segment1 = '400001966'             -- param2
                                     and pla.item_id = cidl.inventory_item_id
                                     and plla.po_line_id = pla.po_line_id))loop
        cux_inv_bud_pkg.check_budget_po( in_header_id =>i.header_id , 
                                         in_line_id => i.line_id   , --ÐèÇóÉêÇëÐÐID
                            ov_error_msg => v_error ) ;
       end loop ;   
 dbms_output.put_line(v_error);
end;
