
--SELECT * FROM ORG_ORGANIZATION_DEFINITIONS

SELECT 
--*
COUNT(*)

FROM CUX_INV_DEMAND_LINES L
WHERE L.HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS H 
                             WHERE H.ORGANIZATION_ID=1618
                             --AND H.COMMENTS IN ('SQ02201511100010')
                             AND H.BUD_YEAR='2016')
;

SELECT * 
FROM CUX_INV_DEMAND_HEADERS H
WHERE H.ORGANIZATION_ID=1618
      AND H.BUD_YEAR='2016'
--      AND H.COMMENTS NOT LIKE 'SQ02201%'
      AND H.COMMENTS IN ('SQ02201511100010')
;

--SELECT H.DEMAND_CODE
SELECT H.COMMENTS
FROM CUX_INV_DEMAND_HEADERS H
WHERE H.ORGANIZATION_ID=1618
      AND H.BUD_YEAR='2016'
      AND H.COMMENTS LIKE 'SQ02201%'
--HAVING COUNT(H.COMMENTS)>1  
HAVING COUNT(H.COMMENTS)>1  
GROUP BY  h.COMMENTS    
--      AND H.COMMENTS NOT LIKE 'SQ02201%'      
                                   
