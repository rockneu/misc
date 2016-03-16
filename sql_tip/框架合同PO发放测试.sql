

SELECT * FROM PO_LINES_ALL 
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                              WHERE SEGMENT1='40100000143' AND ORG_ID=82)
;

--30092
select rowid,pl.attribute6,pl.* from po_lines_all pl
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                              WHERE SEGMENT1='400001733' AND ORG_ID=82)
   and       item_id=11422                                                            
;


-- 协议PO发放时控制数量不超合同 -- 原控制方式
:PO_SHIPMENTS.quantity > (select nvl(sum(nvl(pla.quantity_committed,0)),0) from po_lines_all pla where pla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID) -
     (SELECT  nvl(SUM(decode(plla.po_release_id, NULL, 0, plla.quantity)), 0)
FROM po_line_locations_all plla
WHERE plla.po_header_id = :PO_SHIPMENTS.PO_HEADER_ID
AND plla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID
AND plla.line_location_id <> NVL(:PO_SHIPMENTS.LINE_LOCATION_ID,0)
AND nvl(plla.cancel_flag, 'N') = 'N')
and (select nvl(pls.attribute6,'0') from po_lines_all pls where pls.po_line_id = :PO_SHIPMENTS.PO_LINE_ID and pls.po_header_id = :PO_SHIPMENTS.PO_HEADER_ID)='0'
;

-- 协议PO发放时控制数量不超合同 -- IBM在原控制方式上的bug fix
:PO_SHIPMENTS.quantity > (select nvl(sum(nvl(pla.quantity_committed,0)),0) 
                                 from po_lines_all pla 
                                 where pla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID) -
     (SELECT  nvl(SUM(decode(plla.po_release_id, NULL, 0, plla.quantity)), 0)
FROM po_line_locations_all plla
WHERE plla.po_header_id = :PO_SHIPMENTS.PO_HEADER_ID
AND plla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID
AND plla.line_location_id <> NVL(:PO_SHIPMENTS.LINE_LOCATION_ID,0)
AND nvl(plla.cancel_flag, 'N') = 'N') and fnd_global.user_id<>1501
;


-- 协议PO发放时控制数量不超合同 -- 东软在（IBM在原控制方式上的bug fix）基础上，根据框架合同发放数量不受限制，对个性化控制进行修改
:PO_SHIPMENTS.quantity > (select nvl(sum(nvl(pla.quantity_committed,0)),0) from po_lines_all pla where pla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID) -
     (SELECT  nvl(SUM(decode(plla.po_release_id, NULL, 0, plla.quantity)), 0)
FROM po_line_locations_all plla
WHERE plla.po_header_id = :PO_SHIPMENTS.PO_HEADER_ID
AND plla.po_line_id = :PO_SHIPMENTS.PO_LINE_ID
AND plla.line_location_id <> NVL(:PO_SHIPMENTS.LINE_LOCATION_ID,0)
AND nvl(plla.cancel_flag, 'N') = 'N') and fnd_global.user_id<>1501
AND NOT EXISTS(SELECT 1 FROM  PO_LINES_ALL PLA WHERE PLA.PO_HEADER_ID =:PO_SHIPMENTS.PO_HEADER_ID AND PLA.PO_LINE_ID =:PO_SHIPMENTS.PO_LINE_ID AND PLA.ATTRIBUTE6 = '1' )
;




SELECT *
FROM PO_HEADERS_ALL
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_LINES_ALL 
                              WHERE ATTRIBUTE6='1' AND ORG_ID=82)
;                              

SELECT * FROM Cux_Po_Pc_Blanket_l_Int WHERE ATTRIBUTE4='l';
SELECT * FROM PO_LINES_ALL WHERE ATTRIBUTE6='1';
--40100000143

/*
SELECT * FROM V$DATABASE;
SELECT * FROM V$INSTANCE;
*/
