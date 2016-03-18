--SHOW USER;
--SELECT * FROM all_tables WHERE TABLE_NAME ='SDWO_IFACE';

--348142	1C1-04-26  338554	1C1-03-05

--SELECT S.WONUM, S.C_SDSUPERVISOR, S.C_WORKBEGINTIME FROM SCHEDUL.sdwo_iface S WHERE C_SDSUPERVISOR IS NULL ORDER BY C_WORKBEGINTIME


SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'),
        S.* 
FROM  SCHEDUL.sdwo_iface S WHERE WONUM in ('3627128','3477938')
order by s.wonum
;

SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'), S.* 
FROM  SCHEDUL.sdwo_iface S 
WHERE c_powerrequest <> 'NA' 
order by C_WORKBEGINTIME desc


      --WONUM in ('3477938','')


SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'), 
         TO_CHAR(targstartdate,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(targcompdate,'YYYY-MM-DD HH24:MI:SS'),S.*
FROM  SCHEDUL.sdwo_iface S WHERE WONUM in ('3160565','')
;

SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'), 
         TO_CHAR(targstartdate,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(targcompdate,'YYYY-MM-DD HH24:MI:SS'),S.*
FROM  SCHEDUL.sdwo_iface S WHERE WONUM='2106983';


SELECT TO_CHAR(C_WORKBEGINTIME,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(C_WORKFINISHTIME,'YYYY-MM-DD HH24:MI:SS'), 
         TO_CHAR(targstartdate,'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(targcompdate,'YYYY-MM-DD HH24:MI:SS'),S.*
FROM SCHEDUL.sdwo_iface S WHERE WONUM in ('3290444','3290442');

-- SD582907
select * from SCHEDUL.sdsr_iface where c_ticketid in ('SD594311','SD592436');
select * from SCHEDUL.sdsrout_iface where c_ticketid in ('SD592214'/*,'SD582907'*/) order by transid
;

select max(transseq) from SCHEDUL.sdsr_iface;
select * from SCHEDUL.sdsr_iface 
where c_findby is  null order by transseq
;

--select * from SCHEDUL.sdsrIN_iface where c_ticketid in ('','SD444370');
select * from SCHEDUL.sdsrout_iface where c_ticketid in ('','SD517650'); -- SD446861

--select distinct status from  maximo.SR

select * from maximo.SR where c_ticketid in ('SD517640','SD517650');

select * from SCHEDUL.sdsrout_iface where c_ticketid in ('','SD552455')
;
select i.ticketid, i.status, i.statusdate, i.* from SCHEDUL.sdsrout_iface i
where c_ticketid in ('SD517640','SD517650')
order by i.ticketid , i.statusdate ;

SELECT c_ticketid,S.* FROM maximo.sdsr_iface S where C_FINDBY='200349' 
ORDER BY REPORTDATE DESC;

-- π ’œµ•±‡∫≈
--  select MAXIFACETRANSSEQ.NEXTVAL from dual


SELECT * FROM MAXUSER WHERE USERID LIKE '% %';

select PERSONGROUP,DESCRIPTION,C_OUTGROUP,C_COMPANY from persongroup;

select * from persongroup;
--SD48113
