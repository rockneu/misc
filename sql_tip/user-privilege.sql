------------现有系统中用户职责和用户姓名关联查询
select PA.organization,
       fu.user_id              用户ID,
       pf.last_name,
       fu.user_name            用户名称,
       frv.responsibility_name 职责名称,
       fr.responsibility_key   职责关键字
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
--      and frv.responsibility_name in ( '303_INV_苏轨运营二号线_二级库库存管理用户')
      --    and frv.responsibility_name like '301_INV%_非生产性物资库存需求用户%'
   and frv.responsibility_id = fr.responsibility_id
   and pf.person_id = fu.employee_id
   And lower(fu.user_name) in ('yangyanfang' /*,''*/)
--    and organization like '30107%'
--    and frv.responsibility_name in( '301_INV_苏轨运营公司_库存需求用户')
 order by PA.organization, fu.user_name, frv.responsibility_name;
