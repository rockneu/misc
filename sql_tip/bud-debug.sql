        

--  cux_inv_bud_pkg

  SELECT SUM(nvl(a.appr_amount,
                         0))over (),
                  a.Attribute1
            FROM cux_inv_bud_appr_v a
           WHERE a.attribute1 ='01.008'
             AND a.bud_year = '2015'
             AND a.center_id = 70585
             AND a.bud_type = '������'
             AND a.organization_id = 1359;
--             select * from org_organization_definitions d where d.ORGANIZATION_CODE ='313'

/*
ov_error_msg := ov_error_msg || ln_center_name|| '��֯��'||ln_organization_name || '�����϶������Ԥ��' ||
                            to_char(l_ext_amt) || 'Ԫ,' || l_item_cat || '(' ||
                            c1.attribute1 || ') ��Ԥ�㣺'||ln_bud_amount ||'-- ʵ�ۣ�'||l_final_amt||'-- �ݿۣ�'||l_zankou_amt||'-- ���᣺'||l_frozen_amt||'--'||ln_center_id;
                            
     */
