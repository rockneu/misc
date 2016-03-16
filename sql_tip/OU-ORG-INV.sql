SELECT hou.organization_id ou_org_id,
       hou.NAME ou_name,
       ood.organization_id org_org_id,
       ood.organization_code org_org_code,
       msi.disable_date,
       msi.locator_type,                  -- 货位控制 1-无，2-预指定
       msi.secondary_inventory_name,
       msi.description
  FROM hr_organization_information  hoi,
       hr_organization_units        hou,
       org_organization_definitions ood,
       mtl_secondary_inventories    msi
 WHERE hoi.org_information1 = 'OPERATING_UNIT'
   AND hoi.organization_id = hou.organization_id
   AND ood.operating_unit = hoi.organization_id
   AND ood.organization_id = msi.organization_id
   and ood.organization_code in (301/*,303*/)
   and msi.secondary_inventory_name like 'L01GJ%'
 ORDER BY  msi.secondary_inventory_name;   
