SELECT 
       sum(Cidl.Req_Quantity * Pla.Market_Price)
/*       Cidh.Center_Name,
       cidh.dept_name,
       Cidh.Demand_Code   ��������, --�����
       Cidl.Item_Num, --����
       Cidl.Req_Quantity ����������--��������
       Cidl.List_Price, --���µ�����۸�
       Pla.Market_Price  �ɹ��۸�, --�ɹ�������˰��
--       Pla.Unit_Price, --�ɹ���������˰��
       Pha.Segment1      �ɹ�����--�ɹ�������
       ,pha.approved_date
       ,    Pha.Authorization_Status
--       ,    pha.approved_flag
       ,    pha.cancel_flag*/
  FROM Cux_Inv_Demand_Headers_v Cidh,
       Cux_Inv_Demand_Lines_v   Cidl,
       Cux_Inv_Plan_Lines       Cipl,
       Po_Requisition_Lines_All Prla,
       Po_Req_Distributions_All Prda,
       Po_Headers_All           Pha,
       Po_Lines_All             Pla,
       Po_Line_Locations_All    Plla,
       Po_Distributions_All     Pda
 WHERE Cidl.Header_Id = Cidh.Header_Id
   AND Cipl.Demand_Line_Id = Cidl.Line_Id
   AND Prla.Requisition_Line_Id = Cipl.Requisition_Line_Id
   AND Prda.Requisition_Line_Id = Prla.Requisition_Line_Id
   AND Pda.Req_Distribution_Id = Prda.Distribution_Id
   AND Plla.Line_Location_Id = Pda.Line_Location_Id
   AND Pla.Po_Line_Id = Plla.Po_Line_Id
   AND Pla.Po_Header_Id = Pha.Po_Header_Id

   and Pha.Authorization_Status='APPROVED'
   and pha.cancel_flag='N'
       
   AND Cidl.Attribute1 = '25.004' --����.����
   AND Cidh.Bud_Year = '2013'--��
--   AND Cidh.Center_Name = '�����������'--����  ����ͨ������
   AND Cidh.Center_Name = '����Ӫ������'            --����

   AND Cidh.Demand_Type = '������'              --���
   AND Cidh.Organization_Id = 102               --�����֯
   AND Cidh.Status = 'APPROVED'                 --��������ͨ��
   AND Cidl.Attribute12 = 'PO'                  --�Ѹ��¶����۸�
--   and item_num like '13006%'
