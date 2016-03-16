SELECT usr.user_name,
       get_pwd.decrypt
          ((SELECT (SELECT get_pwd.decrypt(fnd_web_sec.get_guest_username_pwd, usertable.encrypted_foundation_password)
                      FROM DUAL) AS apps_password
              FROM fnd_user usertable
             WHERE usertable.user_name =
                      ( SELECT SUBSTR(fnd_web_sec.get_guest_username_pwd, 1 , INSTR(fnd_web_sec.get_guest_username_pwd,'/' )-1) FROM DUAL)),
           usr.encrypted_user_password
          ) PASSWORD 
  FROM fnd_user usr
  WHERE usr.user_name = upper('gwth02'); 
  
--clzx001/111111  clzx01/111111    clzx/sevenxp
-- UAT env:  yangyanfang/111111,123456 , songguodong/222222
--GWTH01  68202153 gwth02/654321   GWTH/666333,111111
--gdjd001/123654     gdjd01/123654  gdjd/654321  lingyang/215237
--SQ201310120001 SQ201310120002
--gdjd01/123654  gdjd/654321  gdjd01/123654  gdjd/654321
--SELECT C.*,ROWID FROM CUX_INV_DEMAND_HEADERS C WHERE DEMAND_CODE IN ('SQ201310120002');

