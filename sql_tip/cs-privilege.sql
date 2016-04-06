
SELECT TOP 10 * FROM SEC_USER
;
SELECT TOP 10 * FROM SEC_ROLE
;
SELECT TOP 10 * FROM SEC_WF_ROLE
;
SELECT TOP 10 * FROM SEC_WF_USERROLE
;

/*
SELECT TOP 10 U.ID, U.NAME, U.LOGINID, R.NAME --, WR.DESCRIPTION
FROM SEC_USER  			U
	,sec_role			R
	,SEC_WF_ROLE		WR
	,SEC_WF_USERROLE	WU
WHERE U.ID =  WR.ID
	AND R.ID = WR.ROLEID
*/
	



select * from SEC_wf_UserRole
--USERID ca3c394a-67bc-4943-8ac9-c6e8ccc1ba6a 
--WFROLEID 16a8a3cb-ba12-4f04-8768-e92b9a6103e7

SELECT * FROM sec_user where id in ('ca3c394a-67bc-4943-8ac9-c6e8ccc1ba6a');
--select * from sec_role where id in ('16a8a3cb-ba12-4f04-8768-e92b9a6103e7');
select * from SEC_WF_ROLE where id in ('16a8a3cb-ba12-4f04-8768-e92b9a6103e7');