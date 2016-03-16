

--select * from Zx_Rates_b

select pl.unit_price,pl.market_price, pl.quantity
       ,pl.item_description
from po_lines_all pl
where po_header_id in (select po_header_id from po_headers_all where segment1 in ('400004181','400004182'))
