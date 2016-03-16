SELECT p.Segment1,
       p.Vendor_Name,
       s.Vendor_Site_Code,
       s.Vat_Code,
       t.source_id,
       t.Percentage_Rate
       ,t.*
  FROM Zx_Rates_b          t,
       Po_Vendor_Sites_All s,
       Po_Vendors          p
 WHERE t.Tax_Rate_Code = s.Vat_Code
   AND t.Tax_Jurisdiction_Code = 'CNTAX'
   AND t.Active_Flag = 'Y'
   AND Trunc(SYSDATE) BETWEEN Nvl(t.Effective_From, Trunc(SYSDATE)) AND
       Nvl(t.Effective_To, Trunc(SYSDATE))
   AND s.Vendor_Id = p.Vendor_Id
      -- AND s.Vendor_Site_Id = v_Header.Vendor_Site_Id
   AND s.Org_Id = 82 
--   and vendor_name like 'À’÷›∫∆»Ÿ%'
     order by t.tax_rate_code;
   ;
   
/*   select t.* from zx_rates_b t 
            ,Po_Vendor_Sites_All s
   where t.Tax_Jurisdiction_Code = 'CNTAX'
         AND t.Active_Flag = 'Y'
         and t.Tax_Rate_Code = s.Vat_Code
         and t.source_id=10086
*/          