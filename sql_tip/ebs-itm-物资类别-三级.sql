

SELECT V1.Flex_Value  C1,
               V1.Description D1
              -- ,v1.*
          FROM Fnd_Flex_Values_Vl  V1,
               Fnd_Flex_Value_Sets S1
         WHERE V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
           AND S1.Flex_Value_Set_Name = 'SZMTR_ITEM_CATEGORY'
           and V1.Hierarchy_Level = 2
           and substr(v1.FLEX_VALUE,1,2) between '01' and '35'
order by c1;        
