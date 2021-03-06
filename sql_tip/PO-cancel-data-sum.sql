select sum(pll.attribute14*plo.quantity)
from   po_headers_all pha
     ,po_lines_all pll
     ,po_line_locations_all plo
     ,mtl_system_items_b msi
     ,PO_RELEASES_ALL PR
where pha.po_header_id=pll.po_header_id
    and pha.po_header_id=plo.po_header_id
    and pll.po_line_id=plo.po_line_id
    and plo.cancel_flag='Y'--='Y'
   and pha.org_id=82 --301 ou
   and msi.organization_id=102
   AND msi.ITEM_TYPE='WZ'
   AND PR.PO_RELEASE_ID(+)=PLO.PO_RELEASE_ID
   and msi.inventory_item_id=pll.item_id
 -- and NVL(to_char(PR.last_update_DATE,'yyyy-mm-dd'),to_char(PHA.last_update_DATE,'yyyy-mm-dd'))<='2013-09-30'
  and NVL(to_char(PR.last_update_DATE,'yyyy-mm-dd'),to_char(PHA.last_update_DATE,'yyyy-mm-dd'))>='2013-10-01'
--  and to_char(Pha.last_update_DATE,'yyyy-mm-dd')>='2013-01-01'
--50w