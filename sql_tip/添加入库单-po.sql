
--更新入库单号
--select * from po_headers_all pa  where pa.segment1 = '40200000008';

select sr.rma_reference, sr.* from rcv_transactions sr
where sr.rma_reference =600000415
 and sr.transaction_type = 'DELIVER'

select sr.rma_reference, sr.* from rcv_transactions sr
where po_header_id in (select po_header_id from po_headers_all where segment1 = '40200000008')
         and sr.rma_reference =600000476 --is null
         and sr.transaction_type = 'DELIVER'
       -- rma_reference is null
-- select * from po_headers_all where segment1 = '40200000008'

update rcv_transactions sr
   set sr.rma_reference =
       (select sa.seq_number
          from CUX_INV_NUMBER_SEQ_ALL sa
         where sa.organization_id = sr.organization_id
         and sa.transaction_type = 'DELIVER')
 where exists (select 1
          from po_headers_all pa
         where pa.po_header_id = sr.po_header_id
           and pa.segment1 = '40200000008')
   and exists (select 1
          from po_releases_all pr
         where pr.po_release_id = sr.po_release_id
           and pr.po_header_id = sr.po_header_id
           and pr.release_num = '1')
   and sr.rma_reference is null;
 ---更新序列表
 update CUX_INV_NUMBER_SEQ_ALL cs
    set cs.seq_number = cs.seq_number +1
  where cs.organization_id = 969   --98  -- 969 L2, 102 L1
    and cs.transaction_type = 'DELIVER' ;
-- select * from  CUX_INV_NUMBER_SEQ_ALL where transaction_type = 'DELIVER' and organization_id = 969   --98  -- 969 L2, 102 L1;

-- select * from org_organization_definitions

