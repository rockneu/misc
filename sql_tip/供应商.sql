SELECT 
       Ps.Vendor_Site_Id,
       PV.VENDOR_ID,
       Pv.Segment1 AS ��Ӧ�̱���,
       Pv.Vendor_Name "��Ӧ������",
       pv.*,
       decode��pv.VENDOR_TYPE_LOOKUP_CODE,'1-VNDOR','���������ʹ�Ӧ��'��'2-VNDOR','�����������ʹ�Ӧ��'����Ӧ�̷���,
       Hu.Name Ou_Name ,
       Ps.Vendor_Site_Code �ص�����,
       zb.tax_rate_code  ˰��,
       zb.last_update_date,
       Pc.Last_Name || Pc.Middle_Name || Pc.First_Name ��ϵ��  ,
       Ps.Address_Line1 ��Ӧ�̵ص�,
       Ps.Country ����,
       Ps.Province ʡ,
       Ps.City ��,
       Pc.Phone �绰,
       Pc.Fax_Area_Code || '-' || Pc.Fax ����  
       
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
   and pv.VENDOR_NAME like '���ݱ���������ȫ%';
   --����17
   --SZGY05MM200000050
   
--   zb.tax_rate_code
--  select * from    Zx_Rates_b
