CREATE OR REPLACE PACKAGE Cux_Inv_Txn_Pkg IS
  /*=================================================================
         Copyright (C) IBM Global Business Services                                 
                       AllRights Reserved                                            
    =================================================================
  * =================================================================
  *   PROGRAM NAME:
  *                cux_inv_txn_pkg
  *   DESCRIPTION: 
  *                事务处理程序包
  *   PROGRAM LIST:
  *  -------------------------- ----- ----- -----------------------
  *       Name                  Type  Ret   Description
  *  -------------------------- ----- ----- -----------------------
  *  pro_insert_tran_iface        P          插入事务处理接口表
  *  pro_insert_lots_iface        P          插入批次接口表
  *  pro_insert_serials_iface     P          插入序列接口表
  *  fnk_get_jj_lot_price         F          获取基建组织下的批次价格
  *  fnk_get_txn_status           F          获取发料状态
  *  fnk_get_expenditure_type     F          获取支出类型
  *  fnk_get_def_expenditure_type F          获取委外修发票工单成本默认支出类型
  *  fnk_get_expenditure_org_id   F          获取支出类型
  *  fnk_get_account_id           F          获取支出组织
  *
  *   HISTORY: 
  *     1.0   2009-06-15   Mingbao.Zhang     Created
  *     
  * ===============================================================*/
  PROCEDURE Pro_Insert_Tran_Iface(Ir_Tran_Iface IN Mtl_Transactions_Interface%ROWTYPE);

  PROCEDURE Pro_Insert_Lots_Iface(Ir_Lots_Iface IN Mtl_Transaction_Lots_Interface%ROWTYPE);

  PROCEDURE Pro_Insert_Serials_Iface(Ir_Serials_Iface IN Mtl_Serial_Numbers_Interface%ROWTYPE);

  FUNCTION Fnk_Get_Jj_Lot_Price(In_Organization_Id   IN NUMBER, --库存组织
                                In_Inventory_Item_Id IN NUMBER, --物资
                                Iv_Lot_Number        IN VARCHAR2 --批次
                                ) RETURN NUMBER;

  FUNCTION Fnk_Get_Txn_Status(Iv_Type      IN VARCHAR2, --来源: 工单/领料申请单/需求申请
                              In_Header_Id IN NUMBER --头id
                              ) RETURN VARCHAR2;

  FUNCTION Fnk_Get_Expenditure_Type(Iv_Item_Type  IN VARCHAR2, --物资类型
                                    In_Project_Id IN NUMBER --项目
                                    ) RETURN VARCHAR2;

  FUNCTION Fnk_Get_Def_Expenditure_Type(In_Project_Id IN NUMBER --项目
                                        ) RETURN VARCHAR2;

  FUNCTION Fnk_Get_Expenditure_Org_Id(In_Project_Id IN NUMBER --项目
                                      ) RETURN NUMBER;

  FUNCTION Fnk_Get_Account_Id(Iv_Source_Type     IN VARCHAR2, --来源: 库存/发票
                              In_Organization_Id IN NUMBER, --库存组织
                              In_Item_Id         IN NUMBER, --物料ID
                              Iv_Item_Category1  IN VARCHAR2, --物资大类
                              Iv_Item_Category2  IN VARCHAR2, --物资中类
                              Iv_Item_Type       IN VARCHAR2, --物资类型
                              Iv_Apply_User_Id   IN VARCHAR2, --申请人
                              In_Dept_Code       IN VARCHAR2, --部门
                              In_Inv_Code        IN VARCHAR2, --子库
                              In_Asset_Flag      IN VARCHAR2, --固定资产
                              In_Project_Id      IN NUMBER, --项目
                              In_Task_Id         IN NUMBER, --任务
                              Ov_Error_Message   OUT VARCHAR2 --错误消息
                              ) RETURN NUMBER;

  /*************************************************************************************************
  *
  * function name : Get_BR_Account_Id
  * description   : 获取借料成本科目
  *
  ************************************************************************************************/
  FUNCTION Get_Br_Account_Id(In_Organization_Id IN NUMBER, --库存组织
                             In_Inv_Code        IN VARCHAR2, --子库
                             Ov_Error_Message   OUT VARCHAR2 --错误消息
                             ) RETURN NUMBER;

  FUNCTION Fnk_Get_Pa_Acc_Id(p_Organization_Id IN NUMBER,
                             p_Project_Id      IN NUMBER,
                             p_Task_Id         IN NUMBER,
                             p_Pa_Type         IN VARCHAR2,
                             Ov_Error_Message  OUT VARCHAR2) RETURN NUMBER;
  /*************************************************************************************************
  *
  * function name : Gen_CK_Num
  * description   : 自动生成出库单号，CK+日期+0001
  *
  ************************************************************************************************/
  FUNCTION Gen_Ck_Num(In_Organization_Id IN NUMBER) RETURN VARCHAR2;
  FUNCTION Gen_Ck_Num(In_Organization_Id IN NUMBER, In_Dept_name varchar2) RETURN VARCHAR2;

  /*************************************************************************************************
  *
  * function name : Gen_TK_Num
  * description   : 自动生成退库单号，TK+日期+0001
  *
  ************************************************************************************************/
  FUNCTION Gen_Tk_Num(In_Organization_Id IN NUMBER) RETURN VARCHAR2;

  PROCEDURE Delete_Ck_Num(In_Number          IN VARCHAR2,
                          In_Organization_Id IN NUMBER);

  PROCEDURE Delete_Tk_Num(In_Number          IN VARCHAR2,
                          In_Organization_Id IN NUMBER);

  PROCEDURE Submit_Inv_Trx(p_Api_Version      IN NUMBER,
                           p_Init_Msg_List    IN VARCHAR2 := Fnd_Api.g_False,
                           p_Commit           IN VARCHAR2 := Fnd_Api.g_False,
                           p_Validation_Level IN NUMBER := Fnd_Api.g_Valid_Level_Full,
                           x_Return_Status    OUT NOCOPY VARCHAR2,
                           x_Msg_Count        OUT NOCOPY NUMBER,
                           x_Msg_Data         OUT NOCOPY VARCHAR2,
                           x_Trans_Count      OUT NOCOPY NUMBER,
                           p_Table            IN NUMBER := 1,
                           p_Header_Id        IN NUMBER,
                           p_Tran_Iface       IN Mtl_Transactions_Interface%ROWTYPE,
                           x_Return           OUT NUMBER);

  PROCEDURE Insert_Number(p_Organization_Id IN NUMBER,
                          p_Type_Code       IN VARCHAR2,
                          p_Doc_Number      IN VARCHAR2,
                          p_Trx_Date        IN DATE,
                          p_Wo              IN VARCHAR2);
END Cux_Inv_Txn_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Cux_Inv_Txn_Pkg IS
  -- ===============================
  -- Declare Constant
  -- ===============================

  -- ===============================
  -- Declare Variable
  -- ===============================

  --################################################################################################

  /*************************************************************************************************
  *
  * procedure name : pro_insert_tran_iface
  * description   : 插入事务处理接口表，被发料/退料form上调用，form上不能直接用这种写法
  *
  ************************************************************************************************/
  PROCEDURE Pro_Insert_Tran_Iface(Ir_Tran_Iface IN Mtl_Transactions_Interface%ROWTYPE) IS
  BEGIN
    INSERT INTO Mtl_Transactions_Interface VALUES Ir_Tran_Iface;
  
  END Pro_Insert_Tran_Iface;

  --################################################################################################

  /*************************************************************************************************
  *
  * procedure name : pro_insert_lots_iface
  * description   : 插入批次接口表，被发料/退料form上调用，form上不能直接用这种写法
  *
  ************************************************************************************************/
  PROCEDURE Pro_Insert_Lots_Iface(Ir_Lots_Iface IN Mtl_Transaction_Lots_Interface%ROWTYPE) IS
  BEGIN
    INSERT INTO Mtl_Transaction_Lots_Interface VALUES Ir_Lots_Iface;
  
  END Pro_Insert_Lots_Iface;

  --################################################################################################

  /*************************************************************************************************
  *
  * procedure name : pro_insert_serials_iface
  * description   : 插入序列接口表，被发料/退料form上调用，form上不能直接用这种写法
  *
  ************************************************************************************************/
  PROCEDURE Pro_Insert_Serials_Iface(Ir_Serials_Iface IN Mtl_Serial_Numbers_Interface%ROWTYPE) IS
  BEGIN
    INSERT INTO Mtl_Serial_Numbers_Interface VALUES Ir_Serials_Iface;
  
  END Pro_Insert_Serials_Iface;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_jj_lot_price
  * description   : 获取基建组织下的批次价格
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Jj_Lot_Price(In_Organization_Id   IN NUMBER, --库存组织
                                In_Inventory_Item_Id IN NUMBER, --物资
                                Iv_Lot_Number        IN VARCHAR2 --批次
                                ) RETURN NUMBER IS
    Lv_Org_Type VARCHAR2(80); --库存组织类型
    Ln_Price    NUMBER;
  BEGIN
    SELECT Ciotv.Org_Type
      INTO Lv_Org_Type
      FROM Cux_Inv_Orgs_Type_v Ciotv
     WHERE Ciotv.Organization_Id = In_Organization_Id;
  
    IF Lv_Org_Type <> 'JJ' THEN
      --如果不是基建组织，则直接返回空
      RETURN NULL;
    END IF;
  
    --通过基建合同那边获取批次价格
    Ln_Price := 0; /*cux_public_pkg.get_contract_list_price(in_organization_id,
                                                                                                                                                                                                                                                                                                                         iv_lot_number,
                                                                                                                                                                                                                                                                                                                         in_inventory_item_id);*/
    IF Ln_Price IS NULL THEN
      --如果价格为空，则从杂入事务处理获取该物资该批次的加权平均价
      SELECT SUM(Mmt.Transaction_Quantity * Mmt.Actual_Cost) /
             SUM(Mmt.Transaction_Quantity)
        INTO Ln_Price
        FROM Mtl_Material_Transactions   Mmt,
             Mtl_Transaction_Lot_Numbers Mtln
       WHERE Mmt.Organization_Id = In_Organization_Id
         AND Mmt.Inventory_Item_Id = In_Inventory_Item_Id
         AND Mmt.Transaction_Action_Id = 27 --接收至库存
         AND Mtln.Transaction_Id = Mmt.Transaction_Id
         AND Mtln.Lot_Number = Iv_Lot_Number;
    END IF;
  
    RETURN Ln_Price;
  
  END Fnk_Get_Jj_Lot_Price;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_txn_status
  * description   : 获取发料状态
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Txn_Status(Iv_Type      IN VARCHAR2, --来源: 工单/领料申请单/需求申请
                              In_Header_Id IN NUMBER --头id
                              ) RETURN VARCHAR2 IS
    Ln_Line_Count NUMBER; --行总数
    Ln_Count      NUMBER;
  BEGIN
    IF Iv_Type IN ('工单', '领料申请') THEN
      SELECT COUNT(1)
        INTO Ln_Line_Count --获取行数
        FROM Cux_Inv_Mo_Lines Ciml
       WHERE Ciml.Header_Id = In_Header_Id;
    
      IF Ln_Line_Count > 0 THEN
        --如果工单有预留行则判断行是否已经都发完了
        SELECT COUNT(1)
          INTO Ln_Count --获取已发完的行数
          FROM Cux_Inv_Mo_Lines Ciml
         WHERE Ciml.Header_Id = In_Header_Id
           AND Nvl(Ciml.Quantity_Out, 0) - Nvl(Ciml.Quantity_Back, 0) -
               Nvl(Ciml.Quantity, 0) >= 0;
        IF Ln_Count = Ln_Line_Count THEN
          RETURN '已发完';
        ELSE
          SELECT COUNT(1)
            INTO Ln_Count --获取发过料的行数
            FROM Cux_Inv_Mo_Lines Ciml
           WHERE Ciml.Header_Id = In_Header_Id
             AND Nvl(Ciml.Quantity_Out, 0) - Nvl(Ciml.Quantity_Back, 0) > 0;
          IF Ln_Count > 0 THEN
            RETURN '已发料';
          ELSE
            RETURN '未发料';
          END IF; --IF ln_count > 0 THEN
        END IF; --IF ln_count = ln_line_count THEN
      ELSE
        --如果工单没有预留行，则从mtl_material_transactions中判断
        SELECT COUNT(1)
          INTO Ln_Count
          FROM Mtl_Material_Transactions Mmt,
               Cux_Inv_Mo_Headers        Cimh
         WHERE Cimh.Mo_Code = Mmt.Attribute2
           AND Cimh.Mo_Type = Mmt.Source_Code
           AND Cimh.Header_Id = In_Header_Id;
        IF Ln_Count > 0 THEN
          RETURN '已发料';
        ELSE
          RETURN '未发料';
        END IF;
      END IF; --IF ln_line_count > 0 THEN
    ELSIF Iv_Type = '需求申请' THEN
      SELECT COUNT(1)
        INTO Ln_Line_Count --获取行数
        FROM Cux_Inv_Demand_Lines Cidl
       WHERE Cidl.Header_Id = In_Header_Id;
    
      SELECT COUNT(1)
        INTO Ln_Count --获取已发完的行数
        FROM Cux_Inv_Demand_Lines Cidl
       WHERE Cidl.Header_Id = In_Header_Id
         AND Nvl(Cidl.Quantity_Out, 0) - Nvl(Cidl.Quantity_Back, 0) -
             Nvl(Cidl.Req_Quantity, 0) >= 0;
      IF Ln_Count = Ln_Line_Count THEN
        RETURN '已发完';
      ELSE
        SELECT COUNT(1)
          INTO Ln_Count --获取发过料的行数
          FROM Cux_Inv_Demand_Lines Cidl
         WHERE Cidl.Header_Id = In_Header_Id
           AND Nvl(Cidl.Quantity_Out, 0) - Nvl(Cidl.Quantity_Back, 0) > 0;
        IF Ln_Count > 0 THEN
          RETURN '已发料';
        ELSE
          RETURN '未发料';
        END IF; --IF ln_count > 0 THEN
      END IF; --IF ln_count = ln_line_count THEN
    END IF; --IF iv_type IN ('工单', '领料申请单') THEN
  END Fnk_Get_Txn_Status;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_expenditure_type
  * description   : 获取支出类型
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Expenditure_Type(Iv_Item_Type  IN VARCHAR2, --物资类型
                                    In_Project_Id IN NUMBER --项目
                                    ) RETURN VARCHAR2 IS
    Lv_Project_Type     VARCHAR2(80);
    Lv_Expenditure_Type VARCHAR2(80);
  BEGIN
    --获取项目类型
    SELECT Ppa.Project_Type
      INTO Lv_Project_Type
      FROM Pa_Projects_All Ppa
     WHERE Ppa.Project_Id = In_Project_Id;
  
    --获取支出类型
    SELECT Decode(Lv_Project_Type,
                  '大修项目',
                  Ffvv.Attribute1,
                  '架修项目',
                  Ffvv.Attribute2,
                  '基建项目',
                  Ffvv.Attribute3)
      INTO Lv_Expenditure_Type
      FROM Fnd_Lookup_Values_Vl Ffvv
     WHERE Ffvv.Lookup_Type = 'ITEM_TYPE'
       AND Ffvv.Lookup_Code = Iv_Item_Type;
  
    RETURN Lv_Expenditure_Type;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END Fnk_Get_Expenditure_Type;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_def_expenditure_type
  * description   : 获取委外修发票工单成本默认支出类型
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Def_Expenditure_Type(In_Project_Id IN NUMBER --项目
                                        ) RETURN VARCHAR2 IS
    Lv_Project_Type     VARCHAR2(80);
    Lv_Expenditure_Type VARCHAR2(80);
  BEGIN
    --获取项目类型
    SELECT Ppa.Project_Type
      INTO Lv_Project_Type
      FROM Pa_Projects_All Ppa
     WHERE Ppa.Project_Id = In_Project_Id;
  
    --获取支出类型
    SELECT Pet.Expenditure_Type
      INTO Lv_Expenditure_Type
      FROM Pa_Expenditure_Types Pet
     WHERE Decode(Lv_Project_Type,
                  '大修项目',
                  Pet.Attribute1,
                  '架修项目',
                  Pet.Attribute2) = 'Y';
  
    RETURN Lv_Expenditure_Type;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END Fnk_Get_Def_Expenditure_Type;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_expenditure_org_id
  * description   : 获取支出组织
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Expenditure_Org_Id(In_Project_Id IN NUMBER --项目
                                      ) RETURN NUMBER IS
    Ln_Expenditure_Org_Id NUMBER;
  BEGIN
    --默认项目组织就是支出组织
    SELECT Ppa.Carrying_Out_Organization_Id
      INTO Ln_Expenditure_Org_Id
      FROM Pa_Projects_All Ppa
     WHERE Ppa.Project_Id = In_Project_Id;
  
    RETURN Ln_Expenditure_Org_Id;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END Fnk_Get_Expenditure_Org_Id;

  --################################################################################################

  /*************************************************************************************************
  *
  * function name : fnk_get_account_id
  * description   : 获取成本科目
  *
  ************************************************************************************************/
  FUNCTION Fnk_Get_Account_Id(Iv_Source_Type     IN VARCHAR2, --来源: 库存/发票
                              In_Organization_Id IN NUMBER, --库存组织
                              In_Item_Id         IN NUMBER, --物料ID
                              Iv_Item_Category1  IN VARCHAR2, --物资大类
                              Iv_Item_Category2  IN VARCHAR2, --物资中类
                              Iv_Item_Type       IN VARCHAR2, --物资类型
                              Iv_Apply_User_Id   IN VARCHAR2, --申请人
                              In_Dept_Code       IN VARCHAR2, --部门
                              In_Inv_Code        IN VARCHAR2, --子库
                              In_Asset_Flag      IN VARCHAR2, --固定资产
                              In_Project_Id      IN NUMBER, --项目
                              In_Task_Id         IN NUMBER, --任务
                              Ov_Error_Message   OUT VARCHAR2 --错误消息
                              ) RETURN NUMBER IS
    Lv_Organization_Name  VARCHAR2(240); --库存组织名
    Ln_Org_Id             NUMBER; --OU
    Ln_Ledger_Id          NUMBER; --帐套
    Ln_Struct_Num         NUMBER; --科目结构
    Ln_Count              NUMBER := 0; --科目段数
    Lv_Delimiter          VARCHAR2(10) := '.'; --科目段的间隔符
    Lv_Segment            VARCHAR2(80); --段值
    Ln_Sub_Dept_Id        NUMBER; --分部汇总段
    Lv_Flex_Seg           VARCHAR2(2000); --科目结构组合段
    Lv_Error_Msg          VARCHAR2(2000); --错误内容
    Lv_Project_Num        VARCHAR2(80); --项目编号
    Lv_Task_Number        VARCHAR2(80); --任务编号
    Lv_Expenditure_Type   VARCHAR2(80); --支出类型
    Ln_Expenditure_Org_Id NUMBER; --支出组织
    Ln_Dept_Code VARCHAR2(100) := NULL;  --add 20140712
  
    Ln_Ccid    NUMBER; --科目id
    l_Segment1 VARCHAR2(30); --公司段
    l_Segment7 VARCHAR2(30) := '1'; --线路
    l_Segment2 VARCHAR2(30); --部门段
    l_Segment3 VARCHAR2(30); --科目段
    l_Asset_Sg VARCHAR2(30) := '1601990101'; --资产中转科目
    l_b_Seg3   VARCHAR2(30); --借料科目段
  BEGIN
    Ov_Error_Message := NULL;
    --获取OU，库存组织名，帐套，科目结构
    SELECT Ood.Operating_Unit,
           Ood.Organization_Name,
           Ood.Set_Of_Books_Id,
           Ood.Chart_Of_Accounts_Id
      INTO Ln_Org_Id,
           Lv_Organization_Name,
           Ln_Ledger_Id,
           Ln_Struct_Num
      FROM Org_Organization_Definitions Ood
     WHERE Ood.Organization_Id = In_Organization_Id;
  
    IF Lv_Organization_Name LIKE '%食堂%' THEN
      Lv_Flex_Seg := Cux_Inv_Auto_Ccid(In_Organization_Id,
                                       In_Item_Id,
                                       In_Inv_Code);
    
      IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                       Appl_Short_Name  => 'SQLGL',
                                       Key_Flex_Code    => 'GL#',
                                       Structure_Number => Ln_Struct_Num,
                                       Concat_Segments  => Lv_Flex_Seg) THEN
        --根据lv_flex_seg获取ccid
        Ln_Ccid := Fnd_Flex_Ext.Get_Ccid('SQLGL',
                                         'GL#',
                                         Ln_Struct_Num,
                                         NULL,
                                         Lv_Flex_Seg);
      END IF;
    
      IF Nvl(Ln_Ccid, 0) <= 0 THEN
        Ov_Error_Message := '获取科目组合失败' || Lv_Flex_Seg;
        --Raise_Application_Error(-20001, '获取科目组合失败' || Lv_Flex_Seg);
      END IF;
      RETURN Ln_Ccid;
    END IF;
  
    IF In_Asset_Flag = '是' THEN
      SELECT MAX(Glns.Segment_Value)
        INTO l_Segment1
        FROM Hr_Operating_Units      Hou,
             Gl_Ledger_Norm_Seg_Vals Glns
       WHERE Hou.Organization_Id = Ln_Org_Id
         AND Hou.Default_Legal_Context_Id = Glns.Legal_Entity_Id
         AND Glns.Segment_Type_Code = 'B'
         AND Nvl(Glns.Start_Date, SYSDATE) <= SYSDATE
         AND Nvl(Glns.End_Date, SYSDATE) >= SYSDATE;
    
      Lv_Flex_Seg := l_Segment1 || '.0.' || l_Asset_Sg || '.0.0.0.0.0';
    
      IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                       Appl_Short_Name  => 'SQLGL',
                                       Key_Flex_Code    => 'GL#',
                                       Structure_Number => Ln_Struct_Num,
                                       Concat_Segments  => Lv_Flex_Seg) THEN
        --根据lv_flex_seg获取ccid
        Ln_Ccid := Fnd_Flex_Ext.Get_Ccid('SQLGL',
                                         'GL#',
                                         Ln_Struct_Num,
                                         NULL,
                                         Lv_Flex_Seg);
      END IF;
    
      IF Nvl(Ln_Ccid, 0) <= 0 THEN
        Ov_Error_Message := '获取科目组合失败' || Lv_Flex_Seg;
        --Raise_Application_Error(-20001, '获取科目组合失败' || Lv_Flex_Seg);
      END IF;
    
      RETURN Ln_Ccid;
    END IF;
  
    IF In_Project_Id IS NULL THEN
      Lv_Delimiter := Fnd_Flex_Ext.Get_Delimiter('SQLGL',
                                                 'GL#',
                                                 Ln_Struct_Num);
    
      IF Iv_Item_Type = 'NWZ' THEN
        /*BEGIN
          SELECT Sm.Segment1,
                 Sm.Segment3
            INTO l_Segment1,
                 l_Segment3
            FROM Cux_Inv_Req_Acc_Map Sm
           WHERE Sm.Organization_Id = In_Organization_Id
             AND Sm.Item_Category1 = Iv_Item_Category1
             AND Sm.Item_Category2 = Iv_Item_Category2
             AND Rownum = 1;
        EXCEPTION
          WHEN OTHERS THEN
            Raise_Application_Error(-20001,
                                    '没有定义非生产性物资类别的发料科目');
        END;
        
        --获取到申请人, 查找其对应的默认成本中心
        BEGIN
          SELECT Gcc.Segment2
            INTO l_Segment2
            FROM Per_Workforce_Current_x  Pwc,
                 Gl_Code_Combinations_Kfv Gcc,
                 Fnd_User                 Fu
           WHERE Pwc.Person_Id = Fu.Employee_Id
             AND Pwc.Default_Code_Combination_Id = Gcc.Code_Combination_Id
             AND Fu.User_Id = Iv_Apply_User_Id
             AND Rownum = 1;
        
        EXCEPTION
          WHEN OTHERS THEN
            l_Segment2 := '0';
        END;
        
        Lv_Flex_Seg := Nvl(l_Segment1, '0') || Lv_Delimiter ||
                       Nvl(l_Segment2, '0') || Lv_Delimiter ||
                       Nvl(l_Segment3, '0') || Lv_Delimiter || '0' ||
                       Lv_Delimiter || '0' || Lv_Delimiter || '0' ||
                       Lv_Delimiter || '0' || Lv_Delimiter || '0';*/
        BEGIN
          SELECT Nvl(Sm.Segment1, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment2, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment3, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment4, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment5, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment6, '0') || Lv_Delimiter ||
                 Nvl(l_Segment7, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment8, '0')
            INTO Lv_Flex_Seg
            FROM Cux_Inv_Req_Acc_Map Sm,
                 Fnd_Flex_Values_Vl  V1,
                 Fnd_Flex_Value_Sets S1
           WHERE Sm.Segment2 = V1.Attribute3
             AND V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
             AND S1.Flex_Value_Set_Name = 'SZMTR_COMPANY_ARCH'
             AND V1.Enabled_Flag = 'Y'
             AND V1.Flex_Value <> '0'
             AND V1.Hierarchy_Level = '1' --分部
             AND V1.Flex_Value = In_Dept_Code
             AND Trunc(SYSDATE) BETWEEN
                 Nvl(V1.Start_Date_Active, Trunc(SYSDATE)) AND
                 Nvl(V1.End_Date_Active, Trunc(SYSDATE))
             AND Sm.Item_Category1 = Iv_Item_Category1
             AND Sm.Item_Category2 = Iv_Item_Category2
             AND Sm.Organization_Id = In_Organization_Id
             AND Rownum = 1;
        EXCEPTION
          WHEN OTHERS THEN
            Ov_Error_Message := '没有定义非生产性物资类别的发料科目';
            --Raise_Application_Error(-20001, '没有定义非成产物资类别的发料科目');
        END;
      
        --add 20140712
        IF Lv_Flex_Seg IS NULL THEN
          BEGIN
            SELECT DISTINCT C2.FLEX_VALUE
              INTO Ln_Dept_Code
              FROM CUX_INV_USER_DEPT_MAP_V C1,
                   CUX_INV_DEPTS_V C2
             WHERE C1.DEPT_ID = C2.FLEX_VALUE_ID
               AND C1.ORGANIZATION_ID = In_Organization_Id
               AND C1.INV_SUB = In_Inv_Code;
         EXCEPTION
              WHEN OTHERS THEN
                Ov_Error_Message := In_Inv_Code||'-人员班组映射返回0条或多条记录';
          END;
          IF Ln_Dept_Code IS NOT NULL THEN
          BEGIN
          SELECT Nvl(Sm.Segment1, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment2, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment3, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment4, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment5, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment6, '0') || Lv_Delimiter ||
                 Nvl(l_Segment7, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment8, '0')
            INTO Lv_Flex_Seg
            FROM Cux_Inv_Req_Acc_Map Sm,
                 Fnd_Flex_Values_Vl  V1,
                 Fnd_Flex_Value_Sets S1
           WHERE Sm.Segment2 = V1.Attribute3
             AND V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
             AND S1.Flex_Value_Set_Name = 'SZMTR_COMPANY_ARCH'
             AND V1.Enabled_Flag = 'Y'
             AND V1.Flex_Value <> '0'
             AND V1.Hierarchy_Level = '1' --分部
             AND V1.Flex_Value = Ln_Dept_Code
             AND Trunc(SYSDATE) BETWEEN
                 Nvl(V1.Start_Date_Active, Trunc(SYSDATE)) AND
                 Nvl(V1.End_Date_Active, Trunc(SYSDATE))
             AND Sm.Item_Category1 = Iv_Item_Category1
             AND Sm.Item_Category2 = Iv_Item_Category2
             AND Sm.Organization_Id = In_Organization_Id
             AND Rownum = 1;
          EXCEPTION
            WHEN OTHERS THEN
              Ov_Error_Message := '没有定义非成产物资类别的发料科目';
            END;
          END IF;
        END IF;
        --add end
        
        
        IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                         Appl_Short_Name  => 'SQLGL',
                                         Key_Flex_Code    => 'GL#',
                                         Structure_Number => Ln_Struct_Num,
                                         Concat_Segments  => Lv_Flex_Seg) THEN
          --根据lv_flex_seg获取ccid
          Ln_Ccid := Fnd_Flex_Ext.Get_Ccid('SQLGL',
                                           'GL#',
                                           Ln_Struct_Num,
                                           NULL,
                                           Lv_Flex_Seg);
        END IF;
      
        IF Nvl(Ln_Ccid, 0) <= 0 THEN
          Ov_Error_Message := '获取科目组合失败' || Lv_Flex_Seg;
          --Raise_Application_Error(-20001,'获取科目组合失败' || Lv_Flex_Seg);
        END IF;
      
      ELSE
      
        --获得线路
        BEGIN
          SELECT To_Char(To_Number(Substr(In_Inv_Code, 2, 2)))
            INTO l_Segment7
            FROM Dual;
        EXCEPTION
          WHEN OTHERS THEN
            l_Segment7 := '0';
        END;
      
        BEGIN
        
          SELECT Nvl(Sm.Segment1, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment2, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment3, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment4, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment5, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment6, '0') || Lv_Delimiter ||
                 Nvl(l_Segment7, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment8, '0')
            INTO Lv_Flex_Seg
            FROM Cux_Inv_Gl_Segment_Map Sm,
                 Fnd_Flex_Values_Vl     V1,
                 Fnd_Flex_Value_Sets    S1
           WHERE Sm.Segment2 = V1.Attribute3
             AND V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
             AND S1.Flex_Value_Set_Name = 'SZMTR_COMPANY_ARCH'
             AND V1.Enabled_Flag = 'Y'
             AND V1.Flex_Value <> '0'
             AND V1.Hierarchy_Level = '1' --分部
             AND V1.Flex_Value = In_Dept_Code
             AND Trunc(SYSDATE) BETWEEN
                 Nvl(V1.Start_Date_Active, Trunc(SYSDATE)) AND
                 Nvl(V1.End_Date_Active, Trunc(SYSDATE))
             AND Sm.Item_Category1 = Iv_Item_Category1
             AND Sm.Organization_Id = In_Organization_Id
             AND Rownum = 1;
          -- Dbms_Output.Put_Line(Lv_Flex_Seg);
          IF Lv_Error_Msg IS NOT NULL THEN
            Raise_Application_Error(-20001, Lv_Error_Msg || Lv_Flex_Seg);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            Ov_Error_Message := '没有定义成产物资类别的发料科目';
            -- Raise_Application_Error(-20001,'没有定义生产物资类别的发料科目');
        END;
      
        --add 20140712
        IF Lv_Flex_Seg IS NULL THEN
          BEGIN
            SELECT DISTINCT C2.FLEX_VALUE
              INTO Ln_Dept_Code
              FROM CUX_INV_USER_DEPT_MAP_V C1,
                   CUX_INV_DEPTS_V C2
             WHERE C1.DEPT_ID = C2.FLEX_VALUE_ID
               AND C1.ORGANIZATION_ID = In_Organization_Id
               AND C1.INV_SUB = In_Inv_Code;
         EXCEPTION
              WHEN OTHERS THEN
                Ov_Error_Message := In_Inv_Code||'-人员班组映射返回0条或多条记录';   
          END;
          IF Ln_Dept_Code IS NOT NULL THEN
          BEGIN
          SELECT Nvl(Sm.Segment1, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment2, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment3, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment4, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment5, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment6, '0') || Lv_Delimiter ||
                 Nvl(l_Segment7, '0') || Lv_Delimiter ||
                 Nvl(Sm.Segment8, '0')
            INTO Lv_Flex_Seg
            FROM Cux_Inv_Gl_Segment_Map Sm,
                 Fnd_Flex_Values_Vl     V1,
                 Fnd_Flex_Value_Sets    S1
           WHERE Sm.Segment2 = V1.Attribute3
             AND V1.Flex_Value_Set_Id = S1.Flex_Value_Set_Id
             AND S1.Flex_Value_Set_Name = 'SZMTR_COMPANY_ARCH'
             AND V1.Enabled_Flag = 'Y'
             AND V1.Flex_Value <> '0'
             AND V1.Hierarchy_Level = '1' --分部
             AND V1.Flex_Value = Ln_Dept_Code
             AND Trunc(SYSDATE) BETWEEN
                 Nvl(V1.Start_Date_Active, Trunc(SYSDATE)) AND
                 Nvl(V1.End_Date_Active, Trunc(SYSDATE))
             AND Sm.Item_Category1 = Iv_Item_Category1
             AND Sm.Organization_Id = In_Organization_Id
             AND Rownum = 1;
          EXCEPTION
            WHEN OTHERS THEN
              Ov_Error_Message := '没有定义非成产物资类别的发料科目';
            END;
          END IF;
        END IF;
        --add end
        
        
        IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                         Appl_Short_Name  => 'SQLGL',
                                         Key_Flex_Code    => 'GL#',
                                         Structure_Number => Ln_Struct_Num,
                                         Concat_Segments  => Lv_Flex_Seg) THEN
          --根据lv_flex_seg获取ccid
          Ln_Ccid := Fnd_Flex_Ext.Get_Ccid('SQLGL',
                                           'GL#',
                                           Ln_Struct_Num,
                                           NULL,
                                           Lv_Flex_Seg);
        
        END IF;
      
        IF Nvl(Ln_Ccid, 0) <= 0 THEN
          Ov_Error_Message := '获取科目组合失败' || Lv_Flex_Seg;
          -- Raise_Application_Error(-20001,'获取科目组合失败' || Lv_Flex_Seg);
        END IF;
      END IF;
    
    ELSE
      --获取项目编号
      SELECT Ppa.Segment1
        INTO Lv_Project_Num
        FROM Pa_Projects_All Ppa
       WHERE Ppa.Project_Id = In_Project_Id;
    
      --获取任务编号
      SELECT Pt.Task_Number
        INTO Lv_Task_Number
        FROM Pa_Tasks Pt
       WHERE Pt.Task_Id = In_Task_Id;
    
      --获取支出类型
      IF Iv_Source_Type = '库存' THEN
        Lv_Expenditure_Type := Fnk_Get_Expenditure_Type(Iv_Item_Type,
                                                        In_Project_Id);
      ELSE
        Lv_Expenditure_Type := Fnk_Get_Def_Expenditure_Type(In_Project_Id);
      END IF;
      IF Lv_Expenditure_Type IS NULL THEN
        Raise_Application_Error(-20001, '获取支出类型失败');
      END IF;
    
      --获取支出组织(通过找查找集反查)
      Ln_Expenditure_Org_Id := Fnk_Get_Expenditure_Org_Id(In_Project_Id);
      IF Ln_Expenditure_Org_Id IS NULL THEN
        Raise_Application_Error(-20001, '获取支出组织失败');
      END IF;
    
      --modified by DINYA 2012-02-07
      Ln_Ccid := ''; /*cux_gl_to_pa.generate_account --根据会计规则获取费用科目
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (p_org_id           => ln_org_id, --OU
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      p_task_number      => lv_task_number,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      p_expenditure_type => lv_expenditure_type,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      p_return_type      => NULL,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      p_exp_org_id       => ln_expenditure_org_id,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      p_segment8         => lv_project_num);*/
    
      IF Nvl(Ln_Ccid, 0) <= 0 THEN
        Raise_Application_Error(-20001,
                                '自动会计获取科目组合失败' || Ln_Ccid);
      END IF;
    
    END IF; --IF in_project_id IS NULL THEN
  
    RETURN Ln_Ccid;
  
  EXCEPTION
    WHEN OTHERS THEN
      Raise_Application_Error(-20001,
                              '获取科目组合失败' || Chr(10) || SQLERRM);
  END Fnk_Get_Account_Id;

  /*************************************************************************************************
  *
  * function name : Get_BR_Account_Id
  * description   : 获取借料成本科目
  *
  ************************************************************************************************/
  FUNCTION Get_Br_Account_Id(In_Organization_Id IN NUMBER, --库存组织
                             In_Inv_Code        IN VARCHAR2, --子库
                             Ov_Error_Message   OUT VARCHAR2 --错误消息
                             ) RETURN NUMBER IS
    Lv_Organization_Name  VARCHAR2(240); --库存组织名
    Ln_Org_Id             NUMBER; --OU
    Ln_Ledger_Id          NUMBER; --帐套
    Ln_Struct_Num         NUMBER; --科目结构
    Ln_Count              NUMBER := 0; --科目段数
    Lv_Delimiter          VARCHAR2(10) := '.'; --科目段的间隔符
    Lv_Segment            VARCHAR2(80); --段值
    Ln_Sub_Dept_Id        NUMBER; --分部汇总段
    Lv_Flex_Seg           VARCHAR2(2000); --科目结构组合段
    Lv_Error_Msg          VARCHAR2(2000); --错误内容
    Lv_Project_Num        VARCHAR2(80); --项目编号
    Lv_Task_Number        VARCHAR2(80); --任务编号
    Lv_Expenditure_Type   VARCHAR2(80); --支出类型
    Ln_Expenditure_Org_Id NUMBER; --支出组织
  
    Ln_Ccid    NUMBER; --科目id
    l_Segment1 VARCHAR2(30); --公司段
    l_Segment7 VARCHAR2(30) := '1'; --线路
    l_Segment2 VARCHAR2(30); --部门段
    l_Segment3 VARCHAR2(30); --科目段
    l_Asset_Sg VARCHAR2(30) := '1601990101'; --资产中转科目
    l_b_Seg3   VARCHAR2(30) := '1221060101'; --借料科目段
  BEGIN
    Ov_Error_Message := NULL;
    --获取OU，库存组织名，帐套，科目结构
    SELECT Ood.Operating_Unit,
           Ood.Organization_Name,
           Ood.Set_Of_Books_Id,
           Ood.Chart_Of_Accounts_Id
      INTO Ln_Org_Id,
           Lv_Organization_Name,
           Ln_Ledger_Id,
           Ln_Struct_Num
      FROM Org_Organization_Definitions Ood
     WHERE Ood.Organization_Id = In_Organization_Id;
  
    --获得公司段
    BEGIN
      SELECT MAX(Glns.Segment_Value)
        INTO l_Segment1
        FROM Hr_Operating_Units      Hou,
             Gl_Ledger_Norm_Seg_Vals Glns
       WHERE Hou.Organization_Id = Ln_Org_Id
         AND Hou.Default_Legal_Context_Id = Glns.Legal_Entity_Id
         AND Glns.Segment_Type_Code = 'B'
         AND Nvl(Glns.Start_Date, SYSDATE) <= SYSDATE
         AND Nvl(Glns.End_Date, SYSDATE) >= SYSDATE;
    EXCEPTION
      WHEN OTHERS THEN
        l_Segment1 := '0';
    END;
    --获得线路
    BEGIN
      SELECT To_Char(To_Number(Substr(In_Inv_Code, 2, 2)))
        INTO l_Segment7
        FROM Dual;
    EXCEPTION
      WHEN OTHERS THEN
        l_Segment7 := '0';
    END;
  
    BEGIN
    
      SELECT Nvl(l_Segment1, '0') || Lv_Delimiter || '0' || Lv_Delimiter ||
             Nvl(l_b_Seg3, '0') || Lv_Delimiter || '0' || Lv_Delimiter || '0' ||
             Lv_Delimiter || '0' || Lv_Delimiter || Nvl(l_Segment7, '0') ||
             Lv_Delimiter || '0'
        INTO Lv_Flex_Seg
        FROM Dual;
      -- Dbms_Output.Put_Line(Lv_Flex_Seg);
      IF Lv_Error_Msg IS NOT NULL THEN
        Raise_Application_Error(-20001, Lv_Error_Msg || Lv_Flex_Seg);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        Ov_Error_Message := '没有定义成产物资类别的发料科目';
        -- Raise_Application_Error(-20001,'没有定义生产物资类别的发料科目');
    END;
  
    IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                     Appl_Short_Name  => 'SQLGL',
                                     Key_Flex_Code    => 'GL#',
                                     Structure_Number => Ln_Struct_Num,
                                     Concat_Segments  => Lv_Flex_Seg) THEN
      --根据lv_flex_seg获取ccid
      Ln_Ccid := Fnd_Flex_Ext.Get_Ccid('SQLGL',
                                       'GL#',
                                       Ln_Struct_Num,
                                       NULL,
                                       Lv_Flex_Seg);
    
    END IF;
  
    IF Nvl(Ln_Ccid, 0) <= 0 THEN
      Ov_Error_Message := '获取科目组合失败' || Lv_Flex_Seg;
      -- Raise_Application_Error(-20001,'获取科目组合失败' || Lv_Flex_Seg);
    END IF;
  
    RETURN Ln_Ccid;
  
  EXCEPTION
    WHEN OTHERS THEN
      Raise_Application_Error(-20001,
                              '获取科目组合失败' || Chr(10) || SQLERRM);
  END Get_Br_Account_Id;

  FUNCTION Fnk_Get_Pa_Acc_Id(p_Organization_Id IN NUMBER,
                             p_Project_Id      IN NUMBER,
                             p_Task_Id         IN NUMBER,
                             p_Pa_Type         IN VARCHAR2,
                             Ov_Error_Message  OUT VARCHAR2) RETURN NUMBER IS
    Lv_Delimiter    VARCHAR2(1) := '.';
    v_Coa_Id        NUMBER;
    v_Segment       VARCHAR2(80);
    v_Segment_Value VARCHAR2(2000);
    v_Sql_Statement VARCHAR2(2000);
    v_Expense_Acc   NUMBER;
    l_Segment3      VARCHAR2(30);
    Lv_Project_Num  VARCHAR2(30);
    l_Segment1      VARCHAR2(30);
  BEGIN
    SELECT Ood.Chart_Of_Accounts_Id
      INTO v_Coa_Id
      FROM Org_Organization_Definitions Ood
     WHERE Ood.Organization_Id = p_Organization_Id;
  
    Lv_Delimiter := Fnd_Flex_Ext.Get_Delimiter('SQLGL', 'GL#', v_Coa_Id);
  
    BEGIN
      SELECT MAX(Glns.Segment_Value)
        INTO l_Segment1
        FROM Hr_Operating_Units           Hou,
             Org_Organization_Definitions d,
             Gl_Ledger_Norm_Seg_Vals      Glns
       WHERE Hou.Organization_Id = d.Operating_Unit
         AND Hou.Default_Legal_Context_Id = Glns.Legal_Entity_Id
         AND Glns.Segment_Type_Code = 'B'
         AND d.Organization_Id = p_Organization_Id
         AND Nvl(Glns.Start_Date, SYSDATE) <= SYSDATE
         AND Nvl(Glns.End_Date, SYSDATE) >= SYSDATE;
    
      SELECT Ppa.Segment1
        INTO Lv_Project_Num
        FROM Pa_Projects_All Ppa
       WHERE Ppa.Project_Id = p_Project_Id;
    
      SELECT t.Segment_Value
        INTO l_Segment3
        FROM Pa_Segment_Value_Lookups     t,
             Pa_Segment_Value_Lookup_Sets s
       WHERE t.Segment_Value_Lookup_Set_Id = s.Segment_Value_Lookup_Set_Id
         AND s.Segment_Value_Lookup_Set_Name = 'SZMTR_YY_AC'
         AND t.Segment_Value_Lookup = p_Pa_Type;
    
    EXCEPTION
      WHEN OTHERS THEN
        Ov_Error_Message := '自动会计获取项目段失败';
    END;
  
    v_Segment_Value := '';
    FOR v_Segments IN (SELECT Fifs.Application_Id,
                              Fifs.Id_Flex_Code,
                              Fifs.Id_Flex_Num,
                              Fifs.Application_Column_Name Column_Name,
                              Fifs.Segment_Name,
                              Fifs.Segment_Num,
                              Fifs.Flex_Value_Set_Id
                         FROM Fnd_Id_Flex_Segments_Vl Fifs
                        WHERE Fifs.Id_Flex_Num = v_Coa_Id
                          AND Fifs.Application_Id = 101
                          AND Fifs.Id_Flex_Code = 'GL#'
                        ORDER BY Fifs.Segment_Num) LOOP
    
      IF v_Segments.Segment_Num = 1 THEN
        v_Segment := l_Segment1;
      ELSIF v_Segments.Segment_Num = 3 THEN
        v_Segment := l_Segment3;
      ELSIF v_Segments.Segment_Num = 5 THEN
        v_Segment := Lv_Project_Num;
      ELSE
        v_Segment := '0';
      END IF;
    
      v_Segment_Value := v_Segment_Value || Lv_Delimiter || v_Segment;
    END LOOP;
  
    v_Segment_Value := Ltrim(v_Segment_Value, Lv_Delimiter);
  
    IF Fnd_Flex_Keyval.Validate_Segs(Operation        => 'CREATE_COMBINATION',
                                     Appl_Short_Name  => 'SQLGL',
                                     Key_Flex_Code    => 'GL#',
                                     Structure_Number => v_Coa_Id,
                                     Concat_Segments  => v_Segment_Value) THEN
    
      v_Expense_Acc := Fnd_Flex_Ext.Get_Ccid(Application_Short_Name => 'SQLGL',
                                             Key_Flex_Code          => 'GL#',
                                             Structure_Number       => v_Coa_Id,
                                             Validation_Date        => NULL,
                                             Concatenated_Segments  => v_Segment_Value);
    END IF;
  
    IF Nvl(v_Expense_Acc, 0) <= 0 THEN
      Ov_Error_Message := '自动会计获取科目组合失败' || v_Segment_Value;
    END IF;
  
    RETURN v_Expense_Acc;
  END Fnk_Get_Pa_Acc_Id;

  /*************************************************************************************************
  *
  * function name : Gen_CK_Num
  * description   : 自动生成出库单号，CK+日期+0001
  *
  ************************************************************************************************/
  FUNCTION Gen_Ck_Num(In_Organization_Id IN NUMBER) RETURN VARCHAR2 IS
    l_Num     VARCHAR2(80) := NULL;
    l_Max_Num VARCHAR2(80) := NULL;
    l_Index   NUMBER := NULL;
  BEGIN
    UPDATE Cux_Inv_Doc_Numbers d
       SET d.Seq_Num = d.Seq_Num + 1
     WHERE d.Type_Code = 'CK'
    --AND d.Organization_Id = In_Organization_Id
    ;
  
    l_Num := 'CK' || To_Char(SYSDATE, 'YYYYMMDD');
  
    SELECT MAX(h.Doc_Number)
      INTO l_Max_Num
      FROM Cux_Inv_Ck_Numbers h
     WHERE h.Type_Code = 'CK'
          -- AND h.Organization_Id = In_Organization_Id
       AND Substr(h.Doc_Number, 1, 10) = l_Num;
    IF l_Max_Num IS NOT NULL THEN
      SELECT To_Number(Substr(l_Max_Num, 11)) INTO l_Index FROM Dual;
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number)
      VALUES
        (In_Organization_Id,
         'CK',
         l_Num || Lpad(l_Index + 1, 4, 0));
      RETURN l_Num || Lpad(l_Index + 1, 4, 0);
    ELSE
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number)
      VALUES
        (In_Organization_Id,
         'CK',
         l_Num || '0001');
      RETURN l_Num || '0001';
    END IF;
  
    --COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN l_Num || '0001';
  END Gen_Ck_Num;
  
  /*************************************************************************************************
  *
  * function name : Gen_CK_Num
  * description   : change by bin@IBM20131112 add dept name
  *
  ************************************************************************************************/
  FUNCTION Gen_Ck_Num(In_Organization_Id IN NUMBER, In_Dept_name varchar2) RETURN VARCHAR2 IS
    l_Num     VARCHAR2(80) := NULL;
    l_Max_Num VARCHAR2(80) := NULL;
    l_Index   NUMBER := NULL;
  BEGIN
    UPDATE Cux_Inv_Doc_Numbers d
       SET d.Seq_Num = d.Seq_Num + 1
     WHERE d.Type_Code = 'CK'
    --AND d.Organization_Id = In_Organization_Id
    ;
  
    l_Num := 'CK' || To_Char(SYSDATE, 'YYYYMMDD');
  
    SELECT MAX(h.Doc_Number)
      INTO l_Max_Num
      FROM Cux_Inv_Ck_Numbers h
     WHERE h.Type_Code = 'CK'
          -- AND h.Organization_Id = In_Organization_Id
       AND Substr(h.Doc_Number, 1, 10) = l_Num;
    IF l_Max_Num IS NOT NULL THEN
      SELECT To_Number(Substr(l_Max_Num, 11)) INTO l_Index FROM Dual;
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number,
         Dept_name)
      VALUES
        (In_Organization_Id,
         'CK',
         l_Num || Lpad(l_Index + 1, 4, 0),
         In_Dept_name);
      RETURN l_Num || Lpad(l_Index + 1, 4, 0);
    ELSE
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number,
         Dept_name)
      VALUES
        (In_Organization_Id,
         'CK',
         l_Num || '0001',
         In_Dept_name);
      RETURN l_Num || '0001';
    END IF;
  
    --COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN l_Num || '0001';
  END Gen_Ck_Num;

  /*************************************************************************************************
  *
  * function name : Gen_TK_Num
  * description   : 自动生成退库单号，TK+日期+0001
  *
  ************************************************************************************************/
  FUNCTION Gen_Tk_Num(In_Organization_Id IN NUMBER) RETURN VARCHAR2 IS
    l_Num     VARCHAR2(80) := NULL;
    l_Max_Num VARCHAR2(80) := NULL;
    l_Index   NUMBER := NULL;
  BEGIN
    UPDATE Cux_Inv_Doc_Numbers d
       SET d.Seq_Num = d.Seq_Num + 1
     WHERE d.Type_Code = 'TK'
    -- AND  d.Organization_Id = In_Organization_Id
    ;
  
    l_Num := 'TK' || To_Char(SYSDATE, 'YYYYMMDD');
  
    SELECT MAX(h.Doc_Number)
      INTO l_Max_Num
      FROM Cux_Inv_Ck_Numbers h
     WHERE h.Type_Code = 'TK'
          -- AND h.Organization_Id = In_Organization_Id
       AND Substr(h.Doc_Number, 1, 10) = l_Num;
    IF l_Max_Num IS NOT NULL THEN
      SELECT To_Number(Substr(l_Max_Num, 11)) INTO l_Index FROM Dual;
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number)
      VALUES
        (In_Organization_Id,
         'TK',
         l_Num || Lpad(l_Index + 1, 4, 0));
      RETURN l_Num || Lpad(l_Index + 1, 4, 0);
    ELSE
      INSERT INTO Cux_Inv_Ck_Numbers
        (Organization_Id,
         Type_Code,
         Doc_Number)
      VALUES
        (In_Organization_Id,
         'TK',
         l_Num || '0001');
      RETURN l_Num || '0001';
    END IF;
  
    --COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN l_Num || '0001';
  END Gen_Tk_Num;

  PROCEDURE Delete_Ck_Num(In_Number          IN VARCHAR2,
                          In_Organization_Id IN NUMBER) IS
  BEGIN
    DELETE FROM Cux_Inv_Ck_Numbers
     WHERE Type_Code = 'CK'
          -- AND Organization_Id = In_Organization_Id
       AND Doc_Number = In_Number;
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  PROCEDURE Delete_Tk_Num(In_Number          IN VARCHAR2,
                          In_Organization_Id IN NUMBER) IS
  BEGIN
    DELETE FROM Cux_Inv_Ck_Numbers
     WHERE Type_Code = 'TK'
          -- AND Organization_Id = In_Organization_Id
       AND Doc_Number = In_Number;
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  PROCEDURE Submit_Inv_Trx(p_Api_Version      IN NUMBER,
                           p_Init_Msg_List    IN VARCHAR2 := Fnd_Api.g_False,
                           p_Commit           IN VARCHAR2 := Fnd_Api.g_False,
                           p_Validation_Level IN NUMBER := Fnd_Api.g_Valid_Level_Full,
                           x_Return_Status    OUT NOCOPY VARCHAR2,
                           x_Msg_Count        OUT NOCOPY NUMBER,
                           x_Msg_Data         OUT NOCOPY VARCHAR2,
                           x_Trans_Count      OUT NOCOPY NUMBER,
                           p_Table            IN NUMBER := 1,
                           p_Header_Id        IN NUMBER,
                           p_Tran_Iface       IN Mtl_Transactions_Interface%ROWTYPE,
                           x_Return           OUT NUMBER) IS
    --自治事物
    --自治事务可以独立commit,不对外层事务产生影响，
    --同样外层事务的 rollback 也对自治事务没有影响。
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_Outcome           BOOLEAN;
    l_Error_Code        VARCHAR2(4000);
    l_Error_Explanation VARCHAR2(4000);
  BEGIN
    Cux_Inv_Txn_Pkg.Pro_Insert_Tran_Iface(p_Tran_Iface);
    --调用标准事务处理接口
    /*    l_Outcome := Mtl_Online_Transaction_Pub.Process_Online(p_Transaction_Header_Id => p_Header_Id,
                                                           p_Timeout               => 100,
                                                           p_Error_Code            => l_Error_Code,
                                                           p_Error_Explanation     => l_Error_Explanation);
    IF (l_Outcome = FALSE) THEN
      x_Return   := 1;
      x_Msg_Data := Substr(l_Error_Explanation, 1, 240);
    ELSE
      x_Return   := 0;
      x_Msg_Data := NULL;
    END IF;*/
    x_Return := Inv_Txn_Manager_Pub.Process_Transactions(p_Api_Version      => p_Api_Version,
                                                         p_Init_Msg_List    => p_Init_Msg_List,
                                                         p_Commit           => p_Commit,
                                                         p_Validation_Level => p_Validation_Level,
                                                         x_Return_Status    => x_Return_Status,
                                                         x_Msg_Count        => x_Msg_Count,
                                                         x_Msg_Data         => x_Msg_Data,
                                                         x_Trans_Count      => x_Trans_Count,
                                                         p_Table            => p_Table,
                                                         p_Header_Id        => p_Header_Id);
    COMMIT;
  END;

  PROCEDURE Insert_Number(p_Organization_Id IN NUMBER,
                          p_Type_Code       IN VARCHAR2,
                          p_Doc_Number      IN VARCHAR2,
                          p_Trx_Date        IN DATE,
                          p_Wo              IN VARCHAR2) IS
    --自治事物
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO Cux_Inv_Wo_Numbers
      (Organization_Id,
       Type_Code,
       Doc_Number,
       Trx_Date,
       Wo)
    VALUES
      (p_Organization_Id,
       p_Type_Code,
       p_Doc_Number,
       p_Trx_Date,
       p_Wo);
  
    COMMIT;
  END;

END Cux_Inv_Txn_Pkg;
/
