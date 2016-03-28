
/*
  ˵����
        1 csv�ϴ��ļ�������д��CUX_INV_DEMAND_ATTRIBUTE_T���� file_id��file_name���֣�
        2 ��1�����ݽ��н�����д��ӿ�ͷ�ͽӿ��У�cux_demand_header_inf_t��cux_demand_LINE_inf_t
*/
--select count(distinct inputtmp_id) from CUX_INV_DEMAND_ATTRIBUTE_T
--select count(*) from CUX_INV_DEMAND_ATTRIBUTE_T

select a.file_id, a.file_name, a.creation_date, a.created_by, count(a.inputtmp_id)
--       ,a.*
from CUX_INV_DEMAND_ATTRIBUTE_T a
group by a.file_id, a.file_name, a.creation_date, a.created_by
order by a.file_id
;
/*
select a.file_id, a.file_name, a.creation_date, a.created_by
       ,a.*
from CUX_INV_DEMAND_ATTRIBUTE_T a
order by a.file_id
;*/

SELECT ROWID, L.* FROM CUX_INV_DEMAND_LINES L
WHERE HEADER_ID=24563;


SELECT * FROM CUX_INV_DEMAND_HEADERS
WHERE DEMAND_CODE='SQ02201602160006'
;
--SQ02201602160006

SELECT * FROM cux_demand_header_inf_t  h
WHERE H.DEMAND_CODE LIKE 'SQ0220160326%'
      AND H.ORGANIZATION_ID=1618            -- 326 -1618
ORDER BY H.DEMAND_CODE

--WHERE DEMAND_CODE='SQ02201602160006'
;
--SQ02201603260008��SQ02201511090004,SQ02201511090003,SQ02201601050002

-- ��ʾ�ӿڱ��� ���󵥺�������������
SELECT H.DEMAND_CODE,H.COMMENTS, COUNT(L.LINE_ID) , COUNT(DL.LINE_ID)
FROM cux_demand_LINE_inf_t l
     ,cux_inv_demand_lines dl
     ,cux_demand_header_inf_t h
     
WHERE L.HEADER_ID=H.HEADER_ID
      AND L.HEADER_ID=DL.HEADER_ID
      AND H.DEMAND_CODE LIKE 'SQ0220160326%'
      AND H.ORGANIZATION_ID=1618
GROUP BY H.DEMAND_CODE, H.COMMENTS
ORDER BY H.DEMAND_CODE, 2
;



-- �ӿ����ݣ�������ͷû������������
SELECT H.DEMAND_CODE, h.comments old_dmd_code
FROM cux_demand_HEADER_inf_t H
WHERE H.HEADER_ID NOT IN (SELECT HEADER_ID FROM cux_demand_LINE_inf_t) 
      AND H.DEMAND_CODE LIKE 'SQ0220160326%'
      AND H.ORGANIZATION_ID=1618
--      AND H.Comments IN ('SQ02201602160006')
ORDER BY 1
;
select * FROM cux_demand_HEADER_inf_t H where h.comments in ('SQ02201602160006','')
order by h.demand_code;

select * FROM cux_demand_LINE_inf_t L
WHERE L.HEADER_ID IN (SELECT HEADER_ID FROM CUX_DEMAND_HEADER_INF_T H 
                             where h.comments in ('SQ02201602160006',''))
order by L.LINE_NUM
;

SELECT * FROM CUX_INV_DEMAND_HEADERS H WHERE H.DEMAND_CODE IN ('SQ02201603260018','SQ02201511100099','SQ02201511100098');

-- ҵ�����ݣ�������ͷû������������
SELECT H.DEMAND_CODE
FROM cux_demand_HEADER_inf_t H
WHERE H.HEADER_ID NOT IN (SELECT HEADER_ID FROM cux_inv_demand_lines) 
      AND H.DEMAND_CODE LIKE 'SQ0220160326%'
      AND H.ORGANIZATION_ID=1618
--      AND H.DEMAND_CODE IN ('SQ02201602160006')
ORDER BY 1
;



-- �ӿ���ҵ�����ݣ� �ӿڱ��������ݣ�ҵ���û�������ݣ� ��ҵ�������������ڽӿڱ�

-- ҵ�����ݣ�������ͷ��û��������
--
 SELECT h.header_id,h.demand_code,h.comments
 FROM Cux_Inv_Demand_Headers h
--      ,cux_demand_header_inf_t ih
 where h.header_id not in (select header_id from cux_inv_demand_lines )      
 and h.total_demand_amount>0
 AND H.DEMAND_CODE LIKE 'SQ0220160326%'
 AND H.ORGANIZATION_ID=1618
-- and ih.header_id=h.header_id
;

-- ��� ҵ�����ݵ���������
SELECT COUNT(*)
FROM CUX_INV_DEMAND_LINES L
WHERE L.HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS H 
                             WHERE H.DEMAND_CODE LIKE 'SQ0220160326%'
                                   AND H.ORGANIZATION_ID=1618
                             )
;

SELECT * FROM FND_USER WHERE USER_ID IN (1110��2091); -- 1110 FIN, 2091 GWTH017 

seLECT ROWID, H.*
FROM CUX_INV_DEMAND_HEADERS H WHERE H.DEMAND_CODE='SQ02201603260006';

seLECT h.creation_date,h.created_by, h.organization_id,h.demand_code,
       h.*
FROM CUX_INV_DEMAND_HEADERS H WHERE H.DEMAND_CODE LIKE 'SQ%2016032600%'
order by h.creation_date, h.demand_code, h.organization_id;


SELECT H.DEMAND_CODE,H.COMMENTS, COUNT(L.LINE_ID) , COUNT(DL.LINE_ID)
FROM cux_demand_LINE_inf_t l
     ,cux_demand_header_inf_t h
     ,cux_inv_demand_lines dl
     
WHERE L.HEADER_ID=H.HEADER_ID
--      AND L.HEADER_ID=DL.HEADER_ID
      AND H.DEMAND_CODE LIKE 'SQ0220160326%'
      AND H.ORGANIZATION_ID=1618
      AND     
GROUP BY H.DEMAND_CODE, H.COMMENTS
ORDER BY H.DEMAND_CODE, 2
;


--24563
SELECT * FROM cux_demand_HEADER_inf_t WHERE HEADER_ID=24563;
SELECT * FROM cux_demand_LINE_inf_t WHERE HEADER_ID=24563 order by line_num; 
select * from cux_inv_demand_lines  WHERE HEADER_ID=24563 order by line_num; 
