

SELECT appr_type,HEADER_ID, ACTION_DATE, ACTION_NAME, FULL_NAME, COMMENTS,PERSON_ID
  FROM (SELECT caa.header_id,
               caa.action_date,
               caa.appr_type,
               ppf.full_name full_name,
               ppf.PERSON_ID ,
               caa.action_code,
               caa.comments,
               DECODE(caa.action_code,
                      'SUBMIT',
                      '�ύ',
                      'FORWARD',
                      'ת��',
                      'APPROVE',
                      '��׼',
                      'REJECT',
                      '�ܾ�',
                      'RETURN_FR_PR',
                      '�Ӳɹ��˻�',
                      'RETURN_FR_PL',
                      '�Ӽƻ��˻�') action_name
          FROM cux_approve_actions caa, per_people_f ppf
         WHERE 1=1
           AND caa.owner_id = ppf.person_id
           and caa.action_code is null 
           and full_name in ('��ɽ')
           AND TRUNC(SYSDATE) BETWEEN
               NVL(ppf.effective_start_date, TRUNC(SYSDATE)) AND
               NVL(ppf.effective_end_date, TRUNC(SYSDATE))
         ORDER BY caa.header_id, caa.action_date, caa.action_code)
;
