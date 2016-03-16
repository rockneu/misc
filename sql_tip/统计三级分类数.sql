SELECT L1.C1,
       L1.D1,
       L2.C2,
       L2.D2,
       L3.D3
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
       (SELECT Substr(V1.Flex_Value, 1, 5) C3,
               COUNT(*) D3
          FROM Fnd_Flex_Values_Vl  V1,
               Fnd_Flex_Value_Sets S1
         WHERE V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
           AND S1.Flex_Value_Set_Name = 'SZMTR_ITEM_CATEGORY'
           AND V1.Hierarchy_Level = 2
         GROUP BY Substr(V1.Flex_Value, 1, 5)) L3
 WHERE L1.C1 = Substr(L2.C2, 1, 2)
   AND L2.C2 = L3.C3
 ORDER BY L1.C1,
          L2.C2;
