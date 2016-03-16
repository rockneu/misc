--4%1153

select * from org_organization_definitions order by organization_code; 

SELECT SEGMENT1 FROM PO_HEADERS_ALL WHERE PO_HEADER_ID IN (140130,140131,140151);
--400000047

SELECT pl.item_description,
       ph.segment1       ,
       PL.UNIT_PRICE,PL.MARKET_PRICE,PL.ATTRIBUTE14,PL.ATTRIBUTE15, pl.market_price/ pl.unit_price
       ,PL.ATTRIBUTE14/PL.ATTRIBUTE15 /*pl.attribute14/pl.attribute15*/
       ,PL.QUANTITY
       ,PL.* 
FROM PO_LINES_ALL PL 
     ,po_headers_all ph
WHERE    pl.creation_date >= to_date('20140702','yyyymmdd')
         and ph.po_header_id=pl.po_header_id
         and pl.org_id=409
--         and  ph.segment1 =400001704
  order by 7;

PO_HEADER_ID  IN 
       (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL WHERE SEGMENT1 IN (400001158)) --400001153/*,400000554,400001704*/))
       order by org_id;
       
       

