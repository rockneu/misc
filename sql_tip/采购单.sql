Select   Distinct 
  pha.segment1                        po_num    --�ɹ���
 ,pha.type_lookup_code               po_type   --��������
 ,pha.agent_id                       po_agent_id  --�ɹ�Ա��� 
 ,pha.comments                         po_comment  --������ע
 ,to_char(pha.creation_date,'YYYY/MM/DD')           po_date -- ��������
 ,ppv.FULL_NAME                      purchaser  --�ɹ�Ա
 ,ppv.work_telephone                 telephone   --�绰
 ,ppv.email_address                  buy_fax    --�ɹ�Ա����
 ,pv.VENDOR_NAME                    vendor   --��Ӧ������
 ,pvs.ADDRESS_LINE1                vendor_adress  --��Ӧ�̵�ַ
 ,pvc.LAST_NAME||pvc.FIRST_NAME     reference --��ϵ��
 ,pvc.PHONE                         vendor_tel --��ϵ�绰
 ,pvc.FAX_AREA_CODE||'-'||pvc.FAX    fax2  --��Ӧ�̴���
, hrl1.Description                 ship_adress---�ͻ���ַ
,hrl2.Description                   bill_adress---��Ʊ��ַ
/* ,hrl1.location_code                ship_adress---�ͻ���ַ
 ,hrl2.location_code                bill_adress---��Ʊ��ַ*/
 ,pha.currency_code                  cur --����
 ,At.Name                            payment_term--��������
-- ,zptp.party_id
 --, pvs.PARTY_SITE_ID
 ,zrb.percentage_rate                  TAX --˰��
 ,pla.line_num                       po_line_num   --�����б��
 ,msi.segment1||'-'||pla.item_revision                     item   --�Ϻ�
 --,msi.Description                item_des  --Ʒ�����
 ,pla.item_description             item_des  --Ʒ�����
 ,mct.description                  item_category   --���Ϸ���
 ,msi.primary_uom_code         item_uom    --��λ  
 ,pla.quantity                 quantity    --����
 --,pll.quantity_accepted         quantity    --����
 ,pla.unit_price                 unit_price  --����˰����
 ,pla.market_price            market_price  --��˰����
   ,pla.expiration_date               exp_date     --�۸�����
 ,pll.price_override                price_over   --����˰��ʷ��
  ,nvl(pll.quantity_accepted  ,0) * nvl(pla.market_price,0) amount   --���
 ,to_char(pll.need_by_date,'YYYY/MM/DD')       need_by_date  -- ��������

,wpe.wip_entity_name       wip_name --��������
,pha.comments                         polog  --������ע
 From  po_headers_all              pha
       ,po_lines_all               pla
       ,PO_LINE_LOCATIONS_ALL      PLL
       ,mtl_system_items_b         msi
       ,mtl_categories_b
       ,Mtl_Categories_Tl   Mct 
       ,po_vendors   pv
       ,po_vendor_sites_all  pvs
        ,po_vendor_contacts        pvc
        ,Hr_Locations_All_Tl       Hrl1
        ,Hr_Locations_All_Tl       Hrl2
        ,AP_TERMS        At
        ,per_people_v7   ppv
        ,po_distributions_all      pda
        ,wip_entities              wpe
       ,zx_rates_b                 zrb
       ,ZX_PARTY_TAX_PROFILE      zptp 
 Where 1=1
 And pha.po_header_id= pla.po_header_id
 And  pla.item_id=msi.inventory_item_id(+)
 And pla.category_id=mct.category_id
 And mct.language(+)='ZHS'
 And pha.vendor_id=pv.VENDOR_ID(+)
 And pv.VENDOR_ID=pvs.VENDOR_ID(+)
 And pvs.VENDOR_SITE_ID=pvc.VENDOR_SITE_ID(+)
 And  pha.agent_id=ppv.person_id(+)
 And pha.po_header_id=pll.po_header_id
 And pla.po_line_id=pll.po_line_id
And  pha.org_id=pvs.ORG_ID

--And  pv.TERMS_ID=At.TERM_ID(+)
And pvs.TERMS_ID=At.TERM_ID(+)
--And pv.PARTY_ID=zptp.party_id
And pvs.PARTY_SITE_ID=zptp.party_id

And Hrl1.Location_Id(+) = pha.Ship_To_Location_Id
And Hrl1.Language(+) = Userenv('LANG')
And Hrl2.Location_Id(+) = pha.Bill_To_Location_Id 
And Hrl2.Language(+) = Userenv('LANG')
And pha.po_header_id=pda.po_header_id
And pla.po_line_id=pda.po_line_id 
And pda.wip_entity_id=wpe.wip_entity_id(+)
And pha.type_lookup_code In ('STANDARD','PLANNED')
And (pla.cancel_flag Is  Null Or pla.cancel_flag<>'Y')
And zptp.tax_classification_code=zrb.tax_rate_code(+)
And zptp.party_type_code(+)='THIRD_PARTY_SITE'
And pha.vendor_site_id=pvs.VENDOR_SITE_ID
And  pvc.VENDOR_CONTACT_ID=pha.vendor_contact_id
--And pha.segment1=1300000667

--And pha.segment1  Between 1300000406 And 1300000406
/*And pha.segment1 between nvl(:p_po_Num_fr,pha.segment1) and nvl(:p_po_num_to,pha.segment1)*/


Union All


Select  
 pha.segment1||'-'||pra.release_num           po_num    --�ɹ���
 ,pha.type_lookup_code               po_type   --��������
 ,pha.agent_id                       po_agent_id  --�ɹ�Ա��� 
 ,pha.comments                         po_comment  --������ע
 ,to_char(pra.release_date,'YYYY/MM/DD')      po_date -- ��������
-- ,ppv.person_id
  ,ppv.FULL_NAME                    purchaser  --�ɹ�Ա
   ,ppv.work_telephone                 telephone   --�绰
    ,ppv.email_address                  buy_fax    --�ɹ�Ա����
    ,pv.VENDOR_NAME                    vendor   --��Ӧ������
   -- ,pv.VENDOR_ID
     ,pvs.ADDRESS_LINE1                  vendor_adress  --��Ӧ�̵�ַ
     ,pvc.LAST_NAME||pvc.FIRST_NAME     reference --��ϵ��
 ,pvc.AREA_CODE||'-'||pvc.PHONE      vendor_tel --��ϵ�绰
 ,pvc.FAX_AREA_CODE||'-'||pvc.FAX    fax2  --��Ӧ�̴���
 , hrl1.Description                 ship_adress---�ͻ���ַ
,hrl2.Description                   bill_adress---��Ʊ��ַ

 ,pha.currency_code                  cur --����
--,  pv.TERMS_ID       --����ά�����ǵص��ĸ������� 
-- ,pvs.TERMS_ID
  ,At.Name                            payment_term--��������
   , zrb.percentage_rate                        TAX --˰��
  -- ,pv.party_id 
   ,pll.shipment_num                   po_line_num  --�����б��
 -- , Pll.Line_Location_Id
  ,msi.segment1||'-'||pla.item_revision               item   --�Ϻ�
-- ,msi.Description                item_des  --Ʒ�����
 ,pla.item_description             item_des  --Ʒ�����
  ,mct.description                  item_category   --���Ϸ���
 ,msi.primary_uom_code         item_uom    --��λ  
-- ,pll.quantity                     quantity    --����
 ,pda.quantity_ordered                --����
--,pll.quantity_accepted             quantity    --����
 ,pla.unit_price                    unit_price    --����˰����
 ,pla.market_price                 market_price  --��˰����
  ,pla.expiration_date               exp_date     --�۸�����
 ,pll.price_override                price_over   --����˰��ʷ��
 
 ,nvl(pll.quantity_accepted ,0) * nvl(pla.market_price,0) amount   --���
 ,to_char(pll.need_by_date,'YYYY/MM/DD')       need_by_date  -- ��������
 ,wpe.wip_entity_name             wip_name --��������
,pra.attribute1           polog   --������ע
From 
   Po_Headers_All                pha  
   ,po_lines_all          pla  
   ,PO_LINE_LOCATIONS_ALL         Pll
   , Po_Releases_All             pra
   ,per_people_v7       ppv
     ,po_vendors        pv
      ,po_vendor_sites_all    pvs
      ,po_vendor_contacts        pvc
      ,Hr_Locations_All_Tl       Hrl1
     ,Hr_Locations_All_Tl       Hrl2
    
     ,AP_TERMS        At
        ,zx_rates_b                 zrb
        ,ZX_PARTY_TAX_PROFILE      zptp 
       ,mtl_system_items_b         msi
       ,Mtl_Categories_Tl         Mct 
       , wip_entities              wpe
          ,po_distributions_all      pda

Where 1=1
And pll.po_header_id=pha.po_header_id
And pll.po_header_id=pra.po_header_id
And pll.po_release_id=pra.po_release_id
And pll.po_header_id=pla.po_header_id
And pll.po_line_id=pla.po_line_id
 And  pha.agent_id=ppv.person_id(+)
 And pha.vendor_id=pv.VENDOR_ID(+)
 And pv.VENDOR_ID=pvs.VENDOR_ID(+)
 And pvs.ORG_ID=82
 And pvs.VENDOR_SITE_ID=pvc.VENDOR_SITE_ID(+)   
 And Hrl1.Location_Id(+) = pha.Ship_To_Location_Id
And Hrl1.Language(+) = Userenv('LANG')
And Hrl2.Location_Id(+) = pha.Bill_To_Location_Id 
And Hrl2.Language(+) = Userenv('LANG')   

And pda.po_header_id=pha.po_header_id
And pda.line_location_id=pll.line_location_id
--And  pv.TERMS_ID=At.TERM_ID(+)
And pvs.TERMS_ID=At.TERM_ID(+)
--And pv.PARTY_ID=zptp.party_id
And pvs.PARTY_SITE_ID=zptp.party_id
And zptp.tax_classification_code=zrb.tax_rate_code(+)
--And zptp.party_type_code='THIRD_PARTY'
And zptp.party_type_code='THIRD_PARTY_SITE'

 And  pla.item_id=msi.inventory_item_id(+)
 And pha.org_id=msi.organization_id
And pla.category_id=mct.category_id
And mct.language='ZHS'
And pha.po_header_id= pda.po_header_id
/*And pla.po_line_id= pda.po_line_id */
And pll.line_location_id=pda.line_location_id
And pda.wip_entity_id=wpe.wip_entity_id(+)
And pha.type_lookup_code='BLANKET'

And (pla.cancel_flag Is  Null Or pla.cancel_flag<>'Y')
And (pll.cancel_flag Is  Null Or pll.cancel_flag<>'Y')
And pra.approved_flag='Y'
And pha.vendor_site_id=pvs.VENDOR_SITE_ID
And  pvc.VENDOR_CONTACT_ID=pha.vendor_contact_id
/*And pha.segment1 between nvl(:p_po_Num_fr,pha.segment1) and nvl(:p_po_num_to,pha.segment1)
And pra.release_num Between nvl(:RELEASE_NUM_FR,pra.release_num) and nvl(:RELEASE_NUM_TO,pra.release_num)

*/
Order By po_line_num




