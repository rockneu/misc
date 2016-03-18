use SZMETROCS

SELECT TOP 5 * FROM PL_WORKPLAN
;
SELECT TOP 5 * FROM PL_WORKPLANSTATISTICS
;

SELECT TOP 5 * FROM PL_WORKPLANVERSION
WHERE ISMULTILINE = 1	 --IS NOT NULL
;

SELECT TOP 5  WC.WORKSUBJECT, WC.WORKCONTENTCODE, 
		PV.WORKPLANBEGINDT, PV.WORKPLANENDDT
FROM      WC_WorkContent WC,
	 PL_WORKPLANVERSION PV
WHERE 
	WC.WORKPLANVERSIONID = PV.WORKPLANVERSIONID
	AND PV.ISMULTILINE = 1
;

select * from PT_WorkPointApply
where workpointcode in ('PT201503230282') 
;

SELECT * FROM   PL_WorkPlanVersion 
where workplanbegindt > '2015-04-30 06:00:00' and workplanenddt<'2016-05-01 06:00:00'
	AND WORKPLANCODE='PL201504300306'
	and status <> 'Finish'
;
-- UPDATE PL_WORKPLANVERSION SET workplanenddt='2015/5/1 2:30:00' where WORKPLANCODE='PL201504300306' and workplanenddt='2016/5/1 2:30:00'

SELECT * FROM WC_WorkContent WHERE WORKCONTENTCODE='1C1-30-017'
;

SELECT WC.WORKCONTENTCODE, wc.worksubject, PV.STATUS 计划状态, wp.Status 请销点状态, PV.workplanbegindt , PV.workplanenddt
FROM PL_WorkPlanVersion PV,
	WC_WorkContent WC
	, PT_WorkPointApply wp
WHERE PV.WORKPLANversionID=WC.WORKPLANversionID
	--AND WC.WORKCONTENTCODE='1A2-15-001'
	and (pv.workplanbegindt > '2015-05-15 06:00:00' and pv.workplanenddt<'2015-05-16 23:00:00')
	and wp.workplanid = pv.workplanid
	AND  PV.status <> 'Finish'
	AND WP.STATUS='Finish'
--	AND  PV.status = 'Ordered'
ORDER BY WC.WORKCONTENTCODE
;