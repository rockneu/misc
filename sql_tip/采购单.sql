Select   Distinct 
  pha.segment1                        po_num    --采购单
 ,pha.type_lookup_code               po_type   --订单类型
 ,pha.agent_id                       po_agent_id  --采购员编号 
 ,pha.comments                         po_comment  --订单备注
 ,to_char(pha.creation_date,'YYYY/MM/DD')           po_date -- 订单日期
 ,ppv.FULL_NAME                      purchaser  --采购员
 ,ppv.work_telephone                 telephone   --电话
 ,ppv.email_address                  buy_fax    --采购员传真
 ,pv.VENDOR_NAME                    vendor   --供应商名称
 ,pvs.ADDRESS_LINE1                vendor_adress  --供应商地址
 ,pvc.LAST_NAME||pvc.FIRST_NAME     reference --联系人
 ,pvc.PHONE                         vendor_tel --联系电话
 ,pvc.FAX_AREA_CODE||'-'||pvc.FAX    fax2  --供应商传真
, hrl1.Description                 ship_adress---送货地址
,hrl2.Description                   bill_adress---开票地址
/* ,hrl1.location_code                ship_adress---送货地址
 ,hrl2.location_code                bill_adress---开票地址*/
 ,pha.currency_code                  cur --币种
 ,At.Name                            payment_term--付款条件
-- ,zptp.party_id
 --, pvs.PARTY_SITE_ID
 ,zrb.percentage_rate                  TAX --税率
 ,pla.line_num                       po_line_num   --订单行编号
 ,msi.segment1||'-'||pla.item_revision                     item   --料号
 --,msi.Description                item_des  --品名规格
 ,pla.item_description             item_des  --品名规格
 ,mct.description                  item_category   --物料分类
 ,msi.primary_uom_code         item_uom    --单位  
 ,pla.quantity                 quantity    --数量
 --,pll.quantity_accepted         quantity    --数量
 ,pla.unit_price                 unit_price  --不含税单价
 ,pla.market_price            market_price  --含税单价
   ,pla.expiration_date               exp_date     --价格到期日
 ,pll.price_override                price_over   --不含税历史价
  ,nvl(pll.quantity_accepted  ,0) * nvl(pla.market_price,0) amount   --金额
 ,to_char(pll.need_by_date,'YYYY/MM/DD')       need_by_date  -- 需求日期

,wpe.wip_entity_name       wip_name --任务名称
,pha.comments                         polog  --订单备注
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
 pha.segment1||'-'||pra.release_num           po_num    --采购单
 ,pha.type_lookup_code               po_type   --订单类型
 ,pha.agent_id                       po_agent_id  --采购员编号 
 ,pha.comments                         po_comment  --订单备注
 ,to_char(pra.release_date,'YYYY/MM/DD')      po_date -- 订单日期
-- ,ppv.person_id
  ,ppv.FULL_NAME                    purchaser  --采购员
   ,ppv.work_telephone                 telephone   --电话
    ,ppv.email_address                  buy_fax    --采购员传真
    ,pv.VENDOR_NAME                    vendor   --供应商名称
   -- ,pv.VENDOR_ID
     ,pvs.ADDRESS_LINE1                  vendor_adress  --供应商地址
     ,pvc.LAST_NAME||pvc.FIRST_NAME     reference --联系人
 ,pvc.AREA_CODE||'-'||pvc.PHONE      vendor_tel --联系电话
 ,pvc.FAX_AREA_CODE||'-'||pvc.FAX    fax2  --供应商传真
 , hrl1.Description                 ship_adress---送货地址
,hrl2.Description                   bill_adress---开票地址

 ,pha.currency_code                  cur --币种
--,  pv.TERMS_ID       --他们维护的是地点层的付款条件 
-- ,pvs.TERMS_ID
  ,At.Name                            payment_term--付款条件
   , zrb.percentage_rate                        TAX --税率
  -- ,pv.party_id 
   ,pll.shipment_num                   po_line_num  --订单行编号
 -- , Pll.Line_Location_Id
  ,msi.segment1||'-'||pla.item_revision               item   --料号
-- ,msi.Description                item_des  --品名规格
 ,pla.item_description             item_des  --品名规格
  ,mct.description                  item_category   --物料分类
 ,msi.primary_uom_code         item_uom    --单位  
-- ,pll.quantity                     quantity    --数量
 ,pda.quantity_ordered                --数量
--,pll.quantity_accepted             quantity    --数量
 ,pla.unit_price                    unit_price    --不含税单价
 ,pla.market_price                 market_price  --含税单价
  ,pla.expiration_date               exp_date     --价格到期日
 ,pll.price_override                price_over   --不含税历史价
 
 ,nvl(pll.quantity_accepted ,0) * nvl(pla.market_price,0) amount   --金额
 ,to_char(pll.need_by_date,'YYYY/MM/DD')       need_by_date  -- 需求日期
 ,wpe.wip_entity_name             wip_name --任务名称
,pra.attribute1           polog   --订单备注
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




