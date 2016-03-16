SELECT --flv.MEANING 导入时删除,
       msiv.concatenated_segments 物料编码
            ,msiv.description 物料名称
            --,'' 规格型号
            --,msiv.primary_uom_code 单位代码
            ,msiv.primary_unit_of_measure 单位名称
            ,ood.ORGANIZATION_CODE 库存组织
            ,decode(msiv.inventory_item_status_code, 'Active', '有效', 'Inactive', '无效', '') 状态
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',1) 一级分类代码
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',1)) 一级分类描述
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',2) 二级分类代码
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',1)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',2)) 二级分类描述
      ,cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',3) 三级分类代码
      ,cux_common_pkg.get_flex_value_desc('SZMTR_ITEM_CATEGORY',cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',1)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',2)||cux_common_pkg.get_delimiter_value(cux_common_pkg.get_item_category(msiv.organization_id, msiv.inventory_item_id, '库存'),'.',3)) 三级分类描述
      --,'' 四级代码
      --,'' 四级描述
           -- ,'' 政府目录物资
            --,'' 默认采购员代码
            --,'' 启用合格供应商
            --,'' 采购周期
            --,'' 是否批次管理
           -- ,'' 保质期
           -- ,'' 是否危化品
           -- ,'' 采购启动方式
           -- ,'' 最小库存
           -- ,'' 最大库存
           -- ,'' 最小采购数量
           -- ,'' 固定天数供应
           -- ,'' 固定批次增加
           -- ,'' 计划员
           -- ,'' 接收仓库
            --,'' 货位
            ,gcc.concatenated_segments 费用科目
            ,msiv.attribute1 是否固定资产
            ,msiv.attribute2 所属大类
            ,msiv.attribute4 是否总库直发物资
            --,msiv.attribute3 是否归口审批
            ,decode(msiv.ITEM_TYPE,'WZ','SZMTR_生产性物资模板' ,'NWZ','SZMTR_非生产性物资模板','ST','SZMTR_食堂类物资模板','') 模板
            ,msiv.long_description 技术要求
            ,msiv.ATTRIBUTE5 列管消耗
            ,msiv.ATTRIBUTE6 归口部门
            ,msiv.ATTRIBUTE7 是否危化
            ,msiv.LIST_PRICE_PER_UNIT 价目表价格
            --,'' 其他属性
            --,'N' 状态
      FROM mtl_system_items_vl          msiv
          ,org_organization_definitions ood
          ,gl_code_combinations_kfv     gcc
          ,fnd_lookup_values_vl flv
      WHERE 1=1
      and ood.ORGANIZATION_CODE = '301' 
      AND MSIV.ITEM_TYPE = 'WZ'
      --AND msiv.concatenated_segments LIKE '98%'
      --and substr(msiv.CONCATENATED_SEGMENTS,1,2) in ('31','32')
      --AND msiv.INVENTORY_ITEM_STATUS_CODE != 'Inactive'
      AND msiv.organization_id = ood.organization_id
      AND msiv.expense_account = gcc.code_combination_id(+)
      AND msiv.ITEM_TYPE = flv.LOOKUP_CODE(+)
      AND flv.LOOKUP_TYPE(+) = 'ITEM_TYPE'
     -- AND msiv.SEGMENT1='320031210004'    
    --AND msiv.description like '%空调%'
     ORDER BY 1,2
      

      
  
