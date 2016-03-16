SELECT m.Segment1  ���ϱ���,--Item_Code ,
       m.Description  ��������,--Item_Desc,
       Mcb.Description  �������, --Item_Cat,
       Abs(Nvl(r.Item_Qty, 0)) �������, --Zk_In_Qty, --���
       Abs(Nvl(z.Item_Qty, 0)) �ܿ�����,--Zk_Out_Qty, --�ܿ�����
       Abs(Nvl(t.Item_Qty, 0)) ����������,--Ej_Out_Qty, --����������
       Nvl(Oh.Oh_Qty, 0)  ��ǰ������,--Oh_Qty, --��ǰ������
              r.Max_Cost ��ߵ���, --��ߵ���
       r.Min_Cost ��͵���, --��͵���
       c.Item_Cost ��ǰ�ɱ�, --��ǰ�ɱ�
       Abs(Nvl(z.Item_Amount, 0)) �ܿ����Ľ��,--Zk_Amt, --�ܿ����Ľ��
       Abs(Nvl(t.Item_Amount, 0)) ���������Ľ��,--Ej_Amt, --���������Ľ��
       m.Attribute2 ��������,--Inv_Dl,
       m.Attribute1 �Ƿ����,--Inv_Zc,
       m.Attribute5  �й�����,--Inv_Xh,
       m.Attribute6  ��ڲ���,--Inv_Dept,
       m.Attribute7  �Ƿ�Σ�� --Inv_Wh
  FROM Mtl_System_Items_Vl m,
       Mtl_Item_Categories Mic,
       Mtl_Categories_Vl Mcb,
       Cst_Item_Costs c,
       (SELECT h.Organization_Id,
               h.Inventory_Item_Id,
               SUM(h.Transaction_Quantity) Oh_Qty
          FROM Mtl_Onhand_Quantities h
         WHERE h.Organization_Id = 102
         GROUP BY h.Organization_Id,
                  h.Inventory_Item_Id) Oh,
       (SELECT s.Inventory_Item_Id,
               s.Organization_Id,
               SUM(s.Primary_Quantity) Item_Qty,
               Round(SUM(s.Actual_Cost * s.Primary_Quantity), 2) Item_Amount,
               MAX(s.Actual_Cost) Max_Cost,
               MIN(s.Actual_Cost) Min_Cost
          FROM Mtl_Material_Transactions s,
               Mtl_Secondary_Inventories Msi,
               Mtl_System_Items_b        Msb
         WHERE s.Subinventory_Code = Msi.Secondary_Inventory_Name
           AND s.Organization_Id = Msi.Organization_Id
           AND s.Organization_Id = 102
           AND s.Transaction_Action_Id = 27 --�ܿ����
           AND s.Inventory_Item_Id = Msb.Inventory_Item_Id
           AND s.Organization_Id = Msb.Organization_Id
           AND Msb.Item_Type = 'WZ'
           AND Msi.Attribute1 = '1'
           AND s.Subinventory_Code <> 'FZH0001'
              --AND s.Subinventory_Code  BETWEEN '' AND ''
           AND Trunc(s.Transaction_Date) >=
               To_Date('2012-10-01', 'yyyy/mm/dd')
           AND Trunc(s.Transaction_Date) <=
               To_Date('2012-10-31', 'yyyy/mm/dd')
         GROUP BY s.Inventory_Item_Id,
                  s.Organization_Id) r,
       (SELECT s.Inventory_Item_Id,
               s.Organization_Id,
               SUM(s.Primary_Quantity) Item_Qty,
               Round(SUM(s.Actual_Cost * s.Primary_Quantity), 2) Item_Amount
          FROM Mtl_Material_Transactions s,
               Mtl_Secondary_Inventories Msi,
               Mtl_System_Items_b        Msb
         WHERE s.Subinventory_Code = Msi.Secondary_Inventory_Name
           AND s.Organization_Id = Msi.Organization_Id
           AND s.Organization_Id = 102
           AND s.Transaction_Action_Id = 1 --�ܿ�����
           AND s.Inventory_Item_Id = Msb.Inventory_Item_Id
           AND s.Organization_Id = Msb.Organization_Id
           AND Msb.Item_Type = 'WZ'
           AND Msi.Attribute1 = '1'
           AND s.Subinventory_Code <> 'FZH0001'
              --AND s.Subinventory_Code  BETWEEN '' AND ''
           AND Trunc(s.Transaction_Date) >=
               To_Date('2012-10-01', 'yyyy/mm/dd')
           AND Trunc(s.Transaction_Date) <=
               To_Date('2012-10-31', 'yyyy/mm/dd')
         GROUP BY s.Inventory_Item_Id,
                  s.Organization_Id) z,
       (SELECT s.Inventory_Item_Id,
               s.Organization_Id,
               SUM(s.Primary_Quantity) Item_Qty,
               Round(SUM(s.Actual_Cost * s.Primary_Quantity), 2) Item_Amount
          FROM Mtl_Material_Transactions s,
               Mtl_Secondary_Inventories Msi,
               Mtl_System_Items_b        Msb
         WHERE s.Subinventory_Code = Msi.Secondary_Inventory_Name
           AND s.Organization_Id = Msi.Organization_Id
           AND s.Organization_Id = 102
           AND s.Transaction_Action_Id = 2 --����������
           AND s.Inventory_Item_Id = Msb.Inventory_Item_Id
           AND s.Organization_Id = Msb.Organization_Id
           AND Msb.Item_Type = 'WZ'
           AND Msi.Attribute1 = '2'
           AND s.Subinventory_Code <> 'FZH0001'
              --AND s.Subinventory_Code  BETWEEN '' AND ''
           AND Trunc(s.Transaction_Date) >=
               To_Date('2012-10-01', 'yyyy/mm/dd')
           AND Trunc(s.Transaction_Date) <=
               To_Date('2012-10-31', 'yyyy/mm/dd')
         GROUP BY s.Inventory_Item_Id,
                  s.Organization_Id) t
 WHERE Mic.Inventory_Item_Id = m.Inventory_Item_Id
   AND Mic.Organization_Id = m.Organization_Id
   AND m.Inventory_Item_Id = t.Inventory_Item_Id(+)
   AND m.Organization_Id = t.Organization_Id(+)
   AND m.Inventory_Item_Id = r.Inventory_Item_Id(+)
   AND m.Organization_Id = r.Organization_Id(+)
   AND m.Inventory_Item_Id = z.Inventory_Item_Id(+)
   AND m.Organization_Id = z.Organization_Id(+)
   AND m.Inventory_Item_Id = Oh.Inventory_Item_Id(+)
   AND m.Organization_Id = Oh.Organization_Id(+)
   AND m.Inventory_Item_Id = c.Inventory_Item_Id
   AND m.Organization_Id = c.Organization_Id
   AND c.Cost_Type_Id = 2
   AND Mic.Category_Id = Mcb.Category_Id
   AND Mic.Category_Set_Id = 1
   AND m.Organization_Id = 102
   AND (r.Item_Qty IS NOT NULL OR z.Item_Qty IS NOT NULL OR
       t.Item_Qty IS NOT NULL OR Oh.Oh_Qty IS NOT NULL);
