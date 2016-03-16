



/*
    -- basic info query

SELECT * FROM ORG_ORGANIZATION_DEFINITIONS;

SELECT * FROM PO_HEADERS_ALL WHERE SEGMENT1 IN ('400002784','400002934');  

SELECT * FROM rcv_transactions WHERE RMA_REFERENCE='600002973';  --600003066

select * from CUX_INV_NUMBER_SEQ_ALL where organization_id=429;


--update rcv_transactions sr
--   set sr.rma_reference =
SELECT * FROM rcv_transactions SR
      \* (select sa.seq_number
          from CUX_INV_NUMBER_SEQ_ALL sa
         where sa.organization_id = sr.organization_id
            AND sa.transaction_type = 'DELIVER')*\
 where exists (select 1
          from po_headers_all pa
         where pa.po_header_id = sr.po_header_id
           and pa.segment1 = '400002784')
  \* and exists (select 1
          from po_releases_all pr
         where pr.po_release_id = sr.po_release_id
           and pr.po_header_id = sr.po_header_id
           and pr.release_num = '1')*\
   and sr.rma_reference is not null;
*/



--更新入库单号
update rcv_transactions sr
   set sr.rma_reference =
       (select sa.seq_number
          from CUX_INV_NUMBER_SEQ_ALL sa
         where sa.organization_id = sr.organization_id
            AND sa.transaction_type = 'DELIVER')
 where exists (select 1
          from po_headers_all pa
         where pa.po_header_id = sr.po_header_id
           and pa.segment1 = '400002784')
   -- IF po is blanket release        
/*   and exists (select 1
          from po_releases_all pr
         where pr.po_release_id = sr.po_release_id
           and pr.po_header_id = sr.po_header_id
           and pr.release_num = '1')*/
   and sr.rma_reference is not null;
--   and sr.rma_reference=''
   
 ---更新序列表
 update CUX_INV_NUMBER_SEQ_ALL cs
    set cs.seq_number = cs.seq_number +1
  where cs.organization_id = 429 -- WY 429
    and cs.transaction_type = 'DELIVER' ;
    
    
