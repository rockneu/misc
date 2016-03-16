DECLARE
  ERRBUF varchar2(1000);
  RETCODE varchar2(1000);
  P_INFO varchar2(1000);
BEGIN
  P_INFO := 'test';
  CUX_MAXIMO_FA_PKG.SENT_MAIL(ERRBUF,RETCODE,P_INFO); 
  dbms_output.put_line('ERRBUF:'||ERRBUF);
EXCEPTION   
  WHEN OTHERS THEN
    dbms_output.put_line('send mail exception'||SQLERRM);
    dbms_output.put_line('ERRBUF:'||ERRBUF);
END;
