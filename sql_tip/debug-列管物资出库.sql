

SELECT NVL(ITEM_TYPE,'WZ')  FROM CUX_INV_DEMAND_LINES_V WHERE ITEM_NUM='770040020081'
--NVL(:CUX_INV_DEMAND_LINES_V.ITEM_TYPE,'WZ')  in ('WZ','NWZ')

--cux_mmt_max_item_trg
 --车间 6 70604, 工班 12 80338, 人员 13
select * from cux_inv_centers_v where flex_value_id=70604;
select * from cux_inv_depts_v where flex_value_id=70604;
select * from cux_inv_sub_depts_v where flex_value_id=80338;

--MTL_MATERIAL_TRANSACTIONS中 Attribute6 车间,   Attribute12 工班
/*select Attribute6, Attribute12, Attribute13,locator_id,mmt.*
 from MTL_MATERIAL_TRANSACTIONS mmt
where mmt.attribute6='70583' --is not null*/
select Attribute6,Attribute12 from MTL_MATERIAL_TRANSACTIONS
where organization_id=969
      and Attribute12=435467 
      and Attribute6=383484
;

  SELECT MAX(Fv1.Flex_Value)
--    INTO l_Dept_Code_n
    FROM Fnd_Flex_Values_Vl Fv1
   WHERE To_Char(Fv1.Flex_Value_Id) = :New.Attribute6;

  --SELECT MAX(T.HR_DEPT_NUM)
  SELECT T.HR_DEPT_NUM
    --INTO l_Dept_Code
    FROM CUX_DEPT_HR_LINK T
   WHERE T.DEPT_NUM = '010700'--l_Dept_Code_n;

  IF :New.Attribute12 IS NOT NULL THEN
    SELECT MAX(Fv1.Flex_Value)
      --INTO l_Subdept_Code_n
      FROM Fnd_Flex_Values_Vl Fv1
     WHERE To_Char(Fv1.Flex_Value_Id) = :New.Attribute12;

    --SELECT MAX(T.HR_DEPT_NUM)
    SELECT T.HR_DEPT_NUM
     -- INTO l_Subdept_Code
      FROM CUX_DEPT_HR_LINK T
     WHERE T.DEPT_NUM = l_Subdept_Code_n;
  END IF;

  SELECT Substr(l_Dept_Code, 1, 5) || '0000'
    INTO l_Center_Code
    FROM Dual;

--===========================================

  IF :New.Attribute13 IS NOT NULL THEN
    SELECT MAX(He.Employee_Num)
      INTO l_Emp_Num
      FROM Fnd_User     Fu,
           Hr_Employees He
     WHERE Fu.Employee_Id = He.Employee_Id
       AND To_Char(Fu.User_Id) = :New.Attribute13;
  END IF;

  IF :New.Locator_Id IS NOT NULL THEN
    SELECT MAX(k.Concatenated_Segments)
      INTO l_Loc
      FROM Mtl_Item_Locations_Kfv k
     WHERE k.Inventory_Location_Id = :New.Locator_Id;
  END IF;
