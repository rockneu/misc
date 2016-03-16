SELECT COUNT(*),oo.rma_reference,oo.organization_id
  FROM (SELECT s.rma_reference,s.po_header_id ,s.organization_id,s.vendor_id FROM RCV_TRANSACTIONS S where s.transaction_type= 'DELIVER' GROUP BY S.PO_HEADER_ID,s.rma_reference,s.organization_id,s.vendor_id) OO,
       PO_HEADERS_ALL ST
 WHERE OO.PO_HEADER_ID = ST.PO_HEADER_ID
   and oo.rma_reference is not null 
 GROUP BY oo.rma_reference,oo.organization_id
HAVING COUNT(*) > 1;



-- get related PO info.
SELECT  ST.VENDOR_ID,
                po.segment1,
                ST.PO_HEADER_ID,
                ST.RMA_REFERENCE,
                ST.ORGANIZATION_ID
  FROM RCV_TRANSACTIONS ST, PO_HEADERS_ALL PO
 WHERE PO.PO_HEADER_ID = ST.PO_HEADER_ID
   AND ST.RMA_REFERENCE = '600002600'
   AND ST.ORGANIZATION_ID = 429;






