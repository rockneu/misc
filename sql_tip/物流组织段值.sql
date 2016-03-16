SELECT ROWID,/*T.**/ 
       T.DESCRIPTION,T.FLEX_VALUE_MEANING
FROM FND_FLEX_VALUES_TL T
WHERE FLEX_VALUE_ID IN (SELECT FLEX_VALUE_ID FROM FND_FLEX_VALUES
                               WHERE FLEX_VALUE_SET_ID = 1015079 and enabled_flag= 'Y')
       AND DESCRIPTION LIKE '%ÖÐÐÄ%'
       AND DESCRIPTION NOT LIKE '%¹¤°à'
       ORDER BY 2;
       /*
Mxmatusetrans_Iface_Insert_Trg      
1118125 */