SELECT --flv.MEANING ����ʱɾ��,
       msiv.concatenated_segments ���ϱ���
            ,msiv.description ��������
            --,'' ����ͺ�
            --,msiv.primary_uom_code ��λ����
            ,msiv.primary_unit_of_measure ��λ����
            ,ood.ORGANIZATION_CODE �����֯
            ,decode(msiv.inventory_item_status_code, 'Active', '��Ч', 'Inactive', '��Ч', '') ״̬
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',1) һ���������
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',1)) һ����������
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',2) �����������
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',1)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',2)) ������������
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',3) �����������
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',1)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',2)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '���'),'.',3)) ������������
      --,'' �ļ�����
      --,'' �ļ�����
           -- ,'' ����Ŀ¼����
            --,'' Ĭ�ϲɹ�Ա����
            --,'' ���úϸ�Ӧ��
            --,'' �ɹ�����
            --,'' �Ƿ����ι���
           -- ,'' ������
           -- ,'' �Ƿ�Σ��Ʒ
           -- ,'' �ɹ�������ʽ
           -- ,'' ��С���
           -- ,'' �����
           -- ,'' ��С�ɹ�����
           -- ,'' �̶�������Ӧ
           -- ,'' �̶���������
           -- ,'' �ƻ�Ա
           -- ,'' ���ղֿ�
            --,'' ��λ
            ,gcc.concatenated_segments ���ÿ�Ŀ
            ,msiv.attribute1 �Ƿ�̶��ʲ�
            ,msiv.attribute2 ��������
            ,msiv.attribute4 �Ƿ��ܿ�ֱ������
            --,msiv.attribute3 �Ƿ�������
            ,decode(msiv.ITEM_TYPE,'WZ','SZMTR_����������ģ��' ,'NWZ','SZMTR_������������ģ��','ST','SZMTR_ʳ��������ģ��','') ģ��
            ,msiv.long_description ����Ҫ��
            ,msiv.ATTRIBUTE5 �й�����
            ,msiv.ATTRIBUTE6 ��ڲ���
            ,msiv.ATTRIBUTE7 �Ƿ�Σ��
            ,msiv.LIST_PRICE_PER_UNIT ��Ŀ��۸�
            --,'' ��������
            --,'N' ״̬
      FROM mtl_system_items_vl          msiv
          ,org_organization_definitions ood
          ,gl_code_combinations_kfv     gcc
          ,fnd_lookup_values_vl flv
      WHERE 1=1
      and ood.ORGANIZATION_CODE = '301' 
      AND MSIV.ITEM_TYPE = 'WZ'
      --AND msiv.concatenated_segments LIKE '98%'
      --and substr(msiv.CONCATENATED_SEGMENTS,1,2) in ('31','32')
      --AND msiv.INVENTORY_ITEM_STATUS_CODE != 'Inactive'
      AND msiv.organization_id = ood.organization_id
      AND msiv.expense_account = gcc.code_combination_id(+)
      AND msiv.ITEM_TYPE = flv.LOOKUP_CODE(+)
      AND flv.LOOKUP_TYPE(+) = 'ITEM_TYPE'
     -- AND msiv.SEGMENT1='320031210004'    
    --AND msiv.description like '%�յ�%'
     ORDER BY 1,2
      

      
  
