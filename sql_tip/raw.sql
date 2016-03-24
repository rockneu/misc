
/*
query privelege ascalation
*/

begin
fnd_global.APPS_INITIALIZE(
  USER_ID=>1501 ,
  RESP_ID=>50689 ,
  RESP_APPL_ID=>201 );
  mo_global.init('M' );
end;

/*
  HR basic info
*/

SELECT * FROM CUX_HR_ORG_STRUC WHERE ORG_CODE LIKE '301%' and org_name like '综合科%'
ORDER BY LAST_UPDATE_DATE DESC;

SELECT * FROM CUX_HR_ORG_STRUC where name like '%车辆中心%'

--SELECT * FROM CUX_EHR_ORG_INF where org_name like '%车辆中心%'

select * from cux_ehr_org_v@hjhr where org_name like '%车辆中心%'
select * from cux_ehr_assignments_v@hjhr 
       where eperson_pk in (SELECT p_EMPLOYEE_number FROM CUX_HR_EMP_DETAIL WHERE P_LAST_name='刘建坤');


select * from cux_ehr_emp_inf where epk in ('201735'); -- employee_name in ('封叶'); -- employee_number in  ('400249',	'410019');

select * from cux_hr_org_struc where org_code like '%YH%';

SELECT * FROM CUX_HR_EMP_ASS 
--WHERE ORG_CODE LIKE '%YH%'
WHERE  --EMPLOYEE_number like '410%' 
employee_name in ('赵哨华');

SELECT * FROM CUX_HR_EMP_DETAIL WHERE  /*p_EMPLOYEE_number='200622'; */ P_LAST_name='于旭' ; --张宏
--('王亮','曹海峰','王亚伟');

SELECT * FROM CUX_HR_EMP_ASS WHERE EMPLOYEE_NUMBER IN ('000175',	'410019');

SELECT * FROM PER_ALL_POSITIONS

SELECT SEGMENT1,SEGMENT2,  FROM PER_POSITION_DEFINITIONS_KFV WHERE CONCATENATED_SEGMENTS LIKE '501%';


select * from cux_ehr_emp_inf where employee_name in ('封叶') -- employee_number in  ('400249',	'410019');
select * from cux_ehr_emp_v@hjhr where employee_name in ('封叶') employee_number in ('400249',	'410019');
select * from cux_ehr_assignments_v@hjhr where eperson_pk in  ('400249',	'000175');

SELECT  p_last_name,P_REGION_OF_BIRTH, p_employee_number FROM CUX_HR_EMP_DETAIL 
WHERE substr(P_EMPLOYEE_NUMBER,1,2) IN ('00','10','30','40','20')
      AND substr(P_REGION_OF_BIRTH,1,2)= '湖北' --LIKE '湖北%'
;

select * from CUX_HR_EMP_DETAIL WHERE substr(P_EMPLOYEE_NUMBER,1,2) IN ('20')

select * from CUX_HR_EMP_DETAIL where p_last_name in ('刘伟','汪红伟');
 P_EMPLOYEE_NUMBER='000110'
 

/* 
         OU related info
 */
SELECT 
  SET_OF_BOOKS_ID, ORGANIZATION_ID, OPERATING_UNIT, ORGANIZATION_CODE,ORGANIZATION_NAME 
-- *
FROM ORG_ORGANIZATION_DEFINITIONS 
ORDER BY SET_OF_BOOKS_ID,ORGANIZATION_ID, OPERATING_UNIT;

/*3 - 运营    
X -
1 - 线路号
其中 304到330保留做线路
*/


 
/*
  query for vendor info
*/
SELECT * FROM ZX_RATES_B 
SELECT * FROM PO_VENDOR_SITES_ALL --PO_VENDORS 
WHERE ROWNUM<20;

SELECT DISTINCT(VENDOR_ID) FROM PO_VENDOR_SITES_ALL
SELECT COUNT(DISTINCT(VENDOR_ID)) FROM PO_VENDOR_SITES_ALL

SELECT * FROM PO_VENDORS WHERE VENDOR_ID=52010;


    
select * from po_lines_all where rownum<11;    
    
SELECT 
 DISTINCT ITEM_TYPE
 FROM MTL_SYSTEM_ITEMS_B
WHERE ROWNUM<10;    
    
WHERE CREATION_DATE >= to_date('2012-11-04', 'yyyy:mm:dd')
      AND ORG_ID=82
      and segment1 like '4%'
order by segment1;


/*
  query for demand lines info
*/
select * from fnd_user where user_name='GDJD02'-- user_id in (1341); -- 1501, 2129
SELECT ROWID, H.* FROM CUX_INV_DEMAND_HEADERS H WHERE DEMAND_CODE IN ('SQ201411260004');
-- 1264 1341
SELECT * 
FROM CUX_INV_DEMAND_LINES WHERE LINE_ID IN (78651,91574);

SELECT rowid, l.* --ATTRIBUTE11， RETURN_FLAG 
FROM CUX_INV_DEMAND_LINES l
WHERE HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS 
                           WHERE DEMAND_CODE in('SQ02201502060002','')) --SQ201403100001
order by LINE_NUM,last_update_date desc
;             

-- 按需求领料方式已完全领用出库的物料行
--SELECT * FROM CUX_INV_DEMAND_LINES WHERE QUANTITY_BACK IS NOT NULL;
SELECT *
FROM CUX_INV_DEMAND_LINES l
WHERE HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS 
                           WHERE DEMAND_CODE in('SQ02201502060002','')) --SQ201403100001
 AND (NVL(REQ_QUANTITY,0) + NVL(QUANTITY_BACK,0) = NVL(QUANTITY_OUT,0)) 
 ;
 
-- 已申请领料的物资行
/*
 attribute4 - 年度需求数量
 attribute5 - 标示本次需申请领用：Y - 本次需领用，N - ， Null - 
 attribute6 - 本次申请领用数量
 attribute7 - 
 attribute8 - 
 
 attribute11 - 用于标示计划员退回
 return_flag - 用于标示采购员退回；
*/
SELECT *
FROM CUX_INV_DEMAND_LINES Cidl
WHERE HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS 
                           WHERE DEMAND_CODE in('SQ02201502060002','')  AND Status = 'APPROVED') --SQ201403100001

   AND(nvl(REQ_QUANTITY, 0) - nvl(QUANTITY_OUT, 0) + nvl(QUANTITY_BACK, 0)) > 0
   AND ('Y' is null or nvl(attribute5, 'N') = 'Y')
; 

-- 已点击提交备料的物资行
SELECT *
FROM CUX_INV_DEMAND_LINES Cidl
WHERE HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_HEADERS 
                           WHERE DEMAND_CODE in('SQ02201502060002','')  AND Status = 'APPROVED') --SQ201403100001
   AND Nvl(Cidl.Attribute5, 'N') = 'Y'
   AND Nvl(Cidl.Attribute6, 0) > 0
   AND Nvl(Cidl.Attribute7, 'N') = 'Y'
;                                                        
 --nvl(REQ_QUANTITY, 0)
--SELECT * FROM FND_USER WHERE USER_ID=2150
;
SELECT * FROM CUX_INV_DEMAND_LINES WHERE RETURN_FLAG='Y';
SELECT DEMAND_CODE,ORGANIZATION_ID FROM CUX_INV_DEMAND_HEADERS 
WHERE HEADER_ID IN (SELECT HEADER_ID FROM CUX_INV_DEMAND_LINES WHERE RETURN_FLAG='Y')
      AND ORGANIZATION_ID=102 
      ORDER BY 1 

SELECT H.DEMAND_CODE, H.ORGANIZATION_ID
FROM CUX_INV_DEMAND_HEADERS H, CUX_INV_DEMAND_LINES L
WHERE H.HEADER_ID=L.HEADER_ID
      AND L.INVENTORY_ITEM_ID=9335
      ;          

SELECT HEADER_ID, ACTION_DATE, ACTION_NAME, FULL_NAME, COMMENTS
  FROM (SELECT caa.header_id,
               caa.action_date,
               ppf.full_name full_name,
               caa.action_code,
               caa.comments,
               DECODE(caa.action_code,
                      'SUBMIT',
                      '提交',
                      'FORWARD',
                      '转发',
                      'APPROVE',
                      '批准',
                      'REJECT',
                      '拒绝',
                      'RETURN_FR_PR',
                      '从采购退回',
                      'RETURN_FR_PL',
                      '从计划退回') action_name
          FROM cux_approve_actions caa, per_people_f ppf
         WHERE caa.appr_type = 'DEMAND'
           AND caa.owner_id = ppf.person_id
           AND TRUNC(SYSDATE) BETWEEN
               NVL(ppf.effective_start_date, TRUNC(SYSDATE)) AND
               NVL(ppf.effective_end_date, TRUNC(SYSDATE))
         ORDER BY caa.header_id, caa.action_date, caa.action_code)
 WHERE --(HEADER_ID = 7827)
       FULL_NAME='张雨为'
 order by 2 desc       
 ;

--select * from     CUX_INV_DEMAND_HEADERS;
cux_inv_bud_pkg
-- search for rejected demand lines related
SELECT ch.demand_code,ch.status, CH.LAST_UPDATE_DATE head_date, 
       CL.LAST_UPDATE_DATE line_date,
       /*CL.HEADER_ID,*/ CL.ATTRIBUTE11,CL.RETURN_FLAG , 
       CL.INVENTORY_ITEM_ID,CL.LIST_PRICE,CL.REQ_QUANTITY
FROM CUX_INV_DEMAND_LINES CL
     ,CUX_INV_DEMAND_HEADERS CH
WHERE (cl.RETURN_FLAG IS NOT NULL or  cl.ATTRIBUTE11 IS NOT NULL)
      and cl.header_id=ch.header_id
      and ch.organization_id=102
      and ch.status='APPROVED'
      AND to_char(CH.LAST_UPDATE_DATE,'YYYY-MM-DD HH:MI:SS') >= TO_CHAR(CL.LAST_UPDATE_DATE,'YYYY-MM-DD HH:MI:SS')
      and ch.demand_code='SQ201405130002'
ORDER BY DEMAND_CODE;

--SELECT /*DISTINCT ATTRIBUTE11,*/ DISTINCT RETURN_FLAG FROM CUX_INV_DEMAND_LINES; --GROUP BY 1,2
--SELECT DISTINCT ATTRIBUTE11 /*DISTINCT RETURN_FLAG*/ FROM CUX_INV_DEMAND_LINES; --GROUP BY 1,2
-- search for unreasonable data from rejected demand lines
SELECT ch.demand_code,ch.status, CH.LAST_UPDATE_DATE head_date, 
       CL.LAST_UPDATE_DATE line_date,
       /*CL.HEADER_ID,*/ CL.ATTRIBUTE11,CL.RETURN_FLAG , 
       CL.INVENTORY_ITEM_ID,CL.LIST_PRICE,CL.REQ_QUANTITY
FROM CUX_INV_DEMAND_LINES CL
     ,CUX_INV_DEMAND_HEADERS CH
WHERE (cl.RETURN_FLAG='Y' OR cl.ATTRIBUTE11='RETURN' )
      and cl.header_id=ch.header_id
      and ch.organization_id=102
      and ch.status='APPROVED'
      AND to_char(CH.LAST_UPDATE_DATE,'YYYY-MM-DD HH:MI:SS') >= TO_CHAR(CL.LAST_UPDATE_DATE,'YYYY-MM-DD HH:MI:SS')
--      and ch.demand_code='SQ201405130002'
ORDER BY DEMAND_CODE;


SELECT * FROM PO_LINES_ALL WHERE ROWNUM<50;
      
/*
  query for PO info
*/

--PO workflow info history
select * from PO_ACTION_HISTORY order by last_update_date desc;

SELECT SEGMENT1 FROM PO_HEADERS_ALL GROUP BY SEGMENT1 HAVING COUNT(SEGMENT1)>1

SELECT p.*,rowid FROM PO_HEADERS_ALL p WHERE SEGMENT1 in (400001145,400000554)order by segment1;

SELECT COUNT(*) FROM PO_HEADERS_ALL
；

SELECT pl.item_description,
       PL.UNIT_PRICE,PL.MARKET_PRICE,PL.ATTRIBUTE14,PL.ATTRIBUTE15, pl.attribute14/pl.attribute15
       ,PL.QUANTITY
       ,PL.* 
FROM PO_LINES_ALL PL WHERE PO_HEADER_ID  IN 
       (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL WHERE SEGMENT1 IN (400001158)) --400001153/*,400000554,400001704*/))
       order by org_id;
       
       
-- unit_price, attribute15 未税价
-- market_price, attribute14 含税价  
     
-- detail material info regarding PO lines
select pl.org_id,
       ph.segment1, pl.item_id, 
       m.segment1, m.DESCRIPTION
from   PO_HEADERS_ALL ph
     ,  PO_LINES_ALL   pl              
     ,Mtl_System_Items_Vl m
where m.segment1 like '30030%'
--      and m.ORGANIZATION_ID=ph.org_id
      and m.Inventory_Item_Id=pl.item_id                  
       and pl.po_header_id=ph.po_header_id;
       
select * 
from   CUX_INV_DETAILS_V    civ
where  civ.item_num like '30030%'
       --and demand_center_name in ('工务通号中心')  ;      
       
SELECT ATTRIBUTE1 /*, PO_HEADER_ID*/ FROM PO_HEADERS_ALL 
WHERE TYPE_LOOKUP_CODE='BLANKET' GROUP BY ATTRIBUTE1/*, PO_HEADER_ID*/ 
HAVING COUNT(ATTRIBUTE1)>1 ORDER BY 1;

SELECT p.attribute1, p.* FROM PO_HEADERS_ALL p 
WHERE ATTRIBUTE1 IN ('SZGY05MM201000164','','SZGY05MM2000016') order by 1;

-- contract release line detail
 SELECT *  FROM PO_LINES_ALL 
 WHERE PO_HEADER_ID IN /*(73042)*/(SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                               WHERE SEGMENT1=40200000008 AND TYPE_LOOKUP_CODE='BLANKET');
-- contract release record
SELECT * FROM PO_RELEASES_ALL 
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL WHERE SEGMENT1=40200000008 AND TYPE_LOOKUP_CODE='BLANKET') ;

-- contract release line detail release record ?
SELECT * FROM PO_LINE_LOCATIONS_RELEASE_V 
WHERE PO_HEADER_ID IN /*(73042)*/(SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                               WHERE SEGMENT1=400000322 AND TYPE_LOOKUP_CODE='BLANKET');
--                               WHERE SEGMENT1=400000704 AND TYPE_LOOKUP_CODE='BLANKET');
-- contract release quantity
SELECT * FROM PO_RELEASES_ALL 

SELECT * FROM PO_LINE_LOCATIONS_RELEASE_V

SELECT * FROM PO_RELEASES_ALL WHERE PO_HEADER_ID IN 
       (SELECT DISTINCT PO_HEADER_ID FROM PO_RELEASES_ALL GROUP BY PO_HEADER_ID HAVING COUNT(PO_HEADER_ID)>2)
ORDER BY PO_HEADER_ID, RELEASE_NUM; 

SELECT * FROM PO_headerS_ALL WHERE PO_HEADER_ID IN 
       (SELECT DISTINCT PO_HEADER_ID FROM PO_RELEASES_ALL GROUP BY PO_HEADER_ID HAVING COUNT(PO_HEADER_ID)>2)
ORDER BY PO_HEADER_ID;


SELECT pl.item_id, pl.item_description,pl.quantity_committed,
       pa.*
 FROM PO_LINE_LOCATIONS_ALL pa,
              po_lines_all          pl

where pa.po_header_id=pl.po_header_id
 and pa.po_line_id=pl.po_line_id
 and pa.po_header_id in (28039)
order by pa.po_release_id;

select * from po_line_locations_all

select ph.segment1,ph.attribute1
from po_line_locations_all pll,
              po_headers_all        ph
              ,PO_LINES_ALL         pl
where ph.po_header_id=pll.po_header_id
      and ph.po_header_id=pl.po_header_id
      and ph.segment1=40200000008  
      and ph.authorization_status='APPROVED'
      AND pll.approved_flag='Y'            

SELECT pl.item_id, pl.item_description,pl.quantity_committed,
       pa.*
 FROM PO_LINE_LOCATIONS_ALL pa,
              po_lines_all          pl
where pa.po_header_id=pl.po_header_id
 and pa.po_line_id=pl.po_line_id
 and pa.po_header_id in (select po_header_id from po_headers_all where segment1 in (400000711))
 and pl.org_id=82
order by pa.po_release_id;

/*
      PO approving notification 
*/

select * from CUX_NOTIFICATIONS_V where item_type= 'PO 审批';



SELECT  
       /*CIC.Description 申领中心,
        CID.Description 申领车间,*/
        civ.*
FROM CUX_INV_DETAILS_V civ
     /*, Cux_Inv_Depts_v       cid,
     Cux_Inv_Centers_v     cic*/

where    civ.item_num like '30030%'
        and civ.demand_status<>'REJECTED'
      
    
SELECT *--count(distinct(segment1))
FROM PO_HEADERS_ALL  PH ,--WHERE ROWNUM<20;
    PO_LINES_ALL  PL ,
    mtl_system_items_b   msi
WHERE PH.PO_HEADER_ID=PL.PO_HEADER_ID
    AND PL.ITEM_ID=MSI.INVENTORY_ITEM_ID
    AND MSI.ITEM_TYPE LIKE 'WZ%'
    
SELECT * FROM CUX_HR_ORG_STRUC
WHERE ROWNUM<20;    


      
SELECT *--count(distinct(segment1))
FROM PO_HEADERS_ALL  PH ,--WHERE ROWNUM<20;
    PO_LINES_ALL  PL ,
    mtl_system_items_b   msi
WHERE PH.PO_HEADER_ID=PL.PO_HEADER_ID
    AND PL.ITEM_ID=MSI.INVENTORY_ITEM_ID
    AND MSI.ITEM_TYPE LIKE 'WZ%'


SELECT * 
FROM (SELECT po_header_id, rma_reference, receipt_num,transaction_date 
      FROM  RCV_VRC_TXS_VENDINT_V 
      WHERE RECEIPT_NUM IN (500000528) AND ORGANIZATION_ID=102) T
pivot(     --sum(po_header_id)
           sum(RMA_REFERENCE/2)
            --FOR SUBSTR(to_char(RMA_REFERENCE),1,1) IN (NULL,'6','7')
            for RMA_REFERENCE in (600000473,700000073) )      
      
/*
       query for material info
*/      
SELECT count(distinct(ph.segment1)) 
FROM PO_HEADERS_ALL  PH , --WHERE ROWNUM<20; 
    PO_LINES_ALL  PL ,
    mtl_system_items_b   msi
WHERE PH.PO_HEADER_ID=PL.PO_HEADER_ID
    AND PL.ITEM_ID=MSI.INVENTORY_ITEM_ID
    AND PH.CREATION_DATE >= to_date( '2012-11-04', 'yyyy:mm:dd' )
    AND MSI.ITEM_TYPE IN ('WZ','NWZ')  
    
SELECT * FROM MTL_SYSTEM_ITEMS_B MSI WHERE INVENTORY_ITEM_ID IN (5369,5370);    

--seleCT * FROM MTL_CATEGORIES_TL WHERE ROWNUM<9;

SELECT COUNT(*) FROM MTL_SYSTEM_ITEMS_VL WHERE ORGANIZATION_ID=102;
; 

seleCT * FROM MTL_SYSTEM_ITEMS_VL WHERE organization_id=102 and rownum<20;  --material code



/*
       query for organization info
*/
select * from org_organization_definitions WHERE ROWNUM<39 order by organization_code;

select * from po_lines_all where /*item_id=5525 and */rownum<11;

seleCT * FROM MTL_SYSTEM_ITEMS_VL WHERE organization_id=102 and inventory_item_id=5525 and rownum<20;



/*
       query for contract material list
              重新运行清单导入需同时清除接口头和行的flag
*/

--select * from Po_Requisition_Headers_All  ph where 

select PL.ITEM_DESCRIPTION, M.SEGMENT1,M.DESCRIPTION
       ,PL.* 
from Po_Requisition_Lines_All pl 
              ,mtl_system_items_vl     M
WHERE PL.DESTINATION_ORGANIZATION_ID = M.ORGANIZATION_ID
      AND M.INVENTORY_ITEM_ID = PL.ITEM_ID
      AND PL.REQUISITION_HEADER_ID IN (SELECT REQUISITION_HEADER_ID FROM PO_REQUISITION_HEADERS_ALL
                                               WHERE SEGMENT1='JH201403100001' )
      AND PL.ORG_ID=82
      ;                      
--SELECT * FROM PO_REQUISITION_HEADERS_ALL WHERE SEGMENT1='JH201403100001'
--SELECT count(*) FROM PO_REQUISITION_LINES_ALL WHERE REQUISITION_HEADER_ID=150009
                                                                              
--      AND M.SEGMENT1='120060020004'
--      AND PL.ITEM_DESCRIPTION<>M.DESCRIPTION              
--where pl.blanket_po_line_num is not null like '%400001390%'

SELECT REQUISITION_HEADER_ID FROM PO_REQUISITION_HEADERS_ALL WHERE SEGMENT1='JH201403100001' 
SELECT * FROM Po_Requisition_Lines_All 
       WHERE REQUISITION_HEADER_ID = (SELECT REQUISITION_HEADER_ID FROM PO_REQUISITION_HEADERS_ALL WHERE SEGMENT1='JH201403100001' )
             AND ORG_ID=82

SELECT rowid, c.* FROM Cux_Po_Pc_Blanket_h_Int c
WHERE /*Process_Flag = 0 and*/  contract_code in ('SZGY05MM200000085','')
;

-- 查找开口合同对应的PO头
select ph.segment1, ph.attribute1, ph.* from po_headers_all ph
where po_header_id in (select distinct po_header_id from po_lines_all 
                           --   where attribute6=1
                           )
      and ph.attribute1 in ('SZGY05MM200000085')
order by ph.attribute1
;

-- 查找开口合同对应的合同头接口数据
select * from Cux_Po_Pc_Blanket_h_Int
where  interface_header_id in
(select distinct interface_header_id from Cux_Po_Pc_Blanket_l_Int where attribute4=1)
order by contract_code
;            
  
select  M.concatenated_segments ,M.DESCRIPTION,
        l.interface_header_id, l.attribute4,
        l.* 
from  Cux_Po_Pc_Blanket_l_Int l
      ,mtl_system_items_vl     M
where l.interface_header_id in (SELECT interface_header_id 
                                       FROM Cux_Po_Pc_Blanket_h_Int c
                                       WHERE contract_code In ('SZGY05MM201000372','SZGY05MM200000084') 
                                           /*and org_id=82*/
                                           ) 
          AND M.INVENTORY_ITEM_ID=L.INVENTORY_ITEM_ID     
          AND M.ORGANIZATION_ID=L.organization_id
order by l.interface_header_id, l.line_num
;
       
-- 120060020004 30098 车站二级交换机-[规格：OS6850-24L] --> 120050020002	38446 交换机-[规格：S3600-28P-SI,4个千兆上行，24个10/100 Base-T]      
SELECT rowid,pl.attribute6, pl.* FROM PO_LINES_ALL pl
       WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL WHERE attribute1='SZGY05MM201000372')
             and item_id=38446 -- item_description='车站二级交换机-[规格：OS6850-24L]';
;
--SELECT * FROM PO_REQUISITION_HEADERS_ALL  WHERE SEGMENT1='JH201403100001'   ;
   
SELECT rowid,prl.* FROM PO_REQUISITION_LINES_ALL prl
WHERE REQUISITION_HEADER_ID IN (SELECT REQUISITION_HEADER_ID FROM PO_REQUISITION_HEADERS_ALL  WHERE SEGMENT1='JH201403100001')
      and item_id=38446 --item_description='车站二级交换机-[规格：OS6850-24L]';


-- 合同清单导入标准错误信息查询
select * from po_interface_errors d ;
select s.attribute1 ,s.* from po_headers_interface s ;
select * from po_lines_interface ;

       
SELECT ATTRIBUTE1，SEGMENT1,PH.* FROM PO_HEADERS_ALL PH
 WHERE ATTRIBUTE1 IS NOT NULL AND ORG_ID=82 ORDER BY LAST_UPDATE_DATE DESC;

SELECT * FROM PO_HEADERS_ALL WHERE attribute1 like 'SZGY05MM200000084%';    -- 400001390  

SELECT * FROM PO_HEADERS_ALL WHERE attribute1 in ('','SZGY05MM201000383');    -- 400001390  
seleCT * FROM PO_HEADERS_ALL WHERE SEGMENT1='400000418';

SELECT rowid, c.* FROM Cux_Po_Pc_Blanket_h_Int c
WHERE /*Process_Flag = 0 and*/  contract_code in ('SZGY05MM201000383','')
      and Org_Id = 82 ;
--0 --初始状态,     1 --导入中，2 --导入成功,     3 --导入错误  
select * from fnd_user where user_name='TAOCHUNYAN' user_id in (1501); -- 1501, 2129
--SELECT ROWID,P.* FROM PO_HEADERS_ALL P WHERE SEGMENT1='400001309' --SZGY05MM201000269

select rowid, l.* 
from  Cux_Po_Pc_Blanket_l_Int l
where l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c
                                     WHERE /*Process_Flag = 0 and*/ /*Org_Id = 82 and*/ 
                                           contract_code in ('SZGY05MM201000383'/*,'SZGY05MM202000057'*/ ))                                           
          and process_flag=3
;   
   
      
select * from Cux_Po_Pc_Blanket_h_Int where process_flag=0 order by creation_date desc;
--SZGY05MM200000042
--SZGY05MM2010%107   mis-deleted

-- with material code & description
--          and process_flag=3 ;   
select  M.concatenated_segments ,M.DESCRIPTION,
        l.* 
from  Cux_Po_Pc_Blanket_l_Int l
      ,mtl_system_items_vl     M
where l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c
                                     WHERE contract_code In ('','SZGY05MM201000383' ) 
                                           /*and org_id=82*/) 
          AND M.INVENTORY_ITEM_ID=L.INVENTORY_ITEM_ID     
          AND M.ORGANIZATION_ID=L.organization_id         
          and m.CONCATENATED_SEGMENTS in ('300040370028','','')
          ;
-- organization_id 1359, org_id 82
select * from po_headers_all where segment1='400001908'
select * from org_organization_definitions

/********************************************************************
-- 框架合同属性在 attribute6          
--SELECT * FROM PO_HEADERS_ALL WHERE attribute1 in('400003334',)
*********************************************************************/
;
SELECT rowid,p.attribute6,p.po_header_id,p.org_id,p.* 
FROM PO_LINES_ALL p
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                              WHERE attribute1 in ('SZGY05MM200000085','','' ))
;
-- update PO_LINES_ALL set attribute6=1 WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                                                                      WHERE attribute1 in ('','','SZGY05MM200000085' )) 
                                              and attribute6 is null                         

SELECT rowid,p.attribute6,p.* FROM PO_LINES_ALL p
WHERE PO_HEADER_ID IN (SELECT PO_HEADER_ID FROM PO_HEADERS_ALL 
                              WHERE SEGMENT1='400003334' ）
                                    AND ORG_ID=82 
;

--SEGMENT1=400001055
select distinct organization_id from Cux_Po_Pc_Blanket_l_Int             
  
select rowid,        l.* 
from  Cux_Po_Pc_Blanket_l_Int l
where l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c
                                     WHERE /*Process_Flag = 0 and*/ /*Org_Id = 82 and*/ 
                                           contract_code in ('SZGY05MM201000269'/*,'SZGY05MM202000057'*/ ))                                           
          and process_flag=3;   
                                          
--update Cux_Po_Pc_Blanket_l_Int l set process_flag=2, error_message='' where  process_flag=3 and l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c WHERE /*Process_Flag = 0 and*/ Org_Id = 82 and contract_code='SZGY05MM200000042' );                                     


SELECT ATTRIBUTE1，SEGMENT1,PH.* FROM PO_HEADERS_ALL PH
 WHERE ATTRIBUTE1 IS NOT NULL AND ORG_ID=82 ORDER BY LAST_UPDATE_DATE DESC;
 
select /*rowid,*/ m.segment1,m.description ,l.* 
from 
       Cux_Po_Pc_Blanket_l_Int l
       ,mtl_system_items_vl M
where l.interface_header_id in (SELECT interface_header_id FROM Cux_Po_Pc_Blanket_h_Int c
                                     WHERE /*Process_Flag = 0 and*/ Org_Id = 82 and contract_code='SZGY05MM200000081' ) 
      and l.inventory_item_id=m.inventory_item_id
   AND m.Organization_Id = 102
   AND m.ITEM_TYPE='WZ'
   and m.segment1 in ('300130760002','300130760003')
order by 1;




/*
  列管属性物资出库到maximo
*/
--Mxmatusetrans_Iface_Insert_Trg
SELECT * FROM maxora.mxmanagitem_iface  WHERE issuenum='CK201411280027'
ORDER BY ISSUEDATE DESC
;
--SELECT * FROM MTL_MATERIAL_TRANSACTIONS WHERE TRANSACTION_ID =2046438;


/*
      Maximo material consuming and inventory updating
*/
SELECT transaction_source_name, error_explanation, error_code, mti.* 
FROM mtl_transactions_interface mti
where /*error_explanation= '事务处理日期不能为将来日期' and*/
  to_char(last_update_date, 'yyyy-mm-dd' ) like '2016-03%' ;
--delete from mtl_transactions_interface where error_explanation='事务处理日期不能为将来日期' and transaction_source_name='WO:429224' and to_char(last_update_date,'yyyy-mm-dd' ) like '2013-04%' ;

select distinct error_explanation ,transaction_date,last_update_date, i.*
from mtl_transactions_interface i
where to_char(last_update_date, 'yyyy-mm-dd') like '2013-04%' order by 2 desc;

SELECT m.CONCATENATED_SEGMENTS,m.DESCRIPTION,
      i.transaction_source_name,i.transaction_date,i.creation_date, i.program_update_date, i.last_update_date, i.error_explanation , i.error_code, i.*
FROM mtl_transactions_interface i
     , mtl_system_items_vl     M
where --error_explanation= '事务处理日期不能为将来日期' --and
--  to_char(last_update_date, 'yyyy-mm-dd' ) like '2013-10%'
--  AND SUBINVENTORY_CODE='L01KY05'  and 
        
 /*and*/ i.transaction_source_name in ('WO:4163766','WO:4163767')
          AND M.INVENTORY_ITEM_ID=i.INVENTORY_ITEM_ID    
          and m.ORGANIZATION_ID=i.organization_id 
order by i.last_update_date desc          ; 

SELECT i.transaction_source_name,i.transaction_date,i.creation_date, i.program_update_date, i.last_update_date, i.error_explanation , i.error_code
 FROM mtl_transactions_interface i
WHERE TO_CHAR(TRANSACTION_DATE,'YYYY-MM-DD hh24:mi:ss') > TO_CHAR(CREATION_DATE,'YYYY-MM-DD hh24:mi:ss')
ORDER BY LAST_UPDATE_DATE DESC;

SELECT * FROM maxora.MXMATUSETRANS_IFACE 
WHERE TO_CHAR(TRANSDATE,'YYYY-MM-DD hh24:mi:ss') > TO_CHAR(ACTUALDATE,'YYYY-MM-DD hh24:mi:ss')
;

select rowid, p.c_status,p.refwo,p.c_dept,itemnum,p.storeloc,to_char(TRANSDATE, 'yyyy-mm-dd hh24:mi:ss'),p.*
from maxora.MXMATUSETRANS_IFACE p
where refwo in ('2821475','')
AND ITEMNUM IN ('230023170008','300030780003')
order by p.refwo, p.itemnum;    

select * from mtl_transactions_interface where transaction_interface_id in (1717226,1717228);

--where p.c_status<> '0' order by p.transdate desc;
select mi.binnum, mi.itemnum,mi.c_status,mi.c_dept, rowid,mi.* from maxora.MXMATUSETRANS_IFACE mi where c_status is not null and c_status <>'0' 
--and refwo in ('1233381');       
order by actualdate desc;
select * from maxora.MXMATUSETRANS_IFACE where rowid='AABkBzAAvAAAbnKAAR';
--update  maxora.MXMATUSETRANS_IFACE set c_status ='' where c_status is not null and c_status <>'0' and refwo in ('2651463','2651478'); 

--4-物资出库科目映射没有在ERP维护获取科目组合失败
SELECT l.Flex_Value_Id,l.Flex_Value FROM Cux_Inv_Depts_v l WHERE '3' || l.Flex_Value || '00' = '301090300';      
      
SELECT Nvl(Sm.Segment1, '0') || '.' ||
                 Nvl(Sm.Segment2, '0') || '.' ||  --财务成本中心？
                 Nvl(Sm.Segment3, '0') || '.' ||
                 Nvl(Sm.Segment4, '0') || '.' ||
                 Nvl(Sm.Segment5, '0') || '.' ||
                 Nvl(Sm.Segment6, '0') || '.' ||
                 Nvl(2, '0') || '.' ||
                 Nvl(Sm.Segment8, '0') a,V1.Flex_Value,V1.ATTRIBUTE3
           -- INTO Lv_Flex_Seg
            FROM Cux_Inv_Gl_Segment_Map Sm,
                 Fnd_Flex_Values_Vl     V1,
                 Fnd_Flex_Value_Sets    S1
           WHERE Sm.Segment2 = V1.Attribute3
             AND V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
             AND S1.Flex_Value_Set_Name = 'SZMTR_COMPANY_ARCH'
             AND V1.Enabled_Flag = 'Y'
             AND V1.Flex_Value <> '0'
             AND V1.Hierarchy_Level = '1' --分部
             --AND V1.Hierarchy_Level = case length('01100402') when 6 then 1 else 2 end--'1' --分部
             AND V1.Flex_Value = '010904'--In_Dept_Code
             AND Trunc(SYSDATE) BETWEEN
                 Nvl(V1.Start_Date_Active, Trunc(SYSDATE)) AND
                 Nvl(V1.End_Date_Active, Trunc(SYSDATE))
             AND Sm.Item_Category1 = '30'--Iv_Item_Category1
             AND Sm.Organization_Id = 969--In_Organization_Id
             --AND Rownum = 1;   

SELECT * FROM Cux_Inv_Gl_Segment_Map                
WHERE  ORGANIZATION_ID=102 AND ITEM_CATEGORY1='30'

                                  
SELECT CID.*
FROM  CUX_INV_USER_DEPT_MAP_V CIU
      ,CUX_INV_DEPTS_V        CID
WHERE CIU. ORGANIZATION_ID=969 AND CIU.INV_SUB='L02SB01'                                         
      AND CID.Flex_Value_Id=CIU.Dept_Id
      ;


-- transaction type definitions
     select * from mtl_transaction_types order by 1;
-- 待办信息
SELECT * FROM CUX_NOTIFICATIONS_V WHERE SUBJECT LIKE '%LY01201503300003%'  

select * from cux_hr_emp_ass where employee_number='200292';
select * from FND_USER
;
select * from cux_hr_emp_ass where 
SELECT * 
--
FROM cux_hr_emp_ass ch,
     FND_USER fu
where      
  
     
