SELECT L1.C1 一级,
       L1.D1 一级描述,
       substr(L2.C2,3,3) 二级,
       L2.D2 二级描述,
       substr(L3.C3,6,3) 三级,
       L3.D3 三级描述
  FROM (SELECT V1.Flex_Value  C1,
               V1.Description D1
          FROM Fnd_Flex_Values_Vl  V1,
               Fnd_Flex_Value_Sets S1
         WHERE V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
           AND S1.Flex_Value_Set_Name = 'SZMTR_ITEM_CATEGORY'
           AND V1.Hierarchy_Level = 0) L1,
       (SELECT V1.Flex_Value  C2,
               V1.Description D2
          FROM Fnd_Flex_Values_Vl  V1,
               Fnd_Flex_Value_Sets S1
         WHERE V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
           AND S1.Flex_Value_Set_Name = 'SZMTR_ITEM_CATEGORY'
           AND V1.Hierarchy_Level = 1) L2,
       (SELECT V1.Flex_Value  C3,
               V1.Description D3
          FROM Fnd_Flex_Values_Vl  V1,
               Fnd_Flex_Value_Sets S1
         WHERE V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
           AND S1.Flex_Value_Set_Name = 'SZMTR_ITEM_CATEGORY'
           AND V1.Hierarchy_Level = 2) L3
 WHERE L1.C1 = Substr(L2.C2, 1, 2)
   AND L2.C2 = Substr(L3.c3, 1, 5)
   AND L1.C1 in (77,78,79)
--   and substr(L2.C2,3,3)=001
ORDER BY L1.C1,L2.C2,L3.C3
;

/*SELECT \*DISTINCT*\ Mcb.Segment1 || '.' || Mcb.Segment2 Item_Cat2,Mcb.Description,
                Substr(Mcb.Description,
                       1,
                       Instr(Mcb.Description, '-', 1, 2) - 1) Item_Cat2_Desc
  FROM Mtl_Categories_Vl   Mcb,
       Mtl_Item_Categories Mic
 WHERE Mic.Category_Id = Mcb.Category_Id
   AND Mic.Category_Set_Id = 1
   AND Mcb.Structure_Id = 101
   AND Mcb.Enabled_Flag = 'Y'
   AND Mcb.Summary_Flag = 'N'
   AND Mic.Organization_Id = 102
   AND mcb.segment1 = '18'
   AND mcb.SEGMENT2 = '001'
 ORDER BY 1;*/

