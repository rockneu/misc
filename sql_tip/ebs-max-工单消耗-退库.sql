SELECT  * FROM MTL_MATERIAL_TRANSACTIONS S WHERE S.ATTRIBUTE1 = 'TK201507150001';


select p.c_status,p.refwo,p.c_dept,itemnum,p.storeloc,to_char(TRANSDATE, 'yyyy-mm-dd hh24:mi:ss'),p.*
from maxora.MXMATUSETRANS_IFACE p
where refwo in ('','2668610');    

