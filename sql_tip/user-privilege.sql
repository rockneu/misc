------------����ϵͳ���û�ְ����û�����������ѯ
select PA.organization,
       fu.user_id              �û�ID,
       pf.last_name,
       fu.user_name            �û�����,
       frv.responsibility_name ְ������,
       fr.responsibility_key   ְ��ؼ���
  from fnd_responsibility    fr,
       fnd_user              fu,
       fnd_user_resp_groups  furg,
       PER_ALL_PEOPLE_F      pf,
       fnd_responsibility_vl frv,
       PER_ALL_ASSIGNMENTS_D PA
 where PA.assignment_number = PF.EMPLOYEE_NUMBER
   and to_char(pa.effective_end_date, 'yyyy-mm-dd') >
       to_char(sysdate, 'yyyy-mm-dd')
   AND fu.user_id = furg.user_id
   and furg.responsibility_id = fr.responsibility_id
      --and fr.responsibility_key like '%IBAS%'
--      and frv.responsibility_name in ( '303_INV_�չ���Ӫ������_������������û�')
      --    and frv.responsibility_name like '301_INV%_�����������ʿ�������û�%'
   and frv.responsibility_id = fr.responsibility_id
   and pf.person_id = fu.employee_id
   And lower(fu.user_name) in ('yangyanfang' /*,''*/)
--    and organization like '30107%'
--    and frv.responsibility_name in( '301_INV_�չ���Ӫ��˾_��������û�')
 order by PA.organization, fu.user_name, frv.responsibility_name;