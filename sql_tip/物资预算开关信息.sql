SELECT 
/*
ROWID,
       APPLICATION_ID,
       PROFILE_OPTION_ID,
       PROFILE_OPTION_NAME,
       USER_PROFILE_OPTION_NAME,
       SQL_VALIDATION,
       HIERARCHY_TYPE*/
       fpo.*
  FROM FND_PROFILE_OPTIONS_VL fpo
 WHERE START_DATE_ACTIVE <= SYSDATE
   and NVL(END_DATE_ACTIVE, SYSDATE) >= SYSDATE
   and (SITE_ENABLED_FLAG = 'Y' or APP_ENABLED_FLAG = 'Y' or
       RESP_ENABLED_FLAG = 'Y' or USER_ENABLED_FLAG = 'Y' or
       SERVER_ENABLED_FLAG = 'Y' or SERVERRESP_ENABLED_FLAG = 'Y' or
       ORG_ENABLED_FLAG = 'Y')
   and (UPPER(USER_PROFILE_OPTION_NAME) = 'CUX_物资需求预算控制' and
       (USER_PROFILE_OPTION_NAME LIKE '%物%' or
       USER_PROFILE_OPTION_NAME LIKE '%物%'))
 order by user_profile_option_name
