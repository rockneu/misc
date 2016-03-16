
--select * from PO_REQUISITION_HEADERS_ALL WHERE SEGMENT1='JH201503160005'

SELECT rowid,pr.* FROM Po_Requisition_Lines_All pr
 where requisition_header_id in (select requisition_header_id from PO_REQUISITION_HEADERS_ALL WHERE SEGMENT1='JH201503100006' );
 
 select rowid, pd.*
   from po_req_distributions_all pd
  where requisition_line_id in
        (SELECT requisition_line_id
           FROM Po_Requisition_Lines_All pr
          where requisition_header_id in
                (select requisition_header_id
                   from PO_REQUISITION_HEADERS_ALL
                  WHERE SEGMENT1 = 'JH201403100001'))
 ;
 
 select rowid, cl.* from cux_inv_plan_lines cl
 where cl.header_id in (select header_id
                       from cux_inv_plan_headers
                      where plan_code = 'JH201503100006')
;                      
 SELECT rowid,cl.*
  FROM Cux_Inv_Demand_Lines cl
 where header_id in (select header_id
                       from cux_inv_demand_headers
                      where demand_code = 'SQ201503060009');
  
--    SQ201503060009        JH201503100006       400002018  500002037      600002029
--select * from CUX_INV_DEMAND_LINES_V
