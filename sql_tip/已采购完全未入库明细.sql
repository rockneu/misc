SELECT h.Segment1             Po_Num,
       h.Authorization_Status,
       m.Segment1             Item_Num,
       m.Description          Item_Desc,
       m.Item_Type,
       l.quantity,
       l.unit_price,
       l.quantity*l.unit_price ,
       He.Full_Name
  FROM Po_Headers_All      h,
       Po_Lines_All        l,
       Mtl_System_Items_Vl m,
       Hr_Employees        He
 WHERE h.Po_Header_Id = l.Po_Header_Id
   AND l.Item_Id = m.Inventory_Item_Id
   AND (l.Cancel_Flag IS NULL OR l.Cancel_Flag = 'N')
   AND m.Organization_Id = 102
   AND h.Org_Id = 82
   AND h.Segment1 >= '400000082'
   AND h.Agent_Id = He.Employee_Id
   AND NOT EXISTS (SELECT 1
          FROM Rcv_Transactions Rt
         WHERE Rt.Po_Header_Id = l.Po_Header_Id
           --AND Rt.Po_Line_Id = l.Po_Line_Id
           AND Rt.Transaction_Type = 'DELIVER')