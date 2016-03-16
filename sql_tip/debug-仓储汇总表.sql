
--SELECT * FROM 

--CUX_INV_TRX_SUMMARY_PKG.MAIN

SELECT * FROM CUX_INV_TRX_DETAILS_V 
--where to_char(transaction_date ,'yyyymmdd hh:mi:ss') between '20140424'  and '20140522'
where to_char(transaction_date ,'yyyymmdd') between ('20140424')  and ('20140522') 
      and subinv_level=2;
      
SELECT * FROM MTL_MATERIAL_TRANSACTIONS      
where to_char(transaction_date ,'yyyymmdd') between ('20140424')  and ('20140522') 
      AND to_char(CREATION_date ,'yyyymmdd') > '20140526'  --between ('20140424')  and ('20140522') 
      and organization_id=102