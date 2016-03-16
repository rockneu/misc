SELECT 
       Ps.Vendor_Site_Id,
       PV.VENDOR_ID,
       Pv.Segment1 AS 供应商编码,
       Pv.Vendor_Name "供应商名称",
       pv.*,
       decode（pv.VENDOR_TYPE_LOOKUP_CODE,'1-VNDOR','生产性物资供应商'，'2-VNDOR','非生产性物资供应商'）供应商分类,
       Hu.Name Ou_Name ,
       Ps.Vendor_Site_Code 地点名称,
       zb.tax_rate_code  税率,
       zb.last_update_date,
       Pc.Last_Name || Pc.Middle_Name || Pc.First_Name 联系人  ,
       Ps.Address_Line1 供应商地点,
       Ps.Country 国家,
       Ps.Province 省,
       Ps.City 市,
       Pc.Phone 电话,
       Pc.Fax_Area_Code || '-' || Pc.Fax 传真  
       
  FROM Po_Vendors               Pv,
       Po_Vendor_Sites_All      Ps,
       Hr_Operating_Units       Hu,
       Po_Vendor_Contacts       Pc,
         FND_LOOKUP_VALUES_VL   FV ,
         Zx_Rates_b             zb
 WHERE Pv.Vendor_Id = Ps.Vendor_Id
   AND Hu.Organization_Id = Ps.Org_Id
   AND Ps.Vendor_Site_Id = Pc.Vendor_Site_Id(+)
   AND PV.VENDOR_TYPE_LOOKUP_CODE = FV.LOOKUP_CODE(+)
   AND FV.LOOKUP_TYPE(+) = 'VENDOR TYPE'
   AND zb.Tax_Rate_Code(+) = Ps.Vat_Code
   AND zb.Tax_Jurisdiction_Code(+) = 'CNTAX'
   AND zb.Active_Flag(+) = 'Y'
--   AND  Hu.Name LIKE '%303%'
   and pv.VENDOR_NAME like '苏州宝富电力安全%';
   --进项17
   --SZGY05MM200000050
   
--   zb.tax_rate_code
--  select * from    Zx_Rates_b
