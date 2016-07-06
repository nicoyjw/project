/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : sale

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-07-06 17:36:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for myr_action_code
-- ----------------------------
DROP TABLE IF EXISTS `myr_action_code`;
CREATE TABLE `myr_action_code` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `action_code` varchar(25) NOT NULL,
  `action_name` varchar(50) NOT NULL,
  `action_des` varchar(100) DEFAULT NULL,
  `action_type` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_action_code
-- ----------------------------
INSERT INTO `myr_action_code` VALUES ('9', 'load_case', '加载Case', '', '7');
INSERT INTO `myr_action_code` VALUES ('29', 'del_account', '删除账户', '', '1');
INSERT INTO `myr_action_code` VALUES ('28', 'edit_account', '编辑账户', '', '1');
INSERT INTO `myr_action_code` VALUES ('6', 'list_goods', '查看产品列表', '', '2');
INSERT INTO `myr_action_code` VALUES ('7', 'load_order', '加载订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('8', 'list_case', '查看Case', '', '7');
INSERT INTO `myr_action_code` VALUES ('12', 'list_user', '查看用户', '', '1');
INSERT INTO `myr_action_code` VALUES ('13', 'edit_user', '编辑用户', '', '1');
INSERT INTO `myr_action_code` VALUES ('14', 'del_user', '删除用户', '', '1');
INSERT INTO `myr_action_code` VALUES ('15', 'list_privilege', '权限列表管理', '', '1');
INSERT INTO `myr_action_code` VALUES ('16', 'edit_privilege', '编辑权限列表', '', '1');
INSERT INTO `myr_action_code` VALUES ('17', 'del_privilege', '删除权限列表', '', '1');
INSERT INTO `myr_action_code` VALUES ('18', 'list_privilegetype', '权限分类管理', '', '1');
INSERT INTO `myr_action_code` VALUES ('19', 'list_log', '查看系统日志', '', '1');
INSERT INTO `myr_action_code` VALUES ('20', 'list_dd', '查看基础环境', '', '1');
INSERT INTO `myr_action_code` VALUES ('21', 'edit_dd', '编辑基础环境', '', '1');
INSERT INTO `myr_action_code` VALUES ('22', 'del_dd', '删除基础项', '', '1');
INSERT INTO `myr_action_code` VALUES ('23', 'view_system', '查看系统设置', '', '1');
INSERT INTO `myr_action_code` VALUES ('24', 'edit_system', '编辑系统设置', '', '1');
INSERT INTO `myr_action_code` VALUES ('25', 'list_express', '查看快递规则', '', '1');
INSERT INTO `myr_action_code` VALUES ('26', 'edit_express', '编辑快递规则', '', '1');
INSERT INTO `myr_action_code` VALUES ('27', 'list_account', '查看账户', '', '1');
INSERT INTO `myr_action_code` VALUES ('31', 'edit_orderstatus', '审核订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('32', 'list_category', '产品品牌分类', '', '2');
INSERT INTO `myr_action_code` VALUES ('33', 'import_goods', '导入产品', '', '2');
INSERT INTO `myr_action_code` VALUES ('34', 'edit_category', '编辑品牌分类', '', '2');
INSERT INTO `myr_action_code` VALUES ('35', 'list_supplier', '查看供应商', '', '5');
INSERT INTO `myr_action_code` VALUES ('36', 'edit_supplier', '编辑供应商', '', '5');
INSERT INTO `myr_action_code` VALUES ('38', 'list_p_quote', '查看采购报价', '', '5');
INSERT INTO `myr_action_code` VALUES ('39', 'list_p_order', '查看采购订单', '', '5');
INSERT INTO `myr_action_code` VALUES ('40', 'add_p_order', '添加采购订单', '', '5');
INSERT INTO `myr_action_code` VALUES ('41', 'edit_p_order', '编辑采购订单', '', '5');
INSERT INTO `myr_action_code` VALUES ('42', 'list_stockin', '查看入库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('43', 'add_stockin', '添加入库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('44', 'edit_in_order', '编辑入库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('45', 'list_stockout', '查看出库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('46', 'add_stockout', '添加出库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('47', 'edit_out_order', '编辑出库单', '', '6');
INSERT INTO `myr_action_code` VALUES ('48', 'add_order', '添加销售订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('49', 'edit_order', '编辑订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('50', 'check_paypal', '订单Paypal核对', '', '3');
INSERT INTO `myr_action_code` VALUES ('51', 'order_mark', '标记发货', '', '3');
INSERT INTO `myr_action_code` VALUES ('52', 'service_check', '客服审核', '', '3');
INSERT INTO `myr_action_code` VALUES ('53', 'depot_check', '库管审核', '', '3');
INSERT INTO `myr_action_code` VALUES ('54', 'order_handle', '普通订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('55', 'order_refund', '退款订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('56', 'order_cod', '货到付款订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('57', 'order_all', '所有订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('58', 'order_stockout', '生成出库单', '', '3');
INSERT INTO `myr_action_code` VALUES ('59', 'handle_message', 'message处理', '', '7');
INSERT INTO `myr_action_code` VALUES ('60', 'load_message', 'message加载', '', '7');
INSERT INTO `myr_action_code` VALUES ('61', 'add_goods', '添加产品', '', '2');
INSERT INTO `myr_action_code` VALUES ('62', 'edit_goods', '编辑产品', '基础属性的编辑', '2');
INSERT INTO `myr_action_code` VALUES ('63', 'view_price', '查看费用相关', '能否打开费用相关', '2');
INSERT INTO `myr_action_code` VALUES ('64', 'list_cn', '中文刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('65', 'list_us', '美国刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('66', 'list_au', '澳大利亚刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('67', 'list_uk', '英国刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('68', 'list_de', '德文刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('69', 'list_fr', '法文刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('70', 'view_cost', '查看成本价', '', '2');
INSERT INTO `myr_action_code` VALUES ('71', 'edit_cost', '编辑成本价', '', '2');
INSERT INTO `myr_action_code` VALUES ('72', 'view_price1', '查看价格1', '', '2');
INSERT INTO `myr_action_code` VALUES ('73', 'edit_price1', '编辑价格1', '', '2');
INSERT INTO `myr_action_code` VALUES ('74', 'view_price2', '查看价格2', '', '2');
INSERT INTO `myr_action_code` VALUES ('75', 'edit_price2', '编辑价格2', '', '2');
INSERT INTO `myr_action_code` VALUES ('76', 'view_price3', '查看价格3', '', '2');
INSERT INTO `myr_action_code` VALUES ('77', 'edit_price3', '编辑价格3', '', '2');
INSERT INTO `myr_action_code` VALUES ('78', 'list_sp', '西班牙文刊登', '', '2');
INSERT INTO `myr_action_code` VALUES ('79', 'edit_stock', '编辑库存', '', '2');
INSERT INTO `myr_action_code` VALUES ('80', 'export_goods', '导出产品列表', '', '2');
INSERT INTO `myr_action_code` VALUES ('81', 'export_listing', '导出listing列表', '', '2');
INSERT INTO `myr_action_code` VALUES ('82', 'view_supplier', '查看供应商', '', '2');
INSERT INTO `myr_action_code` VALUES ('83', 'order_unlcok', '解锁订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('84', 'del_goods', '删除产品', '', '2');
INSERT INTO `myr_action_code` VALUES ('85', 'paypal_order', 'paypal流水', '', '3');
INSERT INTO `myr_action_code` VALUES ('87', 'goods_update', '产品批量更新', '', '2');
INSERT INTO `myr_action_code` VALUES ('88', 'load_goods', '加载Ebay产品', '', '2');
INSERT INTO `myr_action_code` VALUES ('89', 'order_ofs', '缺货订单处理', '', '3');
INSERT INTO `myr_action_code` VALUES ('90', 'order_import', '订单导入', '', '3');
INSERT INTO `myr_action_code` VALUES ('91', 'edit_currency', '编辑汇率', '', '1');
INSERT INTO `myr_action_code` VALUES ('92', 'list_currency', '汇率管理', '', '1');
INSERT INTO `myr_action_code` VALUES ('93', 'order_update', '订单批量更新', '', '3');
INSERT INTO `myr_action_code` VALUES ('94', 'export_order', '订单导出', '', '3');
INSERT INTO `myr_action_code` VALUES ('95', 'del_order', '删除订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('96', 'edit_template', '编辑模板', '新增/编辑', '8');
INSERT INTO `myr_action_code` VALUES ('97', 'del_template', '删除模板', '', '8');
INSERT INTO `myr_action_code` VALUES ('98', 'order_pickup', '拣货订单处理', '', '3');
INSERT INTO `myr_action_code` VALUES ('99', 'edit_supplier_goods', '编辑供应商产品', '', '5');
INSERT INTO `myr_action_code` VALUES ('100', 'stock_change', '库存调换', '缺货时才有其他产品发货进行库存调整', '6');
INSERT INTO `myr_action_code` VALUES ('101', 'porder_import', '采购导入', '', '5');
INSERT INTO `myr_action_code` VALUES ('102', 'stockout_import', '出库导入', '', '6');
INSERT INTO `myr_action_code` VALUES ('103', 'stockin_import', '入库导入', '', '6');
INSERT INTO `myr_action_code` VALUES ('104', 'list_p_plan', '采购计划', '', '5');
INSERT INTO `myr_action_code` VALUES ('105', 'list_stock', '当前库存', '', '6');
INSERT INTO `myr_action_code` VALUES ('106', 'stock_check', '库存盘点', '', '6');
INSERT INTO `myr_action_code` VALUES ('110', 'check_listing', 'listing重复核对', '', '2');
INSERT INTO `myr_action_code` VALUES ('112', 'list_fee', '费用单管理', '', '9');
INSERT INTO `myr_action_code` VALUES ('113', 'edit_fee', '编辑费用单', '', '9');
INSERT INTO `myr_action_code` VALUES ('114', 'list_rf', '收款单管理', '', '9');
INSERT INTO `myr_action_code` VALUES ('115', 'edit_rf', '编辑收款单', '', '9');
INSERT INTO `myr_action_code` VALUES ('116', 'list_gf', '付款单管理', '', '9');
INSERT INTO `myr_action_code` VALUES ('117', 'edit_gf', '编辑付款单', '', '9');
INSERT INTO `myr_action_code` VALUES ('122', 'template_message', 'message模板', '', '8');
INSERT INTO `myr_action_code` VALUES ('123', 'template_partner', '客户联系模板', '', '8');
INSERT INTO `myr_action_code` VALUES ('124', 'import_supplier_goods', '导入供应商产品', '', '5');
INSERT INTO `myr_action_code` VALUES ('125', 'goods_allocation', '分仓调拨', '', '6');
INSERT INTO `myr_action_code` VALUES ('126', 'edit_db_order', '更改调拨状态', '', '6');
INSERT INTO `myr_action_code` VALUES ('127', 'clear_varstock', '清空锁定库存', '', '2');
INSERT INTO `myr_action_code` VALUES ('129', 'sys_init', '系统初始化', '', '1');
INSERT INTO `myr_action_code` VALUES ('130', 'change_stock', '库存调换发货', '', '6');
INSERT INTO `myr_action_code` VALUES ('131', 'eub_order_handle', 'EUB订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('133', 'list_sku', '多SKU管理', '', '2');
INSERT INTO `myr_action_code` VALUES ('138', 'listing_support', 'Ebay Listing管理', '', '2');
INSERT INTO `myr_action_code` VALUES ('139', 'auto_checkorder', '自动配货核对', '', '3');
INSERT INTO `myr_action_code` VALUES ('140', 'list_shelf', '仓库货架', '', '6');
INSERT INTO `myr_action_code` VALUES ('143', 'order_complete', '外仓订单发货', '', '3');
INSERT INTO `myr_action_code` VALUES ('144', 'allocation_import', '调拨单导入', '', '6');
INSERT INTO `myr_action_code` VALUES ('154', 'order_revocation', '撤单入库', '', '6');
INSERT INTO `myr_action_code` VALUES ('153', 'list_feedback', 'feedback处理', '', '7');
INSERT INTO `myr_action_code` VALUES ('147', 'list_4px', '4PX订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('148', 'list_rma', 'RMA管理', '', '7');
INSERT INTO `myr_action_code` VALUES ('149', 'list_return', '退换货管理', '', '7');
INSERT INTO `myr_action_code` VALUES ('156', 'list_goods_log', '查询产品日志', '', '2');
INSERT INTO `myr_action_code` VALUES ('158', 'template_order', '订单导出模版', '', '8');
INSERT INTO `myr_action_code` VALUES ('159', 'template_goods', '产品导出模版', '', '8');
INSERT INTO `myr_action_code` VALUES ('161', 'list_all_news', '查看所有公告', '', '1');
INSERT INTO `myr_action_code` VALUES ('162', 'add_news', '编辑公告', '', '1');
INSERT INTO `myr_action_code` VALUES ('163', 'del_news', '删除公告', '', '1');
INSERT INTO `myr_action_code` VALUES ('164', 'list_news', '内部公告管理', '', '1');
INSERT INTO `myr_action_code` VALUES ('165', 'list_p_return', '采购退货', '', '5');
INSERT INTO `myr_action_code` VALUES ('167', 'list_p_advice', '采购建议', '', '5');
INSERT INTO `myr_action_code` VALUES ('169', 'amazon_config', 'Amazon Schedule', '', '1');
INSERT INTO `myr_action_code` VALUES ('170', 'load_amzorder', 'AMZ报表管理', 'AMZ报表管理', '3');
INSERT INTO `myr_action_code` VALUES ('171', 'load_amzlisting', 'amazon产品报表', '', '2');
INSERT INTO `myr_action_code` VALUES ('177', 'eub1_order_handle', '线下EUB订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('179', 'list_sfc', '三态订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('181', 'list_bank', '银行账户', '', '9');
INSERT INTO `myr_action_code` VALUES ('182', 'list_banklog', '账户日志', '', '9');
INSERT INTO `myr_action_code` VALUES ('185', 'edit_comorder', '编辑已完成订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('186', 'list_ck1', '出口易订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('187', 'updateitem', 'Ebay listing更新', '', '2');
INSERT INTO `myr_action_code` VALUES ('189', 'audit_p_order', '审核采购单', '', '5');
INSERT INTO `myr_action_code` VALUES ('191', 'goods_attribute', '产品属性管理', '', '2');
INSERT INTO `myr_action_code` VALUES ('192', 'goods_attribute_set', '产品属性集管理', '', '2');
INSERT INTO `myr_action_code` VALUES ('193', 'edit_attribute', '编辑属性', null, '2');
INSERT INTO `myr_action_code` VALUES ('194', 'edit_attribute_set', '编辑属性集', null, '2');
INSERT INTO `myr_action_code` VALUES ('195', 'list_Language', '查看语言', '', '2');
INSERT INTO `myr_action_code` VALUES ('196', 'edit_language', '编辑语言', '', '2');
INSERT INTO `myr_action_code` VALUES ('197', 'list_icehkpost', '互联易订单', '', '3');
INSERT INTO `myr_action_code` VALUES ('198', 'order_shippinged', '发货订单', null, '3');
INSERT INTO `myr_action_code` VALUES ('199', 'ali_goods', '速卖通产品管理', null, '2');
INSERT INTO `myr_action_code` VALUES ('201', 'load_aligood', '同步速卖通产品', null, '2');
INSERT INTO `myr_action_code` VALUES ('202', 'Subhandle', '速邮宝订单', null, '3');
INSERT INTO `myr_action_code` VALUES ('203', 'order_collation', '扫描拣货订单', null, '3');
INSERT INTO `myr_action_code` VALUES ('206', 'ali_goods_imgbank', 'Ali图片银行', null, '2');
INSERT INTO `myr_action_code` VALUES ('207', 'ali_good_upsale', '速卖通上架产品', null, '2');
INSERT INTO `myr_action_code` VALUES ('208', 'ali_good_downsale', '速卖通下架产品', null, '2');

-- ----------------------------
-- Table structure for myr_action_type
-- ----------------------------
DROP TABLE IF EXISTS `myr_action_type`;
CREATE TABLE `myr_action_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `action_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_action_type
-- ----------------------------
INSERT INTO `myr_action_type` VALUES ('1', '系统管理');
INSERT INTO `myr_action_type` VALUES ('2', '产品管理');
INSERT INTO `myr_action_type` VALUES ('3', '销售管理');
INSERT INTO `myr_action_type` VALUES ('5', '采购管理');
INSERT INTO `myr_action_type` VALUES ('6', '库存管理');
INSERT INTO `myr_action_type` VALUES ('7', '售后管理');
INSERT INTO `myr_action_type` VALUES ('8', '模板管理');
INSERT INTO `myr_action_type` VALUES ('9', '账款管理');
INSERT INTO `myr_action_type` VALUES ('10', '统计模块');

-- ----------------------------
-- Table structure for myr_admin_action
-- ----------------------------
DROP TABLE IF EXISTS `myr_admin_action`;
CREATE TABLE `myr_admin_action` (
  `action_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action_code` varchar(20) NOT NULL DEFAULT '',
  `action_lang` varchar(30) NOT NULL,
  PRIMARY KEY (`action_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_admin_action
-- ----------------------------

-- ----------------------------
-- Table structure for myr_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `myr_admin_user`;
CREATE TABLE `myr_admin_user` (
  `user_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(60) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `add_time` int(11) NOT NULL,
  `last_login` int(11) NOT NULL,
  `last_ip` varchar(15) NOT NULL,
  `action_list` text NOT NULL,
  `role_id` smallint(5) DEFAULT NULL,
  `account_list` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `versions` tinyint(1) NOT NULL DEFAULT '2',
  `now_login` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_name` (`user_name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_admin_user
-- ----------------------------
INSERT INTO `myr_admin_user` VALUES ('1', 'allpyra', 'admin@163.com', 'e10adc3949ba59abbe56e057f20f883e', '1284446489', '1443161712', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,listing_support,list_goods_log,load_amzlisting,updateitem,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_all,order_stockout,order_unlcok,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,order_complete,load_amzorder,eub1_order_handle,edit_comorder,list_icehkpost,order_shippinged,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1467797589');
INSERT INTO `myr_admin_user` VALUES ('2', 'porridge', 'porridge@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442479171', '1442545690', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1443002911');
INSERT INTO `myr_admin_user` VALUES ('3', 'xu', 'xu@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442482202', '1442828871', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1442836650');
INSERT INTO `myr_admin_user` VALUES ('4', 'martin', 'martin@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442482501', '1443143976', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1443150190');
INSERT INTO `myr_admin_user` VALUES ('5', 'samuel', 'samuel@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442482556', '1443065142', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1443076559');
INSERT INTO `myr_admin_user` VALUES ('12', 'sam', 'sam@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442545309', '0', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '0');
INSERT INTO `myr_admin_user` VALUES ('9', 'david', 'meng@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442483432', '0', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '0');
INSERT INTO `myr_admin_user` VALUES ('13', 'jerry', 'Jerry@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1442545337', '1442913212', '', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '1,2', 'allpyra', '2', '1443075190');
INSERT INTO `myr_admin_user` VALUES ('14', 'Tony', 'tony@allpyra.com', 'e10adc3949ba59abbe56e057f20f883e', '1443087452', '0', '', 'list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,check_listing,clear_varstock,list_sku,list_goods_log,load_amzlisting,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_upsale,ali_good_downsale,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,load_amzorder,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,Subhandle,order_collation,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_advice,audit_p_order,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,change_stock,list_shelf,order_revocation,load_case,list_case,handle_message,load_message,list_feedback,list_rma,list_return,edit_template,del_template,template_message,template_partner,template_order,template_goods,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '1', '', 'allpyra', '2', '0');

-- ----------------------------
-- Table structure for myr_aliand_aligoods
-- ----------------------------
DROP TABLE IF EXISTS `myr_aliand_aligoods`;
CREATE TABLE `myr_aliand_aligoods` (
  `goods_id` int(11) NOT NULL,
  `ali_goods_id` bigint(15) unsigned NOT NULL,
  `account_id` int(11) unsigned NOT NULL,
  `ali_rec_id` int(11) NOT NULL,
  KEY `goodid` (`goods_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of myr_aliand_aligoods
-- ----------------------------
INSERT INTO `myr_aliand_aligoods` VALUES ('35504', '1723539094', '71', '387425');
INSERT INTO `myr_aliand_aligoods` VALUES ('35503', '1723558924', '71', '387424');
INSERT INTO `myr_aliand_aligoods` VALUES ('35505', '1723555940', '71', '387426');
INSERT INTO `myr_aliand_aligoods` VALUES ('35505', '0', '72', '387475');
INSERT INTO `myr_aliand_aligoods` VALUES ('35506', '1727117151', '75', '387477');
INSERT INTO `myr_aliand_aligoods` VALUES ('35507', '1504974914', '75', '387478');
INSERT INTO `myr_aliand_aligoods` VALUES ('35508', '1723958809', '75', '387479');
INSERT INTO `myr_aliand_aligoods` VALUES ('35509', '1727094744', '75', '387480');
INSERT INTO `myr_aliand_aligoods` VALUES ('35510', '1541547632', '75', '387481');
INSERT INTO `myr_aliand_aligoods` VALUES ('35511', '1540010289', '75', '387482');
INSERT INTO `myr_aliand_aligoods` VALUES ('35512', '1724084712', '75', '387483');
INSERT INTO `myr_aliand_aligoods` VALUES ('35513', '1698161225', '75', '387484');
INSERT INTO `myr_aliand_aligoods` VALUES ('35514', '1624645150', '75', '387485');
INSERT INTO `myr_aliand_aligoods` VALUES ('35515', '1624605333', '75', '387486');
INSERT INTO `myr_aliand_aligoods` VALUES ('35516', '1709994399', '75', '387487');
INSERT INTO `myr_aliand_aligoods` VALUES ('35517', '1709856156', '75', '387488');
INSERT INTO `myr_aliand_aligoods` VALUES ('35518', '1697980535', '75', '387489');
INSERT INTO `myr_aliand_aligoods` VALUES ('35519', '1696713980', '75', '387490');
INSERT INTO `myr_aliand_aligoods` VALUES ('35520', '1696444287', '75', '387491');
INSERT INTO `myr_aliand_aligoods` VALUES ('35521', '1678179117', '75', '387492');
INSERT INTO `myr_aliand_aligoods` VALUES ('35522', '1677167118', '75', '387493');
INSERT INTO `myr_aliand_aligoods` VALUES ('35523', '1675546208', '75', '387494');
INSERT INTO `myr_aliand_aligoods` VALUES ('35524', '1670924602', '75', '387495');
INSERT INTO `myr_aliand_aligoods` VALUES ('35525', '1670782539', '75', '387496');
INSERT INTO `myr_aliand_aligoods` VALUES ('35526', '1670713267', '75', '387497');
INSERT INTO `myr_aliand_aligoods` VALUES ('35527', '1666826091', '75', '387498');
INSERT INTO `myr_aliand_aligoods` VALUES ('35528', '1666736664', '75', '387499');
INSERT INTO `myr_aliand_aligoods` VALUES ('35529', '1628285987', '75', '387500');
INSERT INTO `myr_aliand_aligoods` VALUES ('35530', '1626709925', '75', '387501');
INSERT INTO `myr_aliand_aligoods` VALUES ('35531', '1723557858', '71', '387427');
INSERT INTO `myr_aliand_aligoods` VALUES ('35532', '1723532364', '71', '387428');
INSERT INTO `myr_aliand_aligoods` VALUES ('35533', '1723456432', '71', '387430');
INSERT INTO `myr_aliand_aligoods` VALUES ('35534', '1723409066', '71', '387431');
INSERT INTO `myr_aliand_aligoods` VALUES ('35535', '1723420917', '71', '387432');
INSERT INTO `myr_aliand_aligoods` VALUES ('35536', '1723396286', '71', '387433');
INSERT INTO `myr_aliand_aligoods` VALUES ('35537', '1721513094', '71', '387434');
INSERT INTO `myr_aliand_aligoods` VALUES ('35538', '1721542395', '71', '387435');
INSERT INTO `myr_aliand_aligoods` VALUES ('35539', '1305574007', '71', '387436');
INSERT INTO `myr_aliand_aligoods` VALUES ('35540', '1692807548', '71', '387437');
INSERT INTO `myr_aliand_aligoods` VALUES ('35541', '1655652346', '71', '387438');
INSERT INTO `myr_aliand_aligoods` VALUES ('35542', '1642520076', '71', '387439');
INSERT INTO `myr_aliand_aligoods` VALUES ('35543', '1697022459', '71', '387440');
INSERT INTO `myr_aliand_aligoods` VALUES ('35544', '1696987539', '71', '387441');
INSERT INTO `myr_aliand_aligoods` VALUES ('35545', '1696924271', '71', '387442');
INSERT INTO `myr_aliand_aligoods` VALUES ('35546', '1696534836', '71', '387443');
INSERT INTO `myr_aliand_aligoods` VALUES ('35547', '1694116615', '71', '387444');
INSERT INTO `myr_aliand_aligoods` VALUES ('35548', '1694116610', '71', '387445');
INSERT INTO `myr_aliand_aligoods` VALUES ('35549', '1694114648', '71', '387446');
INSERT INTO `myr_aliand_aligoods` VALUES ('35550', '1694110648', '71', '387447');
INSERT INTO `myr_aliand_aligoods` VALUES ('35551', '1694124470', '71', '387448');
INSERT INTO `myr_aliand_aligoods` VALUES ('35552', '1694120500', '71', '387449');
INSERT INTO `myr_aliand_aligoods` VALUES ('35553', '1694110653', '71', '387450');
INSERT INTO `myr_aliand_aligoods` VALUES ('35554', '1727468504', '72', '387475');
INSERT INTO `myr_aliand_aligoods` VALUES ('35555', '1727468504', '71', '387476');
INSERT INTO `myr_aliand_aligoods` VALUES ('35556', '1619065931', '75', '387502');
INSERT INTO `myr_aliand_aligoods` VALUES ('35557', '1619039581', '75', '387503');
INSERT INTO `myr_aliand_aligoods` VALUES ('35558', '1617573231', '75', '387504');
INSERT INTO `myr_aliand_aligoods` VALUES ('35559', '1542176256', '75', '387505');
INSERT INTO `myr_aliand_aligoods` VALUES ('35560', '1528125480', '75', '387506');
INSERT INTO `myr_aliand_aligoods` VALUES ('35561', '1528016260', '75', '387507');
INSERT INTO `myr_aliand_aligoods` VALUES ('35562', '1496483384', '75', '387508');
INSERT INTO `myr_aliand_aligoods` VALUES ('35563', '1710096811', '75', '387509');
INSERT INTO `myr_aliand_aligoods` VALUES ('35564', '1682629150', '75', '387510');
INSERT INTO `myr_aliand_aligoods` VALUES ('35565', '1678078397', '75', '387511');
INSERT INTO `myr_aliand_aligoods` VALUES ('35566', '1664858278', '75', '387512');
INSERT INTO `myr_aliand_aligoods` VALUES ('35567', '1664075793', '75', '387513');
INSERT INTO `myr_aliand_aligoods` VALUES ('35568', '1630069423', '75', '387514');
INSERT INTO `myr_aliand_aligoods` VALUES ('35569', '1628472971', '75', '387515');
INSERT INTO `myr_aliand_aligoods` VALUES ('35570', '1618874008', '75', '387516');
INSERT INTO `myr_aliand_aligoods` VALUES ('35571', '1542080446', '75', '387517');
INSERT INTO `myr_aliand_aligoods` VALUES ('35572', '1505074343', '75', '387518');
INSERT INTO `myr_aliand_aligoods` VALUES ('35573', '1502668278', '75', '387519');
INSERT INTO `myr_aliand_aligoods` VALUES ('35574', '1727239684', '75', '387524');
INSERT INTO `myr_aliand_aligoods` VALUES ('35575', '1727187676', '75', '387525');
INSERT INTO `myr_aliand_aligoods` VALUES ('1', '1729783958', '75', '387526');
INSERT INTO `myr_aliand_aligoods` VALUES ('2', '1729748032', '75', '387527');
INSERT INTO `myr_aliand_aligoods` VALUES ('3', '1729787728', '75', '387528');
INSERT INTO `myr_aliand_aligoods` VALUES ('4', '1729717951', '75', '387529');
INSERT INTO `myr_aliand_aligoods` VALUES ('5', '1729721852', '75', '387530');
INSERT INTO `myr_aliand_aligoods` VALUES ('6', '1729674139', '75', '387531');
INSERT INTO `myr_aliand_aligoods` VALUES ('7', '1729716484', '75', '387532');
INSERT INTO `myr_aliand_aligoods` VALUES ('8', '1729677927', '75', '387533');
INSERT INTO `myr_aliand_aligoods` VALUES ('9', '1729647072', '75', '387534');
INSERT INTO `myr_aliand_aligoods` VALUES ('10', '1729684574', '75', '387535');
INSERT INTO `myr_aliand_aligoods` VALUES ('9', '0', '76', '387536');
INSERT INTO `myr_aliand_aligoods` VALUES ('1', '1655596873', '76', '387537');
INSERT INTO `myr_aliand_aligoods` VALUES ('2', '1651056418', '76', '387540');
INSERT INTO `myr_aliand_aligoods` VALUES ('3', '1652669104', '76', '387541');
INSERT INTO `myr_aliand_aligoods` VALUES ('4', '1653518246', '76', '387543');
INSERT INTO `myr_aliand_aligoods` VALUES ('5', '1652855372', '76', '387544');
INSERT INTO `myr_aliand_aligoods` VALUES ('6', '1651105535', '76', '387546');
INSERT INTO `myr_aliand_aligoods` VALUES ('7', '1651056429', '76', '387547');
INSERT INTO `myr_aliand_aligoods` VALUES ('8', '1638706261', '76', '387548');
INSERT INTO `myr_aliand_aligoods` VALUES ('9', '1652733594', '76', '387550');
INSERT INTO `myr_aliand_aligoods` VALUES ('10', '1686290446', '76', '387552');
INSERT INTO `myr_aliand_aligoods` VALUES ('11', '1686219468', '76', '387553');
INSERT INTO `myr_aliand_aligoods` VALUES ('12', '1686177666', '76', '387554');
INSERT INTO `myr_aliand_aligoods` VALUES ('13', '1686000087', '76', '387555');
INSERT INTO `myr_aliand_aligoods` VALUES ('14', '1686014342', '76', '387556');
INSERT INTO `myr_aliand_aligoods` VALUES ('15', '1652593799', '76', '387557');
INSERT INTO `myr_aliand_aligoods` VALUES ('16', '1652346206', '76', '387558');
INSERT INTO `myr_aliand_aligoods` VALUES ('17', '1653677039', '76', '387559');
INSERT INTO `myr_aliand_aligoods` VALUES ('18', '1652751249', '76', '387560');
INSERT INTO `myr_aliand_aligoods` VALUES ('19', '1691370308', '76', '387561');
INSERT INTO `myr_aliand_aligoods` VALUES ('20', '1651072344', '76', '387562');
INSERT INTO `myr_aliand_aligoods` VALUES ('21', '1686026243', '76', '387563');
INSERT INTO `myr_aliand_aligoods` VALUES ('22', '1686046290', '76', '387564');
INSERT INTO `myr_aliand_aligoods` VALUES ('23', '1685912510', '76', '387565');
INSERT INTO `myr_aliand_aligoods` VALUES ('24', '1685650199', '76', '387566');
INSERT INTO `myr_aliand_aligoods` VALUES ('25', '1670237037', '76', '387567');

-- ----------------------------
-- Table structure for myr_alicategory
-- ----------------------------
DROP TABLE IF EXISTS `myr_alicategory`;
CREATE TABLE `myr_alicategory` (
  `cat_id` varchar(15) NOT NULL,
  `parent_id` varchar(15) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `name_en` varchar(50) DEFAULT NULL,
  `isleaf` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `cat_id` (`cat_id`) USING BTREE,
  KEY `parid` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_alicategory
-- ----------------------------

-- ----------------------------
-- Table structure for myr_aligoods
-- ----------------------------
DROP TABLE IF EXISTS `myr_aligoods`;
CREATE TABLE `myr_aligoods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) NOT NULL,
  `goods_id` int(8) NOT NULL DEFAULT '0',
  `last_update_time` int(10) NOT NULL,
  `aeopAeProductSKUs` text NOT NULL,
  `skuCode` varchar(50) NOT NULL,
  `deliveryTime` int(8) NOT NULL,
  `categoryId` varchar(50) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `productMoreKeywords1` varchar(255) DEFAULT NULL,
  `productMoreKeywords2` varchar(255) DEFAULT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `freightTemplateId` varchar(50) NOT NULL,
  `isImageDynamic` tinyint(1) NOT NULL COMMENT '多动态图-1  静态单图-0',
  `productUnit` varchar(50) NOT NULL,
  `is_upload` tinyint(1) NOT NULL DEFAULT '0',
  `ali_good_id` bigint(18) NOT NULL,
  `aeopAeProductPropertys` text NOT NULL,
  `goods_status` varchar(50) NOT NULL,
  `ownerMemberId` varchar(50) NOT NULL,
  `wsOfflineDate` int(11) NOT NULL,
  `wsDisplay` varchar(100) NOT NULL,
  `groupId` varchar(100) DEFAULT NULL,
  `packageType` tinyint(1) NOT NULL DEFAULT '0',
  `lotNum` smallint(5) NOT NULL DEFAULT '1',
  `wsValidNum` smallint(5) NOT NULL,
  `bulkOrder` int(8) NOT NULL,
  `bulkDiscount` smallint(5) NOT NULL,
  `goods_img` varchar(80) NOT NULL,
  `account_id` int(11) NOT NULL,
  `imageURLs` text NOT NULL,
  `packageLength` decimal(10,2) NOT NULL,
  `packageWidth` decimal(10,2) NOT NULL,
  `packageHeight` decimal(10,2) NOT NULL,
  `grossWeight` decimal(10,2) NOT NULL,
  `detail` text NOT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '0为在线   1为等待上传  2为已经结束',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `account_id` (`account_id`,`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (id)
(PARTITION p0 VALUES LESS THAN (50000) ENGINE = InnoDB,
 PARTITION p1 VALUES LESS THAN (100000) ENGINE = InnoDB,
 PARTITION p2 VALUES LESS THAN (150000) ENGINE = InnoDB,
 PARTITION p3 VALUES LESS THAN (200000) ENGINE = InnoDB,
 PARTITION p4 VALUES LESS THAN (250000) ENGINE = InnoDB,
 PARTITION p5 VALUES LESS THAN (300000) ENGINE = InnoDB,
 PARTITION p6 VALUES LESS THAN (350000) ENGINE = InnoDB,
 PARTITION p7 VALUES LESS THAN (400000) ENGINE = InnoDB,
 PARTITION p8 VALUES LESS THAN (450000) ENGINE = InnoDB,
 PARTITION p9 VALUES LESS THAN (500000) ENGINE = InnoDB,
 PARTITION p10 VALUES LESS THAN (550000) ENGINE = InnoDB,
 PARTITION p11 VALUES LESS THAN (600000) ENGINE = InnoDB,
 PARTITION p12 VALUES LESS THAN (650000) ENGINE = InnoDB,
 PARTITION p13 VALUES LESS THAN (700000) ENGINE = InnoDB,
 PARTITION p14 VALUES LESS THAN (750000) ENGINE = InnoDB,
 PARTITION p15 VALUES LESS THAN (800000) ENGINE = InnoDB,
 PARTITION p16 VALUES LESS THAN (850000) ENGINE = InnoDB,
 PARTITION p17 VALUES LESS THAN (900000) ENGINE = InnoDB,
 PARTITION p18 VALUES LESS THAN (950000) ENGINE = InnoDB,
 PARTITION p19 VALUES LESS THAN (1000000) ENGINE = InnoDB,
 PARTITION p20 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;

-- ----------------------------
-- Records of myr_aligoods
-- ----------------------------

-- ----------------------------
-- Table structure for myr_aligood_child
-- ----------------------------
DROP TABLE IF EXISTS `myr_aligood_child`;
CREATE TABLE `myr_aligood_child` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `ali_good_id` varchar(30) NOT NULL,
  `skuPrice` decimal(10,2) NOT NULL,
  `skuCode` varchar(30) NOT NULL,
  `skuStock` tinyint(3) NOT NULL DEFAULT '1',
  `aeopSKUProperty` varchar(255) NOT NULL,
  `account_id` int(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1519472 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_aligood_child
-- ----------------------------

-- ----------------------------
-- Table structure for myr_aligood_lib
-- ----------------------------
DROP TABLE IF EXISTS `myr_aligood_lib`;
CREATE TABLE `myr_aligood_lib` (
  `goods_id` int(8) NOT NULL AUTO_INCREMENT,
  `account_id` int(8) NOT NULL,
  `ali_good_id` int(12) NOT NULL,
  `is_uplod` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of myr_aligood_lib
-- ----------------------------

-- ----------------------------
-- Table structure for myr_aliorder_msg
-- ----------------------------
DROP TABLE IF EXISTS `myr_aliorder_msg`;
CREATE TABLE `myr_aliorder_msg` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` bigint(15) unsigned NOT NULL,
  `orderId` bigint(16) unsigned DEFAULT NULL,
  `content` text,
  `fileUrl` varchar(255) NOT NULL,
  `haveFile` tinyint(1) NOT NULL DEFAULT '0' COMMENT '附件 默认0 没有',
  `receiverLoginId` varchar(128) NOT NULL,
  `gmtCreate` int(11) NOT NULL,
  `add_time` int(11) NOT NULL,
  `messageType` varchar(128) NOT NULL,
  `receiverEmail` varchar(128) NOT NULL,
  `receiverName` varchar(128) NOT NULL,
  `readed` varchar(5) NOT NULL DEFAULT '',
  `orderUrl` varchar(255) NOT NULL,
  `productUrl` varchar(255) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productId` bigint(16) NOT NULL,
  `senderName` varchar(128) NOT NULL,
  `senderLoginId` varchar(128) NOT NULL,
  `typeId` bigint(16) NOT NULL,
  `relationId` bigint(16) NOT NULL COMMENT '关系ID',
  `account_id` int(11) unsigned NOT NULL,
  `msg_type` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `message_id` (`message_id`) USING BTREE,
  KEY `orderId` (`orderId`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_aliorder_msg
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_attributes
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_attributes`;
CREATE TABLE `myr_ali_attributes` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` bigint(18) unsigned NOT NULL,
  `attributeId` bigint(18) NOT NULL,
  `attr_name_en` varchar(50) NOT NULL,
  `attr_name` varchar(50) NOT NULL,
  `spec` tinyint(1) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `value` tinyint(1) NOT NULL,
  `skuStyleValue` varchar(50) DEFAULT NULL,
  `customizedName` varchar(50) DEFAULT NULL,
  `keyAttribute` tinyint(1) NOT NULL DEFAULT '0',
  `sku` tinyint(1) NOT NULL DEFAULT '0',
  `ShowType` varchar(30) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `inputType` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`cat_id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `st` (`ShowType`) USING BTREE,
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28091 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_attributes
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_attributes_option_values
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_attributes_option_values`;
CREATE TABLE `myr_ali_attributes_option_values` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` varchar(50) NOT NULL,
  `attrNameId` bigint(18) NOT NULL,
  `attrValueId` bigint(18) NOT NULL,
  `attrValueName` varchar(50) NOT NULL,
  `attrValueName_en` varchar(50) NOT NULL,
  PRIMARY KEY (`id`,`cat_id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `cid` (`cat_id`,`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=148102 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_attributes_option_values
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_freight
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_freight`;
CREATE TABLE `myr_ali_freight` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `appkey_id` int(8) NOT NULL,
  `template_id` int(10) NOT NULL,
  `template_name` varchar(100) NOT NULL,
  `is_default` int(1) NOT NULL COMMENT '1为默认  0非默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_freight
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_images_lib
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_images_lib`;
CREATE TABLE `myr_ali_images_lib` (
  `account_id` int(8) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `fileSize` bigint(18) NOT NULL,
  `height` int(8) NOT NULL,
  `width` int(8) NOT NULL,
  `iid` bigint(18) NOT NULL,
  `displayName` varchar(128) NOT NULL,
  `groupId` bigint(18) NOT NULL,
  `last_update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_images_lib
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_images_lib_group
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_images_lib_group`;
CREATE TABLE `myr_ali_images_lib_group` (
  `groupId` bigint(18) NOT NULL,
  `account_id` int(8) NOT NULL,
  `groupName` varchar(128) NOT NULL,
  `parent_gid` bigint(18) NOT NULL,
  PRIMARY KEY (`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_images_lib_group
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ali_orders
-- ----------------------------
DROP TABLE IF EXISTS `myr_ali_orders`;
CREATE TABLE `myr_ali_orders` (
  `order_id` int(11) unsigned NOT NULL,
  `aliexpress_id` bigint(18) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ali_orders
-- ----------------------------

-- ----------------------------
-- Table structure for myr_allocation
-- ----------------------------
DROP TABLE IF EXISTS `myr_allocation`;
CREATE TABLE `myr_allocation` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `out_time` int(10) NOT NULL,
  `operator_id` tinyint(3) unsigned NOT NULL,
  `depot_id_from` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `depot_id_to` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `add_user` tinyint(3) unsigned NOT NULL,
  `comment` varchar(100) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `count` smallint(4) unsigned NOT NULL,
  `weight` float unsigned NOT NULL DEFAULT '0',
  `db_shipping` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `first_shipping` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `track_no` varchar(30) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_allocation
-- ----------------------------

-- ----------------------------
-- Table structure for myr_allocation_detail
-- ----------------------------
DROP TABLE IF EXISTS `myr_allocation_detail`;
CREATE TABLE `myr_allocation_detail` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_qty` smallint(5) unsigned NOT NULL,
  `is_ok` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `no` varchar(30) NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`,`goods_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_allocation_detail
-- ----------------------------

-- ----------------------------
-- Table structure for myr_amazon_listing
-- ----------------------------
DROP TABLE IF EXISTS `myr_amazon_listing`;
CREATE TABLE `myr_amazon_listing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` tinyint(3) unsigned NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_description` text NOT NULL,
  `listing_id` varchar(11) NOT NULL,
  `seller_sku` varchar(30) NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `quantity` smallint(5) unsigned NOT NULL,
  `open_date` varchar(25) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `item_is_marketplace` varchar(1) NOT NULL,
  `product_id_type` tinyint(1) unsigned NOT NULL COMMENT 'asin/ISBN/UPC/EAN',
  `product_id` varchar(10) NOT NULL,
  `item_note` text NOT NULL,
  `item_condition` tinyint(2) unsigned NOT NULL COMMENT 'NEW/GOODS/Acceptable',
  `item_will_ship_internationally` varchar(1) NOT NULL COMMENT '1N2Y',
  `expedited_shipping` varchar(15) NOT NULL,
  `fulfillment_channel` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`,`listing_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1381 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_amazon_listing
-- ----------------------------

-- ----------------------------
-- Table structure for myr_amazon_report
-- ----------------------------
DROP TABLE IF EXISTS `myr_amazon_report`;
CREATE TABLE `myr_amazon_report` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` tinyint(3) unsigned NOT NULL,
  `ReportId` bigint(10) unsigned NOT NULL,
  `ReportType` varchar(50) NOT NULL,
  `AvailableDate` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`,`ReportId`)
) ENGINE=MyISAM AUTO_INCREMENT=300 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_amazon_report
-- ----------------------------

-- ----------------------------
-- Table structure for myr_amazon_schedule
-- ----------------------------
DROP TABLE IF EXISTS `myr_amazon_schedule`;
CREATE TABLE `myr_amazon_schedule` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` tinyint(3) unsigned NOT NULL,
  `ReportType` varchar(50) NOT NULL,
  `Schedule` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`,`ReportType`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_amazon_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for myr_attribute_group
-- ----------------------------
DROP TABLE IF EXISTS `myr_attribute_group`;
CREATE TABLE `myr_attribute_group` (
  `attribute_group_set_id` int(8) NOT NULL AUTO_INCREMENT,
  `attribute_set_id` varchar(255) DEFAULT NULL,
  `attribute_sort_order` varchar(255) DEFAULT NULL,
  `attribute_group_name` varchar(80) NOT NULL,
  `sort_order` int(8) NOT NULL,
  PRIMARY KEY (`attribute_group_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_attribute_group
-- ----------------------------

-- ----------------------------
-- Table structure for myr_attribute_option
-- ----------------------------
DROP TABLE IF EXISTS `myr_attribute_option`;
CREATE TABLE `myr_attribute_option` (
  `option_id` int(8) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(8) NOT NULL,
  `sort_order` int(8) NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_attribute_option
-- ----------------------------

-- ----------------------------
-- Table structure for myr_attribute_option_value
-- ----------------------------
DROP TABLE IF EXISTS `myr_attribute_option_value`;
CREATE TABLE `myr_attribute_option_value` (
  `value_id` int(8) NOT NULL AUTO_INCREMENT,
  `option_id` int(8) NOT NULL,
  `language_id` smallint(5) NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  `parent_value_id` int(8) NOT NULL,
  `is_default` varchar(5) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_attribute_option_value
-- ----------------------------

-- ----------------------------
-- Table structure for myr_attribute_tag
-- ----------------------------
DROP TABLE IF EXISTS `myr_attribute_tag`;
CREATE TABLE `myr_attribute_tag` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `language_id` smallint(5) NOT NULL,
  `attribute_id` int(8) NOT NULL,
  `value` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of myr_attribute_tag
-- ----------------------------

-- ----------------------------
-- Table structure for myr_bank
-- ----------------------------
DROP TABLE IF EXISTS `myr_bank`;
CREATE TABLE `myr_bank` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL,
  `money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `add_time` int(10) NOT NULL,
  `add_user` int(11) NOT NULL,
  `users` text,
  `collect_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `pay_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_bank
-- ----------------------------
INSERT INTO `myr_bank` VALUES ('1', '主账号', '0.00', '1319289993', '0', ',1,', '0.00', '0.00');
INSERT INTO `myr_bank` VALUES ('2', '12313131', '3.00', '1443146657', '4', ',,', '0.00', '0.00');

-- ----------------------------
-- Table structure for myr_bank_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_bank_log`;
CREATE TABLE `myr_bank_log` (
  `deal_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `account_id` mediumint(8) NOT NULL,
  `deal_type` tinyint(1) NOT NULL,
  `order_sn` varchar(20) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `time` int(10) NOT NULL,
  `add_user` int(11) NOT NULL,
  `confirm_user` int(11) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_bank_log
-- ----------------------------
INSERT INTO `myr_bank_log` VALUES ('2', '2', '3', '', '0.00', '1443146657', '4', '4', '3.00', '新增账户12313131的记录');

-- ----------------------------
-- Table structure for myr_bid_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_bid_log`;
CREATE TABLE `myr_bid_log` (
  `itemid` bigint(19) NOT NULL,
  `account_id` tinyint(3) NOT NULL,
  `sku` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_bid_log
-- ----------------------------

-- ----------------------------
-- Table structure for myr_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `myr_blacklist`;
CREATE TABLE `myr_blacklist` (
  `blacklist_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(100) NOT NULL,
  `remark` varchar(500) NOT NULL DEFAULT '',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`blacklist_id`),
  UNIQUE KEY `domain_name` (`domain_name`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for myr_brand
-- ----------------------------
DROP TABLE IF EXISTS `myr_brand`;
CREATE TABLE `myr_brand` (
  `brand_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(20) NOT NULL,
  PRIMARY KEY (`brand_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_brand
-- ----------------------------

-- ----------------------------
-- Table structure for myr_case
-- ----------------------------
DROP TABLE IF EXISTS `myr_case`;
CREATE TABLE `myr_case` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `caseid` varchar(38) NOT NULL,
  `casetype` varchar(20) NOT NULL,
  `order_sn` varchar(20) NOT NULL,
  `creatdate` int(10) unsigned NOT NULL,
  `lastmodifieddate` int(10) NOT NULL,
  `status` varchar(50) NOT NULL,
  `userId` varchar(50) NOT NULL,
  `itemId` varchar(19) NOT NULL,
  `itemTitle` varchar(55) NOT NULL,
  `transactionId` varchar(30) NOT NULL,
  `Sales_account_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_case
-- ----------------------------

-- ----------------------------
-- Table structure for myr_category
-- ----------------------------
DROP TABLE IF EXISTS `myr_category`;
CREATE TABLE `myr_category` (
  `cat_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `cat_name` varchar(20) NOT NULL,
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `package_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Declared_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ali_cat_id` varchar(11) NOT NULL,
  `dec_cn_name` varchar(30) NOT NULL,
  `dec_en_name` varchar(30) NOT NULL,
  `defaul_title` varchar(128) DEFAULT NULL,
  `defalut_summary` text,
  `customs_code` varchar(30) NOT NULL,
  `attribute_group_id` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `product_purchaser` int(8) NOT NULL,
  `products_developers` int(8) NOT NULL,
  `product_operation` int(8) NOT NULL,
  `product_quality_inspector` int(8) NOT NULL,
  `product_rights_checker` int(8) NOT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `code` (`code`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_category
-- ----------------------------
INSERT INTO `myr_category` VALUES ('1', '01', '食品', '0', '0.00', '0.00', '0.00', '', '', '', '', '', '', '', '', '2', '3', '3', '4', '4');
INSERT INTO `myr_category` VALUES ('2', '0101', '奶粉', '1', '10.00', '10.00', '0.00', '', '', '', '', '', '', '', '', '3', '3', '3', '3', '3');
INSERT INTO `myr_category` VALUES ('3', '02', '化妆品', '0', '0.00', '0.00', '0.00', '', '', '', '', '', '', '', '', '2', '3', '3', '4', '4');
INSERT INTO `myr_category` VALUES ('4', '0102', '辅食', '1', '0.00', '0.00', '0.00', '', '', '', '', '', '', '', '', '2', '3', '3', '4', '4');

-- ----------------------------
-- Table structure for myr_category_product_template
-- ----------------------------
DROP TABLE IF EXISTS `myr_category_product_template`;
CREATE TABLE `myr_category_product_template` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `category_id` int(8) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `content` text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of myr_category_product_template
-- ----------------------------

-- ----------------------------
-- Table structure for myr_cf_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_cf_order`;
CREATE TABLE `myr_cf_order` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `fee_type` tinyint(2) unsigned NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL DEFAULT 'CNY',
  `comment` varchar(200) NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `add_user` smallint(5) unsigned NOT NULL,
  `confirm_user` int(11) DEFAULT NULL,
  `confirm_time` int(10) DEFAULT NULL,
  `account_id` mediumint(8) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 未确认款项 1 已确认款项 2 已收/付款',
  PRIMARY KEY (`rec_id`),
  KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_cf_order
-- ----------------------------

-- ----------------------------
-- Table structure for myr_client
-- ----------------------------
DROP TABLE IF EXISTS `myr_client`;
CREATE TABLE `myr_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info_id` varchar(20) DEFAULT NULL COMMENT '信息号',
  `real_name` varchar(45) DEFAULT NULL COMMENT '姓名',
  `age` varchar(10) DEFAULT NULL COMMENT '年龄',
  `sex` int(11) DEFAULT '0' COMMENT '性别（DD）',
  `birthday` int(11) DEFAULT '0' COMMENT '生日',
  `id_card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `is_married` int(11) DEFAULT '0' COMMENT '婚否（DD）',
  `workplace` varchar(100) DEFAULT NULL COMMENT '工作地址',
  `education` int(11) DEFAULT '0' COMMENT '教育程度（DD）',
  `works` int(6) DEFAULT NULL COMMENT '工作(DD)',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `telephone` varchar(100) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机',
  `email` varchar(50) DEFAULT NULL COMMENT 'Email',
  `contact_note` varchar(255) DEFAULT NULL COMMENT '联系备注',
  `month_earn` float(6,2) DEFAULT '0.00' COMMENT '月收入',
  `buy_ability` float(8,2) DEFAULT NULL COMMENT '购买能力',
  `min_price` float(8,2) DEFAULT '0.00' COMMENT '最低价',
  `max_price` float(8,2) DEFAULT '0.00' COMMENT '最高价',
  `buy_plan` text COMMENT '购买计划',
  `is_invest` tinyint(4) DEFAULT '0' COMMENT '是否投资者（DD）',
  `buy_count` tinyint(4) DEFAULT '0' COMMENT '购买总数',
  `agent_name` varchar(45) DEFAULT NULL COMMENT '代理人',
  `agent_id_card` varchar(20) DEFAULT NULL COMMENT '代理人身份证',
  `note` text COMMENT '备注',
  `follow_user_id` int(11) DEFAULT '0' COMMENT '跟单人',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `create_user_id` int(11) DEFAULT '0' COMMENT '创建人',
  `modify_time` int(11) DEFAULT '0' COMMENT '修改时间',
  `modify_user_id` int(11) DEFAULT '0' COMMENT '修改人',
  `dept_id` int(11) DEFAULT NULL COMMENT '部门',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_client
-- ----------------------------

-- ----------------------------
-- Table structure for myr_country
-- ----------------------------
DROP TABLE IF EXISTS `myr_country`;
CREATE TABLE `myr_country` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(50) NOT NULL,
  `cn_country` varchar(30) NOT NULL,
  `code` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_country
-- ----------------------------
INSERT INTO `myr_country` VALUES ('1', 'United States', '美国', 'US');
INSERT INTO `myr_country` VALUES ('2', 'United Kingdom', '英国', 'GB');
INSERT INTO `myr_country` VALUES ('3', 'Australia', '澳大利亚', 'AU');
INSERT INTO `myr_country` VALUES ('4', 'Italy', '意大利', 'IT');
INSERT INTO `myr_country` VALUES ('5', 'Spain', '西班牙', 'ES');
INSERT INTO `myr_country` VALUES ('6', 'Germany', '德国', 'DE');
INSERT INTO `myr_country` VALUES ('7', 'Austria', '奥地利', 'AT');
INSERT INTO `myr_country` VALUES ('8', 'Netherlands', '荷兰', 'NL');
INSERT INTO `myr_country` VALUES ('9', 'Andorra', '安道尔', 'AD');
INSERT INTO `myr_country` VALUES ('10', 'United Arab Emirates', '阿拉伯联合大公国', 'AE');
INSERT INTO `myr_country` VALUES ('11', 'Afghanistan', '阿富汗', 'AF');
INSERT INTO `myr_country` VALUES ('12', 'Antigua And Barbuda', '安提瓜和巴布达', 'AG');
INSERT INTO `myr_country` VALUES ('13', 'Anguilla', '安圭拉', 'AI');
INSERT INTO `myr_country` VALUES ('14', 'Albania', '阿尔巴尼亚', 'AL');
INSERT INTO `myr_country` VALUES ('15', 'Armenia', '亚美尼亚', 'AM');
INSERT INTO `myr_country` VALUES ('16', 'Netherlands Antilles', '荷属安的列斯群岛', 'AN');
INSERT INTO `myr_country` VALUES ('17', 'Angola', '安哥拉', 'AO');
INSERT INTO `myr_country` VALUES ('18', 'Antarctica', '南极洲', 'AQ');
INSERT INTO `myr_country` VALUES ('19', 'Argentina', '阿根廷', 'AR');
INSERT INTO `myr_country` VALUES ('20', 'Samoa,Usa Territory', '萨摩亚(美国新界)', 'AS');
INSERT INTO `myr_country` VALUES ('21', 'Aruba', '雅卢巴', 'AW');
INSERT INTO `myr_country` VALUES ('22', 'Azerbaijan', '阿塞拜疆', 'AZ');
INSERT INTO `myr_country` VALUES ('23', 'Bosnia And Herzegovina', '波斯尼亚 - 黑塞哥维那', 'BA');
INSERT INTO `myr_country` VALUES ('24', 'Barbados', '巴巴多斯', 'BB');
INSERT INTO `myr_country` VALUES ('25', 'Bangladesh', '孟加拉', 'BD');
INSERT INTO `myr_country` VALUES ('26', 'Belgium', '比利时', 'BE');
INSERT INTO `myr_country` VALUES ('27', 'Burkina Faso', '布基纳法索', 'BF');
INSERT INTO `myr_country` VALUES ('28', 'Bulgaria', '保加利亚', 'BG');
INSERT INTO `myr_country` VALUES ('29', 'Bahrain', '巴林', 'BH');
INSERT INTO `myr_country` VALUES ('30', 'Burundi', '布隆迪', 'BI');
INSERT INTO `myr_country` VALUES ('31', 'Benin', '贝宁', 'BJ');
INSERT INTO `myr_country` VALUES ('32', 'Bermuda', '百慕大', 'BM');
INSERT INTO `myr_country` VALUES ('33', 'Brunei Darussalam', '文莱', 'BN');
INSERT INTO `myr_country` VALUES ('34', 'Bolivia', '玻利维亚', 'BO');
INSERT INTO `myr_country` VALUES ('35', 'Brazil', '巴西', 'BR');
INSERT INTO `myr_country` VALUES ('36', 'Bahamas', '巴哈马', 'BS');
INSERT INTO `myr_country` VALUES ('37', 'Bhutan', '不丹', 'BT');
INSERT INTO `myr_country` VALUES ('38', 'Bouvet Island', '布维岛', 'BV');
INSERT INTO `myr_country` VALUES ('39', 'Botswana', '博茨瓦纳', 'BW');
INSERT INTO `myr_country` VALUES ('40', 'Belarus', '白俄罗斯', 'BY');
INSERT INTO `myr_country` VALUES ('41', 'Belize', '伯利兹', 'BZ');
INSERT INTO `myr_country` VALUES ('42', 'Canada', '加拿大', 'CA');
INSERT INTO `myr_country` VALUES ('43', 'Cocos(keeling)islands', '科科斯群岛', 'CC');
INSERT INTO `myr_country` VALUES ('44', 'Congo (dem. Rep. Of)', '刚果（民主共和国）', 'CD');
INSERT INTO `myr_country` VALUES ('45', 'Central African Republic', '中非共和国', 'CF');
INSERT INTO `myr_country` VALUES ('46', 'Congo (rep. Of)', '刚果', 'CG');
INSERT INTO `myr_country` VALUES ('47', 'Switzerland', '瑞士', 'CH');
INSERT INTO `myr_country` VALUES ('48', 'Cook Islands', '库克群岛', 'CK');
INSERT INTO `myr_country` VALUES ('49', 'Chile', '智利', 'CL');
INSERT INTO `myr_country` VALUES ('50', 'Cameroon', '喀麦隆', 'CM');
INSERT INTO `myr_country` VALUES ('51', 'China', '中国', 'CN');
INSERT INTO `myr_country` VALUES ('52', 'Colombia', '哥伦比亚', 'CO');
INSERT INTO `myr_country` VALUES ('53', 'Costa Rica', '哥斯达黎加', 'CR');
INSERT INTO `myr_country` VALUES ('54', 'Cuba', '古巴', 'CU');
INSERT INTO `myr_country` VALUES ('55', 'Cape Verde', '佛得角群岛', 'CV');
INSERT INTO `myr_country` VALUES ('56', 'Christmas Island', '圣诞岛', 'CX');
INSERT INTO `myr_country` VALUES ('57', 'Cyprus', '塞浦路斯', 'CY');
INSERT INTO `myr_country` VALUES ('58', 'Czech Republic', '捷克的', 'CZ');
INSERT INTO `myr_country` VALUES ('59', 'Djibouti', '吉布提', 'DJ');
INSERT INTO `myr_country` VALUES ('60', 'Denmark', '丹麦', 'DK');
INSERT INTO `myr_country` VALUES ('61', 'Dominica', '多米尼加', 'DM');
INSERT INTO `myr_country` VALUES ('62', 'Dominican Republic', '多米尼加共和国', 'DO');
INSERT INTO `myr_country` VALUES ('63', 'Algeria', '阿尔及利亚', 'DZ');
INSERT INTO `myr_country` VALUES ('64', 'Ecuador', '厄瓜多尔', 'EC');
INSERT INTO `myr_country` VALUES ('65', 'Estonia', '爱沙尼亚', 'EE');
INSERT INTO `myr_country` VALUES ('66', 'Egypt', '埃及', 'EG');
INSERT INTO `myr_country` VALUES ('67', 'Western Sahara A)', '西撒哈拉', 'EH');
INSERT INTO `myr_country` VALUES ('68', 'Eritrea', '厄立特里亚', 'ER');
INSERT INTO `myr_country` VALUES ('69', 'Ethiopia', '埃塞俄比亚', 'ET');
INSERT INTO `myr_country` VALUES ('70', 'Finland', '芬兰', 'FI');
INSERT INTO `myr_country` VALUES ('71', 'Fiji', '斐济', 'FJ');
INSERT INTO `myr_country` VALUES ('72', 'Falkland Island (malvinas)', '福克兰群岛', 'FK');
INSERT INTO `myr_country` VALUES ('73', 'Micronesia (federated States Of)', '密克罗尼西亚', 'FM');
INSERT INTO `myr_country` VALUES ('74', 'Faroe Islands', '法罗群岛', 'FO');
INSERT INTO `myr_country` VALUES ('75', 'France', '法国', 'FR');
INSERT INTO `myr_country` VALUES ('76', 'FRANCE, METROPOLITAN', '法国,大都会', 'FX');
INSERT INTO `myr_country` VALUES ('77', 'Gabon', '另外薘', 'GA');
INSERT INTO `myr_country` VALUES ('78', 'Grenada', '格林纳达', 'GD');
INSERT INTO `myr_country` VALUES ('79', 'Georgia', '格鲁吉亚', 'GE');
INSERT INTO `myr_country` VALUES ('80', 'French Guiana', '法属圭亚那', 'GF');
INSERT INTO `myr_country` VALUES ('81', 'Ghana', '加纳', 'GH');
INSERT INTO `myr_country` VALUES ('82', 'Gibraltar', '直布罗陀', 'GI');
INSERT INTO `myr_country` VALUES ('83', 'Greenland', '格陵兰', 'GL');
INSERT INTO `myr_country` VALUES ('84', 'Gambia', '冈比亚', 'GM');
INSERT INTO `myr_country` VALUES ('85', 'Guinea', '新几内亚', 'GN');
INSERT INTO `myr_country` VALUES ('86', 'Guadeloupe', '瓜德罗普岛', 'GP');
INSERT INTO `myr_country` VALUES ('87', 'Equatorial Guinea', '赤道几内亚', 'GQ');
INSERT INTO `myr_country` VALUES ('88', 'Greece', '希腊', 'GR');
INSERT INTO `myr_country` VALUES ('89', 'South Georgia And The South Sandwich Isl', '南乔治亚岛和南桑威奇群岛', 'GS');
INSERT INTO `myr_country` VALUES ('90', 'Guatemala', '危地马拉', 'GT');
INSERT INTO `myr_country` VALUES ('91', 'Guam', '关岛', 'GU');
INSERT INTO `myr_country` VALUES ('92', 'Guinea-bissau', '几内亚比绍', 'GW');
INSERT INTO `myr_country` VALUES ('93', 'Guyana', '圭亚那', 'GY');
INSERT INTO `myr_country` VALUES ('94', 'Hong Kong', '香港', 'HK');
INSERT INTO `myr_country` VALUES ('95', 'Heard Island And Mcdonald Islands', '赫德岛和麦克唐纳岛', 'HM');
INSERT INTO `myr_country` VALUES ('96', 'Honduras', '洪都拉斯', 'HN');
INSERT INTO `myr_country` VALUES ('97', 'Croatia', '克罗地亚', 'HR');
INSERT INTO `myr_country` VALUES ('98', 'Haiti', '海地', 'HT');
INSERT INTO `myr_country` VALUES ('99', 'Hungary', '匈牙利', 'HU');
INSERT INTO `myr_country` VALUES ('100', 'Indonesia', '印尼', 'ID');
INSERT INTO `myr_country` VALUES ('101', 'Ireland', '爱尔兰', 'IE');
INSERT INTO `myr_country` VALUES ('102', 'Israel', '以色列', 'IL');
INSERT INTO `myr_country` VALUES ('103', 'India', '印度', 'IN');
INSERT INTO `myr_country` VALUES ('104', 'British Indian Ocean Territory', '英属印度洋领地', 'IO');
INSERT INTO `myr_country` VALUES ('105', 'Iraq', '伊拉克', 'IQ');
INSERT INTO `myr_country` VALUES ('106', 'Iran (islamic Republic Of)', '伊朗', 'IR');
INSERT INTO `myr_country` VALUES ('107', 'Iceland', '冰岛', 'IS');
INSERT INTO `myr_country` VALUES ('108', 'Jamaica', '牙买加', 'JM');
INSERT INTO `myr_country` VALUES ('109', 'Jordan', '约旦', 'JO');
INSERT INTO `myr_country` VALUES ('110', 'Japan', '日本', 'JP');
INSERT INTO `myr_country` VALUES ('111', 'Kenya', '肯尼亚', 'KE');
INSERT INTO `myr_country` VALUES ('112', 'Kyrgyzstan', '吉尔吉斯', 'KG');
INSERT INTO `myr_country` VALUES ('113', 'Cambodia', '柬埔寨', 'KH');
INSERT INTO `myr_country` VALUES ('114', 'Kiribati', '基里巴斯', 'KI');
INSERT INTO `myr_country` VALUES ('115', 'Comoros', '科摩罗', 'KM');
INSERT INTO `myr_country` VALUES ('116', 'Saint Kitts And Nevis', '圣基茨和尼维斯', 'KN');
INSERT INTO `myr_country` VALUES ('117', 'Korea', '韩国', 'KR');
INSERT INTO `myr_country` VALUES ('118', 'Kuwait', '科威特', 'KW');
INSERT INTO `myr_country` VALUES ('119', 'Cayman Islands', '开曼群岛', 'KY');
INSERT INTO `myr_country` VALUES ('120', 'Kazakhstan', '哈萨克斯坦', 'KZ');
INSERT INTO `myr_country` VALUES ('121', 'Lebanon', '黎巴嫩', 'LB');
INSERT INTO `myr_country` VALUES ('122', 'Saint Lucia', '圣卢西亚', 'LC');
INSERT INTO `myr_country` VALUES ('123', 'Liechtenstein', '列支敦士登', 'LI');
INSERT INTO `myr_country` VALUES ('124', 'Sri Lanka', '斯里兰卡', 'LK');
INSERT INTO `myr_country` VALUES ('125', 'Liberia', '利比里亚', 'LR');
INSERT INTO `myr_country` VALUES ('126', 'Lesotho', '莱索托', 'LS');
INSERT INTO `myr_country` VALUES ('127', 'Lithuania', '立陶宛', 'LT');
INSERT INTO `myr_country` VALUES ('128', 'Luxembourg', '卢森堡', 'LU');
INSERT INTO `myr_country` VALUES ('129', 'Latvia', '拉脱维亚', 'LV');
INSERT INTO `myr_country` VALUES ('130', 'Libyan Arab Jamahiriya', '利比亚', 'LY');
INSERT INTO `myr_country` VALUES ('131', 'Morocco', '摩洛哥', 'MA');
INSERT INTO `myr_country` VALUES ('132', 'Monaco', '摩纳哥', 'MC');
INSERT INTO `myr_country` VALUES ('133', 'MOLDOVA, REPUBLIC OF', '摩尔多瓦', 'MD');
INSERT INTO `myr_country` VALUES ('134', 'Montenegro', '黑山共和国', 'ME');
INSERT INTO `myr_country` VALUES ('135', 'Madagascar', '马达加斯加', 'MG');
INSERT INTO `myr_country` VALUES ('136', 'Marshall Islands', '马绍尔群岛', 'MH');
INSERT INTO `myr_country` VALUES ('137', 'Macedonia (rep. Of) (former Yogoslavia)', '马其顿', 'MK');
INSERT INTO `myr_country` VALUES ('138', 'Mali', '马里', 'ML');
INSERT INTO `myr_country` VALUES ('139', 'Myanmar', '缅甸', 'MM');
INSERT INTO `myr_country` VALUES ('140', 'Mongolia', '蒙古', 'MN');
INSERT INTO `myr_country` VALUES ('141', 'Macau', '澳门', 'MO');
INSERT INTO `myr_country` VALUES ('142', 'Mariana Islands (northern)', '马里亚纳群岛（北方）', 'MP');
INSERT INTO `myr_country` VALUES ('143', 'Martinique', '马提尼克岛', 'MQ');
INSERT INTO `myr_country` VALUES ('144', 'Mauritania', '毛里塔尼亚', 'MR');
INSERT INTO `myr_country` VALUES ('145', 'Montserrat', '蒙特塞拉特', 'MS');
INSERT INTO `myr_country` VALUES ('146', 'Malta', '马耳他', 'MT');
INSERT INTO `myr_country` VALUES ('147', 'Mauritius', '毛里求斯', 'MU');
INSERT INTO `myr_country` VALUES ('148', 'Maldives', '马尔代夫', 'MV');
INSERT INTO `myr_country` VALUES ('149', 'Malawi', '马拉维', 'MW');
INSERT INTO `myr_country` VALUES ('150', 'Mexico', '墨西哥', 'MX');
INSERT INTO `myr_country` VALUES ('151', 'Malaysia', '马来西亚', 'MY');
INSERT INTO `myr_country` VALUES ('152', 'Mozambique', '莫桑比克', 'MZ');
INSERT INTO `myr_country` VALUES ('153', 'Namibia', '纳米比亚', 'NA');
INSERT INTO `myr_country` VALUES ('154', 'New Caledonia', '新喀里多尼亚', 'NC');
INSERT INTO `myr_country` VALUES ('155', 'Niger', '尼日尔', 'NE');
INSERT INTO `myr_country` VALUES ('156', 'Norfolk Island', '无极褔克岛', 'NF');
INSERT INTO `myr_country` VALUES ('157', 'Nigeria', '尼日利亚', 'NG');
INSERT INTO `myr_country` VALUES ('158', 'Nicaragua', '尼加拉瓜', 'NI');
INSERT INTO `myr_country` VALUES ('159', 'Norway', '挪威', 'NO');
INSERT INTO `myr_country` VALUES ('160', 'Nepal', '尼泊尔', 'NP');
INSERT INTO `myr_country` VALUES ('161', 'Nauru', '瑙鲁', 'NR');
INSERT INTO `myr_country` VALUES ('162', 'Niue', '纽埃', 'NU');
INSERT INTO `myr_country` VALUES ('163', 'New Zealand', '新西兰', 'NZ');
INSERT INTO `myr_country` VALUES ('164', 'Oman', '阿曼', 'OM');
INSERT INTO `myr_country` VALUES ('165', 'Panama', '巴拿马', 'PA');
INSERT INTO `myr_country` VALUES ('166', 'Peru', '秘鲁', 'PE');
INSERT INTO `myr_country` VALUES ('167', 'French Polynesia', '法属波利尼西亚', 'PF');
INSERT INTO `myr_country` VALUES ('168', 'Papua New Guinea', '巴布亚新几内亚', 'PG');
INSERT INTO `myr_country` VALUES ('169', 'Philippines', '菲律宾', 'PH');
INSERT INTO `myr_country` VALUES ('170', 'Pakistan', '巴基斯坦', 'PK');
INSERT INTO `myr_country` VALUES ('171', 'Poland', '波兰', 'PL');
INSERT INTO `myr_country` VALUES ('172', 'Saint Pierre And Miquelon', '圣皮埃尔和密克隆', 'PM');
INSERT INTO `myr_country` VALUES ('173', 'Pitcairn', '皮特克恩岛', 'PN');
INSERT INTO `myr_country` VALUES ('174', 'Puerto Rico', '波多黎各', 'PR');
INSERT INTO `myr_country` VALUES ('175', 'Portugal', '葡萄牙', 'PT');
INSERT INTO `myr_country` VALUES ('176', 'Paraguay', '巴拉圭', 'PY');
INSERT INTO `myr_country` VALUES ('177', 'Qatar', '卡塔尔', 'QA');
INSERT INTO `myr_country` VALUES ('178', 'Reunion', '留尼旺岛', 'RE');
INSERT INTO `myr_country` VALUES ('179', 'Romania', '罗马尼亚', 'RO');
INSERT INTO `myr_country` VALUES ('180', 'Serbia', '塞尔维亚', 'RS');
INSERT INTO `myr_country` VALUES ('181', 'Russian Federation', '俄罗斯', 'RU');
INSERT INTO `myr_country` VALUES ('182', 'Rwanda', '卢旺达', 'RW');
INSERT INTO `myr_country` VALUES ('183', 'Saudi Arabia', '沙特阿拉伯', 'SA');
INSERT INTO `myr_country` VALUES ('184', 'Solomon Islands', '索罗门群岛', 'SB');
INSERT INTO `myr_country` VALUES ('185', 'Seychelles', '塞舌尔', 'SC');
INSERT INTO `myr_country` VALUES ('186', 'Sudan', '苏丹', 'SD');
INSERT INTO `myr_country` VALUES ('187', 'Sweden', '瑞典', 'SE');
INSERT INTO `myr_country` VALUES ('188', 'Singapore', '新加坡', 'SG');
INSERT INTO `myr_country` VALUES ('189', 'Saint Helena', '圣赫勒拿岛', 'SH');
INSERT INTO `myr_country` VALUES ('190', 'Slovenia', '斯洛文尼亚', 'SI');
INSERT INTO `myr_country` VALUES ('191', 'Spitsbergen(svalbard)', '斯匹次卑尔根群岛', 'SJ');
INSERT INTO `myr_country` VALUES ('192', 'Slovak Republic', '斯洛伐克', 'SK');
INSERT INTO `myr_country` VALUES ('193', 'Sierra Leone', '塞拉利昂', 'SL');
INSERT INTO `myr_country` VALUES ('194', 'San Marino', '圣马力诺', 'SM');
INSERT INTO `myr_country` VALUES ('195', 'Senegal', '塞内加尔', 'SN');
INSERT INTO `myr_country` VALUES ('196', 'Somalia', '索马里', 'SO');
INSERT INTO `myr_country` VALUES ('197', 'Suriname', '苏里南', 'SR');
INSERT INTO `myr_country` VALUES ('198', 'Sao Tome And Principe', '圣多美和普林西比', 'ST');
INSERT INTO `myr_country` VALUES ('199', 'El Salvador', '萨尔瓦多', 'SV');
INSERT INTO `myr_country` VALUES ('200', 'Syrian Arab Republic', '阿拉伯叙利亚共和国（叙利亚）', 'SY');
INSERT INTO `myr_country` VALUES ('201', 'Swaziland', '斯威士兰', 'SZ');
INSERT INTO `myr_country` VALUES ('202', 'Turks And Caicos Islands', '特克斯和凯科斯群岛', 'TC');
INSERT INTO `myr_country` VALUES ('203', 'Chad', '乍得', 'TD');
INSERT INTO `myr_country` VALUES ('204', 'French Southern Territories', '法国南部地区', 'TF');
INSERT INTO `myr_country` VALUES ('205', 'Togo', '多哥', 'TG');
INSERT INTO `myr_country` VALUES ('206', 'Thailand', '泰国', 'TH');
INSERT INTO `myr_country` VALUES ('207', 'Tajikistan', '塔吉克', 'TJ');
INSERT INTO `myr_country` VALUES ('208', 'Tokelau', '托克劳', 'TK');
INSERT INTO `myr_country` VALUES ('209', 'Turkmenistan', '土库曼', 'TM');
INSERT INTO `myr_country` VALUES ('210', 'Tunisia', '突尼斯', 'TN');
INSERT INTO `myr_country` VALUES ('211', 'Tonga', '汤加', 'TO');
INSERT INTO `myr_country` VALUES ('212', 'East Timor A)', '东帝汶', 'TP');
INSERT INTO `myr_country` VALUES ('213', 'Turkey', '土耳其', 'TR');
INSERT INTO `myr_country` VALUES ('214', 'Trinidad And Tobago', '特里尼达和多巴哥', 'TT');
INSERT INTO `myr_country` VALUES ('215', 'Tuvalu', '图瓦卢', 'TV');
INSERT INTO `myr_country` VALUES ('216', 'Taiwan', '台湾', 'TW');
INSERT INTO `myr_country` VALUES ('217', 'Tanzania', '坦桑尼亚', 'TZ');
INSERT INTO `myr_country` VALUES ('218', 'Ukraine', '乌克兰', 'UA');
INSERT INTO `myr_country` VALUES ('219', 'Uganda', '乌干达', 'UG');
INSERT INTO `myr_country` VALUES ('220', 'United States Minor Outlying Islands', '美国本土外小岛屿', 'UM');
INSERT INTO `myr_country` VALUES ('221', 'Uruguay', '乌拉圭', 'UY');
INSERT INTO `myr_country` VALUES ('222', 'Uzbekistan', '乌兹别克', 'UZ');
INSERT INTO `myr_country` VALUES ('223', 'Vatican City State (holy See)', '教廷', 'VA');
INSERT INTO `myr_country` VALUES ('224', 'Saint Vincent And The Grenadines', '圣文森特和格林纳丁斯', 'VC');
INSERT INTO `myr_country` VALUES ('225', 'Venezuela', '委内瑞拉', 'VE');
INSERT INTO `myr_country` VALUES ('226', 'Tortola (british Virgin Islands)', '英属维尔京群岛（英属维尔京群岛）', 'VG');
INSERT INTO `myr_country` VALUES ('227', 'Virgin Islands (u.s.)', '美国美属维尔京群岛', 'VI');
INSERT INTO `myr_country` VALUES ('228', 'Viet Nam', '越南', 'VN');
INSERT INTO `myr_country` VALUES ('229', 'Vanuatu', '瓦努阿图', 'VU');
INSERT INTO `myr_country` VALUES ('230', 'Wallis And Futuna Islands', '瓦利斯群岛和富图纳群岛', 'WF');
INSERT INTO `myr_country` VALUES ('231', 'SAMOA, WESTERN', '西萨摩亚', 'WS');
INSERT INTO `myr_country` VALUES ('232', 'Canary Islands', '加那利群岛', 'XA');
INSERT INTO `myr_country` VALUES ('233', 'Tristan Da Cunha', '特里斯坦 - 达库尼亚岛', 'XB');
INSERT INTO `myr_country` VALUES ('234', 'Channel Islands', '海峡群岛', 'XC');
INSERT INTO `myr_country` VALUES ('235', 'Ascension', '上升', 'XD');
INSERT INTO `myr_country` VALUES ('236', 'Gaza And Khan Yunis', '加沙地带汗尤尼斯', 'XE');
INSERT INTO `myr_country` VALUES ('237', 'Corsica', '科西嘉岛', 'XF');
INSERT INTO `myr_country` VALUES ('238', 'Spanish Territories Of N. Africa', '北非，西班牙属土', 'XG');
INSERT INTO `myr_country` VALUES ('239', 'Azores', '亚速尔群岛', 'XH');
INSERT INTO `myr_country` VALUES ('240', 'Madeira', '马德拉', 'XI');
INSERT INTO `myr_country` VALUES ('241', 'Balearic Islands', '巴利阿里群岛', 'XJ');
INSERT INTO `myr_country` VALUES ('242', 'Caroline Islands', '加罗林群岛', 'XK');
INSERT INTO `myr_country` VALUES ('243', 'New Zealand Islands Territories', '属土群岛（库克群岛）在新西兰', 'XL');
INSERT INTO `myr_country` VALUES ('244', 'Wake Island', '威克岛', 'XM');
INSERT INTO `myr_country` VALUES ('245', 'Kosovo', '科索沃', 'XO');
INSERT INTO `myr_country` VALUES ('246', 'Yemen (republic Of)', '也门', 'YE');
INSERT INTO `myr_country` VALUES ('247', 'Mayotte', '马约特岛', 'YT');
INSERT INTO `myr_country` VALUES ('248', 'South Africa', '南非', 'ZA');
INSERT INTO `myr_country` VALUES ('249', 'Zambia', '赞比亚', 'ZM');
INSERT INTO `myr_country` VALUES ('250', 'Zimbabwe', '津巴布韦', 'ZW');

-- ----------------------------
-- Table structure for myr_currency
-- ----------------------------
DROP TABLE IF EXISTS `myr_currency`;
CREATE TABLE `myr_currency` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `currency` varchar(5) NOT NULL,
  `rate` float unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency` (`currency`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_currency
-- ----------------------------
INSERT INTO `myr_currency` VALUES ('1', 'USD', '6.3795');
INSERT INTO `myr_currency` VALUES ('2', 'GBP', '9.8261');
INSERT INTO `myr_currency` VALUES ('6', 'EUR', '7.2098');
INSERT INTO `myr_currency` VALUES ('4', 'AUD', '4.5465');
INSERT INTO `myr_currency` VALUES ('5', 'CAD', '4.8136');
INSERT INTO `myr_currency` VALUES ('8', 'CNY', '1');

-- ----------------------------
-- Table structure for myr_customer
-- ----------------------------
DROP TABLE IF EXISTS `myr_customer`;
CREATE TABLE `myr_customer` (
  `customer_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `consignee` varchar(100) NOT NULL,
  `tel` varchar(40) DEFAULT '',
  `buy_degree` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `buy_sum_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `last_buy_time` int(10) unsigned NOT NULL DEFAULT '0',
  `is_value` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '有价值',
  `is_black` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '在黑名单',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `userid` (`userid`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM AUTO_INCREMENT=13722 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_customer
-- ----------------------------

-- ----------------------------
-- Table structure for myr_customer_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_customer_log`;
CREATE TABLE `myr_customer_log` (
  `order_id` mediumint(8) unsigned NOT NULL,
  `crawll_count` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_customer_log
-- ----------------------------

-- ----------------------------
-- Table structure for myr_customer_note
-- ----------------------------
DROP TABLE IF EXISTS `myr_customer_note`;
CREATE TABLE `myr_customer_note` (
  `customer_note_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` mediumint(8) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `remark` varchar(500) NOT NULL DEFAULT '',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_note_id`),
  KEY `customer_id` (`customer_id`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_customer_note
-- ----------------------------

-- ----------------------------
-- Table structure for myr_dd
-- ----------------------------
DROP TABLE IF EXISTS `myr_dd`;
CREATE TABLE `myr_dd` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `dd_name` varchar(30) NOT NULL,
  `dd_caption` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_dd
-- ----------------------------
INSERT INTO `myr_dd` VALUES ('1', 'shipping', '快递方式');
INSERT INTO `myr_dd` VALUES ('3', 'Sales_channels', '销售渠道');
INSERT INTO `myr_dd` VALUES ('4', 'payment', '支付方式');
INSERT INTO `myr_dd` VALUES ('5', 'is_true', '是否');
INSERT INTO `myr_dd` VALUES ('6', 'start_end', '订单位置');
INSERT INTO `myr_dd` VALUES ('7', 'goods_status', '产品状态');
INSERT INTO `myr_dd` VALUES ('8', 'fee_type', '费用类型');
INSERT INTO `myr_dd` VALUES ('9', 'p_status', '采购单状态');
INSERT INTO `myr_dd` VALUES ('10', 'role', '用户类型');
INSERT INTO `myr_dd` VALUES ('11', 'o_status', '单据状态');
INSERT INTO `myr_dd` VALUES ('12', 'stockin_type', '入库类型');
INSERT INTO `myr_dd` VALUES ('13', 'stockout_type', '出库类型');
INSERT INTO `myr_dd` VALUES ('14', 'express_rule', '快递规则选项');
INSERT INTO `myr_dd` VALUES ('15', 'goods_color', '产品颜色');
INSERT INTO `myr_dd` VALUES ('16', 'goods_size', '产品尺寸');
INSERT INTO `myr_dd` VALUES ('17', 'depot', '仓库设置');
INSERT INTO `myr_dd` VALUES ('18', 'print_template', '打印模板');
INSERT INTO `myr_dd` VALUES ('19', 'amazon_site', '亚马逊站点');
INSERT INTO `myr_dd` VALUES ('20', 'ebay_cat', 'Ebay分类ID');
INSERT INTO `myr_dd` VALUES ('21', 'rma_status', 'RMA处理状态');
INSERT INTO `myr_dd` VALUES ('22', 'rma_reason', 'RMA处理原因');
INSERT INTO `myr_dd` VALUES ('23', 'wikitype', '知识库分类');
INSERT INTO `myr_dd` VALUES ('24', 'msg_type', 'Message分类');
INSERT INTO `myr_dd` VALUES ('25', 'db_status', '调拨状态');
INSERT INTO `myr_dd` VALUES ('26', 'db_shipping', '调拨物流方式');
INSERT INTO `myr_dd` VALUES ('27', 'languages', '属性语言');
INSERT INTO `myr_dd` VALUES ('28', 'attribute_option_type', '属性标签类型');
INSERT INTO `myr_dd` VALUES ('30', 'language_code', '语言编码');

-- ----------------------------
-- Table structure for myr_dd_item
-- ----------------------------
DROP TABLE IF EXISTS `myr_dd_item`;
CREATE TABLE `myr_dd_item` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `dd_id` tinyint(3) NOT NULL,
  `di_value` varchar(5) NOT NULL,
  `di_caption` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=235 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_dd_item
-- ----------------------------
INSERT INTO `myr_dd_item` VALUES ('10', '1', '1', 'EMS');
INSERT INTO `myr_dd_item` VALUES ('12', '3', '1', 'ebay');
INSERT INTO `myr_dd_item` VALUES ('15', '4', '1', 'paypal');
INSERT INTO `myr_dd_item` VALUES ('16', '4', '2', 'TT');
INSERT INTO `myr_dd_item` VALUES ('17', '5', '0', '否');
INSERT INTO `myr_dd_item` VALUES ('20', '6', '1', '结束');
INSERT INTO `myr_dd_item` VALUES ('21', '6', '0', '开始');
INSERT INTO `myr_dd_item` VALUES ('46', '6', '2', '流程中');
INSERT INTO `myr_dd_item` VALUES ('47', '7', '1', 'Normal');
INSERT INTO `myr_dd_item` VALUES ('26', '7', '4', 'Suspend');
INSERT INTO `myr_dd_item` VALUES ('27', '7', '5', 'Cease');
INSERT INTO `myr_dd_item` VALUES ('33', '9', '1', '审核通过');
INSERT INTO `myr_dd_item` VALUES ('34', '9', '2', '部分到货');
INSERT INTO `myr_dd_item` VALUES ('35', '9', '3', '完成收货');
INSERT INTO `myr_dd_item` VALUES ('36', '9', '4', '采购结单');
INSERT INTO `myr_dd_item` VALUES ('37', '10', '1', '系统管理员');
INSERT INTO `myr_dd_item` VALUES ('38', '10', '2', '采购');
INSERT INTO `myr_dd_item` VALUES ('39', '11', '1', '已完成');
INSERT INTO `myr_dd_item` VALUES ('40', '11', '2', '已作废');
INSERT INTO `myr_dd_item` VALUES ('41', '11', '0', '已落单');
INSERT INTO `myr_dd_item` VALUES ('42', '4', '3', '快递代收');
INSERT INTO `myr_dd_item` VALUES ('43', '4', '4', '支付宝');
INSERT INTO `myr_dd_item` VALUES ('44', '5', '1', '是');
INSERT INTO `myr_dd_item` VALUES ('48', '10', '3', '操作');
INSERT INTO `myr_dd_item` VALUES ('49', '10', '4', '库管');
INSERT INTO `myr_dd_item` VALUES ('50', '10', '5', '财务');
INSERT INTO `myr_dd_item` VALUES ('51', '12', '1', '采购入库');
INSERT INTO `myr_dd_item` VALUES ('52', '12', '2', '退货入库');
INSERT INTO `myr_dd_item` VALUES ('53', '12', '3', '盘盈入库');
INSERT INTO `myr_dd_item` VALUES ('54', '13', '1', '销售出库');
INSERT INTO `myr_dd_item` VALUES ('55', '13', '2', '盘亏出库');
INSERT INTO `myr_dd_item` VALUES ('56', '12', '6', '撤单入库');
INSERT INTO `myr_dd_item` VALUES ('57', '14', '0', '默认');
INSERT INTO `myr_dd_item` VALUES ('58', '14', '1', '订单金额大于');
INSERT INTO `myr_dd_item` VALUES ('59', '14', '2', '订单金额小于');
INSERT INTO `myr_dd_item` VALUES ('60', '14', '3', '国家等于');
INSERT INTO `myr_dd_item` VALUES ('61', '14', '4', 'ebay表达式');
INSERT INTO `myr_dd_item` VALUES ('63', '15', '1', 'red');
INSERT INTO `myr_dd_item` VALUES ('64', '15', '2', 'yellow');
INSERT INTO `myr_dd_item` VALUES ('65', '16', '1', 'S');
INSERT INTO `myr_dd_item` VALUES ('66', '16', '2', 'M');
INSERT INTO `myr_dd_item` VALUES ('67', '16', '0', 'normal');
INSERT INTO `myr_dd_item` VALUES ('68', '15', '0', 'normal');
INSERT INTO `myr_dd_item` VALUES ('69', '8', '6', '工资');
INSERT INTO `myr_dd_item` VALUES ('70', '9', '0', '采购下单');
INSERT INTO `myr_dd_item` VALUES ('71', '14', '5', 'Sellerid');
INSERT INTO `myr_dd_item` VALUES ('73', '12', '5', '调拨入库');
INSERT INTO `myr_dd_item` VALUES ('74', '13', '3', '调拨出库');
INSERT INTO `myr_dd_item` VALUES ('75', '7', '2', 'Promotion');
INSERT INTO `myr_dd_item` VALUES ('76', '7', '3', 'New');
INSERT INTO `myr_dd_item` VALUES ('77', '3', '3', 'amazon');
INSERT INTO `myr_dd_item` VALUES ('78', '3', '4', 'AE');
INSERT INTO `myr_dd_item` VALUES ('216', '4', '5', 'WU');
INSERT INTO `myr_dd_item` VALUES ('81', '3', '7', '阿里巴巴');
INSERT INTO `myr_dd_item` VALUES ('83', '13', '4', '调换出库');
INSERT INTO `myr_dd_item` VALUES ('84', '12', '4', '调换入库');
INSERT INTO `myr_dd_item` VALUES ('85', '17', '0', '广州流花保税仓');
INSERT INTO `myr_dd_item` VALUES ('88', '3', '9', '其他');
INSERT INTO `myr_dd_item` VALUES ('90', '18', '166', '拣货单');
INSERT INTO `myr_dd_item` VALUES ('223', '10', '6', '客服');
INSERT INTO `myr_dd_item` VALUES ('224', '10', '7', '出货员');
INSERT INTO `myr_dd_item` VALUES ('98', '14', '6', 'SKU包含');
INSERT INTO `myr_dd_item` VALUES ('99', '19', '1', 'US');
INSERT INTO `myr_dd_item` VALUES ('100', '19', '2', 'UK');
INSERT INTO `myr_dd_item` VALUES ('101', '19', '3', 'DE');
INSERT INTO `myr_dd_item` VALUES ('102', '19', '4', 'FR');
INSERT INTO `myr_dd_item` VALUES ('103', '19', '5', 'IT');
INSERT INTO `myr_dd_item` VALUES ('104', '19', '6', 'JP');
INSERT INTO `myr_dd_item` VALUES ('105', '19', '7', 'CN');
INSERT INTO `myr_dd_item` VALUES ('106', '19', '8', 'CA');
INSERT INTO `myr_dd_item` VALUES ('107', '20', '1', 'Collectibles');
INSERT INTO `myr_dd_item` VALUES ('108', '20', '99', 'Everything Else');
INSERT INTO `myr_dd_item` VALUES ('109', '20', '220', 'Toys_Hobbies');
INSERT INTO `myr_dd_item` VALUES ('110', '20', '237', 'Dolls_Bears');
INSERT INTO `myr_dd_item` VALUES ('111', '20', '260', 'Stamps');
INSERT INTO `myr_dd_item` VALUES ('112', '20', '267', 'Books');
INSERT INTO `myr_dd_item` VALUES ('113', '20', '281', 'Jewelry*Watches');
INSERT INTO `myr_dd_item` VALUES ('114', '20', '293', 'Consumer Electronics');
INSERT INTO `myr_dd_item` VALUES ('115', '20', '316', 'Specialty Services');
INSERT INTO `myr_dd_item` VALUES ('116', '20', '382', 'Sporting Goods');
INSERT INTO `myr_dd_item` VALUES ('117', '20', '550', 'Art');
INSERT INTO `myr_dd_item` VALUES ('118', '20', '619', 'Musical Instruments');
INSERT INTO `myr_dd_item` VALUES ('119', '20', '625', 'Cameras*Photo');
INSERT INTO `myr_dd_item` VALUES ('120', '20', '870', 'Pottery*Glass');
INSERT INTO `myr_dd_item` VALUES ('121', '20', '1249', 'Video Games');
INSERT INTO `myr_dd_item` VALUES ('122', '20', '1281', 'Pet Supplies');
INSERT INTO `myr_dd_item` VALUES ('123', '20', '1305', 'Tickets');
INSERT INTO `myr_dd_item` VALUES ('124', '20', '2984', 'Baby');
INSERT INTO `myr_dd_item` VALUES ('125', '20', '3252', 'Travel');
INSERT INTO `myr_dd_item` VALUES ('126', '20', '10159', 'Partner');
INSERT INTO `myr_dd_item` VALUES ('127', '20', '10542', 'Real Estate');
INSERT INTO `myr_dd_item` VALUES ('128', '20', '11116', 'Coins*Paper Mone');
INSERT INTO `myr_dd_item` VALUES ('129', '20', '11232', 'DVDs*Movies');
INSERT INTO `myr_dd_item` VALUES ('130', '20', '11233', 'Music');
INSERT INTO `myr_dd_item` VALUES ('131', '20', '11450', 'Clothing*Shoes*Accessories');
INSERT INTO `myr_dd_item` VALUES ('132', '20', '11700', 'Home*Garden');
INSERT INTO `myr_dd_item` VALUES ('133', '20', '12576', 'Business*Industrial');
INSERT INTO `myr_dd_item` VALUES ('134', '20', '14339', 'Crafts');
INSERT INTO `myr_dd_item` VALUES ('135', '20', '15032', 'Cell Phones*PDAs');
INSERT INTO `myr_dd_item` VALUES ('136', '20', '20081', 'Antiques');
INSERT INTO `myr_dd_item` VALUES ('138', '20', '45100', 'Entertainment');
INSERT INTO `myr_dd_item` VALUES ('139', '20', '58058', 'Computer*Networking');
INSERT INTO `myr_dd_item` VALUES ('140', '20', '64482', 'SportsMem*Cards*Fan Shop');
INSERT INTO `myr_dd_item` VALUES ('141', '20', '17200', 'Gift Cards*Coupons');
INSERT INTO `myr_dd_item` VALUES ('142', '14', '7', '国家区域属于');
INSERT INTO `myr_dd_item` VALUES ('144', '21', '0', '未处理');
INSERT INTO `myr_dd_item` VALUES ('145', '21', '1', '退换货');
INSERT INTO `myr_dd_item` VALUES ('146', '21', '2', '不处理');
INSERT INTO `myr_dd_item` VALUES ('147', '21', '3', '退款');
INSERT INTO `myr_dd_item` VALUES ('148', '22', '1', 'Customer Error');
INSERT INTO `myr_dd_item` VALUES ('149', '22', '2', 'Quality Problem');
INSERT INTO `myr_dd_item` VALUES ('150', '22', '3', 'Handling Error');
INSERT INTO `myr_dd_item` VALUES ('151', '22', '4', 'Warehouse Error');
INSERT INTO `myr_dd_item` VALUES ('152', '22', '5', 'Description Error');
INSERT INTO `myr_dd_item` VALUES ('153', '22', '6', 'Incompatible');
INSERT INTO `myr_dd_item` VALUES ('154', '22', '7', 'Unfit');
INSERT INTO `myr_dd_item` VALUES ('155', '22', '8', 'Others');
INSERT INTO `myr_dd_item` VALUES ('157', '14', '8', 'SKU结尾');
INSERT INTO `myr_dd_item` VALUES ('160', '24', '0', '未定义');
INSERT INTO `myr_dd_item` VALUES ('161', '24', '1', '询问发货');
INSERT INTO `myr_dd_item` VALUES ('162', '14', '9', '仓库包含产品');
INSERT INTO `myr_dd_item` VALUES ('163', '25', '0', '调拨开单');
INSERT INTO `myr_dd_item` VALUES ('164', '25', '1', '调拨完成');
INSERT INTO `myr_dd_item` VALUES ('165', '25', '2', '已作废');
INSERT INTO `myr_dd_item` VALUES ('166', '25', '3', '调拨在途');
INSERT INTO `myr_dd_item` VALUES ('167', '19', '9', 'ES');
INSERT INTO `myr_dd_item` VALUES ('168', '14', '10', '重量大于');
INSERT INTO `myr_dd_item` VALUES ('169', '14', '11', '重量小于');
INSERT INTO `myr_dd_item` VALUES ('170', '26', '0', '未定义');
INSERT INTO `myr_dd_item` VALUES ('171', '25', '4', '部分到货');
INSERT INTO `myr_dd_item` VALUES ('174', '14', '12', '订单运费大于');
INSERT INTO `myr_dd_item` VALUES ('175', '14', '13', '订单运费小于');
INSERT INTO `myr_dd_item` VALUES ('177', '27', '1', '中文');
INSERT INTO `myr_dd_item` VALUES ('178', '27', '2', '英文');
INSERT INTO `myr_dd_item` VALUES ('179', '27', '3', '德语');
INSERT INTO `myr_dd_item` VALUES ('180', '27', '4', '法语');
INSERT INTO `myr_dd_item` VALUES ('181', '27', '5', '意大利语');
INSERT INTO `myr_dd_item` VALUES ('182', '28', '1', '文本输入框');
INSERT INTO `myr_dd_item` VALUES ('183', '28', '2', '多行文本框');
INSERT INTO `myr_dd_item` VALUES ('184', '28', '3', '单选按钮');
INSERT INTO `myr_dd_item` VALUES ('185', '28', '4', '复选框');
INSERT INTO `myr_dd_item` VALUES ('186', '28', '5', '下拉选择框');
INSERT INTO `myr_dd_item` VALUES ('187', '28', '6', '价格');
INSERT INTO `myr_dd_item` VALUES ('188', '28', '7', '时间日期');
INSERT INTO `myr_dd_item` VALUES ('189', '28', '8', '是/否');
INSERT INTO `myr_dd_item` VALUES ('190', '27', '6', '西班牙');
INSERT INTO `myr_dd_item` VALUES ('191', '29', '1', '待属性');
INSERT INTO `myr_dd_item` VALUES ('192', '29', '2', '待图片');
INSERT INTO `myr_dd_item` VALUES ('193', '29', '3', '待文案');
INSERT INTO `myr_dd_item` VALUES ('194', '29', '4', '待上传');
INSERT INTO `myr_dd_item` VALUES ('195', '29', '5', '待上架');
INSERT INTO `myr_dd_item` VALUES ('196', '29', '6', '上架审核中');
INSERT INTO `myr_dd_item` VALUES ('197', '29', '7', '上架审核失败');
INSERT INTO `myr_dd_item` VALUES ('198', '29', '8', '正在销售');
INSERT INTO `myr_dd_item` VALUES ('199', '29', '9', '已下架');
INSERT INTO `myr_dd_item` VALUES ('200', '27', '7', '俄语');
INSERT INTO `myr_dd_item` VALUES ('201', '30', '1', 'zh-CN');
INSERT INTO `myr_dd_item` VALUES ('202', '30', '2', 'en');
INSERT INTO `myr_dd_item` VALUES ('203', '30', '3', 'de');
INSERT INTO `myr_dd_item` VALUES ('204', '30', '4', 'fr');
INSERT INTO `myr_dd_item` VALUES ('205', '30', '5', 'it');
INSERT INTO `myr_dd_item` VALUES ('206', '30', '6', 'es');
INSERT INTO `myr_dd_item` VALUES ('207', '30', '7', 'ru');
INSERT INTO `myr_dd_item` VALUES ('213', '9', '6', '问题订单');
INSERT INTO `myr_dd_item` VALUES ('218', '8', '5', '房租');
INSERT INTO `myr_dd_item` VALUES ('219', '8', '4', '运费');
INSERT INTO `myr_dd_item` VALUES ('220', '1', '0', '未定义');
INSERT INTO `myr_dd_item` VALUES ('234', '3', '10', '线下订单');
INSERT INTO `myr_dd_item` VALUES ('232', '1', '2', '圆通');
INSERT INTO `myr_dd_item` VALUES ('233', '1', '3', '广州EMS');
INSERT INTO `myr_dd_item` VALUES ('227', '9', '5', '等待入库');
INSERT INTO `myr_dd_item` VALUES ('228', '17', '2', '深圳保宏保税仓');
INSERT INTO `myr_dd_item` VALUES ('229', '17', '3', '互联易深圳仓');
INSERT INTO `myr_dd_item` VALUES ('230', '17', '4', '互联易香港仓');
INSERT INTO `myr_dd_item` VALUES ('231', '17', '5', '广州南沙保税仓');

-- ----------------------------
-- Table structure for myr_depot
-- ----------------------------
DROP TABLE IF EXISTS `myr_depot`;
CREATE TABLE `myr_depot` (
  `shelf_id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `depot_id` tinyint(3) unsigned NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shelf_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_depot
-- ----------------------------
INSERT INTO `myr_depot` VALUES ('16', '成品区货架', '0', '1');
INSERT INTO `myr_depot` VALUES ('14', '成品区货架', '5', '1');
INSERT INTO `myr_depot` VALUES ('13', '成品区货架', '4', '1');
INSERT INTO `myr_depot` VALUES ('12', '成品区货架', '3', '1');
INSERT INTO `myr_depot` VALUES ('11', '成品区货架', '2', '1');
INSERT INTO `myr_depot` VALUES ('15', '阿斯顿发生', '2', '0');

-- ----------------------------
-- Table structure for myr_depot_stock
-- ----------------------------
DROP TABLE IF EXISTS `myr_depot_stock`;
CREATE TABLE `myr_depot_stock` (
  `goods_id` mediumint(8) unsigned NOT NULL,
  `shelf_id` tinyint(3) unsigned NOT NULL,
  `goods_qty` mediumint(8) NOT NULL DEFAULT '0',
  `varstock` smallint(5) unsigned NOT NULL DEFAULT '0',
  `warn_qty` smallint(5) NOT NULL DEFAULT '0',
  `stock_place` varchar(20) NOT NULL,
  KEY `depot_id` (`shelf_id`),
  KEY `goods_id_2` (`goods_id`),
  KEY `goods_id` (`goods_id`,`shelf_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_depot_stock
-- ----------------------------
INSERT INTO `myr_depot_stock` VALUES ('1', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('2', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('3', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('4', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('5', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('6', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('7', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('8', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('9', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('10', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('11', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('12', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('13', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('14', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('15', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('16', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('17', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('18', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('19', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('20', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('21', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('22', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('23', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('24', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('25', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('26', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('27', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('28', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('29', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('30', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('31', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('32', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('33', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('34', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('35', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('36', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('37', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('38', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('39', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('40', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('41', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('42', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('43', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('44', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('45', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('46', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('47', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('48', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('49', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('50', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('51', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('52', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('53', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('54', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('55', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('56', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('57', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('58', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('59', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('60', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('61', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('62', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('63', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('64', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('65', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('66', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('67', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('68', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('69', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('70', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('71', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('72', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('73', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('74', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('75', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('76', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('77', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('78', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('79', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('80', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('81', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('82', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('83', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('84', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('85', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('86', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('87', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('88', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('89', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('90', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('91', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('92', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('93', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('94', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('95', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('96', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('97', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('98', '0', '25', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('98', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('97', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('96', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('95', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('94', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('93', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('92', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('91', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('90', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('89', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('88', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('87', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('86', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('85', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('84', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('83', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('82', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('81', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('80', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('79', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('78', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('77', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('76', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('75', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('74', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('73', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('72', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('71', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('70', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('69', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('68', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('67', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('66', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('65', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('64', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('63', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('62', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('61', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('60', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('59', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('58', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('57', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('56', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('55', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('54', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('53', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('52', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('51', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('50', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('49', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('48', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('47', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('46', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('45', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('44', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('43', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('42', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('41', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('40', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('39', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('38', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('37', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('36', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('35', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('34', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('33', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('32', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('31', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('30', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('29', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('28', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('27', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('26', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('25', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('24', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('23', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('22', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('21', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('20', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('19', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('18', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('17', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('16', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('15', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('14', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('13', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('12', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('11', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('10', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('9', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('8', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('7', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('6', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('5', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('4', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('3', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('2', '11', '50', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('1', '11', '49', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('98', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('97', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('96', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('95', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('94', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('93', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('92', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('91', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('90', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('89', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('88', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('87', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('86', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('85', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('84', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('83', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('82', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('81', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('80', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('79', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('78', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('77', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('76', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('75', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('74', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('73', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('72', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('71', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('70', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('69', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('68', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('67', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('66', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('65', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('64', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('63', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('62', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('61', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('60', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('59', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('58', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('57', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('56', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('55', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('54', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('53', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('52', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('51', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('50', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('49', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('48', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('47', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('46', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('45', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('44', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('43', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('42', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('41', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('40', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('39', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('38', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('37', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('36', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('35', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('34', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('33', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('32', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('31', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('30', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('29', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('28', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('27', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('26', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('25', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('24', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('23', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('22', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('21', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('20', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('19', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('18', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('17', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('16', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('15', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('14', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('13', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('12', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('11', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('10', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('9', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('8', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('7', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('6', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('5', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('4', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('3', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('2', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('1', '12', '10', '0', '5', '');
INSERT INTO `myr_depot_stock` VALUES ('99', '0', '10', '7', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('135', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('134', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('121', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('122', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('123', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('124', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('125', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('126', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('127', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('128', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('129', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('130', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('131', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('132', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('133', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('136', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('137', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('138', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('139', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('140', '0', '238', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('141', '0', '185', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('142', '0', '597', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('143', '0', '474', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('144', '0', '1', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('145', '0', '25', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('146', '0', '672', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('147', '0', '56', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('148', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('149', '0', '350', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('150', '0', '395', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('151', '0', '105', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('152', '0', '113', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('153', '0', '103', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('154', '0', '46', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('155', '0', '291', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('156', '0', '297', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('157', '0', '240', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('158', '0', '240', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('159', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('160', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('161', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('162', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('163', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('164', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('165', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('166', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('167', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('168', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('169', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('170', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('171', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('172', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('173', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('174', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('175', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('176', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('177', '0', '80', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('178', '0', '190', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('179', '0', '0', '0', '0', '');
INSERT INTO `myr_depot_stock` VALUES ('180', '0', '0', '0', '0', '');

-- ----------------------------
-- Table structure for myr_dept
-- ----------------------------
DROP TABLE IF EXISTS `myr_dept`;
CREATE TABLE `myr_dept` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `dept_caption` varchar(60) NOT NULL,
  `parent_id` varchar(4) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_dept
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebaymessage
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebaymessage`;
CREATE TABLE `myr_ebaymessage` (
  `id` smallint(8) unsigned NOT NULL AUTO_INCREMENT,
  `messageid` varchar(20) NOT NULL,
  `SenderID` varchar(100) NOT NULL,
  `sender_mail` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `subject` varchar(255) NOT NULL,
  `itemid` varchar(19) NOT NULL,
  `itemtitle` varchar(80) NOT NULL,
  `answer` text NOT NULL,
  `accountid` tinyint(3) unsigned NOT NULL,
  `CreationDate` int(10) unsigned NOT NULL,
  `itemEndTime` int(10) NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  `endtime` int(10) NOT NULL,
  `answerstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ebay_ack` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `MessageType` varchar(50) NOT NULL,
  `QuestionType` varchar(50) NOT NULL,
  `msg_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `messageid` (`messageid`),
  KEY `itemid` (`itemid`),
  KEY `accountid` (`accountid`)
) ENGINE=MyISAM AUTO_INCREMENT=842 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebaymessage
-- ----------------------------
INSERT INTO `myr_ebaymessage` VALUES ('828', '848882226015', 'faridaah', 'farida_dr4109phja@members.ebay.com', 'Good day,\r\nI am from saudi Arabia and I want to get 5 Pcs of this product (http://www.ebay.com/itm/110-240V-AC-Wall-Mount-Motion-Sensor-Automatic-PIR-Infrared-Sensor-Light-Switch/191182627768?_trksid=p2047675.c100010.m2109&_trkparms=aid%3D555012%26algo%3DPW.MBE%26ao%3D1%26asc%3D22769%26meid%3D7140632977081008853%26pid%3D100010%26prg%3D9826%26rk%3D10%26rkt%3D24%26sd%3D321411083980). kindly provide me with shipping possibility and all related.\r\nBest regards,\r\nAli', 'Shipping: faridaah sent a message about 110 -240V/AC Wall Mount Motion Sensor Automatic PIR Infrared Sensor Light Switch #191182627768', '191182627768', '110 -240V/AC Wall Mount Motion Sensor Automatic PIR Infrared Sensor Light Switch', '', '82', '1401012795', '1401628633', '1401781777', '0', '0', '0', 'AskSellerQuestion', 'Shipping', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('829', '836427795017', 'gerua2014', 'gerua2_kwiy2745pj@members.ebay.com', 'I made you pay 22,05,2014. \r\nWhy you have not sent me an item?', 'Shipping: gerua2014 sent a message about 360 degree range 220V PIR Motion Sensor Switch with 3 detectors #201084483241', '201084483241', '360 degree range 220V PIR Motion Sensor Switch with 3 detectors', '', '82', '1401024543', '1401764792', '1401781777', '0', '0', '0', 'ContactTransactionPartner', 'Shipping', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('830', '836677307017', 'anatoly.goldberg', 'anatol_kqn5729sgj@members.ebay.com', 'Can you ship this item to Israel ?\r\nWhat is shipping cost and delivery time ?', 'Shipping: anatoly.goldberg sent a message about 360 degree range 220V PIR Motion Sensor Switch with 3 detectors #201084483241', '201084483241', '360 degree range 220V PIR Motion Sensor Switch with 3 detectors', '', '82', '1401064530', '1401764792', '1401781777', '0', '0', '0', 'AskSellerQuestion', 'Shipping', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('832', '839814722018', 'bongmasterx', 'bongma_jy4147sh@members.ebay.com', 'thank you. unfortunately that will not work for me.  sorry for the mistake.', 'bongmasterx has sent a question about item #201084483241, that ended on Jun-02-14 20:06:32 PDT - 360 degree range 220V PIR Motion Sensor Switch with 3 detectors', '201084483241', '360 degree range 220V PIR Motion Sensor Switch with 3 detectors', '', '82', '1401766984', '1401764792', '1401851245', '0', '0', '0', 'AskSellerQuestion', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('833', '840428889018', 'bongmasterx', 'bongma_jy4147sh@members.ebay.com', 'This won\'t work for my application .', 'bongmasterx sent a message about 360 degree range 220V PIR Motion Sensor Switch with 3 detectors #201084483241', '201084483241', '360 degree range 220V PIR Motion Sensor Switch with 3 detectors', '', '82', '1401834467', '1401764792', '1401851245', '0', '0', '0', 'ContactTransactionPartner', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('834', '853779422015', 'faridaah', 'farida_dr4109phja@members.ebay.com.hk', 'Dear friend,\r\nIs it possible to get the correct item which is wall mounted auto pir motion sensor switch? and how much is the last price for 5 pcs?\r\nThanks,', 'faridaah has sent a question about item #321373289793, that ended on Apr-28-14 07:57:22 PDT - 110~220V/AC high quality wall mounted Auto Pir  Motion Sensor Switch', '', '', '', '83', '1401707851', '0', '1402020179', '0', '0', '0', 'ContactEbayMember', 'General', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('835', '854355296015', 'faridaah', 'farida_dr4109phja@members.ebay.com.hk', 'Hi,\nThe most important is that must be a wall switch.  If yes, kindly provide me with a photo for it.\nThanks,', 'faridaah has sent a question about item #321373289793, that ended on Apr-28-14 07:57:22 PDT - 110~220V/AC high quality wall mounted Auto Pir  Motion Sensor Switch', '', '', '', '83', '1401774035', '0', '1402020179', '0', '0', '0', 'ResponseToContacteBayMember', 'General', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('836', '851803216013', 'geomaros', 'geomar_iwil2305mif@members.ebay.com', 'Hello,\r\n\r\nis this module waterproof?\r\nHow to set \"delay\" time?\r\n\r\nThank you', 'Details about item: geomaros sent a message about DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting #191200516317', '191200516317', 'DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting', '', '82', '1401910427', '1404353497', '1402020249', '0', '0', '0', 'AskSellerQuestion', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('837', '843307559017', 'rfrenkel', 'rfrenk_drs3726uet@members.ebay.com', 'What is the function of the 3 potentiometers on the PC board? Is it on-time, sensitivity, and light sensitivity? Which is for what? How is the time adjusted?\r\n\r\nYou say the PIR is more sensitive “left-right” but do indicate which is the top. \r\n\r\n', 'Details about item: rfrenkel sent a message about DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting #191200516317', '191200516317', 'DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting', '', '82', '1401973108', '1404353497', '1402020249', '0', '0', '0', 'AskSellerQuestion', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('838', '843337104017', 'rfrenkel', 'rfrenk_drs3726uet@members.ebay.com', 'Thank you for your quick response. I assume the orientation in the picture indicates TOP or UP, DOWN.', 'Details about item: rfrenkel sent a message about DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting #191200516317', '191200516317', 'DC12V DC24V mini LED motion sensor switch,used on the Motion-activated lighting', '', '82', '1401976460', '1404353497', '1402020249', '0', '0', '0', 'ResponseToASQQuestion', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('839', '848881204015', 'faridaah', 'farida_dr4109phja@members.ebay.com.hk', 'Hello,\r\nI am not asking about the price. I am asking the product itself. check the link below so you will understand what I am looking for.\r\n\r\nhttp://www.ebay.com/itm/Manual-On-Only-Occupancy-Vacancy-Motion-Sensor-Switch-White-Movement-Detector/261079833524?_trksid=p2047675.c100005.m1851&_trkparms=aid%3D222003%26algo%3DSIC.FIT%26ao%3D1%26asc%3D22769%26meid%3D7140625084037904815%26pid%3D100005%26prg%3D9826%26rk%3D3%26rkt%3D6%26sd%3D321411083980&rt=nc\r\n\r\nUrgently response is highly appreciated.\r\n\r\nBest regards,', 'faridaah has sent a question about item #321373289793, that ended on Apr-28-14 07:57:22 PDT - 110~220V/AC high quality wall mounted Auto Pir  Motion Sensor Switch', '', '', '', '83', '1401012335', '0', '1402112292', '0', '0', '0', 'ContactEbayMember', 'General', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('840', '840277827014', 'tcesystems', 'tcesys_grwl6358mij@members.ebay.com.hk', 'Just to confirm.\r\n\r\nI will be getting 10pcs for the purchase?', 'Details about item: tcesystems sent a message about DC12V DC24V mini motion sensor switch (10pcs/lot) #321411083980', '321411083980', 'DC12V DC24V mini motion sensor switch (10pcs/lot)', '', '83', '1401195687', '1401340462', '1402112292', '0', '0', '0', 'AskSellerQuestion', 'None', '0', '');
INSERT INTO `myr_ebaymessage` VALUES ('841', '836120726019', 'han2465', 'han246_dx5899ldtc@members.ebay.com.hk', '\nOkay. No problem. \n\nThank you\n\n나의 iPhone에서 보냄\n\n2014. 5. 29. 오후 3:46 \"eBay Member: etouch008\" <> 작성:\n\n', 'Re: etouch008 sent a message about DC12V DC24V mini motion sensor switch (10pcs/lot) #321411083980', '321411083980', 'DC12V DC24V mini motion sensor switch (10pcs/lot)', '', '83', '1401415473', '1401340462', '1402112292', '0', '0', '0', 'ContacteBayMemberViaAnonymousEmail', 'None', '0', '');

-- ----------------------------
-- Table structure for myr_ebayselling
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebayselling`;
CREATE TABLE `myr_ebayselling` (
  `rec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` tinyint(3) unsigned NOT NULL,
  `ItemID` bigint(19) unsigned NOT NULL,
  `ListingDuration` varchar(20) NOT NULL,
  `ListingType` varchar(25) NOT NULL,
  `Quantity` mediumint(8) unsigned NOT NULL,
  `buyitnowprice` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `ShippingServiceCost` decimal(10,2) NOT NULL,
  `Title` varchar(120) NOT NULL,
  `SKU` varchar(50) NOT NULL,
  `GalleryURL` varchar(255) NOT NULL,
  `starttime` int(10) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL,
  `startprice` decimal(10,2) NOT NULL,
  `bidcount` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `SKU` (`SKU`),
  KEY `ItemID` (`ItemID`)
) ENGINE=MyISAM AUTO_INCREMENT=20489 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebayselling
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebayselling_bulk
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebayselling_bulk`;
CREATE TABLE `myr_ebayselling_bulk` (
  `rec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` tinyint(3) unsigned NOT NULL,
  `ItemID` bigint(19) unsigned NOT NULL,
  `ListingType` varchar(25) NOT NULL,
  `Quantity` mediumint(8) unsigned NOT NULL,
  `StartPrice` decimal(10,2) NOT NULL,
  `Title` varchar(120) NOT NULL,
  `SKU` varchar(50) NOT NULL,
  `GalleryURL` varchar(255) NOT NULL,
  `auto` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_need` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `SKU` (`SKU`),
  KEY `ItemID` (`ItemID`),
  KEY `account_id` (`account_id`,`ItemID`,`SKU`)
) ENGINE=MyISAM AUTO_INCREMENT=1825 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebayselling_bulk
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebayselling_temp
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebayselling_temp`;
CREATE TABLE `myr_ebayselling_temp` (
  `account_id` tinyint(3) unsigned NOT NULL,
  `ItemID` bigint(19) unsigned NOT NULL,
  KEY `account_id` (`account_id`),
  KEY `account_id_2` (`account_id`,`ItemID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebayselling_temp
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebay_account
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebay_account`;
CREATE TABLE `myr_ebay_account` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(60) NOT NULL,
  `p_id` tinyint(4) NOT NULL,
  `devID` varchar(60) NOT NULL,
  `appID` varchar(60) NOT NULL,
  `certID` varchar(60) NOT NULL,
  `userToken` text NOT NULL,
  `APIDevUserID` varchar(50) NOT NULL,
  `APIPassword` varchar(80) NOT NULL,
  `APISellerUserID` varchar(50) NOT NULL,
  `site` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `cat_id` varchar(150) NOT NULL,
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `url` varchar(255) NOT NULL,
  `ac_token` varchar(50) NOT NULL,
  `re_token` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebay_account
-- ----------------------------
INSERT INTO `myr_ebay_account` VALUES ('1', 'test', '0', '', '', '', '', '', '', '', '0', '', '0', '', '', '');
INSERT INTO `myr_ebay_account` VALUES ('2', 'admin', '0', '', '', '', '', '', '', '', '0', '', '0', '', '', '');

-- ----------------------------
-- Table structure for myr_ebay_bestmatch
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebay_bestmatch`;
CREATE TABLE `myr_ebay_bestmatch` (
  `itemid` bigint(19) unsigned NOT NULL,
  `addtime` int(10) NOT NULL,
  `impression` bigint(20) unsigned NOT NULL DEFAULT '0',
  `viewitemcount` int(10) unsigned NOT NULL DEFAULT '0',
  `salescount` int(10) unsigned NOT NULL DEFAULT '0',
  `watchcount` int(10) unsigned NOT NULL DEFAULT '0',
  `viewItemPerImpression` double unsigned NOT NULL DEFAULT '0',
  `salesPerImpression` double unsigned NOT NULL DEFAULT '0',
  `salesPerViewItem` double unsigned NOT NULL DEFAULT '0',
  `currentprice` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `bidcount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `itemrank` int(10) unsigned NOT NULL DEFAULT '0',
  `quantityAvailable` int(10) unsigned NOT NULL DEFAULT '0',
  `quantitySold` int(10) unsigned NOT NULL DEFAULT '0',
  `account_id` tinyint(3) unsigned NOT NULL,
  KEY `itemid` (`itemid`),
  KEY `itemid_2` (`itemid`,`addtime`),
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebay_bestmatch
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebay_category
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebay_category`;
CREATE TABLE `myr_ebay_category` (
  `account_id` tinyint(3) unsigned NOT NULL,
  `cat_id` bigint(20) NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `order_id` tinyint(3) NOT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebay_category
-- ----------------------------

-- ----------------------------
-- Table structure for myr_ebay_feedback
-- ----------------------------
DROP TABLE IF EXISTS `myr_ebay_feedback`;
CREATE TABLE `myr_ebay_feedback` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `CommentingUser` varchar(80) NOT NULL,
  `CommentText` varchar(125) NOT NULL,
  `CommentType` varchar(30) NOT NULL,
  `CommentTime` int(10) unsigned NOT NULL,
  `FeedbackResponse` varchar(125) NOT NULL,
  `ItemID` varchar(19) NOT NULL,
  `FeedbackID` varchar(15) NOT NULL,
  `TransactionID` varchar(20) NOT NULL,
  `OrderLineItemID` varchar(50) NOT NULL,
  `ItemTitle` varchar(120) NOT NULL,
  `ItemPrice` decimal(10,2) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL,
  `endtime` int(10) unsigned NOT NULL,
  `order_id` mediumint(8) unsigned NOT NULL,
  `Sales_account_id` tinyint(2) unsigned NOT NULL,
  `answerstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_ebay_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for myr_email_attach
-- ----------------------------
DROP TABLE IF EXISTS `myr_email_attach`;
CREATE TABLE `myr_email_attach` (
  `email_attach_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) DEFAULT '',
  `email_uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`email_attach_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_email_attach
-- ----------------------------

-- ----------------------------
-- Table structure for myr_email_cfg
-- ----------------------------
DROP TABLE IF EXISTS `myr_email_cfg`;
CREATE TABLE `myr_email_cfg` (
  `emailcfg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `in_server_addr` varchar(255) DEFAULT '',
  `in_port` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `in_protocol` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'imap',
  `in_ssl` tinyint(1) unsigned DEFAULT '0',
  `out_server_addr` varchar(255) DEFAULT '',
  `out_port` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `out_protocol` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'smtp',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `remark` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`emailcfg_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_email_cfg
-- ----------------------------

-- ----------------------------
-- Table structure for myr_email_msg
-- ----------------------------
DROP TABLE IF EXISTS `myr_email_msg`;
CREATE TABLE `myr_email_msg` (
  `email_msg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(100) NOT NULL,
  `fromName` varchar(200) NOT NULL,
  `toOther` varchar(255) DEFAULT NULL,
  `toOtherName` varchar(510) DEFAULT NULL,
  `subject` varchar(150) NOT NULL,
  `to` varchar(100) NOT NULL,
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `seen` varchar(10) DEFAULT NULL,
  `date` varchar(50) NOT NULL,
  `body` longtext NOT NULL,
  `boxtype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_reply` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`email_msg_id`),
  KEY `from` (`from`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_email_msg
-- ----------------------------

-- ----------------------------
-- Table structure for myr_express_rule
-- ----------------------------
DROP TABLE IF EXISTS `myr_express_rule`;
CREATE TABLE `myr_express_rule` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `rule_id` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `express_id` int(8) unsigned NOT NULL,
  `order_by` int(8) unsigned NOT NULL,
  `is_action` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_express_rule
-- ----------------------------
INSERT INTO `myr_express_rule` VALUES ('60', '35', '包含(6)<br/>', '1', '5', '1');
INSERT INTO `myr_express_rule` VALUES ('59', '0', '', '0', '0', '1');

-- ----------------------------
-- Table structure for myr_express_rule_option
-- ----------------------------
DROP TABLE IF EXISTS `myr_express_rule_option`;
CREATE TABLE `myr_express_rule_option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `express_rule_id` smallint(5) unsigned DEFAULT NULL,
  `rule_id` smallint(5) unsigned NOT NULL,
  `value` text NOT NULL,
  `if_rule` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_express_rule_option
-- ----------------------------
INSERT INTO `myr_express_rule_option` VALUES ('107', '59', '0', '', '');
INSERT INTO `myr_express_rule_option` VALUES ('108', '60', '35', '6', 'like');

-- ----------------------------
-- Table structure for myr_gf_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_gf_order`;
CREATE TABLE `myr_gf_order` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `relate_order_sn` varchar(20) NOT NULL,
  `paypalid` varchar(25) NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL,
  `amt` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL DEFAULT 'CNY',
  `comment` varchar(200) NOT NULL,
  `paid_time` int(10) unsigned NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `add_user` smallint(5) unsigned NOT NULL,
  `confirm_user` int(11) DEFAULT NULL,
  `confirm_time` int(10) DEFAULT NULL,
  `account_id` mediumint(8) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 未确认款项 1 已确认款项 2 已收/付款',
  PRIMARY KEY (`rec_id`),
  KEY `order_sn` (`order_sn`,`relate_order_sn`,`paypalid`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_gf_order
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods`;
CREATE TABLE `myr_goods` (
  `goods_id` int(8) NOT NULL AUTO_INCREMENT,
  `goods_sn` varchar(30) NOT NULL,
  `cat_id` smallint(5) unsigned NOT NULL,
  `SKU` varchar(30) NOT NULL,
  `code` varchar(25) NOT NULL,
  `upc` varchar(20) NOT NULL,
  `goods_name` varchar(128) NOT NULL,
  `brand_id` smallint(5) unsigned NOT NULL,
  `dec_name` varchar(30) NOT NULL,
  `dec_name_cn` varchar(30) DEFAULT NULL,
  `Declared_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Declared_value_cat` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Declared_weight` decimal(4,3) unsigned NOT NULL,
  `goods_img` varchar(255) DEFAULT '' COMMENT 'common/lib/no_image.jpg',
  `goods_url` varchar(255) NOT NULL,
  `stock_place` varchar(20) NOT NULL,
  `warn_qty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `goods_qty` smallint(4) NOT NULL DEFAULT '0',
  `varstock` smallint(4) unsigned NOT NULL DEFAULT '0',
  `keeptime` int(10) unsigned NOT NULL,
  `l` decimal(10,2) unsigned NOT NULL,
  `w` decimal(10,2) unsigned NOT NULL,
  `h` decimal(10,2) unsigned NOT NULL,
  `grossweight` decimal(10,3) unsigned NOT NULL,
  `weight` decimal(10,3) unsigned NOT NULL DEFAULT '0.000',
  `cost` decimal(10,2) unsigned DEFAULT '0.00',
  `price1` decimal(10,2) unsigned DEFAULT '0.00',
  `price2` decimal(10,2) unsigned DEFAULT '0.00',
  `price3` decimal(10,2) unsigned DEFAULT '0.00',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `comment` varchar(255) NOT NULL,
  `is_group` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_control` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sn_control` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `has_child` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `provider` smallint(5) unsigned NOT NULL,
  `Grade_cn` varchar(10) NOT NULL,
  `plan_cn` varchar(100) NOT NULL,
  `price_cn` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `des_cn` text NOT NULL,
  `Grade_us` varchar(10) NOT NULL,
  `Grade_au` varchar(10) NOT NULL,
  `Grade_uk` varchar(10) NOT NULL,
  `Grade_de` varchar(10) NOT NULL,
  `Grade_fr` varchar(10) NOT NULL,
  `Grade_sp` varchar(10) NOT NULL,
  `plan_us` varchar(100) NOT NULL,
  `plan_au` varchar(100) NOT NULL,
  `plan_uk` varchar(100) NOT NULL,
  `plan_de` varchar(100) NOT NULL,
  `plan_fr` varchar(100) NOT NULL,
  `plan_sp` varchar(100) NOT NULL,
  `price_us` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price_au` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price_uk` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price_de` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price_fr` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price_sp` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `des_en` text NOT NULL,
  `des_de` text NOT NULL,
  `des_fr` text NOT NULL,
  `des_sp` text NOT NULL,
  `add_time` int(10) NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `grade` varchar(1) NOT NULL DEFAULT 'A',
  `is_ali` tinyint(1) NOT NULL DEFAULT '0',
  `keyword` varchar(50) DEFAULT NULL,
  `ali_is_upload` tinyint(1) DEFAULT '0',
  `product_purchaser` int(8) NOT NULL,
  `products_developers` int(8) NOT NULL,
  `product_operation` int(8) NOT NULL,
  `product_quality_inspector` int(8) NOT NULL,
  `product_rights_checker` int(8) NOT NULL,
  `goods_attribute` text,
  `aliID` varchar(30) NOT NULL,
  PRIMARY KEY (`goods_id`),
  KEY `SKU` (`SKU`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods
-- ----------------------------
INSERT INTO `myr_goods` VALUES ('1', '62', '1', '62', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('2', '63', '1', '63', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('3', '64', '1', '64', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('4', '65', '1', '65', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('5', '66', '1', '66', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('6', '67', '1', '67', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('7', '68', '1', '68', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('8', '69', '1', '69', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('9', '70', '1', '70', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('10', '71', '1', '71', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('11', '72', '1', '72', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('12', '73', '1', '73', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('13', '74', '1', '74', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('14', '75', '1', '75', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('15', '76', '1', '76', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('16', '77', '1', '77', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('17', '78', '1', '78', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('18', '79', '1', '79', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('19', '80', '1', '80', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('20', '81', '1', '81', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('21', '82', '1', '82', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('22', '83', '1', '83', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('23', '84', '1', '84', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('24', '85', '1', '85', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('25', '86', '1', '86', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('26', '87', '1', '87', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('27', '88', '1', '88', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('28', '89', '1', '89', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('29', '90', '1', '90', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('30', '91', '1', '91', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('31', '92', '1', '92', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('32', '93', '1', '93', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('33', '94', '1', '94', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('34', '95', '1', '95', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('35', '96', '1', '96', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('36', '97', '1', '97', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('37', '98', '1', '98', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('38', '99', '1', '99', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('39', '100', '1', '100', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('40', '101', '1', '101', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('41', '102', '1', '102', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('42', '103', '1', '103', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('43', '104', '1', '104', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('44', '105', '1', '105', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('45', '106', '1', '106', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('46', '107', '1', '107', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('47', '108', '1', '108', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('48', '109', '1', '109', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('49', '110', '1', '110', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('50', '111', '1', '111', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('51', '112', '1', '112', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('52', '113', '1', '113', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('53', '114', '1', '114', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('54', '115', '1', '115', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('55', '116', '1', '116', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('56', '117', '1', '117', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('57', '118', '1', '118', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('58', '119', '1', '119', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('59', '120', '1', '120', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('60', '121', '1', '121', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('61', '122', '1', '122', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('62', '123', '1', '123', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('63', '124', '1', '124', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('64', '125', '1', '125', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('65', '126', '1', '126', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('66', '127', '1', '127', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('67', '128', '1', '128', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('68', '129', '1', '129', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('69', '130', '1', '130', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('70', '131', '1', '131', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('71', '132', '1', '132', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('72', '133', '1', '133', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('73', '134', '1', '134', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('74', '135', '1', '135', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('75', '136', '1', '136', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('76', '137', '1', '137', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('77', '138', '1', '138', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('78', '139', '1', '139', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('79', '140', '1', '140', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('80', '141', '1', '141', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('81', '142', '1', '142', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('82', '143', '1', '143', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('83', '144', '1', '144', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('84', '145', '1', '145', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('85', '146', '1', '146', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('86', '147', '1', '147', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('87', '148', '1', '148', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('88', '149', '1', '149', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('89', '150', '1', '150', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('90', '151', '1', '151', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('91', '152', '1', '152', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('92', '153', '1', '153', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('93', '154', '1', '154', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('94', '155', '1', '155', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('95', '156', '1', '156', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('96', '157', '1', '157', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('97', '158', '1', '158', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('98', '159', '1', '159', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442820607', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('99', '61', '1', '61', '', '', 'Fashion jewelry J0003#6', '0', 'test', 'test', '2.00', '0.00', '1.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '3.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442826655', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('138', 'QMX00085', '1', 'QMX00085', '', '', '雅培1段奶粉/964g', '0', 'Abbott similac 1 964g', '雅培1段奶粉/964g', '210.00', '0.00', '0.964', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('121', 'QMX00016', '1', 'QMX00016', '', '', 'Aptamil爱他美奶粉 初段800g', '0', 'Milupa Aptamil Pre 800g', 'Aptamil爱他美奶粉 初段800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('122', 'QMX00017', '1', 'QMX00017', '', '', 'Aptamil爱他美奶粉 1段 800g', '0', 'Milupa Aptamil 1 800g', 'Aptamil爱他美奶粉 1段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('123', 'QMX00018', '1', 'QMX00018', '', '', 'Aptamil爱他美奶粉 2段 800g', '0', 'Milupa Aptamil 2 800g', 'Aptamil爱他美奶粉 2段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('124', 'QMX00019', '1', 'QMX00019', '', '', 'Aptamil爱他美奶粉 3段 800g', '0', 'Milupa Aptamil 3 800g', 'Aptamil爱他美奶粉 3段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('125', 'QMX00020', '1', 'QMX00020', '', '', 'Aptamil爱他美奶粉 1+段 600g', '0', 'Milupa Aptamil 1+ 600g', 'Aptamil爱他美奶粉 1+段 600g', '79.00', '0.00', '0.600', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('126', 'QMX00021', '1', 'QMX00021', '', '', 'Aptamil爱他美奶粉 2+段 600g', '0', 'Milupa Aptamil 2+ 600g', 'Aptamil爱他美奶粉 2+段 600g', '79.00', '0.00', '0.600', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('127', 'QMX00022', '1', 'QMX00022', '', '', 'Nutrilon牛栏奶粉 1段 850g', '0', 'Nutricia Nutrilon 1 850g', 'Nutrilon牛栏奶粉 1段 850g', '114.00', '0.00', '0.850', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('128', 'QMX00023', '1', 'QMX00023', '', '', 'Nutrilon牛栏奶粉 2段 850g', '0', 'Nutricia Nutrilon 2 850g', 'Nutrilon牛栏奶粉 2段 850g', '114.00', '0.00', '0.850', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('129', 'QMX00024', '1', 'QMX00024', '', '', 'Nutrilon牛栏奶粉 3段 800g', '0', 'Nutricia Nutrilon 3 800g', 'Nutrilon牛栏奶粉 3段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('130', 'QMX00025', '1', 'QMX00025', '', '', 'Nutrilon牛栏奶粉 4段 800g', '0', 'Nutricia Nutrilon 4 800g', 'Nutrilon牛栏奶粉 4段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('131', 'QMX00026', '1', 'QMX00026', '', '', 'Nutrilon牛栏奶粉 5段 800g', '0', 'Nutricia Nutrilon 5 800g', 'Nutrilon牛栏奶粉 5段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('132', 'QMX00027', '1', 'QMX00027', '', '', 'Hero Baby玺乐奶粉 1段 800g', '0', 'Hero Baby 1 800g', 'Hero Baby玺乐奶粉 1段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('133', 'QMX00028', '1', 'QMX00028', '', '', 'Hero Baby玺乐奶粉 2段 800g', '0', 'Hero Baby 2 800g', 'Hero Baby玺乐奶粉 2段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('134', 'QMX00029', '1', 'QMX00029', '', '', 'Hero Baby玺乐奶粉3段 800g', '0', 'Hero Baby 3 800g', 'Hero Baby玺乐奶粉3段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('135', 'QMX00030', '1', 'QMX00030', '', '', 'Hero Baby玺乐奶粉 4段 700g', '0', 'Hero Baby 4 700g', 'Hero Baby玺乐奶粉 4段 700g', '64.00', '0.00', '0.700', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('136', 'QMX00039', '1', 'QMX00039', '', '', '美赞臣1段奶粉/765g', '0', 'Meadjohnson 1/765g', '美赞臣1段奶粉/765g', '170.00', '0.00', '0.765', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('137', 'QMX00040', '1', 'QMX00040', '', '', '美赞臣2段奶粉/1080g', '0', 'Meadjohnson 2/1080g', '美赞臣2段奶粉/1080g', '160.00', '0.00', '1.080', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('139', 'QMX00086', '1', 'QMX00086', '', '', '雅培3段奶粉/964g', '0', 'Abbott similac 3 964g', '雅培3段奶粉/964g', '228.00', '0.00', '0.964', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830384', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('140', '0101001', '2', 'QMX00016', '', '', 'Aptamil爱他美奶粉 初段800g', '0', 'Milupa Aptamil Pre 800g', 'Aptamil爱他美奶粉 初段800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('141', '0101002', '2', 'QMX00017', '', '', 'Aptamil爱他美奶粉 1段 800g', '0', 'Milupa Aptamil 1 800g', 'Aptamil爱他美奶粉 1段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('142', '0101003', '2', 'QMX00018', '', '', 'Aptamil爱他美奶粉 2段 800g', '0', 'Milupa Aptamil 2 800g', 'Aptamil爱他美奶粉 2段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('143', '0101004', '2', 'QMX00019', '', '', 'Aptamil爱他美奶粉 3段 800g', '0', 'Milupa Aptamil 3 800g', 'Aptamil爱他美奶粉 3段 800g', '120.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('144', '0101005', '2', 'QMX00020', '', '', 'Aptamil爱他美奶粉 1+段 600g', '0', 'Milupa Aptamil 1+ 600g', 'Aptamil爱他美奶粉 1+段 600g', '79.00', '0.00', '0.600', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('145', '0101006', '2', 'QMX00021', '', '', 'Aptamil爱他美奶粉 2+段 600g', '0', 'Milupa Aptamil 2+ 600g', 'Aptamil爱他美奶粉 2+段 600g', '79.00', '0.00', '0.600', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('146', '0101007', '2', 'QMX00022', '', '', 'Nutrilon牛栏奶粉 1段 850g', '0', 'Nutricia Nutrilon 1 850g', 'Nutrilon牛栏奶粉 1段 850g', '114.00', '0.00', '0.850', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('147', '0101008', '2', 'QMX00023', '', '', 'Nutrilon牛栏奶粉 2段 850g', '0', 'Nutricia Nutrilon 2 850g', 'Nutrilon牛栏奶粉 2段 850g', '114.00', '0.00', '0.850', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('148', '0101009', '2', 'QMX00024', '', '', 'Nutrilon牛栏奶粉 3段 800g', '0', 'Nutricia Nutrilon 3 800g', 'Nutrilon牛栏奶粉 3段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('149', '0101010', '2', 'QMX00025', '', '', 'Nutrilon牛栏奶粉 4段 800g', '0', 'Nutricia Nutrilon 4 800g', 'Nutrilon牛栏奶粉 4段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('150', '0101011', '2', 'QMX00026', '', '', 'Nutrilon牛栏奶粉 5段 800g', '0', 'Nutricia Nutrilon 5 800g', 'Nutrilon牛栏奶粉 5段 800g', '114.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('151', '0101012', '2', 'QMX00027', '', '', 'Hero Baby玺乐奶粉 1段 800g', '0', 'Hero Baby 1 800g', 'Hero Baby玺乐奶粉 1段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('152', '0101013', '2', 'QMX00028', '', '', 'Hero Baby玺乐奶粉 2段 800g', '0', 'Hero Baby 2 800g', 'Hero Baby玺乐奶粉 2段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('153', '0101014', '2', 'QMX00029', '', '', 'Hero Baby玺乐奶粉3段 800g', '0', 'Hero Baby 3 800g', 'Hero Baby玺乐奶粉3段 800g', '71.00', '0.00', '0.800', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('154', '0101015', '2', 'QMX00030', '', '', 'Hero Baby玺乐奶粉 4段 700g', '0', 'Hero Baby 4 700g', 'Hero Baby玺乐奶粉 4段 700g', '64.00', '0.00', '0.700', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('155', '0101016', '2', 'QMX00039', '', '', '美赞臣1段奶粉/765g', '0', 'Meadjohnson 1/765g', '美赞臣1段奶粉/765g', '170.00', '0.00', '0.765', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('156', '0101017', '2', 'QMX00040', '', '', '美赞臣2段奶粉/1080g', '0', 'Meadjohnson 2/1080g', '美赞臣2段奶粉/1080g', '160.00', '0.00', '1.080', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('157', '0101018', '2', 'QMX00085', '', '', '雅培1段奶粉/964g', '0', 'Abbott similac 1 964g', '雅培1段奶粉/964g', '210.00', '0.00', '0.964', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('158', '0101019', '2', 'QMX00086', '', '', '雅培3段奶粉/964g', '0', 'Abbott similac 3 964g', '雅培3段奶粉/964g', '228.00', '0.00', '0.964', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442830483', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('159', '9001', '3', '9001', '', '', '口红 玫瑰色1', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('160', '9002', '3', '9002', '', '', '口红 玫瑰色2', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('161', '9003', '3', '9003', '', '', '口红 玫瑰色3', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('162', '9004', '3', '9004', '', '', '口红 玫瑰色4', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('163', '9005', '3', '9005', '', '', '口红 玫瑰色5', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('164', '9006', '3', '9006', '', '', '口红 玫瑰色6', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('165', '9007', '3', '9007', '', '', '口红 玫瑰色7', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('166', '9008', '3', '9008', '', '', '口红 玫瑰色8', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('167', '9009', '3', '9009', '', '', '口红 玫瑰色9', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('168', '9010', '3', '9010', '', '', '口红 玫瑰色10', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('169', '9011', '3', '9011', '', '', '口红 玫瑰色11', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('170', '9012', '3', '9012', '', '', '口红 玫瑰色12', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('171', '9013', '3', '9013', '', '', '口红 玫瑰色13', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('172', '9014', '3', '9014', '', '', '口红 玫瑰色14', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('173', '9015', '3', '9015', '', '', '口红 玫瑰色15', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('174', '9016', '3', '9016', '', '', '口红 玫瑰色16', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('175', '9017', '3', '9017', '', '', '口红 玫瑰色17', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('176', '9018', '3', '9018', '', '', '口红 玫瑰色18', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('177', '9019', '3', '9019', '', '', '口红 玫瑰色19', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '10.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('178', '9020', '3', '9020', '', '', '口红 玫瑰色20', '0', 'lipstick', '口红', '10.00', '0.00', '5.000', 'allpyra/data/upload/no_picture.gif', '', '', '0', '0', '0', '2145801600', '0.00', '0.00', '0.00', '0.000', '0.000', '20.00', '0.00', '0.00', '0.00', '1', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1442889167', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('179', '010120', '2', '010120', '', '', '11', '0', '', '', '0.00', '0.00', '0.000', 'erp_client/allpyra/data/upload/no_picture.gif', '11', '', '0', '0', '0', '1609344000', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '0', '', '0', '1', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1443075777', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');
INSERT INTO `myr_goods` VALUES ('180', '1', '65535', '1', '', '', '母婴产品', '0', 'case', '奶粉', '15.00', '0.00', '0.000', 'erp_client/allpyra/data/upload/no_picture.gif', 'http://m.allpyra.com/', '', '0', '0', '0', '1444752000', '0.00', '0.00', '0.00', '0.000', '0.000', '0.00', '0.00', '0.00', '0.00', '3', '备注备注备注', '1', '0', '0', '0', '0', '', '', '0.00', '', '', '', '', '', '', '', '', '', '', '', '', '', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '', '', '', '', '1443085904', '0', 'A', '0', null, '0', '0', '0', '0', '0', '0', '', '');

-- ----------------------------
-- Table structure for myr_goods_assign
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_assign`;
CREATE TABLE `myr_goods_assign` (
  `goods_id` mediumint(8) NOT NULL,
  `assign_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `add_user` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` int(2) NOT NULL,
  `add_time` int(10) NOT NULL,
  PRIMARY KEY (`assign_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_assign
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_audit
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_audit`;
CREATE TABLE `myr_goods_audit` (
  `audit_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) NOT NULL COMMENT '对象ID',
  `audit_user` tinyint(3) NOT NULL,
  `audit_advice` text,
  `audit_time` int(10) NOT NULL,
  `audit_status` tinyint(1) NOT NULL,
  `audit_type` tinyint(1) NOT NULL,
  PRIMARY KEY (`audit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_audit
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_child
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_child`;
CREATE TABLE `myr_goods_child` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `child_sn` varchar(30) NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `color` int(11) unsigned NOT NULL,
  `size` int(11) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `stock` smallint(4) NOT NULL,
  `varstock` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_child
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_combsplit
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_combsplit`;
CREATE TABLE `myr_goods_combsplit` (
  `rec_id` smallint(8) unsigned NOT NULL AUTO_INCREMENT,
  `comb_goods_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_qty` smallint(4) unsigned NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `comb_goods_id` (`comb_goods_id`,`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_combsplit
-- ----------------------------
INSERT INTO `myr_goods_combsplit` VALUES ('1', '180', '170', '10');
INSERT INTO `myr_goods_combsplit` VALUES ('2', '180', '172', '12');
INSERT INTO `myr_goods_combsplit` VALUES ('3', '180', '177', '32');
INSERT INTO `myr_goods_combsplit` VALUES ('4', '180', '178', '21');

-- ----------------------------
-- Table structure for myr_goods_des
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_des`;
CREATE TABLE `myr_goods_des` (
  `goods_id` mediumint(8) unsigned NOT NULL,
  `des_type` varchar(6) NOT NULL,
  `description` text NOT NULL,
  KEY `sindex` (`goods_id`,`des_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_des
-- ----------------------------
INSERT INTO `myr_goods_des` VALUES ('35540', '0', '<p> asdfasdfsadf</p>');

-- ----------------------------
-- Table structure for myr_goods_gallery
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_gallery`;
CREATE TABLE `myr_goods_gallery` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`rec_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2026 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_gallery
-- ----------------------------
INSERT INTO `myr_goods_gallery` VALUES ('1', '35497', '');
INSERT INTO `myr_goods_gallery` VALUES ('2', '35498', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_1.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('3', '35498', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_2.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('4', '35498', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_3.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('5', '35498', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_4.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('6', '35498', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_5.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('7', '35499', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_1.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('8', '35499', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_2.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('9', '35499', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_3.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('10', '35499', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_4.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('11', '35499', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_5.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('12', '35500', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_1.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('13', '35500', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_2.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('14', '35500', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_3.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('15', '35500', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_4.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('16', '35500', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_5.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('17', '35501', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_1.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('18', '35501', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_2.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('19', '35501', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_3.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('20', '35501', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_4.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('21', '35502', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_1.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('22', '35502', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_2.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('23', '35502', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_3.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('24', '35502', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_4.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('25', '35502', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_5.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('26', '35503', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_1.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('27', '35503', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_2.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('28', '35503', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_3.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('29', '35503', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_4.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('30', '35503', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/89/1723558924_5.jpg?1395141313000');
INSERT INTO `myr_goods_gallery` VALUES ('31', '35504', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_1.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('32', '35504', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_2.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('33', '35504', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_3.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('34', '35504', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/90/1723539094_4.jpg?1395141161000');
INSERT INTO `myr_goods_gallery` VALUES ('35', '35505', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_1.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('36', '35505', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_2.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('37', '35505', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_3.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('38', '35505', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_4.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('39', '35505', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_5.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('40', '35506', 'http://img.vip.alibaba.com/img/wsproduct/17/27/11/71/1727117151_1.jpg?1395284380000');
INSERT INTO `myr_goods_gallery` VALUES ('41', '35506', 'http://img.vip.alibaba.com/img/wsproduct/17/27/11/71/1727117151_2.jpg?1395284380000');
INSERT INTO `myr_goods_gallery` VALUES ('42', '35506', 'http://img.vip.alibaba.com/img/wsproduct/17/27/11/71/1727117151_3.jpg?1395284380000');
INSERT INTO `myr_goods_gallery` VALUES ('43', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_1.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('44', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_2.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('45', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_3.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('46', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_4.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('47', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_5.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('48', '35507', 'http://img.vip.alibaba.com/img/wsproduct/15/04/97/49/1504974914_6.jpg?1395283431000');
INSERT INTO `myr_goods_gallery` VALUES ('49', '35508', 'http://img.vip.alibaba.com/img/wsproduct/17/23/95/88/1723958809_1.jpg?1395281434000');
INSERT INTO `myr_goods_gallery` VALUES ('50', '35508', 'http://img.vip.alibaba.com/img/wsproduct/17/23/95/88/1723958809_2.jpg?1395281434000');
INSERT INTO `myr_goods_gallery` VALUES ('51', '35508', 'http://img.vip.alibaba.com/img/wsproduct/17/23/95/88/1723958809_3.jpg?1395281434000');
INSERT INTO `myr_goods_gallery` VALUES ('52', '35509', 'http://img.vip.alibaba.com/img/wsproduct/17/27/09/47/1727094744_1.jpg?1395280719000');
INSERT INTO `myr_goods_gallery` VALUES ('53', '35509', 'http://img.vip.alibaba.com/img/wsproduct/17/27/09/47/1727094744_2.jpg?1395280719000');
INSERT INTO `myr_goods_gallery` VALUES ('54', '35509', 'http://img.vip.alibaba.com/img/wsproduct/17/27/09/47/1727094744_3.jpg?1395280719000');
INSERT INTO `myr_goods_gallery` VALUES ('55', '35509', 'http://img.vip.alibaba.com/img/wsproduct/17/27/09/47/1727094744_4.jpg?1395280719000');
INSERT INTO `myr_goods_gallery` VALUES ('56', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_1.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('57', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_2.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('58', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_3.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('59', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_4.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('60', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_5.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('61', '35510', 'http://img.vip.alibaba.com/img/wsproduct/15/41/54/76/1541547632_6.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('62', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_1.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('63', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_2.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('64', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_3.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('65', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_4.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('66', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_5.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('67', '35511', 'http://img.vip.alibaba.com/img/wsproduct/15/40/01/02/1540010289_6.jpg?1395215157000');
INSERT INTO `myr_goods_gallery` VALUES ('68', '35512', 'http://img.vip.alibaba.com/img/wsproduct/17/24/08/47/1724084712_1.jpg?1395153900000');
INSERT INTO `myr_goods_gallery` VALUES ('69', '35512', 'http://img.vip.alibaba.com/img/wsproduct/17/24/08/47/1724084712_2.jpg?1395153900000');
INSERT INTO `myr_goods_gallery` VALUES ('70', '35512', 'http://img.vip.alibaba.com/img/wsproduct/17/24/08/47/1724084712_3.jpg?1395153900000');
INSERT INTO `myr_goods_gallery` VALUES ('71', '35512', 'http://img.vip.alibaba.com/img/wsproduct/17/24/08/47/1724084712_4.jpg?1395153900000');
INSERT INTO `myr_goods_gallery` VALUES ('72', '35513', 'http://img.vip.alibaba.com/img/wsproduct/16/98/16/12/1698161225.jpg?1395153315000');
INSERT INTO `myr_goods_gallery` VALUES ('73', '35514', 'http://img.vip.alibaba.com/img/wsproduct/16/24/64/51/1624645150.jpg?1395153315000');
INSERT INTO `myr_goods_gallery` VALUES ('74', '35515', 'http://img.vip.alibaba.com/img/wsproduct/16/24/60/53/1624605333.jpg?1395153315000');
INSERT INTO `myr_goods_gallery` VALUES ('75', '35516', 'http://img.vip.alibaba.com/img/wsproduct/17/09/99/43/1709994399.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('76', '35517', 'http://img.vip.alibaba.com/img/wsproduct/17/09/85/61/1709856156.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('77', '35518', 'http://img.vip.alibaba.com/img/wsproduct/16/97/98/05/1697980535.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('78', '35519', 'http://img.vip.alibaba.com/img/wsproduct/16/96/71/39/1696713980.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('79', '35520', 'http://img.vip.alibaba.com/img/wsproduct/16/96/44/42/1696444287_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('80', '35520', 'http://img.vip.alibaba.com/img/wsproduct/16/96/44/42/1696444287_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('81', '35521', 'http://img.vip.alibaba.com/img/wsproduct/16/78/17/91/1678179117_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('82', '35521', 'http://img.vip.alibaba.com/img/wsproduct/16/78/17/91/1678179117_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('83', '35521', 'http://img.vip.alibaba.com/img/wsproduct/16/78/17/91/1678179117_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('84', '35521', 'http://img.vip.alibaba.com/img/wsproduct/16/78/17/91/1678179117_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('85', '35521', 'http://img.vip.alibaba.com/img/wsproduct/16/78/17/91/1678179117_5.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('86', '35522', 'http://img.vip.alibaba.com/img/wsproduct/16/77/16/71/1677167118_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('87', '35522', 'http://img.vip.alibaba.com/img/wsproduct/16/77/16/71/1677167118_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('88', '35522', 'http://img.vip.alibaba.com/img/wsproduct/16/77/16/71/1677167118_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('89', '35522', 'http://img.vip.alibaba.com/img/wsproduct/16/77/16/71/1677167118_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('90', '35523', 'http://img.vip.alibaba.com/img/wsproduct/16/75/54/62/1675546208_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('91', '35523', 'http://img.vip.alibaba.com/img/wsproduct/16/75/54/62/1675546208_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('92', '35523', 'http://img.vip.alibaba.com/img/wsproduct/16/75/54/62/1675546208_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('93', '35523', 'http://img.vip.alibaba.com/img/wsproduct/16/75/54/62/1675546208_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('94', '35524', 'http://img.vip.alibaba.com/img/wsproduct/16/70/92/46/1670924602_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('95', '35524', 'http://img.vip.alibaba.com/img/wsproduct/16/70/92/46/1670924602_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('96', '35524', 'http://img.vip.alibaba.com/img/wsproduct/16/70/92/46/1670924602_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('97', '35524', 'http://img.vip.alibaba.com/img/wsproduct/16/70/92/46/1670924602_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('98', '35525', 'http://img.vip.alibaba.com/img/wsproduct/16/70/78/25/1670782539_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('99', '35525', 'http://img.vip.alibaba.com/img/wsproduct/16/70/78/25/1670782539_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('100', '35525', 'http://img.vip.alibaba.com/img/wsproduct/16/70/78/25/1670782539_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('101', '35525', 'http://img.vip.alibaba.com/img/wsproduct/16/70/78/25/1670782539_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('102', '35526', 'http://img.vip.alibaba.com/img/wsproduct/16/70/71/32/1670713267_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('103', '35526', 'http://img.vip.alibaba.com/img/wsproduct/16/70/71/32/1670713267_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('104', '35526', 'http://img.vip.alibaba.com/img/wsproduct/16/70/71/32/1670713267_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('105', '35526', 'http://img.vip.alibaba.com/img/wsproduct/16/70/71/32/1670713267_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('106', '35527', 'http://img.vip.alibaba.com/img/wsproduct/16/66/82/60/1666826091_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('107', '35527', 'http://img.vip.alibaba.com/img/wsproduct/16/66/82/60/1666826091_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('108', '35527', 'http://img.vip.alibaba.com/img/wsproduct/16/66/82/60/1666826091_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('109', '35528', 'http://img.vip.alibaba.com/img/wsproduct/16/66/73/66/1666736664_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('110', '35528', 'http://img.vip.alibaba.com/img/wsproduct/16/66/73/66/1666736664_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('111', '35528', 'http://img.vip.alibaba.com/img/wsproduct/16/66/73/66/1666736664_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('112', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('113', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('114', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('115', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('116', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_5.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('117', '35529', 'http://img.vip.alibaba.com/img/wsproduct/16/28/28/59/1628285987_6.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('118', '35530', 'http://img.vip.alibaba.com/img/wsproduct/16/26/70/99/1626709925_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('119', '35530', 'http://img.vip.alibaba.com/img/wsproduct/16/26/70/99/1626709925_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('120', '35530', 'http://img.vip.alibaba.com/img/wsproduct/16/26/70/99/1626709925_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('121', '35531', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/78/1723557858_1.jpg?1395140925000');
INSERT INTO `myr_goods_gallery` VALUES ('122', '35531', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/78/1723557858_2.jpg?1395140925000');
INSERT INTO `myr_goods_gallery` VALUES ('123', '35531', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/78/1723557858_3.jpg?1395140925000');
INSERT INTO `myr_goods_gallery` VALUES ('124', '35531', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/78/1723557858_4.jpg?1395140925000');
INSERT INTO `myr_goods_gallery` VALUES ('125', '35531', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/78/1723557858_5.jpg?1395140925000');
INSERT INTO `myr_goods_gallery` VALUES ('126', '35532', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/23/1723532364_1.jpg?1395139140000');
INSERT INTO `myr_goods_gallery` VALUES ('127', '35532', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/23/1723532364_2.jpg?1395139140000');
INSERT INTO `myr_goods_gallery` VALUES ('128', '35532', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/23/1723532364_3.jpg?1395139140000');
INSERT INTO `myr_goods_gallery` VALUES ('129', '35532', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/23/1723532364_4.jpg?1395139140000');
INSERT INTO `myr_goods_gallery` VALUES ('130', '35532', 'http://img.vip.alibaba.com/img/wsproduct/17/23/53/23/1723532364_5.jpg?1395139140000');
INSERT INTO `myr_goods_gallery` VALUES ('131', '35533', 'http://img.vip.alibaba.com/img/wsproduct/17/23/45/64/1723456432_1.jpg?1395137086000');
INSERT INTO `myr_goods_gallery` VALUES ('132', '35533', 'http://img.vip.alibaba.com/img/wsproduct/17/23/45/64/1723456432_2.jpg?1395137086000');
INSERT INTO `myr_goods_gallery` VALUES ('133', '35533', 'http://img.vip.alibaba.com/img/wsproduct/17/23/45/64/1723456432_3.jpg?1395137086000');
INSERT INTO `myr_goods_gallery` VALUES ('134', '35533', 'http://img.vip.alibaba.com/img/wsproduct/17/23/45/64/1723456432_4.jpg?1395137086000');
INSERT INTO `myr_goods_gallery` VALUES ('135', '35533', 'http://img.vip.alibaba.com/img/wsproduct/17/23/45/64/1723456432_5.jpg?1395137086000');
INSERT INTO `myr_goods_gallery` VALUES ('136', '35534', 'http://img.vip.alibaba.com/img/wsproduct/17/23/40/90/1723409066_1.jpg?1395137070000');
INSERT INTO `myr_goods_gallery` VALUES ('137', '35534', 'http://img.vip.alibaba.com/img/wsproduct/17/23/40/90/1723409066_2.jpg?1395137070000');
INSERT INTO `myr_goods_gallery` VALUES ('138', '35534', 'http://img.vip.alibaba.com/img/wsproduct/17/23/40/90/1723409066_3.jpg?1395137070000');
INSERT INTO `myr_goods_gallery` VALUES ('139', '35534', 'http://img.vip.alibaba.com/img/wsproduct/17/23/40/90/1723409066_4.jpg?1395137070000');
INSERT INTO `myr_goods_gallery` VALUES ('140', '35534', 'http://img.vip.alibaba.com/img/wsproduct/17/23/40/90/1723409066_5.jpg?1395137070000');
INSERT INTO `myr_goods_gallery` VALUES ('141', '35535', 'http://img.vip.alibaba.com/img/wsproduct/17/23/42/09/1723420917_1.jpg?1395137059000');
INSERT INTO `myr_goods_gallery` VALUES ('142', '35535', 'http://img.vip.alibaba.com/img/wsproduct/17/23/42/09/1723420917_2.jpg?1395137059000');
INSERT INTO `myr_goods_gallery` VALUES ('143', '35535', 'http://img.vip.alibaba.com/img/wsproduct/17/23/42/09/1723420917_3.jpg?1395137059000');
INSERT INTO `myr_goods_gallery` VALUES ('144', '35535', 'http://img.vip.alibaba.com/img/wsproduct/17/23/42/09/1723420917_4.jpg?1395137059000');
INSERT INTO `myr_goods_gallery` VALUES ('145', '35535', 'http://img.vip.alibaba.com/img/wsproduct/17/23/42/09/1723420917_5.jpg?1395137059000');
INSERT INTO `myr_goods_gallery` VALUES ('146', '35536', 'http://img.vip.alibaba.com/img/wsproduct/17/23/39/62/1723396286_1.jpg?1395137048000');
INSERT INTO `myr_goods_gallery` VALUES ('147', '35536', 'http://img.vip.alibaba.com/img/wsproduct/17/23/39/62/1723396286_2.jpg?1395137048000');
INSERT INTO `myr_goods_gallery` VALUES ('148', '35536', 'http://img.vip.alibaba.com/img/wsproduct/17/23/39/62/1723396286_3.jpg?1395137048000');
INSERT INTO `myr_goods_gallery` VALUES ('149', '35536', 'http://img.vip.alibaba.com/img/wsproduct/17/23/39/62/1723396286_4.jpg?1395137048000');
INSERT INTO `myr_goods_gallery` VALUES ('150', '35536', 'http://img.vip.alibaba.com/img/wsproduct/17/23/39/62/1723396286_5.jpg?1395137048000');
INSERT INTO `myr_goods_gallery` VALUES ('151', '35537', 'http://img.vip.alibaba.com/img/wsproduct/17/21/51/30/1721513094_1.jpg?1395085540000');
INSERT INTO `myr_goods_gallery` VALUES ('152', '35537', 'http://img.vip.alibaba.com/img/wsproduct/17/21/51/30/1721513094_2.jpg?1395085540000');
INSERT INTO `myr_goods_gallery` VALUES ('153', '35537', 'http://img.vip.alibaba.com/img/wsproduct/17/21/51/30/1721513094_3.jpg?1395085540000');
INSERT INTO `myr_goods_gallery` VALUES ('154', '35537', 'http://img.vip.alibaba.com/img/wsproduct/17/21/51/30/1721513094_4.jpg?1395085540000');
INSERT INTO `myr_goods_gallery` VALUES ('155', '35537', 'http://img.vip.alibaba.com/img/wsproduct/17/21/51/30/1721513094_5.jpg?1395085540000');
INSERT INTO `myr_goods_gallery` VALUES ('156', '35538', 'http://img.vip.alibaba.com/img/wsproduct/17/21/54/23/1721542395_1.jpg?1395085402000');
INSERT INTO `myr_goods_gallery` VALUES ('157', '35538', 'http://img.vip.alibaba.com/img/wsproduct/17/21/54/23/1721542395_2.jpg?1395085402000');
INSERT INTO `myr_goods_gallery` VALUES ('158', '35538', 'http://img.vip.alibaba.com/img/wsproduct/17/21/54/23/1721542395_3.jpg?1395085402000');
INSERT INTO `myr_goods_gallery` VALUES ('159', '35538', 'http://img.vip.alibaba.com/img/wsproduct/17/21/54/23/1721542395_4.jpg?1395085402000');
INSERT INTO `myr_goods_gallery` VALUES ('160', '35538', 'http://img.vip.alibaba.com/img/wsproduct/17/21/54/23/1721542395_5.jpg?1395085402000');
INSERT INTO `myr_goods_gallery` VALUES ('161', '35539', 'http://img.vip.alibaba.com/img/wsproduct/13/05/57/40/1305574007.jpg?1394154847000');
INSERT INTO `myr_goods_gallery` VALUES ('162', '35540', 'http://img.vip.alibaba.com/img/wsproduct/16/92/80/75/1692807548.jpg?1394154846000');
INSERT INTO `myr_goods_gallery` VALUES ('163', '35541', 'http://img.vip.alibaba.com/img/wsproduct/16/55/65/23/1655652346.jpg?1394154846000');
INSERT INTO `myr_goods_gallery` VALUES ('164', '35542', 'http://img.vip.alibaba.com/img/wsproduct/16/42/52/00/1642520076.jpg?1394154846000');
INSERT INTO `myr_goods_gallery` VALUES ('165', '35543', 'http://img.vip.alibaba.com/img/wsproduct/16/97/02/24/1697022459_1.jpg?1394154047000');
INSERT INTO `myr_goods_gallery` VALUES ('166', '35543', 'http://img.vip.alibaba.com/img/wsproduct/16/97/02/24/1697022459_2.jpg?1394154047000');
INSERT INTO `myr_goods_gallery` VALUES ('167', '35543', 'http://img.vip.alibaba.com/img/wsproduct/16/97/02/24/1697022459_3.jpg?1394154047000');
INSERT INTO `myr_goods_gallery` VALUES ('168', '35543', 'http://img.vip.alibaba.com/img/wsproduct/16/97/02/24/1697022459_4.jpg?1394154047000');
INSERT INTO `myr_goods_gallery` VALUES ('169', '35543', 'http://img.vip.alibaba.com/img/wsproduct/16/97/02/24/1697022459_5.jpg?1394154047000');
INSERT INTO `myr_goods_gallery` VALUES ('170', '35544', 'http://img.vip.alibaba.com/img/wsproduct/16/96/98/75/1696987539_1.jpg?1394151637000');
INSERT INTO `myr_goods_gallery` VALUES ('171', '35544', 'http://img.vip.alibaba.com/img/wsproduct/16/96/98/75/1696987539_2.jpg?1394151637000');
INSERT INTO `myr_goods_gallery` VALUES ('172', '35545', 'http://img.vip.alibaba.com/img/wsproduct/16/96/92/42/1696924271_1.jpg?1394150342000');
INSERT INTO `myr_goods_gallery` VALUES ('173', '35545', 'http://img.vip.alibaba.com/img/wsproduct/16/96/92/42/1696924271_2.jpg?1394150342000');
INSERT INTO `myr_goods_gallery` VALUES ('174', '35545', 'http://img.vip.alibaba.com/img/wsproduct/16/96/92/42/1696924271_3.jpg?1394150342000');
INSERT INTO `myr_goods_gallery` VALUES ('175', '35545', 'http://img.vip.alibaba.com/img/wsproduct/16/96/92/42/1696924271_4.jpg?1394150342000');
INSERT INTO `myr_goods_gallery` VALUES ('176', '35545', 'http://img.vip.alibaba.com/img/wsproduct/16/96/92/42/1696924271_5.jpg?1394150342000');
INSERT INTO `myr_goods_gallery` VALUES ('177', '35546', 'http://img.vip.alibaba.com/img/wsproduct/16/96/53/48/1696534836.jpg?1394122538000');
INSERT INTO `myr_goods_gallery` VALUES ('178', '35547', 'http://img.vip.alibaba.com/img/wsproduct/16/94/11/66/1694116615.jpg?1394113355000');
INSERT INTO `myr_goods_gallery` VALUES ('179', '35548', 'http://img.vip.alibaba.com/img/wsproduct/16/94/11/66/1694116610.jpg?1394113355000');
INSERT INTO `myr_goods_gallery` VALUES ('180', '35549', 'http://img.vip.alibaba.com/img/wsproduct/16/94/11/46/1694114648.jpg?1394113355000');
INSERT INTO `myr_goods_gallery` VALUES ('181', '35550', 'http://img.vip.alibaba.com/img/wsproduct/16/94/11/06/1694110648.jpg?1394113355000');
INSERT INTO `myr_goods_gallery` VALUES ('182', '35551', 'http://img.vip.alibaba.com/img/wsproduct/16/94/12/44/1694124470.jpg?1394113354000');
INSERT INTO `myr_goods_gallery` VALUES ('183', '35552', 'http://img.vip.alibaba.com/img/wsproduct/16/94/12/05/1694120500.jpg?1394113354000');
INSERT INTO `myr_goods_gallery` VALUES ('184', '35553', 'http://img.vip.alibaba.com/img/wsproduct/16/94/11/06/1694110653.jpg?1394113354000');
INSERT INTO `myr_goods_gallery` VALUES ('185', '35554', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_1.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('186', '35554', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_2.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('187', '35554', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_3.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('188', '35554', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_4.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('189', '35554', 'http://img.vip.alibaba.com/img/wsproduct/17/23/55/59/1723555940_5.jpg?1395141089000');
INSERT INTO `myr_goods_gallery` VALUES ('190', '35555', 'http://img.vip.alibaba.com/img/wsproduct/17/27/46/85/1727468504.jpg?1395250866000');
INSERT INTO `myr_goods_gallery` VALUES ('191', '35556', 'http://img.vip.alibaba.com/img/wsproduct/16/19/06/59/1619065931_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('192', '35556', 'http://img.vip.alibaba.com/img/wsproduct/16/19/06/59/1619065931_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('193', '35556', 'http://img.vip.alibaba.com/img/wsproduct/16/19/06/59/1619065931_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('194', '35557', 'http://img.vip.alibaba.com/img/wsproduct/16/19/03/95/1619039581_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('195', '35557', 'http://img.vip.alibaba.com/img/wsproduct/16/19/03/95/1619039581_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('196', '35557', 'http://img.vip.alibaba.com/img/wsproduct/16/19/03/95/1619039581_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('197', '35558', 'http://img.vip.alibaba.com/img/wsproduct/16/17/57/32/1617573231_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('198', '35558', 'http://img.vip.alibaba.com/img/wsproduct/16/17/57/32/1617573231_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('199', '35558', 'http://img.vip.alibaba.com/img/wsproduct/16/17/57/32/1617573231_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('200', '35559', 'http://img.vip.alibaba.com/img/wsproduct/15/42/17/62/1542176256_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('201', '35559', 'http://img.vip.alibaba.com/img/wsproduct/15/42/17/62/1542176256_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('202', '35559', 'http://img.vip.alibaba.com/img/wsproduct/15/42/17/62/1542176256_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('203', '35559', 'http://img.vip.alibaba.com/img/wsproduct/15/42/17/62/1542176256_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('204', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('205', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('206', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('207', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('208', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_5.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('209', '35560', 'http://img.vip.alibaba.com/img/wsproduct/15/28/12/54/1528125480_6.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('210', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('211', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('212', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('213', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('214', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_5.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('215', '35561', 'http://img.vip.alibaba.com/img/wsproduct/15/28/01/62/1528016260_6.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('216', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_1.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('217', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_2.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('218', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_3.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('219', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_4.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('220', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_5.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('221', '35562', 'http://img.vip.alibaba.com/img/wsproduct/14/96/48/33/1496483384_6.jpg?1395153314000');
INSERT INTO `myr_goods_gallery` VALUES ('222', '35563', 'http://img.vip.alibaba.com/img/wsproduct/17/10/09/68/1710096811_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('223', '35563', 'http://img.vip.alibaba.com/img/wsproduct/17/10/09/68/1710096811_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('224', '35563', 'http://img.vip.alibaba.com/img/wsproduct/17/10/09/68/1710096811_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('225', '35563', 'http://img.vip.alibaba.com/img/wsproduct/17/10/09/68/1710096811_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('226', '35563', 'http://img.vip.alibaba.com/img/wsproduct/17/10/09/68/1710096811_5.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('227', '35564', 'http://img.vip.alibaba.com/img/wsproduct/16/82/62/91/1682629150_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('228', '35564', 'http://img.vip.alibaba.com/img/wsproduct/16/82/62/91/1682629150_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('229', '35564', 'http://img.vip.alibaba.com/img/wsproduct/16/82/62/91/1682629150_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('230', '35564', 'http://img.vip.alibaba.com/img/wsproduct/16/82/62/91/1682629150_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('231', '35565', 'http://img.vip.alibaba.com/img/wsproduct/16/78/07/83/1678078397_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('232', '35565', 'http://img.vip.alibaba.com/img/wsproduct/16/78/07/83/1678078397_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('233', '35565', 'http://img.vip.alibaba.com/img/wsproduct/16/78/07/83/1678078397_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('234', '35565', 'http://img.vip.alibaba.com/img/wsproduct/16/78/07/83/1678078397_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('235', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('236', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('237', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('238', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('239', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_5.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('240', '35566', 'http://img.vip.alibaba.com/img/wsproduct/16/64/85/82/1664858278_6.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('241', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('242', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('243', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('244', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('245', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_5.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('246', '35567', 'http://img.vip.alibaba.com/img/wsproduct/16/64/07/57/1664075793_6.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('247', '35568', 'http://img.vip.alibaba.com/img/wsproduct/16/30/06/94/1630069423_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('248', '35568', 'http://img.vip.alibaba.com/img/wsproduct/16/30/06/94/1630069423_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('249', '35568', 'http://img.vip.alibaba.com/img/wsproduct/16/30/06/94/1630069423_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('250', '35569', 'http://img.vip.alibaba.com/img/wsproduct/16/28/47/29/1628472971_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('251', '35569', 'http://img.vip.alibaba.com/img/wsproduct/16/28/47/29/1628472971_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('252', '35570', 'http://img.vip.alibaba.com/img/wsproduct/16/18/87/40/1618874008_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('253', '35570', 'http://img.vip.alibaba.com/img/wsproduct/16/18/87/40/1618874008_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('254', '35570', 'http://img.vip.alibaba.com/img/wsproduct/16/18/87/40/1618874008_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('255', '35571', 'http://img.vip.alibaba.com/img/wsproduct/15/42/08/04/1542080446_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('256', '35571', 'http://img.vip.alibaba.com/img/wsproduct/15/42/08/04/1542080446_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('257', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('258', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('259', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('260', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('261', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_5.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('262', '35572', 'http://img.vip.alibaba.com/img/wsproduct/15/05/07/43/1505074343_6.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('263', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_1.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('264', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_2.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('265', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_3.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('266', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_4.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('267', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_5.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('268', '35573', 'http://img.vip.alibaba.com/img/wsproduct/15/02/66/82/1502668278_6.jpg?1395153313000');
INSERT INTO `myr_goods_gallery` VALUES ('269', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_1.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('270', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_2.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('271', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_3.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('272', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_4.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('273', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_5.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('274', '35574', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/23/96/1727239684_6.jpg?1395241889000');
INSERT INTO `myr_goods_gallery` VALUES ('275', '35575', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/18/76/1727187676_1.jpg?1395240748000');
INSERT INTO `myr_goods_gallery` VALUES ('276', '35575', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/18/76/1727187676_2.jpg?1395240748000');
INSERT INTO `myr_goods_gallery` VALUES ('277', '35575', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/18/76/1727187676_3.jpg?1395240748000');
INSERT INTO `myr_goods_gallery` VALUES ('278', '35575', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/18/76/1727187676_4.jpg?1395240748000');
INSERT INTO `myr_goods_gallery` VALUES ('279', '35575', 'http://img.vip.alibaba.com/img/wsproduct/draft/17/27/18/76/1727187676_5.jpg?1395240748000');
INSERT INTO `myr_goods_gallery` VALUES ('280', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_1.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('281', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_2.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('282', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_3.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('283', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_4.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('284', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_5.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('285', '1', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/39/1729783958_6.jpg?1395319074000');
INSERT INTO `myr_goods_gallery` VALUES ('286', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/29/74/80/1729748032_1.jpg?1395318556000');
INSERT INTO `myr_goods_gallery` VALUES ('287', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/29/74/80/1729748032_2.jpg?1395318556000');
INSERT INTO `myr_goods_gallery` VALUES ('288', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/29/74/80/1729748032_3.jpg?1395318556000');
INSERT INTO `myr_goods_gallery` VALUES ('289', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/29/74/80/1729748032_4.jpg?1395318556000');
INSERT INTO `myr_goods_gallery` VALUES ('290', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_1.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('291', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_2.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('292', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_3.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('293', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_4.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('294', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_5.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('295', '3', 'http://img.vip.alibaba.com/img/wsproduct/17/29/78/77/1729787728_6.jpg?1395318522000');
INSERT INTO `myr_goods_gallery` VALUES ('296', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_1.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('297', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_2.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('298', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_3.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('299', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_4.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('300', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_5.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('301', '4', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/79/1729717951_6.jpg?1395317677000');
INSERT INTO `myr_goods_gallery` VALUES ('302', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/29/72/18/1729721852_1.jpg?1395317275000');
INSERT INTO `myr_goods_gallery` VALUES ('303', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/29/72/18/1729721852_2.jpg?1395317275000');
INSERT INTO `myr_goods_gallery` VALUES ('304', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/29/72/18/1729721852_3.jpg?1395317275000');
INSERT INTO `myr_goods_gallery` VALUES ('305', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/29/72/18/1729721852_4.jpg?1395317275000');
INSERT INTO `myr_goods_gallery` VALUES ('306', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/29/72/18/1729721852_5.jpg?1395317275000');
INSERT INTO `myr_goods_gallery` VALUES ('307', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_1.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('308', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_2.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('309', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_3.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('310', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_4.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('311', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_5.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('312', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/41/1729674139_6.jpg?1395316909000');
INSERT INTO `myr_goods_gallery` VALUES ('313', '7', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/64/1729716484_1.jpg?1395316559000');
INSERT INTO `myr_goods_gallery` VALUES ('314', '7', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/64/1729716484_2.jpg?1395316559000');
INSERT INTO `myr_goods_gallery` VALUES ('315', '7', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/64/1729716484_3.jpg?1395316559000');
INSERT INTO `myr_goods_gallery` VALUES ('316', '7', 'http://img.vip.alibaba.com/img/wsproduct/17/29/71/64/1729716484_4.jpg?1395316559000');
INSERT INTO `myr_goods_gallery` VALUES ('317', '8', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/79/1729677927_1.jpg?1395316541000');
INSERT INTO `myr_goods_gallery` VALUES ('318', '8', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/79/1729677927_2.jpg?1395316541000');
INSERT INTO `myr_goods_gallery` VALUES ('319', '8', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/79/1729677927_3.jpg?1395316541000');
INSERT INTO `myr_goods_gallery` VALUES ('320', '8', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/79/1729677927_4.jpg?1395316541000');
INSERT INTO `myr_goods_gallery` VALUES ('321', '8', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/79/1729677927_5.jpg?1395316541000');
INSERT INTO `myr_goods_gallery` VALUES ('322', '9', 'http://img.vip.alibaba.com/img/wsproduct/17/29/64/70/1729647072_1.jpg?1395315880000');
INSERT INTO `myr_goods_gallery` VALUES ('323', '9', 'http://img.vip.alibaba.com/img/wsproduct/17/29/64/70/1729647072_2.jpg?1395315880000');
INSERT INTO `myr_goods_gallery` VALUES ('324', '9', 'http://img.vip.alibaba.com/img/wsproduct/17/29/64/70/1729647072_3.jpg?1395315880000');
INSERT INTO `myr_goods_gallery` VALUES ('325', '9', 'http://img.vip.alibaba.com/img/wsproduct/17/29/64/70/1729647072_4.jpg?1395315880000');
INSERT INTO `myr_goods_gallery` VALUES ('326', '9', 'http://img.vip.alibaba.com/img/wsproduct/17/29/64/70/1729647072_5.jpg?1395315880000');
INSERT INTO `myr_goods_gallery` VALUES ('327', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_1.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('328', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_2.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('329', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_3.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('330', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_4.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('331', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_5.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('332', '10', 'http://img.vip.alibaba.com/img/wsproduct/17/29/68/45/1729684574_6.jpg?1395315734000');
INSERT INTO `myr_goods_gallery` VALUES ('333', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_1.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('334', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_2.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('335', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_3.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('336', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_4.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('337', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_5.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('338', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/55/59/68/1655596873_6.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('339', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056418_1.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('340', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056418_2.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('341', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056418_3.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('342', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056418_4.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('343', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/52/66/91/1652669104_1.jpg?1395026971000');
INSERT INTO `myr_goods_gallery` VALUES ('344', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/52/66/91/1652669104_2.jpg?1395026971000');
INSERT INTO `myr_goods_gallery` VALUES ('345', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/52/66/91/1652669104_3.jpg?1395026971000');
INSERT INTO `myr_goods_gallery` VALUES ('346', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/52/66/91/1652669104_4.jpg?1395026971000');
INSERT INTO `myr_goods_gallery` VALUES ('347', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/52/66/91/1652669104_5.jpg?1395026971000');
INSERT INTO `myr_goods_gallery` VALUES ('348', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/53/51/82/1653518246_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('349', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/53/51/82/1653518246_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('350', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/53/51/82/1653518246_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('351', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/53/51/82/1653518246_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('352', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('353', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('354', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('355', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('356', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_5.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('357', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/52/85/53/1652855372_6.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('358', '6', 'http://img.vip.alibaba.com/img/wsproduct/16/51/10/55/1651105535_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('359', '6', 'http://img.vip.alibaba.com/img/wsproduct/16/51/10/55/1651105535_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('360', '6', 'http://img.vip.alibaba.com/img/wsproduct/16/51/10/55/1651105535_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('361', '6', 'http://img.vip.alibaba.com/img/wsproduct/16/51/10/55/1651105535_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('362', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056429_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('363', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056429_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('364', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/51/05/64/1651056429_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('365', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('366', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('367', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('368', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('369', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_5.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('370', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/38/70/62/1638706261_6.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('371', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/52/73/35/1652733594_1.jpg?1393769070000');
INSERT INTO `myr_goods_gallery` VALUES ('372', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/52/73/35/1652733594_2.jpg?1393769070000');
INSERT INTO `myr_goods_gallery` VALUES ('373', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/52/73/35/1652733594_3.jpg?1393769070000');
INSERT INTO `myr_goods_gallery` VALUES ('374', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/52/73/35/1652733594_4.jpg?1393769070000');
INSERT INTO `myr_goods_gallery` VALUES ('375', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/52/73/35/1652733594_5.jpg?1393769070000');
INSERT INTO `myr_goods_gallery` VALUES ('376', '10', 'http://img.vip.alibaba.com/img/wsproduct/16/86/29/04/1686290446_1.jpg?1393761717000');
INSERT INTO `myr_goods_gallery` VALUES ('377', '10', 'http://img.vip.alibaba.com/img/wsproduct/16/86/29/04/1686290446_2.jpg?1393761717000');
INSERT INTO `myr_goods_gallery` VALUES ('378', '10', 'http://img.vip.alibaba.com/img/wsproduct/16/86/29/04/1686290446_3.jpg?1393761717000');
INSERT INTO `myr_goods_gallery` VALUES ('379', '10', 'http://img.vip.alibaba.com/img/wsproduct/16/86/29/04/1686290446_4.jpg?1393761717000');
INSERT INTO `myr_goods_gallery` VALUES ('380', '10', 'http://img.vip.alibaba.com/img/wsproduct/16/86/29/04/1686290446_5.jpg?1393761717000');
INSERT INTO `myr_goods_gallery` VALUES ('381', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_1.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('382', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_2.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('383', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_3.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('384', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_4.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('385', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_5.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('386', '11', 'http://img.vip.alibaba.com/img/wsproduct/16/86/21/94/1686219468_6.jpg?1393760442000');
INSERT INTO `myr_goods_gallery` VALUES ('387', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_1.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('388', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_2.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('389', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_3.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('390', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_4.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('391', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_5.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('392', '12', 'http://img.vip.alibaba.com/img/wsproduct/16/86/17/76/1686177666_6.jpg?1393760355000');
INSERT INTO `myr_goods_gallery` VALUES ('393', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_1.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('394', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_2.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('395', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_3.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('396', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_4.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('397', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_5.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('398', '13', 'http://img.vip.alibaba.com/img/wsproduct/16/86/00/00/1686000087_6.jpg?1393754019000');
INSERT INTO `myr_goods_gallery` VALUES ('399', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_1.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('400', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_2.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('401', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_3.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('402', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_4.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('403', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_5.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('404', '14', 'http://img.vip.alibaba.com/img/wsproduct/16/86/01/43/1686014342_6.jpg?1393753978000');
INSERT INTO `myr_goods_gallery` VALUES ('405', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_1.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('406', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_2.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('407', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_3.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('408', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_4.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('409', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_5.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('410', '15', 'http://img.vip.alibaba.com/img/wsproduct/16/52/59/37/1652593799_6.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('411', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_1.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('412', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_2.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('413', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_3.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('414', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_4.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('415', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_5.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('416', '16', 'http://img.vip.alibaba.com/img/wsproduct/16/52/34/62/1652346206_6.jpg?1395129254000');
INSERT INTO `myr_goods_gallery` VALUES ('417', '17', 'http://img.vip.alibaba.com/img/wsproduct/16/53/67/70/1653677039_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('418', '17', 'http://img.vip.alibaba.com/img/wsproduct/16/53/67/70/1653677039_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('419', '17', 'http://img.vip.alibaba.com/img/wsproduct/16/53/67/70/1653677039_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('420', '17', 'http://img.vip.alibaba.com/img/wsproduct/16/53/67/70/1653677039_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('421', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_1.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('422', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_2.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('423', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_3.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('424', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_4.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('425', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_5.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('426', '18', 'http://img.vip.alibaba.com/img/wsproduct/16/52/75/12/1652751249_6.jpg?1395026809000');
INSERT INTO `myr_goods_gallery` VALUES ('427', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_1.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('428', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_2.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('429', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_3.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('430', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_4.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('431', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_5.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('432', '19', 'http://img.vip.alibaba.com/img/wsproduct/16/91/37/03/1691370308_6.jpg?1393943615000');
INSERT INTO `myr_goods_gallery` VALUES ('433', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_1.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('434', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_2.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('435', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_3.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('436', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_4.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('437', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_5.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('438', '20', 'http://img.vip.alibaba.com/img/wsproduct/16/51/07/23/1651072344_6.jpg?1393765980000');
INSERT INTO `myr_goods_gallery` VALUES ('439', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_1.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('440', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_2.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('441', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_3.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('442', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_4.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('443', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_5.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('444', '21', 'http://img.vip.alibaba.com/img/wsproduct/16/86/02/62/1686026243_6.jpg?1393753953000');
INSERT INTO `myr_goods_gallery` VALUES ('445', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_1.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('446', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_2.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('447', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_3.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('448', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_4.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('449', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_5.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('450', '22', 'http://img.vip.alibaba.com/img/wsproduct/16/86/04/62/1686046290_6.jpg?1393753902000');
INSERT INTO `myr_goods_gallery` VALUES ('451', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_1.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('452', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_2.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('453', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_3.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('454', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_4.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('455', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_5.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('456', '23', 'http://img.vip.alibaba.com/img/wsproduct/16/85/91/25/1685912510_6.jpg?1393746602000');
INSERT INTO `myr_goods_gallery` VALUES ('457', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_1.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('458', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_2.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('459', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_3.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('460', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_4.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('461', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_5.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('462', '24', 'http://img.vip.alibaba.com/img/wsproduct/16/85/65/01/1685650199_6.jpg?1393745753000');
INSERT INTO `myr_goods_gallery` VALUES ('463', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_1.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('464', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_2.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('465', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_3.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('466', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_4.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('467', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_5.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('468', '25', 'http://img.vip.alibaba.com/img/wsproduct/16/70/23/70/1670237037_6.jpg?1393139356000');
INSERT INTO `myr_goods_gallery` VALUES ('469', '1', 'http://img.vip.alibaba.com/img/wsproduct/52/76/48/85/527648854_1.jpg?1400829897000');
INSERT INTO `myr_goods_gallery` VALUES ('470', '1', 'http://img.vip.alibaba.com/img/wsproduct/52/76/48/85/527648854_2.jpg?1400829897000');
INSERT INTO `myr_goods_gallery` VALUES ('471', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_1.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('472', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_2.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('473', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_3.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('474', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_4.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('475', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_5.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('476', '2', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_6.jpg?1400829604000');
INSERT INTO `myr_goods_gallery` VALUES ('477', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_1.jpg?1400759159000');
INSERT INTO `myr_goods_gallery` VALUES ('478', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_2.jpg?1400759159000');
INSERT INTO `myr_goods_gallery` VALUES ('479', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_3.jpg?1400759159000');
INSERT INTO `myr_goods_gallery` VALUES ('480', '4', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_1.jpg?1400724770000');
INSERT INTO `myr_goods_gallery` VALUES ('481', '4', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_2.jpg?1400724770000');
INSERT INTO `myr_goods_gallery` VALUES ('482', '4', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_3.jpg?1400724770000');
INSERT INTO `myr_goods_gallery` VALUES ('483', '4', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_4.jpg?1400724770000');
INSERT INTO `myr_goods_gallery` VALUES ('484', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_1.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('485', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_2.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('486', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_3.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('487', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_4.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('488', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_5.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('489', '5', 'http://img.vip.alibaba.com/img/wsproduct/13/32/86/36/1332863674_6.jpg?1400642894000');
INSERT INTO `myr_goods_gallery` VALUES ('490', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_1.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('491', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_2.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('492', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_3.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('493', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_4.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('494', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_5.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('495', '6', 'http://img.vip.alibaba.com/img/wsproduct/81/18/87/37/811887371_6.jpg?1400392033000');
INSERT INTO `myr_goods_gallery` VALUES ('496', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_1.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('497', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_2.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('498', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_3.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('499', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_4.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('500', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_5.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('501', '1', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_6.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('502', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_1.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('503', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_2.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('504', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_3.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('505', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_4.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('506', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_5.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('507', '2', 'http://img.vip.alibaba.com/img/wsproduct/16/22/58/61/1622586154_6.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('508', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/60/68/46/1560684641_1.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('509', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/60/68/46/1560684641_2.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('510', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/60/68/46/1560684641_3.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('511', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/60/68/46/1560684641_4.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('512', '3', 'http://img.vip.alibaba.com/img/wsproduct/15/60/68/46/1560684641_5.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('513', '4', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_1.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('514', '4', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_2.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('515', '4', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_3.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('516', '4', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_4.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('517', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('518', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('519', '5', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('520', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('521', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('522', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('523', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('524', '6', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('525', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('526', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('527', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('528', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('529', '7', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('530', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('531', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('532', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('533', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('534', '8', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('535', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('536', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('537', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('538', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('539', '9', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('540', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('541', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('542', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('543', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('544', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('545', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('546', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('547', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('548', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('549', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('550', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('551', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('552', '13', 'http://img.vip.alibaba.com/img/wsproduct/14/24/27/06/1424270633_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('553', '13', 'http://img.vip.alibaba.com/img/wsproduct/14/24/27/06/1424270633_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('554', '14', 'http://img.vip.alibaba.com/img/wsproduct/14/24/27/06/1424270633_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('555', '14', 'http://img.vip.alibaba.com/img/wsproduct/14/24/27/06/1424270633_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('556', '15', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('557', '15', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('558', '15', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('559', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('560', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('561', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('562', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('563', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('564', '16', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_6.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('565', '17', 'http://img.vip.alibaba.com/img/wsproduct/80/04/89/41/800489413.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('566', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('567', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('568', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('569', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('570', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('571', '18', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_6.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('572', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('573', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('574', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('575', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('576', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('577', '19', 'http://img.vip.alibaba.com/img/wsproduct/70/90/22/51/709022519_6.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('578', '20', 'http://img.vip.alibaba.com/img/wsproduct/70/59/29/08/705929084_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('579', '20', 'http://img.vip.alibaba.com/img/wsproduct/70/59/29/08/705929084_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('580', '21', 'http://img.vip.alibaba.com/img/wsproduct/67/32/68/83/673268839_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('581', '21', 'http://img.vip.alibaba.com/img/wsproduct/67/32/68/83/673268839_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('582', '21', 'http://img.vip.alibaba.com/img/wsproduct/67/32/68/83/673268839_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('583', '22', 'http://img.vip.alibaba.com/img/wsproduct/62/30/47/66/623047665.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('584', '23', 'http://img.vip.alibaba.com/img/wsproduct/52/76/48/85/527648854_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('585', '23', 'http://img.vip.alibaba.com/img/wsproduct/52/76/48/85/527648854_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('586', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('587', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('588', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('589', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('590', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('591', '24', 'http://img.vip.alibaba.com/img/wsproduct/18/82/95/02/1882950227_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('592', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('593', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('594', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('595', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('596', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('597', '25', 'http://img.vip.alibaba.com/img/wsproduct/18/82/10/13/1882101358_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('598', '26', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('599', '26', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('600', '26', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('601', '26', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('602', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('603', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('604', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('605', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('606', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('607', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/59/36/46/1759364688_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('608', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/58/50/49/1758504926_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('609', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/58/50/49/1758504926_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('610', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/58/50/49/1758504926_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('611', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/58/50/49/1758504926_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('612', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('613', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('614', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('615', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('616', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('617', '29', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('618', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('619', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('620', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('621', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('622', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('623', '30', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('624', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('625', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('626', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('627', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('628', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('629', '31', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('630', '32', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('631', '32', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('632', '32', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('633', '32', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('634', '33', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('635', '33', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('636', '33', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('637', '33', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('638', '34', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('639', '34', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('640', '34', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('641', '34', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('642', '35', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('643', '35', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('644', '35', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('645', '35', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('646', '36', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('647', '36', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('648', '36', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('649', '36', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('650', '37', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('651', '37', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('652', '37', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('653', '37', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('654', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('655', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('656', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('657', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('658', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('659', '38', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('660', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('661', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('662', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('663', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('664', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('665', '39', 'http://img.vip.alibaba.com/img/wsproduct/15/27/45/14/1527451404_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('666', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('667', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('668', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('669', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('670', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('671', '40', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('672', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('673', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('674', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('675', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('676', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('677', '41', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('678', '42', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/15/1527081590_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('679', '42', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/15/1527081590_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('680', '42', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/15/1527081590_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('681', '42', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/15/1527081590_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('682', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('683', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('684', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('685', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('686', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('687', '43', 'http://img.vip.alibaba.com/img/wsproduct/15/27/00/04/1527000473_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('688', '44', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('689', '44', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('690', '44', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('691', '44', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('692', '44', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('693', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('694', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('695', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('696', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('697', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('698', '45', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('699', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('700', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('701', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('702', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('703', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('704', '46', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('705', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('706', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('707', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('708', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('709', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('710', '47', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('711', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('712', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('713', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('714', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('715', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('716', '48', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('717', '49', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/78/1317717806_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('718', '49', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/78/1317717806_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('719', '49', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/78/1317717806_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('720', '49', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/78/1317717806_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('721', '50', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('722', '50', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('723', '50', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('724', '50', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('725', '50', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('726', '51', 'http://img.vip.alibaba.com/img/wsproduct/92/94/94/83/929494837.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('727', '52', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('728', '52', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('729', '52', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('730', '52', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('731', '53', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('732', '53', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('733', '53', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('734', '53', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('735', '54', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('736', '54', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('737', '54', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('738', '55', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('739', '55', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('740', '55', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('741', '56', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('742', '56', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('743', '56', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('744', '56', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('745', '57', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('746', '57', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('747', '57', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('748', '57', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('749', '57', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('750', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('751', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('752', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('753', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('754', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('755', '58', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('756', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('757', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('758', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('759', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('760', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('761', '59', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('762', '60', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('763', '60', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('764', '60', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('765', '60', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('766', '60', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('767', '61', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('768', '61', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('769', '61', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('770', '61', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('771', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('772', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('773', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('774', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('775', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('776', '62', 'http://img.vip.alibaba.com/img/wsproduct/18/61/23/60/1861236064_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('777', '63', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('778', '63', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('779', '63', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('780', '63', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('781', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('782', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('783', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('784', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('785', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('786', '64', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('787', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('788', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('789', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('790', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('791', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('792', '65', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('793', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('794', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('795', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('796', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('797', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('798', '66', 'http://img.vip.alibaba.com/img/wsproduct/17/51/50/01/1751500172_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('799', '67', 'http://img.vip.alibaba.com/img/wsproduct/17/50/35/28/1750352840_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('800', '67', 'http://img.vip.alibaba.com/img/wsproduct/17/50/35/28/1750352840_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('801', '67', 'http://img.vip.alibaba.com/img/wsproduct/17/50/35/28/1750352840_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('802', '67', 'http://img.vip.alibaba.com/img/wsproduct/17/50/35/28/1750352840_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('803', '67', 'http://img.vip.alibaba.com/img/wsproduct/17/50/35/28/1750352840_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('804', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('805', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('806', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('807', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('808', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('809', '68', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('810', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('811', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('812', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('813', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('814', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('815', '69', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('816', '70', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('817', '70', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('818', '70', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('819', '70', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('820', '70', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('821', '71', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('822', '71', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('823', '71', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('824', '71', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('825', '72', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('826', '72', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('827', '72', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('828', '72', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('829', '73', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('830', '73', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('831', '73', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('832', '73', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('833', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('834', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('835', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('836', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('837', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('838', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('839', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('840', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('841', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('842', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('843', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('844', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('845', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('846', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('847', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('848', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('849', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('850', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('851', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('852', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('853', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('854', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('855', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('856', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('857', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('858', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('859', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('860', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('861', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('862', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('863', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('864', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('865', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('866', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/22/19/79/1622197935_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('867', '80', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('868', '80', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('869', '80', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('870', '80', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('871', '80', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('872', '81', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('873', '81', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('874', '81', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('875', '81', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('876', '81', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('877', '82', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('878', '82', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('879', '82', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('880', '82', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('881', '82', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('882', '83', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('883', '83', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('884', '83', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('885', '83', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('886', '83', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('887', '84', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('888', '84', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('889', '84', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('890', '84', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('891', '84', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('892', '85', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('893', '85', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('894', '85', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('895', '85', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('896', '85', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('897', '86', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('898', '86', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('899', '86', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('900', '86', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('901', '86', 'http://img.vip.alibaba.com/img/wsproduct/16/02/03/10/1602031066_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('902', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('903', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('904', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('905', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('906', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('907', '87', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('908', '88', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('909', '88', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('910', '88', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('911', '88', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('912', '88', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('913', '89', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('914', '89', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('915', '89', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('916', '89', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('917', '89', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('918', '90', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('919', '90', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('920', '90', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('921', '91', 'http://img.vip.alibaba.com/img/wsproduct/12/24/47/56/1224475643_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('922', '91', 'http://img.vip.alibaba.com/img/wsproduct/12/24/47/56/1224475643_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('923', '92', 'http://img.vip.alibaba.com/img/wsproduct/97/82/05/34/978205348_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('924', '92', 'http://img.vip.alibaba.com/img/wsproduct/97/82/05/34/978205348_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('925', '92', 'http://img.vip.alibaba.com/img/wsproduct/97/82/05/34/978205348_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('926', '93', 'http://img.vip.alibaba.com/img/wsproduct/94/87/60/37/948760378_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('927', '93', 'http://img.vip.alibaba.com/img/wsproduct/94/87/60/37/948760378_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('928', '93', 'http://img.vip.alibaba.com/img/wsproduct/94/87/60/37/948760378_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('929', '93', 'http://img.vip.alibaba.com/img/wsproduct/94/87/60/37/948760378_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('930', '93', 'http://img.vip.alibaba.com/img/wsproduct/94/87/60/37/948760378_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('931', '94', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('932', '94', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('933', '94', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('934', '94', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('935', '94', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('936', '95', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('937', '95', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('938', '95', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('939', '96', 'http://img.vip.alibaba.com/img/wsproduct/81/17/52/88/811752882_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('940', '96', 'http://img.vip.alibaba.com/img/wsproduct/81/17/52/88/811752882_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('941', '96', 'http://img.vip.alibaba.com/img/wsproduct/81/17/52/88/811752882_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('942', '97', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('943', '97', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('944', '97', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('945', '97', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('946', '97', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('947', '98', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('948', '98', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('949', '98', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('950', '99', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('951', '99', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('952', '99', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('953', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('954', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('955', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('956', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('957', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('958', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('959', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('960', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('961', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('962', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('963', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('964', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('965', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('966', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('967', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('968', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('969', '102', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('970', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('971', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('972', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('973', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('974', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('975', '103', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('976', '104', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('977', '104', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('978', '104', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('979', '104', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('980', '104', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('981', '105', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('982', '105', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('983', '105', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('984', '105', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('985', '105', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('986', '106', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('987', '106', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('988', '106', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('989', '106', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('990', '106', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('991', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('992', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('993', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('994', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('995', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('996', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('997', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('998', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('999', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1000', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1001', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1002', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1003', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1004', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1005', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1006', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1007', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1008', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1009', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1010', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1011', '110', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1012', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1013', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1014', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1015', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1016', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1017', '111', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1018', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1019', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1020', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1021', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1022', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1023', '112', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1024', '113', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1025', '113', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1026', '113', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1027', '113', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1028', '113', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1029', '114', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/99/1511029999_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1030', '114', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/99/1511029999_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1031', '114', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/99/1511029999_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1032', '114', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/99/1511029999_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1033', '114', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/99/1511029999_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1034', '115', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1035', '115', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1036', '115', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1037', '115', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1038', '115', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1039', '116', 'http://img.vip.alibaba.com/img/wsproduct/15/10/92/91/1510929185_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1040', '116', 'http://img.vip.alibaba.com/img/wsproduct/15/10/92/91/1510929185_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1041', '116', 'http://img.vip.alibaba.com/img/wsproduct/15/10/92/91/1510929185_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1042', '116', 'http://img.vip.alibaba.com/img/wsproduct/15/10/92/91/1510929185_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1043', '116', 'http://img.vip.alibaba.com/img/wsproduct/15/10/92/91/1510929185_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1044', '117', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1045', '117', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1046', '117', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1047', '117', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1048', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1049', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1050', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1051', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1052', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1053', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1054', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1055', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1056', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1057', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1058', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1059', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1060', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1061', '120', 'http://img.vip.alibaba.com/img/wsproduct/12/94/38/71/1294387183_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1062', '121', 'http://img.vip.alibaba.com/img/wsproduct/12/94/15/57/1294155780_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1063', '121', 'http://img.vip.alibaba.com/img/wsproduct/12/94/15/57/1294155780_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1064', '121', 'http://img.vip.alibaba.com/img/wsproduct/12/94/15/57/1294155780_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1065', '121', 'http://img.vip.alibaba.com/img/wsproduct/12/94/15/57/1294155780_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1066', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1067', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1068', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1069', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1070', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1071', '122', 'http://img.vip.alibaba.com/img/wsproduct/12/94/12/87/1294128774_6.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1072', '123', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1073', '123', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1074', '123', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1075', '123', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1076', '123', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1077', '124', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1078', '124', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1079', '124', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1080', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1081', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1082', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1083', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1084', '126', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1085', '126', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1086', '126', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1087', '126', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1088', '127', 'http://img.vip.alibaba.com/img/wsproduct/55/32/10/14/553210147_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1089', '127', 'http://img.vip.alibaba.com/img/wsproduct/55/32/10/14/553210147_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1090', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1091', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1092', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1093', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1094', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1095', '129', 'http://img.vip.alibaba.com/img/wsproduct/18/91/54/04/1891540424_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1096', '129', 'http://img.vip.alibaba.com/img/wsproduct/18/91/54/04/1891540424_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1097', '129', 'http://img.vip.alibaba.com/img/wsproduct/18/91/54/04/1891540424_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1098', '129', 'http://img.vip.alibaba.com/img/wsproduct/18/91/54/04/1891540424_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1099', '129', 'http://img.vip.alibaba.com/img/wsproduct/18/91/54/04/1891540424_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1100', '130', 'http://img.vip.alibaba.com/img/wsproduct/18/91/53/37/1891533743_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1101', '130', 'http://img.vip.alibaba.com/img/wsproduct/18/91/53/37/1891533743_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1102', '130', 'http://img.vip.alibaba.com/img/wsproduct/18/91/53/37/1891533743_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1103', '130', 'http://img.vip.alibaba.com/img/wsproduct/18/91/53/37/1891533743_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1104', '130', 'http://img.vip.alibaba.com/img/wsproduct/18/91/53/37/1891533743_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1105', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1106', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1107', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1108', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1109', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1110', '131', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_6.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1111', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1112', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1113', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1114', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1115', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1116', '132', 'http://img.vip.alibaba.com/img/wsproduct/18/91/09/83/1891098353_6.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1117', '133', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1118', '133', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1119', '133', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1120', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1121', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1122', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1123', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1124', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1125', '134', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_6.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1126', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1127', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1128', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1129', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1130', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1131', '135', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_6.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1132', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1133', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1134', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1135', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1136', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1137', '136', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_6.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1138', '137', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1139', '137', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1140', '137', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1141', '137', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1142', '137', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1143', '138', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1144', '138', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1145', '138', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1146', '138', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1147', '138', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_5.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1148', '139', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/79/1511147960_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1149', '139', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/79/1511147960_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1150', '139', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/79/1511147960_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1151', '140', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1152', '140', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1153', '140', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_3.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1154', '140', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_4.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1155', '141', 'http://img.vip.alibaba.com/img/wsproduct/97/79/76/59/977976599_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1156', '141', 'http://img.vip.alibaba.com/img/wsproduct/97/79/76/59/977976599_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1157', '142', 'http://img.vip.alibaba.com/img/wsproduct/55/58/24/65/555824652.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1158', '143', 'http://img.vip.alibaba.com/img/wsproduct/55/32/16/92/553216925_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1159', '143', 'http://img.vip.alibaba.com/img/wsproduct/55/32/16/92/553216925_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1160', '1', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_1.jpg?1402134096000');
INSERT INTO `myr_goods_gallery` VALUES ('1161', '1', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_2.jpg?1402134096000');
INSERT INTO `myr_goods_gallery` VALUES ('1162', '1', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_3.jpg?1402134096000');
INSERT INTO `myr_goods_gallery` VALUES ('1163', '1', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_4.jpg?1402134096000');
INSERT INTO `myr_goods_gallery` VALUES ('1164', '1', 'http://img.vip.alibaba.com/img/wsproduct/82/76/06/55/827606553_5.jpg?1402134096000');
INSERT INTO `myr_goods_gallery` VALUES ('1165', '2', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_1.jpg?1402132036000');
INSERT INTO `myr_goods_gallery` VALUES ('1166', '2', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_2.jpg?1402132036000');
INSERT INTO `myr_goods_gallery` VALUES ('1167', '2', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_3.jpg?1402132036000');
INSERT INTO `myr_goods_gallery` VALUES ('1168', '2', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_4.jpg?1402132036000');
INSERT INTO `myr_goods_gallery` VALUES ('1169', '2', 'http://img.vip.alibaba.com/img/wsproduct/73/28/74/53/732874539_5.jpg?1402132036000');
INSERT INTO `myr_goods_gallery` VALUES ('1170', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_1.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1171', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_2.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1172', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_3.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1173', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_4.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1174', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_5.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1175', '3', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_6.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1176', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_1.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1177', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_2.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1178', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_3.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1179', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_4.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1180', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_5.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1181', '4', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_6.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1182', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_1.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1183', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_2.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1184', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_3.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1185', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_4.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1186', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_5.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1187', '5', 'http://img.vip.alibaba.com/img/wsproduct/16/02/02/70/1602027011_6.jpg?1402131814000');
INSERT INTO `myr_goods_gallery` VALUES ('1188', '6', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_1.jpg?1402130904000');
INSERT INTO `myr_goods_gallery` VALUES ('1189', '6', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_2.jpg?1402130904000');
INSERT INTO `myr_goods_gallery` VALUES ('1190', '6', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_3.jpg?1402130904000');
INSERT INTO `myr_goods_gallery` VALUES ('1191', '6', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_4.jpg?1402130904000');
INSERT INTO `myr_goods_gallery` VALUES ('1192', '6', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/59/1526975974_5.jpg?1402130904000');
INSERT INTO `myr_goods_gallery` VALUES ('1193', '7', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_1.jpg?1402130880000');
INSERT INTO `myr_goods_gallery` VALUES ('1194', '7', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_2.jpg?1402130880000');
INSERT INTO `myr_goods_gallery` VALUES ('1195', '7', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_3.jpg?1402130880000');
INSERT INTO `myr_goods_gallery` VALUES ('1196', '7', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_4.jpg?1402130880000');
INSERT INTO `myr_goods_gallery` VALUES ('1197', '7', 'http://img.vip.alibaba.com/img/wsproduct/15/26/96/78/1526967846_5.jpg?1402130880000');
INSERT INTO `myr_goods_gallery` VALUES ('1198', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_1.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1199', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_2.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1200', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_3.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1201', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_4.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1202', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_5.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1203', '8', 'http://img.vip.alibaba.com/img/wsproduct/15/26/97/60/1526976038_6.jpg?1402130806000');
INSERT INTO `myr_goods_gallery` VALUES ('1204', '9', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_1.jpg?1402130705000');
INSERT INTO `myr_goods_gallery` VALUES ('1205', '9', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_2.jpg?1402130705000');
INSERT INTO `myr_goods_gallery` VALUES ('1206', '9', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_3.jpg?1402130705000');
INSERT INTO `myr_goods_gallery` VALUES ('1207', '9', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_4.jpg?1402130705000');
INSERT INTO `myr_goods_gallery` VALUES ('1208', '9', 'http://img.vip.alibaba.com/img/wsproduct/15/11/36/45/1511364507_5.jpg?1402130705000');
INSERT INTO `myr_goods_gallery` VALUES ('1209', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_1.jpg?1402130647000');
INSERT INTO `myr_goods_gallery` VALUES ('1210', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_2.jpg?1402130647000');
INSERT INTO `myr_goods_gallery` VALUES ('1211', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_3.jpg?1402130647000');
INSERT INTO `myr_goods_gallery` VALUES ('1212', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_4.jpg?1402130647000');
INSERT INTO `myr_goods_gallery` VALUES ('1213', '10', 'http://img.vip.alibaba.com/img/wsproduct/15/11/02/79/1511027911_5.jpg?1402130647000');
INSERT INTO `myr_goods_gallery` VALUES ('1214', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_1.jpg?1402130435000');
INSERT INTO `myr_goods_gallery` VALUES ('1215', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_2.jpg?1402130435000');
INSERT INTO `myr_goods_gallery` VALUES ('1216', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_3.jpg?1402130435000');
INSERT INTO `myr_goods_gallery` VALUES ('1217', '11', 'http://img.vip.alibaba.com/img/wsproduct/15/10/91/97/1510919773_4.jpg?1402130435000');
INSERT INTO `myr_goods_gallery` VALUES ('1218', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_1.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1219', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_2.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1220', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_3.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1221', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_4.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1222', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_5.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1223', '12', 'http://img.vip.alibaba.com/img/wsproduct/15/27/08/18/1527081888_6.jpg?1402130069000');
INSERT INTO `myr_goods_gallery` VALUES ('1224', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_1.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1225', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_2.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1226', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_3.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1227', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_4.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1228', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_5.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1229', '13', 'http://img.vip.alibaba.com/img/wsproduct/15/27/38/41/1527384162_6.jpg?1402129450000');
INSERT INTO `myr_goods_gallery` VALUES ('1230', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_1.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1231', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_2.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1232', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_3.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1233', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_4.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1234', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_5.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1235', '14', 'http://img.vip.alibaba.com/img/wsproduct/15/27/41/78/1527417863_6.jpg?1402129398000');
INSERT INTO `myr_goods_gallery` VALUES ('1236', '15', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_1.jpg?1402128969000');
INSERT INTO `myr_goods_gallery` VALUES ('1237', '15', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_2.jpg?1402128969000');
INSERT INTO `myr_goods_gallery` VALUES ('1238', '15', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_3.jpg?1402128969000');
INSERT INTO `myr_goods_gallery` VALUES ('1239', '15', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_4.jpg?1402128969000');
INSERT INTO `myr_goods_gallery` VALUES ('1240', '15', 'http://img.vip.alibaba.com/img/wsproduct/15/11/37/65/1511376523_5.jpg?1402128969000');
INSERT INTO `myr_goods_gallery` VALUES ('1241', '16', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_1.jpg?1402128832000');
INSERT INTO `myr_goods_gallery` VALUES ('1242', '16', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_2.jpg?1402128832000');
INSERT INTO `myr_goods_gallery` VALUES ('1243', '16', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_3.jpg?1402128832000');
INSERT INTO `myr_goods_gallery` VALUES ('1244', '16', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_4.jpg?1402128832000');
INSERT INTO `myr_goods_gallery` VALUES ('1245', '16', 'http://img.vip.alibaba.com/img/wsproduct/15/11/16/82/1511168271_5.jpg?1402128832000');
INSERT INTO `myr_goods_gallery` VALUES ('1246', '17', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_1.jpg?1402128575000');
INSERT INTO `myr_goods_gallery` VALUES ('1247', '17', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_2.jpg?1402128575000');
INSERT INTO `myr_goods_gallery` VALUES ('1248', '17', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_3.jpg?1402128575000');
INSERT INTO `myr_goods_gallery` VALUES ('1249', '17', 'http://img.vip.alibaba.com/img/wsproduct/15/11/14/40/1511144052_4.jpg?1402128575000');
INSERT INTO `myr_goods_gallery` VALUES ('1250', '18', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_1.jpg?1402127358000');
INSERT INTO `myr_goods_gallery` VALUES ('1251', '18', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_2.jpg?1402127358000');
INSERT INTO `myr_goods_gallery` VALUES ('1252', '18', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_3.jpg?1402127358000');
INSERT INTO `myr_goods_gallery` VALUES ('1253', '18', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_4.jpg?1402127358000');
INSERT INTO `myr_goods_gallery` VALUES ('1254', '18', 'http://img.vip.alibaba.com/img/wsproduct/17/14/51/28/1714512893_5.jpg?1402127358000');
INSERT INTO `myr_goods_gallery` VALUES ('1255', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_1.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1256', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_2.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1257', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_3.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1258', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_4.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1259', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_5.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1260', '19', 'http://img.vip.alibaba.com/img/wsproduct/17/14/86/72/1714867272_6.jpg?1402127354000');
INSERT INTO `myr_goods_gallery` VALUES ('1261', '20', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_1.jpg?1402126585000');
INSERT INTO `myr_goods_gallery` VALUES ('1262', '20', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_2.jpg?1402126585000');
INSERT INTO `myr_goods_gallery` VALUES ('1263', '20', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_3.jpg?1402126585000');
INSERT INTO `myr_goods_gallery` VALUES ('1264', '20', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_4.jpg?1402126585000');
INSERT INTO `myr_goods_gallery` VALUES ('1265', '20', 'http://img.vip.alibaba.com/img/wsproduct/17/29/67/92/1729679270_5.jpg?1402126585000');
INSERT INTO `myr_goods_gallery` VALUES ('1266', '21', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/01/1317710104_1.jpg?1402126542000');
INSERT INTO `myr_goods_gallery` VALUES ('1267', '21', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/01/1317710104_2.jpg?1402126542000');
INSERT INTO `myr_goods_gallery` VALUES ('1268', '21', 'http://img.vip.alibaba.com/img/wsproduct/13/17/71/01/1317710104_3.jpg?1402126542000');
INSERT INTO `myr_goods_gallery` VALUES ('1269', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_1.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1270', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_2.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1271', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_3.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1272', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_4.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1273', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_5.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1274', '22', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_6.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1275', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_1.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1276', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_2.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1277', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_3.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1278', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_4.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1279', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_5.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1280', '23', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_6.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1281', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_1.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1282', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_2.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1283', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_3.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1284', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_4.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1285', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_5.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1286', '24', 'http://img.vip.alibaba.com/img/wsproduct/13/30/46/29/1330462989_6.jpg?1402125499000');
INSERT INTO `myr_goods_gallery` VALUES ('1287', '25', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_1.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1288', '25', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_2.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1289', '25', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_3.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1290', '25', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_4.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1291', '25', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_5.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1292', '26', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_1.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1293', '26', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_2.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1294', '26', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_3.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1295', '26', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_4.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1296', '26', 'http://img.vip.alibaba.com/img/wsproduct/13/30/38/71/1330387166_5.jpg?1402125390000');
INSERT INTO `myr_goods_gallery` VALUES ('1297', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/58/49/41/1758494114_1.jpg?1402125165000');
INSERT INTO `myr_goods_gallery` VALUES ('1298', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/58/49/41/1758494114_2.jpg?1402125165000');
INSERT INTO `myr_goods_gallery` VALUES ('1299', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/58/49/41/1758494114_3.jpg?1402125165000');
INSERT INTO `myr_goods_gallery` VALUES ('1300', '27', 'http://img.vip.alibaba.com/img/wsproduct/17/58/49/41/1758494114_4.jpg?1402125165000');
INSERT INTO `myr_goods_gallery` VALUES ('1301', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_1.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1302', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_2.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1303', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_3.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1304', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_4.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1305', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_5.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1306', '28', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_6.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1307', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_1.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1308', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_2.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1309', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_3.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1310', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_4.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1311', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_5.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1312', '29', 'http://img.vip.alibaba.com/img/wsproduct/17/16/04/25/1716042565_6.jpg?1402124235000');
INSERT INTO `myr_goods_gallery` VALUES ('1313', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_1.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1314', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_2.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1315', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_3.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1316', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_4.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1317', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_5.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1318', '30', 'http://img.vip.alibaba.com/img/wsproduct/15/54/25/72/1554257273_6.jpg?1402123988000');
INSERT INTO `myr_goods_gallery` VALUES ('1319', '31', 'http://img.vip.alibaba.com/img/wsproduct/15/60/49/91/1560499167_1.jpg?1402123975000');
INSERT INTO `myr_goods_gallery` VALUES ('1320', '31', 'http://img.vip.alibaba.com/img/wsproduct/15/60/49/91/1560499167_2.jpg?1402123975000');
INSERT INTO `myr_goods_gallery` VALUES ('1321', '31', 'http://img.vip.alibaba.com/img/wsproduct/15/60/49/91/1560499167_3.jpg?1402123975000');
INSERT INTO `myr_goods_gallery` VALUES ('1322', '31', 'http://img.vip.alibaba.com/img/wsproduct/15/60/49/91/1560499167_4.jpg?1402123975000');
INSERT INTO `myr_goods_gallery` VALUES ('1323', '31', 'http://img.vip.alibaba.com/img/wsproduct/15/60/49/91/1560499167_5.jpg?1402123975000');
INSERT INTO `myr_goods_gallery` VALUES ('1324', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_1.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1325', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_2.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1326', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_3.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1327', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_4.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1328', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_5.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1329', '32', 'http://img.vip.alibaba.com/img/wsproduct/18/91/17/21/1891172165_6.jpg?1402123572000');
INSERT INTO `myr_goods_gallery` VALUES ('1330', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_1.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1331', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_2.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1332', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_3.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1333', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_4.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1334', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_5.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1335', '33', 'http://img.vip.alibaba.com/img/wsproduct/18/82/83/65/1882836596_6.jpg?1402121018000');
INSERT INTO `myr_goods_gallery` VALUES ('1336', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_1.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1337', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_2.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1338', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_3.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1339', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_4.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1340', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_5.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1341', '34', 'http://img.vip.alibaba.com/img/wsproduct/19/03/71/78/1903717803_6.jpg?1402108896000');
INSERT INTO `myr_goods_gallery` VALUES ('1342', '35', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_1.jpg?1402105663000');
INSERT INTO `myr_goods_gallery` VALUES ('1343', '35', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_2.jpg?1402105663000');
INSERT INTO `myr_goods_gallery` VALUES ('1344', '35', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_3.jpg?1402105663000');
INSERT INTO `myr_goods_gallery` VALUES ('1345', '35', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_4.jpg?1402105663000');
INSERT INTO `myr_goods_gallery` VALUES ('1346', '35', 'http://img.vip.alibaba.com/img/wsproduct/18/91/56/09/1891560965_5.jpg?1402105663000');
INSERT INTO `myr_goods_gallery` VALUES ('1347', '36', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_1.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1348', '36', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_2.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1349', '36', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_3.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1350', '36', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_4.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1351', '36', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_5.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1352', '37', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_1.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1353', '37', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_2.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1354', '37', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_3.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1355', '37', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_4.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1356', '37', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_5.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1357', '38', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_1.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1358', '38', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_2.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1359', '38', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_3.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1360', '38', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_4.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1361', '38', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_5.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1362', '39', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_1.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1363', '39', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_2.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1364', '39', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_3.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1365', '39', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_4.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1366', '39', 'http://img.vip.alibaba.com/img/wsproduct/16/22/28/64/1622286415_5.jpg?1402104759000');
INSERT INTO `myr_goods_gallery` VALUES ('1367', '40', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1368', '40', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1369', '40', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1370', '40', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1371', '40', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1372', '41', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1373', '41', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1374', '41', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1375', '41', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1376', '41', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1377', '42', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_1.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1378', '42', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_2.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1379', '42', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_3.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1380', '42', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_4.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1381', '42', 'http://img.vip.alibaba.com/img/wsproduct/16/23/74/98/1623749806_5.jpg?1402069967000');
INSERT INTO `myr_goods_gallery` VALUES ('1382', '43', 'http://img.vip.alibaba.com/img/wsproduct/14/24/15/71/1424157100_1.jpg?1402053155000');
INSERT INTO `myr_goods_gallery` VALUES ('1383', '43', 'http://img.vip.alibaba.com/img/wsproduct/14/24/15/71/1424157100_2.jpg?1402053155000');
INSERT INTO `myr_goods_gallery` VALUES ('1384', '44', 'http://img.vip.alibaba.com/img/wsproduct/14/24/15/71/1424157100_1.jpg?1402053155000');
INSERT INTO `myr_goods_gallery` VALUES ('1385', '44', 'http://img.vip.alibaba.com/img/wsproduct/14/24/15/71/1424157100_2.jpg?1402053155000');
INSERT INTO `myr_goods_gallery` VALUES ('1386', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_1.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1387', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_2.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1388', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_3.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1389', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_4.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1390', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_5.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1391', '45', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_6.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1392', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_1.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1393', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_2.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1394', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_3.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1395', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_4.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1396', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_5.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1397', '46', 'http://img.vip.alibaba.com/img/wsproduct/16/22/57/01/1622570185_6.jpg?1402052706000');
INSERT INTO `myr_goods_gallery` VALUES ('1398', '47', 'http://img.vip.alibaba.com/img/wsproduct/12/63/83/90/1263839077_1.jpg?1402044126000');
INSERT INTO `myr_goods_gallery` VALUES ('1399', '47', 'http://img.vip.alibaba.com/img/wsproduct/12/63/83/90/1263839077_2.jpg?1402044126000');
INSERT INTO `myr_goods_gallery` VALUES ('1400', '47', 'http://img.vip.alibaba.com/img/wsproduct/12/63/83/90/1263839077_3.jpg?1402044126000');
INSERT INTO `myr_goods_gallery` VALUES ('1401', '47', 'http://img.vip.alibaba.com/img/wsproduct/12/63/83/90/1263839077_4.jpg?1402044126000');
INSERT INTO `myr_goods_gallery` VALUES ('1402', '48', 'http://img.vip.alibaba.com/img/wsproduct/94/87/91/94/948791945_1.jpg?1401964035000');
INSERT INTO `myr_goods_gallery` VALUES ('1403', '48', 'http://img.vip.alibaba.com/img/wsproduct/94/87/91/94/948791945_2.jpg?1401964035000');
INSERT INTO `myr_goods_gallery` VALUES ('1404', '48', 'http://img.vip.alibaba.com/img/wsproduct/94/87/91/94/948791945_3.jpg?1401964035000');
INSERT INTO `myr_goods_gallery` VALUES ('1405', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_1.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1406', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_2.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1407', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_3.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1408', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_4.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1409', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_5.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1410', '49', 'http://img.vip.alibaba.com/img/wsproduct/17/15/10/40/1715104033_6.jpg?1401932676000');
INSERT INTO `myr_goods_gallery` VALUES ('1411', '50', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_1.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1412', '50', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_2.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1413', '50', 'http://img.vip.alibaba.com/img/wsproduct/17/88/11/40/1788114034_3.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1414', '51', 'http://img.vip.alibaba.com/img/wsproduct/17/16/65/86/1716658631_1.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1415', '51', 'http://img.vip.alibaba.com/img/wsproduct/17/16/65/86/1716658631_2.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1416', '51', 'http://img.vip.alibaba.com/img/wsproduct/17/16/65/86/1716658631_3.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1417', '51', 'http://img.vip.alibaba.com/img/wsproduct/17/16/65/86/1716658631_4.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1418', '51', 'http://img.vip.alibaba.com/img/wsproduct/17/16/65/86/1716658631_5.jpg?1401887764000');
INSERT INTO `myr_goods_gallery` VALUES ('1419', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_1.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1420', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_2.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1421', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_3.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1422', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_4.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1423', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_5.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1424', '52', 'http://img.vip.alibaba.com/img/wsproduct/17/14/76/99/1714769914_6.jpg?1401868154000');
INSERT INTO `myr_goods_gallery` VALUES ('1425', '53', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_1.jpg?1401868148000');
INSERT INTO `myr_goods_gallery` VALUES ('1426', '53', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_2.jpg?1401868148000');
INSERT INTO `myr_goods_gallery` VALUES ('1427', '53', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_3.jpg?1401868148000');
INSERT INTO `myr_goods_gallery` VALUES ('1428', '53', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_4.jpg?1401868148000');
INSERT INTO `myr_goods_gallery` VALUES ('1429', '53', 'http://img.vip.alibaba.com/img/wsproduct/17/15/80/82/1715808268_5.jpg?1401868148000');
INSERT INTO `myr_goods_gallery` VALUES ('1430', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_1.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1431', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_2.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1432', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_3.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1433', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_4.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1434', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_5.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1435', '54', 'http://img.vip.alibaba.com/img/wsproduct/17/16/01/53/1716015328_6.jpg?1401868144000');
INSERT INTO `myr_goods_gallery` VALUES ('1436', '55', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_1.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1437', '55', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_2.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1438', '55', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_3.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1439', '55', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_4.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1440', '55', 'http://img.vip.alibaba.com/img/wsproduct/17/14/31/79/1714317902_5.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1441', '56', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_1.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1442', '56', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_2.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1443', '56', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_3.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1444', '56', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_4.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1445', '56', 'http://img.vip.alibaba.com/img/wsproduct/17/14/01/62/1714016282_5.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1446', '57', 'http://img.vip.alibaba.com/img/wsproduct/13/41/85/86/1341858686_1.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1447', '57', 'http://img.vip.alibaba.com/img/wsproduct/13/41/85/86/1341858686_2.jpg?1401785935000');
INSERT INTO `myr_goods_gallery` VALUES ('1448', '58', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_1.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('1449', '58', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_2.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('1450', '58', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_3.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('1451', '58', 'http://img.vip.alibaba.com/img/wsproduct/90/53/91/73/905391733_4.jpg?1401682522000');
INSERT INTO `myr_goods_gallery` VALUES ('1452', '59', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1453', '59', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1454', '59', 'http://img.vip.alibaba.com/img/wsproduct/17/73/35/49/1773354952_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1455', '60', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1456', '60', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1457', '60', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1458', '60', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1459', '60', 'http://img.vip.alibaba.com/img/wsproduct/17/73/25/78/1773257898_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1460', '61', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1461', '61', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1462', '61', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1463', '61', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1464', '61', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1465', '62', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1466', '62', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1467', '62', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1468', '62', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1469', '62', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1470', '63', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1471', '63', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1472', '63', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1473', '63', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1474', '63', 'http://img.vip.alibaba.com/img/wsproduct/16/04/13/56/1604135610_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1475', '64', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1476', '64', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1477', '64', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1478', '64', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1479', '64', 'http://img.vip.alibaba.com/img/wsproduct/15/65/78/34/1565783470_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1480', '65', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1481', '65', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1482', '65', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1483', '65', 'http://img.vip.alibaba.com/img/wsproduct/15/64/36/13/1564361320_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1484', '66', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1485', '66', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1486', '66', 'http://img.vip.alibaba.com/img/wsproduct/15/64/34/41/1564344158_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1487', '67', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1488', '67', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1489', '67', 'http://img.vip.alibaba.com/img/wsproduct/10/53/49/95/1053499510_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1490', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1491', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1492', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1493', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1494', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1495', '68', 'http://img.vip.alibaba.com/img/wsproduct/80/18/66/62/801866625_6.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1496', '69', 'http://img.vip.alibaba.com/img/wsproduct/80/04/89/41/800489413.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1497', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1498', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1499', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1500', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1501', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_5.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1502', '70', 'http://img.vip.alibaba.com/img/wsproduct/79/72/75/43/797275436_6.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1503', '71', 'http://img.vip.alibaba.com/img/wsproduct/66/17/41/35/661741355_1.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1504', '71', 'http://img.vip.alibaba.com/img/wsproduct/66/17/41/35/661741355_2.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1505', '71', 'http://img.vip.alibaba.com/img/wsproduct/66/17/41/35/661741355_3.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1506', '71', 'http://img.vip.alibaba.com/img/wsproduct/66/17/41/35/661741355_4.jpg?1401518226000');
INSERT INTO `myr_goods_gallery` VALUES ('1507', '72', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1508', '72', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1509', '72', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1510', '72', 'http://img.vip.alibaba.com/img/wsproduct/18/77/30/79/1877307955_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1511', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1512', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1513', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1514', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1515', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1516', '73', 'http://img.vip.alibaba.com/img/wsproduct/17/59/33/51/1759335104_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1517', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1518', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1519', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1520', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1521', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1522', '74', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1523', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1524', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1525', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1526', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1527', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1528', '75', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1529', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1530', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1531', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1532', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1533', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1534', '76', 'http://img.vip.alibaba.com/img/wsproduct/16/82/41/09/1682410967_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1535', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1536', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1537', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1538', '77', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1539', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1540', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1541', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1542', '78', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1543', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1544', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1545', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1546', '79', 'http://img.vip.alibaba.com/img/wsproduct/16/12/18/51/1612185102_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1547', '80', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1548', '80', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1549', '80', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1550', '80', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1551', '81', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1552', '81', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1553', '81', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1554', '81', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1555', '82', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1556', '82', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1557', '82', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1558', '82', 'http://img.vip.alibaba.com/img/wsproduct/15/73/33/42/1573334205_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1559', '83', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1560', '83', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1561', '83', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1562', '83', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1563', '83', 'http://img.vip.alibaba.com/img/wsproduct/13/41/95/74/1341957457_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1564', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1565', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1566', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1567', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1568', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1569', '84', 'http://img.vip.alibaba.com/img/wsproduct/13/41/38/44/1341384424_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1570', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1571', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1572', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1573', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1574', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1575', '85', 'http://img.vip.alibaba.com/img/wsproduct/13/39/09/16/1339091640_6.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1576', '86', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1577', '86', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1578', '86', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1579', '86', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1580', '86', 'http://img.vip.alibaba.com/img/wsproduct/95/90/83/53/959083532_5.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1581', '87', 'http://img.vip.alibaba.com/img/wsproduct/92/94/94/83/929494837.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1582', '88', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1583', '88', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1584', '88', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1585', '88', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1586', '89', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1587', '89', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1588', '89', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1589', '89', 'http://img.vip.alibaba.com/img/wsproduct/89/84/23/898423590_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1590', '90', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1591', '90', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1592', '90', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1593', '91', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1594', '91', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1595', '91', 'http://img.vip.alibaba.com/img/wsproduct/89/78/28/68/897828688_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1596', '92', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_1.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1597', '92', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_2.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1598', '92', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_3.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1599', '92', 'http://img.vip.alibaba.com/img/wsproduct/71/67/55/80/716755805_4.jpg?1401515516000');
INSERT INTO `myr_goods_gallery` VALUES ('1600', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1601', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1602', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1603', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1604', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1605', '93', 'http://img.vip.alibaba.com/img/wsproduct/18/77/98/50/1877985004_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1606', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1607', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1608', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1609', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1610', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1611', '94', 'http://img.vip.alibaba.com/img/wsproduct/18/71/21/25/1871212599_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1612', '95', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1613', '95', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1614', '95', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1615', '95', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1616', '95', 'http://img.vip.alibaba.com/img/wsproduct/18/71/16/14/1871161452_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1617', '96', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1618', '96', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1619', '96', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1620', '96', 'http://img.vip.alibaba.com/img/wsproduct/18/65/73/41/1865734136_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1621', '97', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1622', '97', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1623', '97', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1624', '97', 'http://img.vip.alibaba.com/img/wsproduct/18/23/23/39/1823233953_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1625', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1626', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1627', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1628', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1629', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1630', '98', 'http://img.vip.alibaba.com/img/wsproduct/17/51/81/04/1751810447_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1631', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1632', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1633', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1634', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1635', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1636', '99', 'http://img.vip.alibaba.com/img/wsproduct/17/51/73/21/1751732159_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1637', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1638', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1639', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1640', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1641', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1642', '100', 'http://img.vip.alibaba.com/img/wsproduct/17/48/97/70/1748977044_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1643', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1644', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1645', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1646', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1647', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1648', '101', 'http://img.vip.alibaba.com/img/wsproduct/17/48/96/08/1748960813_6.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1649', '102', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1650', '102', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1651', '102', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1652', '102', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1653', '103', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1654', '103', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1655', '103', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1656', '103', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1657', '104', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1658', '104', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1659', '104', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1660', '104', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1661', '105', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1662', '105', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1663', '105', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1664', '105', 'http://img.vip.alibaba.com/img/wsproduct/16/80/82/84/1680828413_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1665', '106', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1666', '106', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1667', '106', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1668', '106', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1669', '106', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1670', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1671', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1672', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1673', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1674', '107', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1675', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1676', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1677', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1678', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1679', '108', 'http://img.vip.alibaba.com/img/wsproduct/16/05/96/05/1605960595_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1680', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1681', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1682', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1683', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1684', '109', 'http://img.vip.alibaba.com/img/wsproduct/16/04/15/03/1604150390_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1685', '110', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1686', '110', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1687', '110', 'http://img.vip.alibaba.com/img/wsproduct/13/22/72/70/1322727061_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1688', '111', 'http://img.vip.alibaba.com/img/wsproduct/12/64/08/43/1264084374_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1689', '111', 'http://img.vip.alibaba.com/img/wsproduct/12/64/08/43/1264084374_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1690', '111', 'http://img.vip.alibaba.com/img/wsproduct/12/64/08/43/1264084374_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1691', '111', 'http://img.vip.alibaba.com/img/wsproduct/12/64/08/43/1264084374_4.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1692', '111', 'http://img.vip.alibaba.com/img/wsproduct/12/64/08/43/1264084374_5.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1693', '112', 'http://img.vip.alibaba.com/img/wsproduct/12/24/47/56/1224475643_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1694', '112', 'http://img.vip.alibaba.com/img/wsproduct/12/24/47/56/1224475643_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1695', '113', 'http://img.vip.alibaba.com/img/wsproduct/97/81/58/66/978158665_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1696', '113', 'http://img.vip.alibaba.com/img/wsproduct/97/81/58/66/978158665_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1697', '114', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1698', '114', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1699', '114', 'http://img.vip.alibaba.com/img/wsproduct/82/71/94/52/827194526_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1700', '115', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1701', '115', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1702', '115', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1703', '116', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_1.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1704', '116', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_2.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1705', '116', 'http://img.vip.alibaba.com/img/wsproduct/52/27/26/20/522726205_3.jpg?1401515515000');
INSERT INTO `myr_goods_gallery` VALUES ('1706', '117', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1707', '117', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1708', '117', 'http://img.vip.alibaba.com/img/wsproduct/16/65/27/79/1665277945_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1709', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1710', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1711', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1712', '118', 'http://img.vip.alibaba.com/img/wsproduct/13/50/67/46/1350674677_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1713', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1714', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1715', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1716', '119', 'http://img.vip.alibaba.com/img/wsproduct/13/49/15/55/1349155519_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1717', '120', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1718', '120', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1719', '120', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1720', '120', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1721', '120', 'http://img.vip.alibaba.com/img/wsproduct/97/81/26/82/978126823_5.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1722', '121', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1723', '121', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1724', '121', 'http://img.vip.alibaba.com/img/wsproduct/66/17/70/76/661770767_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1725', '122', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1726', '122', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1727', '122', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1728', '122', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1729', '123', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1730', '123', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1731', '123', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_3.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1732', '123', 'http://img.vip.alibaba.com/img/wsproduct/55/32/23/65/553223652_4.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1733', '124', 'http://img.vip.alibaba.com/img/wsproduct/55/32/10/14/553210147_1.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1734', '124', 'http://img.vip.alibaba.com/img/wsproduct/55/32/10/14/553210147_2.jpg?1401515514000');
INSERT INTO `myr_goods_gallery` VALUES ('1735', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/16/92/553216925_1.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1736', '125', 'http://img.vip.alibaba.com/img/wsproduct/55/32/16/92/553216925_2.jpg?1401515513000');
INSERT INTO `myr_goods_gallery` VALUES ('1737', '126', 'http://img.vip.alibaba.com/img/wsproduct/draft/18/91/53/37/1891533743_1.jpg?1402112414000');
INSERT INTO `myr_goods_gallery` VALUES ('1738', '126', 'http://img.vip.alibaba.com/img/wsproduct/draft/18/91/53/37/1891533743_2.jpg?1402112414000');
INSERT INTO `myr_goods_gallery` VALUES ('1739', '126', 'http://img.vip.alibaba.com/img/wsproduct/draft/18/91/53/37/1891533743_3.jpg?1402112414000');
INSERT INTO `myr_goods_gallery` VALUES ('1740', '126', 'http://img.vip.alibaba.com/img/wsproduct/draft/18/91/53/37/1891533743_4.jpg?1402112414000');
INSERT INTO `myr_goods_gallery` VALUES ('1741', '126', 'http://img.vip.alibaba.com/img/wsproduct/draft/18/91/53/37/1891533743_5.jpg?1402112414000');
INSERT INTO `myr_goods_gallery` VALUES ('1742', '127', 'http://img.vip.alibaba.com/img/wsproduct/18/24/45/70/1824457041_1.jpg?1402112170000');
INSERT INTO `myr_goods_gallery` VALUES ('1743', '127', 'http://img.vip.alibaba.com/img/wsproduct/18/24/45/70/1824457041_2.jpg?1402112170000');
INSERT INTO `myr_goods_gallery` VALUES ('1744', '127', 'http://img.vip.alibaba.com/img/wsproduct/18/24/45/70/1824457041_3.jpg?1402112170000');
INSERT INTO `myr_goods_gallery` VALUES ('1745', '127', 'http://img.vip.alibaba.com/img/wsproduct/18/24/45/70/1824457041_4.jpg?1402112170000');
INSERT INTO `myr_goods_gallery` VALUES ('1746', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/94/50/06/1894500642_1.jpg?1402055364000');
INSERT INTO `myr_goods_gallery` VALUES ('1747', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/94/50/06/1894500642_2.jpg?1402055364000');
INSERT INTO `myr_goods_gallery` VALUES ('1748', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/94/50/06/1894500642_3.jpg?1402055364000');
INSERT INTO `myr_goods_gallery` VALUES ('1749', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/94/50/06/1894500642_4.jpg?1402055364000');
INSERT INTO `myr_goods_gallery` VALUES ('1750', '128', 'http://img.vip.alibaba.com/img/wsproduct/18/94/50/06/1894500642_5.jpg?1402055364000');
INSERT INTO `myr_goods_gallery` VALUES ('1751', '129', 'http://img.vip.alibaba.com/img/wsproduct/17/82/72/28/1782722849_1.jpg?1402046577000');
INSERT INTO `myr_goods_gallery` VALUES ('1752', '129', 'http://img.vip.alibaba.com/img/wsproduct/17/82/72/28/1782722849_2.jpg?1402046577000');
INSERT INTO `myr_goods_gallery` VALUES ('1753', '129', 'http://img.vip.alibaba.com/img/wsproduct/17/82/72/28/1782722849_3.jpg?1402046577000');
INSERT INTO `myr_goods_gallery` VALUES ('1754', '129', 'http://img.vip.alibaba.com/img/wsproduct/17/82/72/28/1782722849_4.jpg?1402046577000');
INSERT INTO `myr_goods_gallery` VALUES ('1755', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_1.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1756', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_2.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1757', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_3.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1758', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_4.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1759', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_5.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1760', '130', 'http://img.vip.alibaba.com/img/wsproduct/17/50/49/27/1750492769_6.jpg?1402044982000');
INSERT INTO `myr_goods_gallery` VALUES ('1761', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_1.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1762', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_2.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1763', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_3.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1764', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_4.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1765', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_5.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1766', '131', 'http://img.vip.alibaba.com/img/wsproduct/17/16/36/40/1716364094_6.jpg?1402044329000');
INSERT INTO `myr_goods_gallery` VALUES ('1767', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_1.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1768', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_2.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1769', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_3.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1770', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_4.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1771', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_5.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1772', '132', 'http://img.vip.alibaba.com/img/wsproduct/17/51/72/77/1751727797_6.jpg?1402042063000');
INSERT INTO `myr_goods_gallery` VALUES ('1773', '133', 'http://img.vip.alibaba.com/img/wsproduct/13/57/88/82/1357888272_1.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1774', '133', 'http://img.vip.alibaba.com/img/wsproduct/13/57/88/82/1357888272_2.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1775', '134', 'http://img.vip.alibaba.com/img/wsproduct/92/94/27/54/929427543_1.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1776', '134', 'http://img.vip.alibaba.com/img/wsproduct/92/94/27/54/929427543_2.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1777', '135', 'http://img.vip.alibaba.com/img/wsproduct/92/94/01/41/929401419_1.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1778', '135', 'http://img.vip.alibaba.com/img/wsproduct/92/94/01/41/929401419_2.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1779', '136', 'http://img.vip.alibaba.com/img/wsproduct/92/93/37/18/929337182_1.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1780', '136', 'http://img.vip.alibaba.com/img/wsproduct/92/93/37/18/929337182_2.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1781', '137', 'http://img.vip.alibaba.com/img/wsproduct/92/92/88/15/929288154_1.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1782', '137', 'http://img.vip.alibaba.com/img/wsproduct/92/92/88/15/929288154_2.jpg?1401848889000');
INSERT INTO `myr_goods_gallery` VALUES ('1783', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_1.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1784', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_2.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1785', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_3.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1786', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_4.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1787', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_5.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1788', '138', 'http://img.vip.alibaba.com/img/wsproduct/18/70/06/33/1870063392_6.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1789', '139', 'http://img.vip.alibaba.com/img/wsproduct/18/24/57/74/1824577423_1.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1790', '139', 'http://img.vip.alibaba.com/img/wsproduct/18/24/57/74/1824577423_2.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1791', '139', 'http://img.vip.alibaba.com/img/wsproduct/18/24/57/74/1824577423_3.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1792', '139', 'http://img.vip.alibaba.com/img/wsproduct/18/24/57/74/1824577423_4.jpg?1401848888000');
INSERT INTO `myr_goods_gallery` VALUES ('1793', '140', 'http://img.vip.alibaba.com/img/wsproduct/10/28/64/42/1028644278_1.jpg?1401848887000');
INSERT INTO `myr_goods_gallery` VALUES ('1794', '140', 'http://img.vip.alibaba.com/img/wsproduct/10/28/64/42/1028644278_2.jpg?1401848887000');
INSERT INTO `myr_goods_gallery` VALUES ('1795', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_1.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1796', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_2.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1797', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_3.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1798', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_4.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1799', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_5.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1800', '141', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/17/1795761709_6.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1801', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_1.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1802', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_2.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1803', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_3.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1804', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_4.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1805', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_5.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1806', '142', 'http://img.vip.alibaba.com/img/wsproduct/17/95/76/14/1795761472_6.jpg?1401848886000');
INSERT INTO `myr_goods_gallery` VALUES ('1807', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_1.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1808', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_2.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1809', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_3.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1810', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_4.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1811', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_5.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1812', '143', 'http://img.vip.alibaba.com/img/wsproduct/16/23/84/32/1623843255_6.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1813', '144', 'http://img.vip.alibaba.com/img/wsproduct/13/00/31/33/1300313377_1.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1814', '144', 'http://img.vip.alibaba.com/img/wsproduct/13/00/31/33/1300313377_2.jpg?1401797752000');
INSERT INTO `myr_goods_gallery` VALUES ('1815', '145', 'http://img.vip.alibaba.com/img/wsproduct/18/75/04/29/1875042907_1.jpg?1402112114000');
INSERT INTO `myr_goods_gallery` VALUES ('1816', '145', 'http://img.vip.alibaba.com/img/wsproduct/18/75/04/29/1875042907_2.jpg?1402112114000');
INSERT INTO `myr_goods_gallery` VALUES ('1817', '145', 'http://img.vip.alibaba.com/img/wsproduct/18/75/04/29/1875042907_3.jpg?1402112114000');
INSERT INTO `myr_goods_gallery` VALUES ('1818', '145', 'http://img.vip.alibaba.com/img/wsproduct/18/75/04/29/1875042907_4.jpg?1402112114000');
INSERT INTO `myr_goods_gallery` VALUES ('1819', '145', 'http://img.vip.alibaba.com/img/wsproduct/18/75/04/29/1875042907_5.jpg?1402112114000');
INSERT INTO `myr_goods_gallery` VALUES ('1820', '146', 'http://img.vip.alibaba.com/img/wsproduct/14/57/59/67/1457596750_1.jpg?1402109456000');
INSERT INTO `myr_goods_gallery` VALUES ('1821', '146', 'http://img.vip.alibaba.com/img/wsproduct/14/57/59/67/1457596750_2.jpg?1402109456000');
INSERT INTO `myr_goods_gallery` VALUES ('1822', '147', 'http://img.vip.alibaba.com/img/wsproduct/17/73/50/98/1773509843_1.jpg?1402107931000');
INSERT INTO `myr_goods_gallery` VALUES ('1823', '147', 'http://img.vip.alibaba.com/img/wsproduct/17/73/50/98/1773509843_2.jpg?1402107931000');
INSERT INTO `myr_goods_gallery` VALUES ('1824', '147', 'http://img.vip.alibaba.com/img/wsproduct/17/73/50/98/1773509843_3.jpg?1402107931000');
INSERT INTO `myr_goods_gallery` VALUES ('1825', '147', 'http://img.vip.alibaba.com/img/wsproduct/17/73/50/98/1773509843_4.jpg?1402107931000');
INSERT INTO `myr_goods_gallery` VALUES ('1826', '147', 'http://img.vip.alibaba.com/img/wsproduct/17/73/50/98/1773509843_5.jpg?1402107931000');
INSERT INTO `myr_goods_gallery` VALUES ('1827', '148', 'http://img.vip.alibaba.com/img/wsproduct/19/03/33/07/1903330786_1.jpg?1402064684000');
INSERT INTO `myr_goods_gallery` VALUES ('1828', '148', 'http://img.vip.alibaba.com/img/wsproduct/19/03/33/07/1903330786_2.jpg?1402064684000');
INSERT INTO `myr_goods_gallery` VALUES ('1829', '148', 'http://img.vip.alibaba.com/img/wsproduct/19/03/33/07/1903330786_3.jpg?1402064684000');
INSERT INTO `myr_goods_gallery` VALUES ('1830', '148', 'http://img.vip.alibaba.com/img/wsproduct/19/03/33/07/1903330786_4.jpg?1402064684000');
INSERT INTO `myr_goods_gallery` VALUES ('1831', '149', 'http://img.vip.alibaba.com/img/wsproduct/19/03/35/64/1903356454_1.jpg?1402064400000');
INSERT INTO `myr_goods_gallery` VALUES ('1832', '149', 'http://img.vip.alibaba.com/img/wsproduct/19/03/35/64/1903356454_2.jpg?1402064400000');
INSERT INTO `myr_goods_gallery` VALUES ('1833', '149', 'http://img.vip.alibaba.com/img/wsproduct/19/03/35/64/1903356454_3.jpg?1402064400000');
INSERT INTO `myr_goods_gallery` VALUES ('1834', '149', 'http://img.vip.alibaba.com/img/wsproduct/19/03/35/64/1903356454_4.jpg?1402064400000');
INSERT INTO `myr_goods_gallery` VALUES ('1835', '150', 'http://img.vip.alibaba.com/img/wsproduct/19/03/28/13/1903281333_1.jpg?1402064160000');
INSERT INTO `myr_goods_gallery` VALUES ('1836', '150', 'http://img.vip.alibaba.com/img/wsproduct/19/03/28/13/1903281333_2.jpg?1402064160000');
INSERT INTO `myr_goods_gallery` VALUES ('1837', '150', 'http://img.vip.alibaba.com/img/wsproduct/19/03/28/13/1903281333_3.jpg?1402064160000');
INSERT INTO `myr_goods_gallery` VALUES ('1838', '150', 'http://img.vip.alibaba.com/img/wsproduct/19/03/28/13/1903281333_4.jpg?1402064160000');
INSERT INTO `myr_goods_gallery` VALUES ('1839', '151', 'http://img.vip.alibaba.com/img/wsproduct/19/03/30/29/1903302907_1.jpg?1402063785000');
INSERT INTO `myr_goods_gallery` VALUES ('1840', '151', 'http://img.vip.alibaba.com/img/wsproduct/19/03/30/29/1903302907_2.jpg?1402063785000');
INSERT INTO `myr_goods_gallery` VALUES ('1841', '151', 'http://img.vip.alibaba.com/img/wsproduct/19/03/30/29/1903302907_3.jpg?1402063785000');
INSERT INTO `myr_goods_gallery` VALUES ('1842', '151', 'http://img.vip.alibaba.com/img/wsproduct/19/03/30/29/1903302907_4.jpg?1402063785000');
INSERT INTO `myr_goods_gallery` VALUES ('1843', '152', 'http://img.vip.alibaba.com/img/wsproduct/14/60/76/65/1460766539_1.jpg?1402045372000');
INSERT INTO `myr_goods_gallery` VALUES ('1844', '152', 'http://img.vip.alibaba.com/img/wsproduct/14/60/76/65/1460766539_2.jpg?1402045372000');
INSERT INTO `myr_goods_gallery` VALUES ('1845', '1', '');
INSERT INTO `myr_goods_gallery` VALUES ('1846', '1', '');
INSERT INTO `myr_goods_gallery` VALUES ('1847', '2', '');
INSERT INTO `myr_goods_gallery` VALUES ('1848', '3', '');
INSERT INTO `myr_goods_gallery` VALUES ('1849', '4', '');
INSERT INTO `myr_goods_gallery` VALUES ('1850', '5', '');
INSERT INTO `myr_goods_gallery` VALUES ('1851', '6', '');
INSERT INTO `myr_goods_gallery` VALUES ('1852', '7', '');
INSERT INTO `myr_goods_gallery` VALUES ('1853', '8', '');
INSERT INTO `myr_goods_gallery` VALUES ('1854', '9', '');
INSERT INTO `myr_goods_gallery` VALUES ('1855', '10', '');
INSERT INTO `myr_goods_gallery` VALUES ('1856', '11', '');
INSERT INTO `myr_goods_gallery` VALUES ('1857', '12', '');
INSERT INTO `myr_goods_gallery` VALUES ('1858', '13', '');
INSERT INTO `myr_goods_gallery` VALUES ('1859', '14', '');
INSERT INTO `myr_goods_gallery` VALUES ('1860', '15', '');
INSERT INTO `myr_goods_gallery` VALUES ('1861', '16', '');
INSERT INTO `myr_goods_gallery` VALUES ('1862', '17', '');
INSERT INTO `myr_goods_gallery` VALUES ('1863', '18', '');
INSERT INTO `myr_goods_gallery` VALUES ('1864', '19', '');
INSERT INTO `myr_goods_gallery` VALUES ('1865', '20', '');
INSERT INTO `myr_goods_gallery` VALUES ('1866', '21', '');
INSERT INTO `myr_goods_gallery` VALUES ('1867', '22', '');
INSERT INTO `myr_goods_gallery` VALUES ('1868', '23', '');
INSERT INTO `myr_goods_gallery` VALUES ('1869', '24', '');
INSERT INTO `myr_goods_gallery` VALUES ('1870', '25', '');
INSERT INTO `myr_goods_gallery` VALUES ('1871', '26', '');
INSERT INTO `myr_goods_gallery` VALUES ('1872', '27', '');
INSERT INTO `myr_goods_gallery` VALUES ('1873', '28', '');
INSERT INTO `myr_goods_gallery` VALUES ('1874', '29', '');
INSERT INTO `myr_goods_gallery` VALUES ('1875', '30', '');
INSERT INTO `myr_goods_gallery` VALUES ('1876', '31', '');
INSERT INTO `myr_goods_gallery` VALUES ('1877', '32', '');
INSERT INTO `myr_goods_gallery` VALUES ('1878', '33', '');
INSERT INTO `myr_goods_gallery` VALUES ('1879', '34', '');
INSERT INTO `myr_goods_gallery` VALUES ('1880', '35', '');
INSERT INTO `myr_goods_gallery` VALUES ('1881', '36', '');
INSERT INTO `myr_goods_gallery` VALUES ('1882', '37', '');
INSERT INTO `myr_goods_gallery` VALUES ('1883', '38', '');
INSERT INTO `myr_goods_gallery` VALUES ('1884', '39', '');
INSERT INTO `myr_goods_gallery` VALUES ('1885', '40', '');
INSERT INTO `myr_goods_gallery` VALUES ('1886', '41', '');
INSERT INTO `myr_goods_gallery` VALUES ('1887', '42', '');
INSERT INTO `myr_goods_gallery` VALUES ('1888', '43', '');
INSERT INTO `myr_goods_gallery` VALUES ('1889', '44', '');
INSERT INTO `myr_goods_gallery` VALUES ('1890', '45', '');
INSERT INTO `myr_goods_gallery` VALUES ('1891', '46', '');
INSERT INTO `myr_goods_gallery` VALUES ('1892', '47', '');
INSERT INTO `myr_goods_gallery` VALUES ('1893', '48', '');
INSERT INTO `myr_goods_gallery` VALUES ('1894', '49', '');
INSERT INTO `myr_goods_gallery` VALUES ('1895', '50', '');
INSERT INTO `myr_goods_gallery` VALUES ('1896', '51', '');
INSERT INTO `myr_goods_gallery` VALUES ('1897', '52', '');
INSERT INTO `myr_goods_gallery` VALUES ('1898', '53', '');
INSERT INTO `myr_goods_gallery` VALUES ('1899', '54', '');
INSERT INTO `myr_goods_gallery` VALUES ('1900', '55', '');
INSERT INTO `myr_goods_gallery` VALUES ('1901', '56', '');
INSERT INTO `myr_goods_gallery` VALUES ('1902', '57', '');
INSERT INTO `myr_goods_gallery` VALUES ('1903', '58', '');
INSERT INTO `myr_goods_gallery` VALUES ('1904', '59', '');
INSERT INTO `myr_goods_gallery` VALUES ('1905', '60', '');
INSERT INTO `myr_goods_gallery` VALUES ('1906', '61', '');
INSERT INTO `myr_goods_gallery` VALUES ('1907', '62', '');
INSERT INTO `myr_goods_gallery` VALUES ('1908', '63', '');
INSERT INTO `myr_goods_gallery` VALUES ('1909', '64', '');
INSERT INTO `myr_goods_gallery` VALUES ('1910', '65', '');
INSERT INTO `myr_goods_gallery` VALUES ('1911', '66', '');
INSERT INTO `myr_goods_gallery` VALUES ('1912', '67', '');
INSERT INTO `myr_goods_gallery` VALUES ('1913', '68', '');
INSERT INTO `myr_goods_gallery` VALUES ('1914', '69', '');
INSERT INTO `myr_goods_gallery` VALUES ('1915', '70', '');
INSERT INTO `myr_goods_gallery` VALUES ('1916', '71', '');
INSERT INTO `myr_goods_gallery` VALUES ('1917', '72', '');
INSERT INTO `myr_goods_gallery` VALUES ('1918', '73', '');
INSERT INTO `myr_goods_gallery` VALUES ('1919', '74', '');
INSERT INTO `myr_goods_gallery` VALUES ('1920', '75', '');
INSERT INTO `myr_goods_gallery` VALUES ('1921', '76', '');
INSERT INTO `myr_goods_gallery` VALUES ('1922', '77', '');
INSERT INTO `myr_goods_gallery` VALUES ('1923', '78', '');
INSERT INTO `myr_goods_gallery` VALUES ('1924', '79', '');
INSERT INTO `myr_goods_gallery` VALUES ('1925', '80', '');
INSERT INTO `myr_goods_gallery` VALUES ('1926', '81', '');
INSERT INTO `myr_goods_gallery` VALUES ('1927', '82', '');
INSERT INTO `myr_goods_gallery` VALUES ('1928', '83', '');
INSERT INTO `myr_goods_gallery` VALUES ('1929', '84', '');
INSERT INTO `myr_goods_gallery` VALUES ('1930', '85', '');
INSERT INTO `myr_goods_gallery` VALUES ('1931', '86', '');
INSERT INTO `myr_goods_gallery` VALUES ('1932', '87', '');
INSERT INTO `myr_goods_gallery` VALUES ('1933', '88', '');
INSERT INTO `myr_goods_gallery` VALUES ('1934', '89', '');
INSERT INTO `myr_goods_gallery` VALUES ('1935', '90', '');
INSERT INTO `myr_goods_gallery` VALUES ('1936', '91', '');
INSERT INTO `myr_goods_gallery` VALUES ('1937', '92', '');
INSERT INTO `myr_goods_gallery` VALUES ('1938', '93', '');
INSERT INTO `myr_goods_gallery` VALUES ('1939', '94', '');
INSERT INTO `myr_goods_gallery` VALUES ('1940', '95', '');
INSERT INTO `myr_goods_gallery` VALUES ('1941', '96', '');
INSERT INTO `myr_goods_gallery` VALUES ('1942', '97', '');
INSERT INTO `myr_goods_gallery` VALUES ('1943', '98', '');
INSERT INTO `myr_goods_gallery` VALUES ('1944', '99', '');
INSERT INTO `myr_goods_gallery` VALUES ('1945', '100', '');
INSERT INTO `myr_goods_gallery` VALUES ('1946', '101', '');
INSERT INTO `myr_goods_gallery` VALUES ('1947', '102', '');
INSERT INTO `myr_goods_gallery` VALUES ('1948', '103', '');
INSERT INTO `myr_goods_gallery` VALUES ('1949', '104', '');
INSERT INTO `myr_goods_gallery` VALUES ('1950', '105', '');
INSERT INTO `myr_goods_gallery` VALUES ('1951', '106', '');
INSERT INTO `myr_goods_gallery` VALUES ('1952', '107', '');
INSERT INTO `myr_goods_gallery` VALUES ('1953', '108', '');
INSERT INTO `myr_goods_gallery` VALUES ('1954', '109', '');
INSERT INTO `myr_goods_gallery` VALUES ('1955', '110', '');
INSERT INTO `myr_goods_gallery` VALUES ('1956', '111', '');
INSERT INTO `myr_goods_gallery` VALUES ('1957', '112', '');
INSERT INTO `myr_goods_gallery` VALUES ('1958', '113', '');
INSERT INTO `myr_goods_gallery` VALUES ('1959', '114', '');
INSERT INTO `myr_goods_gallery` VALUES ('1960', '115', '');
INSERT INTO `myr_goods_gallery` VALUES ('1961', '116', '');
INSERT INTO `myr_goods_gallery` VALUES ('1962', '117', '');
INSERT INTO `myr_goods_gallery` VALUES ('1963', '118', '');
INSERT INTO `myr_goods_gallery` VALUES ('1964', '119', '');
INSERT INTO `myr_goods_gallery` VALUES ('1965', '120', '');
INSERT INTO `myr_goods_gallery` VALUES ('1966', '121', '');
INSERT INTO `myr_goods_gallery` VALUES ('1967', '122', '');
INSERT INTO `myr_goods_gallery` VALUES ('1968', '123', '');
INSERT INTO `myr_goods_gallery` VALUES ('1969', '124', '');
INSERT INTO `myr_goods_gallery` VALUES ('1970', '125', '');
INSERT INTO `myr_goods_gallery` VALUES ('1971', '126', '');
INSERT INTO `myr_goods_gallery` VALUES ('1972', '127', '');
INSERT INTO `myr_goods_gallery` VALUES ('1973', '128', '');
INSERT INTO `myr_goods_gallery` VALUES ('1974', '129', '');
INSERT INTO `myr_goods_gallery` VALUES ('1975', '130', '');
INSERT INTO `myr_goods_gallery` VALUES ('1976', '131', '');
INSERT INTO `myr_goods_gallery` VALUES ('1977', '132', '');
INSERT INTO `myr_goods_gallery` VALUES ('1978', '133', '');
INSERT INTO `myr_goods_gallery` VALUES ('1979', '134', '');
INSERT INTO `myr_goods_gallery` VALUES ('1980', '135', '');
INSERT INTO `myr_goods_gallery` VALUES ('1981', '136', '');
INSERT INTO `myr_goods_gallery` VALUES ('1982', '137', '');
INSERT INTO `myr_goods_gallery` VALUES ('1983', '138', '');
INSERT INTO `myr_goods_gallery` VALUES ('1984', '139', '');
INSERT INTO `myr_goods_gallery` VALUES ('1985', '140', '');
INSERT INTO `myr_goods_gallery` VALUES ('1986', '141', '');
INSERT INTO `myr_goods_gallery` VALUES ('1987', '142', '');
INSERT INTO `myr_goods_gallery` VALUES ('1988', '143', '');
INSERT INTO `myr_goods_gallery` VALUES ('1989', '144', '');
INSERT INTO `myr_goods_gallery` VALUES ('1990', '145', '');
INSERT INTO `myr_goods_gallery` VALUES ('1991', '146', '');
INSERT INTO `myr_goods_gallery` VALUES ('1992', '147', '');
INSERT INTO `myr_goods_gallery` VALUES ('1993', '148', '');
INSERT INTO `myr_goods_gallery` VALUES ('1994', '149', '');
INSERT INTO `myr_goods_gallery` VALUES ('1995', '150', '');
INSERT INTO `myr_goods_gallery` VALUES ('1996', '151', '');
INSERT INTO `myr_goods_gallery` VALUES ('1997', '152', '');
INSERT INTO `myr_goods_gallery` VALUES ('1998', '153', '');
INSERT INTO `myr_goods_gallery` VALUES ('1999', '154', '');
INSERT INTO `myr_goods_gallery` VALUES ('2000', '155', '');
INSERT INTO `myr_goods_gallery` VALUES ('2001', '156', '');
INSERT INTO `myr_goods_gallery` VALUES ('2002', '157', '');
INSERT INTO `myr_goods_gallery` VALUES ('2003', '158', '');
INSERT INTO `myr_goods_gallery` VALUES ('2004', '159', '');
INSERT INTO `myr_goods_gallery` VALUES ('2005', '160', '');
INSERT INTO `myr_goods_gallery` VALUES ('2006', '161', '');
INSERT INTO `myr_goods_gallery` VALUES ('2007', '162', '');
INSERT INTO `myr_goods_gallery` VALUES ('2008', '163', '');
INSERT INTO `myr_goods_gallery` VALUES ('2009', '164', '');
INSERT INTO `myr_goods_gallery` VALUES ('2010', '165', '');
INSERT INTO `myr_goods_gallery` VALUES ('2011', '166', '');
INSERT INTO `myr_goods_gallery` VALUES ('2012', '167', '');
INSERT INTO `myr_goods_gallery` VALUES ('2013', '168', '');
INSERT INTO `myr_goods_gallery` VALUES ('2014', '169', '');
INSERT INTO `myr_goods_gallery` VALUES ('2015', '170', '');
INSERT INTO `myr_goods_gallery` VALUES ('2016', '171', '');
INSERT INTO `myr_goods_gallery` VALUES ('2017', '172', '');
INSERT INTO `myr_goods_gallery` VALUES ('2018', '173', '');
INSERT INTO `myr_goods_gallery` VALUES ('2019', '174', '');
INSERT INTO `myr_goods_gallery` VALUES ('2020', '175', '');
INSERT INTO `myr_goods_gallery` VALUES ('2021', '176', '');
INSERT INTO `myr_goods_gallery` VALUES ('2022', '177', '');
INSERT INTO `myr_goods_gallery` VALUES ('2023', '178', '');
INSERT INTO `myr_goods_gallery` VALUES ('2024', '179', '');
INSERT INTO `myr_goods_gallery` VALUES ('2025', '180', '');

-- ----------------------------
-- Table structure for myr_goods_inter_des
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_inter_des`;
CREATE TABLE `myr_goods_inter_des` (
  `des_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `des_lang_id` int(11) NOT NULL COMMENT '语种',
  `goods_id` mediumint(8) NOT NULL,
  `des_text` text NOT NULL,
  `add_user` tinyint(3) NOT NULL,
  `add_time` int(10) NOT NULL,
  `audit_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`des_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_inter_des
-- ----------------------------
INSERT INTO `myr_goods_inter_des` VALUES ('1', '2', '1', '<p>fdsafdsafdsafsfdsafdsafaa</p>', '1', '1350612695', '5');

-- ----------------------------
-- Table structure for myr_goods_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_log`;
CREATE TABLE `myr_goods_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) NOT NULL,
  `action` varchar(30) NOT NULL DEFAULT '8',
  `field` varchar(30) NOT NULL,
  `content` varchar(255) NOT NULL,
  `admin_id` smallint(5) NOT NULL,
  `addtime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `action` (`action`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_log
-- ----------------------------
INSERT INTO `myr_goods_log` VALUES ('1', '0', 'QSD092110001订单锁定库存', 'varstock', '广州流花保税仓值由更新为1', '1', '1442823275');
INSERT INTO `myr_goods_log` VALUES ('2', '0', 'QSD092110001订单锁定库存', 'varstock', '广州流花保税仓值由更新为1', '1', '1442823313');
INSERT INTO `myr_goods_log` VALUES ('3', '1', 'QSD092110002订单锁定库存', 'varstock', '深圳保宏保税仓值由0更新为1', '1', '1442823868');
INSERT INTO `myr_goods_log` VALUES ('4', '1', 'QSD092110002订单出库', 'varstock', '深圳保宏保税仓值由1更新为0', '1', '1442824498');
INSERT INTO `myr_goods_log` VALUES ('5', '1', 'QSD092110002订单出库', 'goods_qty', '深圳保宏保税仓值由50更新为49', '1', '1442824498');
INSERT INTO `myr_goods_log` VALUES ('6', '99', '产品入库', 'goods_qty', 'RKD15092133543入库,广州流花保税仓|成品区货架库存由0更新为7,原成本价由0.00更新为0', '1', '1442827512');
INSERT INTO `myr_goods_log` VALUES ('7', '99', 'QSD092110003订单锁定库存', 'varstock', '广州流花保税仓值由0更新为1', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('8', '99', 'QSD092110006订单锁定库存', 'varstock', '广州流花保税仓值由1更新为2', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('9', '99', 'QSD092110002订单锁定库存', 'varstock', '广州流花保税仓值由2更新为3', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('10', '99', 'QSD092110005订单锁定库存', 'varstock', '广州流花保税仓值由3更新为4', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('11', '99', 'QSD092110001订单锁定库存', 'varstock', '广州流花保税仓值由4更新为5', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('12', '99', 'QSD092110004订单锁定库存', 'varstock', '广州流花保税仓值由5更新为6', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('13', '99', 'QSD092110007订单锁定库存', 'varstock', '广州流花保税仓值由6更新为7', '1', '1442827520');
INSERT INTO `myr_goods_log` VALUES ('14', '100', '产品编辑', 'SKU', '值由01011更新为QMX00016', '3', '1442827706');
INSERT INTO `myr_goods_log` VALUES ('15', '100', '产品编辑', 'status', '值由0更新为3', '3', '1442827711');
INSERT INTO `myr_goods_log` VALUES ('16', '100', '产品编辑', 'goods_qty', '广州流花保税仓|成品区货架值由0更新为238', '3', '1442827770');
INSERT INTO `myr_goods_log` VALUES ('17', '100', '产品编辑', 'upc', '值由更新为4008976022350', '3', '1442827830');
INSERT INTO `myr_goods_log` VALUES ('18', '100', '产品编辑', 'warn_qty', '广州流花保税仓|成品区货架值由0更新为100', '3', '1442828021');
INSERT INTO `myr_goods_log` VALUES ('19', '100', '产品编辑', 'goods_qty', '互联易深圳仓|成品区货架值由0更新为3', '3', '1442828053');
INSERT INTO `myr_goods_log` VALUES ('20', '100', '产品编辑', 'warn_qty', '互联易深圳仓|成品区货架值由0更新为10', '3', '1442828117');
INSERT INTO `myr_goods_log` VALUES ('21', '100', '产品编辑', 'warn_qty', '互联易深圳仓|成品区货架值由10更新为1', '3', '1442828154');
INSERT INTO `myr_goods_log` VALUES ('22', '99', '产品入库', 'goods_qty', 'RKD15092187675入库,广州流花保税仓|成品区货架库存由7更新为10,原成本价由0.00更新为3', '1', '1442828172');
INSERT INTO `myr_goods_log` VALUES ('23', '100', '产品编辑', 'status', '值由3更新为3', '3', '1442828266');
INSERT INTO `myr_goods_log` VALUES ('24', '100', '产品编辑', 'goods_qty', '互联易深圳仓|成品区货架值由3更新为', '3', '1442828343');
INSERT INTO `myr_goods_log` VALUES ('25', '100', '产品编辑', 'warn_qty', '互联易深圳仓|成品区货架值由1更新为', '3', '1442828344');
INSERT INTO `myr_goods_log` VALUES ('26', '177', '产品入库', 'goods_qty', 'RKD15092289731入库,广州流花保税仓|成品区货架库存由0更新为80,原成本价由0.00更新为10', '1', '1442889670');
INSERT INTO `myr_goods_log` VALUES ('27', '178', '产品入库', 'goods_qty', 'RKD15092289731入库,广州流花保税仓|成品区货架库存由0更新为100,原成本价由0.00更新为20', '1', '1442889670');
INSERT INTO `myr_goods_log` VALUES ('28', '177', '产品入库', 'goods_qty', 'RKD15092293538入库,广州流花保税仓|成品区货架库存由80更新为100,原成本价由10.00更新为10', '1', '1442889767');
INSERT INTO `myr_goods_log` VALUES ('29', '178', '产品入库', 'goods_qty', 'RKD15092293538入库,广州流花保税仓|成品区货架库存由100更新为200,原成本价由20.00更新为20', '1', '1442889767');
INSERT INTO `myr_goods_log` VALUES ('30', '177', 'QSD092210001订单锁定库存', 'varstock', '广州流花保税仓值由0更新为10', '1', '1442891898');
INSERT INTO `myr_goods_log` VALUES ('31', '178', 'QSD092210001订单锁定库存', 'varstock', '广州流花保税仓值由0更新为5', '1', '1442891898');
INSERT INTO `myr_goods_log` VALUES ('32', '178', 'QSD092210002订单锁定库存', 'varstock', '广州流花保税仓值由5更新为10', '1', '1442891898');
INSERT INTO `myr_goods_log` VALUES ('33', '177', 'QSD092210003订单锁定库存', 'varstock', '广州流花保税仓值由10更新为20', '1', '1442891898');
INSERT INTO `myr_goods_log` VALUES ('34', '177', 'QSD092210003订单出库', 'varstock', '广州流花保税仓值由20更新为10', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('35', '177', 'QSD092210003订单出库', 'goods_qty', '广州流花保税仓值由100更新为90', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('36', '178', 'QSD092210002订单出库', 'varstock', '广州流花保税仓值由10更新为5', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('37', '178', 'QSD092210002订单出库', 'goods_qty', '广州流花保税仓值由200更新为195', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('38', '177', 'QSD092210001订单出库', 'varstock', '广州流花保税仓值由10更新为0', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('39', '177', 'QSD092210001订单出库', 'goods_qty', '广州流花保税仓值由90更新为80', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('40', '178', 'QSD092210001订单出库', 'varstock', '广州流花保税仓值由5更新为0', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('41', '178', 'QSD092210001订单出库', 'goods_qty', '广州流花保税仓值由195更新为190', '1', '1442892066');
INSERT INTO `myr_goods_log` VALUES ('42', '140', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为238,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('43', '141', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为185,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('44', '142', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为597,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('45', '143', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为474,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('46', '144', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为1,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('47', '145', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为25,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('48', '146', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为672,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('49', '147', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为56,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('50', '148', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为0,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('51', '149', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为350,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('52', '150', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为395,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('53', '151', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为105,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('54', '152', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为113,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('55', '153', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为103,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('56', '154', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为46,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('57', '155', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为291,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('58', '156', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为297,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('59', '157', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为240,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('60', '158', '产品入库', 'goods_qty', 'RKD15092195441入库,广州流花保税仓|成品区货架库存由0更新为240,原成本价由0.00更新为0', '4', '1443059992');
INSERT INTO `myr_goods_log` VALUES ('61', '180', '产品编辑', 'brand_id', '值由0更新为', '4', '1443085905');

-- ----------------------------
-- Table structure for myr_goods_new
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_new`;
CREATE TABLE `myr_goods_new` (
  `goods_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `des_status` tinyint(1) DEFAULT NULL,
  `goods_name` varchar(100) NOT NULL,
  `brand_id` smallint(5) NOT NULL,
  `cat_id` smallint(5) NOT NULL,
  `goods_img` varchar(255) DEFAULT '/data/upload/no_picture.gif',
  `goods_url` varchar(255) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT '0.00',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `goods_title` varchar(100) DEFAULT NULL,
  `goods_attribute` varchar(100) DEFAULT NULL,
  `resume` text,
  `depict` text,
  `comment` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `add_user` int(11) NOT NULL,
  `add_time` int(10) NOT NULL,
  `sizes` varchar(255) DEFAULT '',
  `colors` varchar(255) DEFAULT '',
  `sku` varchar(100) NOT NULL,
  `l` decimal(10,2) DEFAULT '0.00',
  `w` decimal(10,2) DEFAULT '0.00',
  `h` decimal(10,2) DEFAULT '0.00',
  `suttle` decimal(10,2) DEFAULT '0.00',
  `img_status` tinyint(1) DEFAULT NULL,
  `assign_status` tinyint(1) DEFAULT NULL COMMENT '0 未分配 1 已分配',
  PRIMARY KEY (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_new
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_on_sales
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_on_sales`;
CREATE TABLE `myr_goods_on_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(8) NOT NULL,
  `account_id` tinyint(4) NOT NULL,
  `account_name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of myr_goods_on_sales
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_sku`;
CREATE TABLE `myr_goods_sku` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(30) NOT NULL,
  `out_sku` varchar(60) NOT NULL,
  PRIMARY KEY (`rec_id`),
  UNIQUE KEY `out_sku` (`out_sku`),
  KEY `sku` (`sku`)
) ENGINE=MyISAM AUTO_INCREMENT=1434 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_sku
-- ----------------------------

-- ----------------------------
-- Table structure for myr_goods_sn
-- ----------------------------
DROP TABLE IF EXISTS `myr_goods_sn`;
CREATE TABLE `myr_goods_sn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `sn` varchar(30) NOT NULL,
  `order_sn` varchar(20) NOT NULL,
  `in_sn` varchar(20) NOT NULL,
  `out_sn` varchar(20) NOT NULL,
  `used` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `add_time` int(10) unsigned NOT NULL,
  `out_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_goods_sn
-- ----------------------------

-- ----------------------------
-- Table structure for myr_inventory
-- ----------------------------
DROP TABLE IF EXISTS `myr_inventory`;
CREATE TABLE `myr_inventory` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `admin_id` smallint(5) unsigned NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `end_time` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `is_in` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_out` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `depot_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_inventory
-- ----------------------------
INSERT INTO `myr_inventory` VALUES ('17', '15092152859', '4', '1442831786', '0', '0', '0', '0', '12');
INSERT INTO `myr_inventory` VALUES ('18', '15092232503', '1', '1442900086', '0', '0', '0', '0', '0');
INSERT INTO `myr_inventory` VALUES ('19', '15092360711', '5', '1442997458', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for myr_inventory_detail
-- ----------------------------
DROP TABLE IF EXISTS `myr_inventory_detail`;
CREATE TABLE `myr_inventory_detail` (
  `rec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `last_qty` smallint(5) NOT NULL DEFAULT '0' COMMENT '期初库存',
  `in_qty` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '入库库存',
  `out_qty` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '出库库存',
  `stock_qty` smallint(5) NOT NULL COMMENT '账面库存',
  `check_qty` smallint(5) unsigned NOT NULL COMMENT '盘点结果',
  `is_ok` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`,`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15343 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_inventory_detail
-- ----------------------------

-- ----------------------------
-- Table structure for myr_load_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_load_log`;
CREATE TABLE `myr_load_log` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `account_id` int(8) NOT NULL,
  `user_id` int(8) NOT NULL,
  `content` text NOT NULL,
  `load_time` int(10) NOT NULL,
  `load_id` int(8) NOT NULL,
  `error` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_load_log
-- ----------------------------

-- ----------------------------
-- Table structure for myr_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_log`;
CREATE TABLE `myr_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT '0',
  `log_time` int(11) DEFAULT '0',
  `module_name` varchar(30) DEFAULT NULL,
  `log_object` varchar(30) DEFAULT NULL,
  `log_ip` varchar(24) DEFAULT NULL,
  `content` varchar(255) DEFAULT '''\n',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1684 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_log
-- ----------------------------
INSERT INTO `myr_log` VALUES ('1123', '0', '1395132003', 'login', '1', '116.23.203.179', '登录系统');
INSERT INTO `myr_log` VALUES ('1124', '1', '1395132003', 'login', '', '116.23.203.179', '登录成功');
INSERT INTO `myr_log` VALUES ('1125', '0', '1395234509', 'login', '1', '116.76.106.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1126', '1', '1395234509', 'login', '', '116.76.106.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1127', '1', '1395239796', 'login', '1', '116.76.106.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1128', '1', '1395239796', 'login', '', '116.76.106.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1129', '1', '1395239842', 'ModelEbayaccount', '70', '116.76.106.134', '信息被删除');
INSERT INTO `myr_log` VALUES ('1130', '1', '1395240786', 'stockin', '90', '116.76.106.134', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1131', '0', '1395275594', 'login', '1', '58.251.230.36', '登录系统');
INSERT INTO `myr_log` VALUES ('1132', '1', '1395275594', 'login', '', '58.251.230.36', '登录成功');
INSERT INTO `myr_log` VALUES ('1133', '0', '1395284963', 'login', '1', '113.116.248.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1134', '1', '1395284963', 'login', '', '113.116.248.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1135', '1', '1395285016', 'ModelEbayaccount', '72', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1136', '1', '1395285029', 'ModelEbayaccount', '72', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1137', '1', '1395285209', 'ModelEbayaccount', '71', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1138', '1', '1395285314', 'login', '1', '113.116.248.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1139', '1', '1395285314', 'login', '', '113.116.248.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1140', '1', '1395285334', 'login', '1', '113.116.248.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1141', '1', '1395285334', 'login', '', '113.116.248.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1142', '1', '1395285558', 'ModelEbayaccount', '73', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1143', '1', '1395285785', 'ModelEbayaccount', '74', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1144', '1', '1395285791', 'ModelEbayaccount', '74', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1145', '1', '1395285878', 'ModelEbayaccount', '74', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1146', '1', '1395286418', 'ModelExpress', '6', '113.116.248.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1147', '1', '1395287062', 'stockin', '91', '113.116.248.9', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1148', '1', '1395287168', 'stockin', '92', '113.116.248.9', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1149', '1', '1395287568', 'stockin', '93', '113.116.248.9', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1150', '1', '1395307061', 'login', '1', '113.116.248.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1151', '1', '1395307061', 'login', '', '113.116.248.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1152', '1', '1395324308', 'login', '1', '113.116.248.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1153', '1', '1395324308', 'login', '', '113.116.248.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1154', '0', '1395369179', 'login', '1', '113.116.249.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1155', '1', '1395369179', 'login', '', '113.116.249.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1156', '0', '1400755951', 'login', '1', '163.125.253.120', '登录系统');
INSERT INTO `myr_log` VALUES ('1157', '1', '1400755951', 'login', '', '163.125.253.120', '登录成功');
INSERT INTO `myr_log` VALUES ('1158', '1', '1400764829', 'login', '1', '163.125.253.120', '登录系统');
INSERT INTO `myr_log` VALUES ('1159', '1', '1400764829', 'login', '', '163.125.253.120', '登录成功');
INSERT INTO `myr_log` VALUES ('1160', '0', '1400765320', 'login', '1', '183.49.18.130', '登录系统');
INSERT INTO `myr_log` VALUES ('1161', '1', '1400765320', 'login', '', '183.49.18.130', '登录成功');
INSERT INTO `myr_log` VALUES ('1162', '1', '1400820809', 'ModelEbayaccount', '76', '113.116.249.76', '信息被删除');
INSERT INTO `myr_log` VALUES ('1163', '1', '1400820812', 'ModelEbayaccount', '75', '113.116.249.76', '信息被删除');
INSERT INTO `myr_log` VALUES ('1164', '0', '1400851514', 'login', '1', '59.40.100.235', '登录系统');
INSERT INTO `myr_log` VALUES ('1165', '1', '1400851514', 'login', '', '59.40.100.235', '登录成功');
INSERT INTO `myr_log` VALUES ('1166', '1', '1400902809', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1167', '1', '1400902809', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1168', '1', '1400912635', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1169', '1', '1400912635', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1170', '0', '1400912848', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1171', '1', '1400912848', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1172', '1', '1400916381', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1173', '1', '1400916381', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1174', '1', '1400921949', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1175', '1', '1400921949', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1176', '1', '1400937355', 'login', '1', '59.40.20.191', '登录系统');
INSERT INTO `myr_log` VALUES ('1177', '1', '1400937355', 'login', '', '59.40.20.191', '登录成功');
INSERT INTO `myr_log` VALUES ('1178', '1', '1400939550', 'ModelDd', '72', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1179', '1', '1400939553', 'ModelDd', '62', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1180', '1', '1400939614', 'ModelDd', '13', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1181', '1', '1400939632', 'ModelDd', '80', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1182', '1', '1400939635', 'ModelDd', '79', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1183', '1', '1400939645', 'ModelDd', '82', '59.40.20.191', '信息被删除');
INSERT INTO `myr_log` VALUES ('1184', '0', '1401010333', 'login', '1', '101.36.76.135', '登录系统');
INSERT INTO `myr_log` VALUES ('1185', '1', '1401010333', 'login', '', '101.36.76.135', '登录成功');
INSERT INTO `myr_log` VALUES ('1186', '0', '1401011112', 'login', '1', '101.36.76.135', '登录系统');
INSERT INTO `myr_log` VALUES ('1187', '1', '1401011112', 'login', '', '101.36.76.135', '登录成功');
INSERT INTO `myr_log` VALUES ('1188', '1', '1401030228', 'login', '1', '101.36.76.135', '登录系统');
INSERT INTO `myr_log` VALUES ('1189', '1', '1401030228', 'login', '', '101.36.76.135', '登录成功');
INSERT INTO `myr_log` VALUES ('1190', '0', '1401070298', 'login', '1', '59.40.23.40', '登录系统');
INSERT INTO `myr_log` VALUES ('1191', '1', '1401070298', 'login', '', '59.40.23.40', '登录成功');
INSERT INTO `myr_log` VALUES ('1192', '0', '1401105032', 'login', '1', '14.28.194.115', '登录系统');
INSERT INTO `myr_log` VALUES ('1193', '1', '1401105032', 'login', '', '14.28.194.115', '登录成功');
INSERT INTO `myr_log` VALUES ('1194', '0', '1401251233', 'login', '1', '59.40.95.98', '登录系统');
INSERT INTO `myr_log` VALUES ('1195', '1', '1401251233', 'login', '', '59.40.95.98', '登录成功');
INSERT INTO `myr_log` VALUES ('1196', '1', '1401268381', 'login', '1', '59.40.95.98', '登录系统');
INSERT INTO `myr_log` VALUES ('1197', '1', '1401268381', 'login', '', '59.40.95.98', '登录成功');
INSERT INTO `myr_log` VALUES ('1198', '0', '1401359923', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1199', '1', '1401359923', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1200', '0', '1401360700', 'login', '1', '113.81.227.74', '登录系统');
INSERT INTO `myr_log` VALUES ('1201', '1', '1401360700', 'login', '', '113.81.227.74', '登录成功');
INSERT INTO `myr_log` VALUES ('1202', '1', '1401362387', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1203', '1', '1401362387', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1204', '0', '1401364301', 'login', '1', '64.120.219.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1205', '1', '1401364301', 'login', '', '64.120.219.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1206', '1', '1401367126', 'login', '1', '113.81.227.74', '登录系统');
INSERT INTO `myr_log` VALUES ('1207', '1', '1401367126', 'login', '', '113.81.227.74', '登录成功');
INSERT INTO `myr_log` VALUES ('1208', '0', '1401368445', 'login', '1', '64.120.219.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1209', '1', '1401368445', 'login', '', '64.120.219.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1210', '0', '1401368734', 'login', '1', '64.120.219.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1211', '1', '1401368734', 'login', '', '64.120.219.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1212', '0', '1401371971', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1213', '1', '1401371971', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1214', '0', '1401405321', 'login', '1', '123.151.164.199', '登录系统');
INSERT INTO `myr_log` VALUES ('1215', '1', '1401405321', 'login', '', '123.151.164.199', '登录成功');
INSERT INTO `myr_log` VALUES ('1216', '0', '1401405394', 'login', '1', '123.151.164.199', '登录系统');
INSERT INTO `myr_log` VALUES ('1217', '1', '1401405394', 'login', '', '123.151.164.199', '登录成功');
INSERT INTO `myr_log` VALUES ('1218', '1', '1401408529', 'login', '1', '123.151.164.199', '登录系统');
INSERT INTO `myr_log` VALUES ('1219', '1', '1401408529', 'login', '', '123.151.164.199', '登录成功');
INSERT INTO `myr_log` VALUES ('1220', '0', '1401414475', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1221', '1', '1401414475', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1222', '0', '1401414887', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1223', '1', '1401414887', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1224', '0', '1401416617', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1225', '1', '1401416617', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1226', '0', '1401417421', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1227', '1', '1401417421', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1228', '6', '1401421849', 'login', '1', '218.18.139.143', '登录系统');
INSERT INTO `myr_log` VALUES ('1229', '1', '1401421849', 'login', '', '218.18.139.143', '登录成功');
INSERT INTO `myr_log` VALUES ('1230', '0', '1401424475', 'login', '1', '218.18.139.143', '登录系统');
INSERT INTO `myr_log` VALUES ('1231', '1', '1401424475', 'login', '', '218.18.139.143', '登录成功');
INSERT INTO `myr_log` VALUES ('1232', '0', '1401429006', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1233', '1', '1401429006', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1234', '0', '1401431702', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1235', '1', '1401431702', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1236', '0', '1401447873', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1237', '1', '1401447873', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1238', '0', '1401503312', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1239', '1', '1401503312', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1240', '0', '1401503345', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1241', '1', '1401503345', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1242', '0', '1401507041', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1243', '1', '1401507041', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1244', '0', '1401507525', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1245', '1', '1401507525', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1246', '1', '1401518861', 'login', '1', '113.91.199.252', '登录系统');
INSERT INTO `myr_log` VALUES ('1247', '1', '1401518861', 'login', '', '113.91.199.252', '登录成功');
INSERT INTO `myr_log` VALUES ('1248', '1', '1401524394', 'login', '1', '61.145.150.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1249', '1', '1401524394', 'login', '', '61.145.150.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1250', '1', '1401529705', 'login', '1', '61.145.150.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1251', '1', '1401529705', 'login', '', '61.145.150.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1252', '0', '1401538579', 'login', '1', '61.145.150.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1253', '1', '1401538579', 'login', '', '61.145.150.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1254', '0', '1401685796', 'login', '1', '61.145.150.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1255', '1', '1401685796', 'login', '', '61.145.150.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1256', '0', '1401775481', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1257', '1', '1401775481', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1258', '0', '1401778281', 'login', '1', '64.120.219.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1259', '1', '1401778281', 'login', '', '64.120.219.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1260', '0', '1401778433', 'login', '1', '116.24.216.62', '登录系统');
INSERT INTO `myr_log` VALUES ('1261', '1', '1401778433', 'login', '', '116.24.216.62', '登录成功');
INSERT INTO `myr_log` VALUES ('1262', '0', '1401779864', 'login', '1', '116.24.216.62', '登录系统');
INSERT INTO `myr_log` VALUES ('1263', '1', '1401779864', 'login', '', '116.24.216.62', '登录成功');
INSERT INTO `myr_log` VALUES ('1264', '1', '1401780752', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1265', '1', '1401780752', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1266', '0', '1401781038', 'login', '1', '113.81.225.145', '登录系统');
INSERT INTO `myr_log` VALUES ('1267', '1', '1401781038', 'login', '', '113.81.225.145', '登录成功');
INSERT INTO `myr_log` VALUES ('1268', '1', '1401783108', 'goods', '1', '116.24.216.62', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1269', '1', '1401785394', 'ModelEbayaccount', '1', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1270', '0', '1401787209', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1271', '1', '1401787209', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1272', '0', '1401787338', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1273', '1', '1401787338', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1274', '0', '1401787616', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1275', '1', '1401787616', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1276', '1', '1401788089', 'ModelDd', '97', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1277', '1', '1401788092', 'ModelDd', '95', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1278', '1', '1401788094', 'ModelDd', '96', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1279', '1', '1401788095', 'ModelDd', '94', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1280', '1', '1401788097', 'ModelDd', '93', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1281', '1', '1401788099', 'ModelDd', '92', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1282', '1', '1401788101', 'ModelDd', '91', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1283', '1', '1401788104', 'ModelDd', '89', '116.24.216.62', '信息被删除');
INSERT INTO `myr_log` VALUES ('1284', '1', '1401793961', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1285', '1', '1401793961', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1286', '0', '1401798642', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1287', '1', '1401798642', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1288', '0', '1401798928', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1289', '1', '1401798928', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1290', '0', '1401809137', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1291', '1', '1401809137', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1292', '0', '1401850911', 'login', '1', '113.81.226.145', '登录系统');
INSERT INTO `myr_log` VALUES ('1293', '1', '1401850911', 'login', '', '113.81.226.145', '登录成功');
INSERT INTO `myr_log` VALUES ('1294', '0', '1401853138', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1295', '1', '1401853138', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1296', '1', '1401853274', 'goods', '1', '183.14.115.233', '批量更新产品信息');
INSERT INTO `myr_log` VALUES ('1297', '1', '1401858774', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1298', '1', '1401858774', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1299', '1', '1401862876', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1300', '1', '1401862876', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1301', '1', '1401864239', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1302', '1', '1401864239', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1303', '0', '1401865716', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1304', '1', '1401865716', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1305', '0', '1401865819', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1306', '1', '1401865819', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1307', '1', '1401866166', 'login', '1', '183.14.115.233', '登录系统');
INSERT INTO `myr_log` VALUES ('1308', '1', '1401866166', 'login', '', '183.14.115.233', '登录成功');
INSERT INTO `myr_log` VALUES ('1309', '1', '1401869071', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1310', '1', '1401869071', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1311', '0', '1401870112', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1312', '1', '1401870112', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1313', '1', '1401870518', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1314', '1', '1401870518', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1315', '0', '1401879220', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1316', '1', '1401879220', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1317', '0', '1401880753', 'login', '1', '116.24.216.62', '登录系统');
INSERT INTO `myr_log` VALUES ('1318', '1', '1401880753', 'login', '', '116.24.216.62', '登录成功');
INSERT INTO `myr_log` VALUES ('1319', '1', '1401881652', 'login', '1', '116.24.216.62', '登录系统');
INSERT INTO `myr_log` VALUES ('1320', '1', '1401881652', 'login', '', '116.24.216.62', '登录成功');
INSERT INTO `myr_log` VALUES ('1321', '0', '1401881793', 'login', '1', '116.24.216.62', '登录系统');
INSERT INTO `myr_log` VALUES ('1322', '1', '1401881793', 'login', '', '116.24.216.62', '登录成功');
INSERT INTO `myr_log` VALUES ('1323', '0', '1401929758', 'login', '1', '123.151.164.193', '登录系统');
INSERT INTO `myr_log` VALUES ('1324', '1', '1401929758', 'login', '', '123.151.164.193', '登录成功');
INSERT INTO `myr_log` VALUES ('1325', '0', '1401932316', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1326', '1', '1401932316', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1327', '0', '1401934534', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1328', '1', '1401934534', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1329', '1', '1401946972', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1330', '1', '1401946972', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1331', '0', '1401953705', 'login', '1', '116.24.249.28', '登录系统');
INSERT INTO `myr_log` VALUES ('1332', '1', '1401953705', 'login', '', '116.24.249.28', '登录成功');
INSERT INTO `myr_log` VALUES ('1333', '1', '1401956509', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1334', '1', '1401956509', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1335', '0', '1401960142', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1336', '1', '1401960142', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1337', '1', '1401961612', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1338', '1', '1401961612', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1339', '1', '1401965367', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1340', '1', '1401965367', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1341', '1', '1401981985', 'login', '1', '14.153.115.242', '登录系统');
INSERT INTO `myr_log` VALUES ('1342', '1', '1401981985', 'login', '', '14.153.115.242', '登录成功');
INSERT INTO `myr_log` VALUES ('1343', '0', '1401983369', 'login', '1', '14.153.113.154', '登录系统');
INSERT INTO `myr_log` VALUES ('1344', '1', '1401983369', 'login', '', '14.153.113.154', '登录成功');
INSERT INTO `myr_log` VALUES ('1345', '1', '1401983686', 'login', '6', '14.153.113.154', '登录系统');
INSERT INTO `myr_log` VALUES ('1346', '6', '1401983686', 'login', '', '14.153.113.154', '登录成功');
INSERT INTO `myr_log` VALUES ('1347', '0', '1402018005', 'login', '1', '183.14.121.77', '登录系统');
INSERT INTO `myr_log` VALUES ('1348', '1', '1402018005', 'login', '', '183.14.121.77', '登录成功');
INSERT INTO `myr_log` VALUES ('1349', '0', '1402019997', 'login', '1', '14.127.67.45', '登录系统');
INSERT INTO `myr_log` VALUES ('1350', '1', '1402019997', 'login', '', '14.127.67.45', '登录成功');
INSERT INTO `myr_log` VALUES ('1351', '0', '1402023357', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1352', '1', '1402023357', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1353', '0', '1402024709', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1354', '1', '1402024709', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1355', '1', '1402025697', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1356', '1', '1402025697', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1357', '0', '1402027151', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1358', '1', '1402027151', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1359', '1', '1402033457', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1360', '1', '1402033457', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1361', '0', '1402033840', 'login', '1', '59.40.94.11', '登录系统');
INSERT INTO `myr_log` VALUES ('1362', '1', '1402033840', 'login', '', '59.40.94.11', '登录成功');
INSERT INTO `myr_log` VALUES ('1363', '1', '1402043163', 'login', '1', '14.127.67.45', '登录系统');
INSERT INTO `myr_log` VALUES ('1364', '1', '1402043163', 'login', '', '14.127.67.45', '登录成功');
INSERT INTO `myr_log` VALUES ('1365', '1', '1402043717', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1366', '1', '1402043717', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1367', '0', '1402044355', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1368', '1', '1402044355', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1369', '0', '1402049989', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1370', '1', '1402049989', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1371', '1', '1402050407', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1372', '1', '1402050407', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1373', '0', '1402063195', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1374', '1', '1402063195', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1375', '1', '1402064474', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1376', '1', '1402064474', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1377', '0', '1402105712', 'login', '1', '183.54.11.178', '登录系统');
INSERT INTO `myr_log` VALUES ('1378', '1', '1402105712', 'login', '', '183.54.11.178', '登录成功');
INSERT INTO `myr_log` VALUES ('1379', '0', '1402106275', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1380', '1', '1402106275', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1381', '0', '1402110320', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1382', '1', '1402110320', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1383', '1', '1402110933', 'login', '1', '183.54.11.178', '登录系统');
INSERT INTO `myr_log` VALUES ('1384', '1', '1402110933', 'login', '', '183.54.11.178', '登录成功');
INSERT INTO `myr_log` VALUES ('1385', '0', '1402114562', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1386', '1', '1402114562', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1387', '1', '1402121270', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1388', '1', '1402121270', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1389', '1', '1402136107', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1390', '1', '1402136107', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1391', '1', '1402138475', 'goods', '1', '61.141.97.149', '批量更新产品信息');
INSERT INTO `myr_log` VALUES ('1392', '1', '1402144657', 'login', '1', '61.141.97.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1393', '1', '1402144657', 'login', '', '61.141.97.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1394', '1', '1402145792', 'goods', '1', '14.20.100.7', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1395', '1', '1402145803', 'goods', '1', '14.20.100.7', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1396', '1', '1402145822', 'goods', '1', '14.20.100.7', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1397', '1', '1402145852', 'goods', '1', '14.20.100.7', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1398', '1', '1402146417', 'goods', '1', '61.141.97.149', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1399', '0', '1402194278', 'login', '1', '14.153.118.96', '登录系统');
INSERT INTO `myr_log` VALUES ('1400', '1', '1402194278', 'login', '', '14.153.118.96', '登录成功');
INSERT INTO `myr_log` VALUES ('1401', '0', '1402197669', 'login', '1', '119.122.187.86', '登录系统');
INSERT INTO `myr_log` VALUES ('1402', '1', '1402197669', 'login', '', '119.122.187.86', '登录成功');
INSERT INTO `myr_log` VALUES ('1403', '1', '1402213341', 'login', '1', '14.153.114.0', '登录系统');
INSERT INTO `myr_log` VALUES ('1404', '1', '1402213341', 'login', '', '14.153.114.0', '登录成功');
INSERT INTO `myr_log` VALUES ('1405', '0', '1402279315', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1406', '1', '1402279315', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1407', '0', '1402280284', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1408', '1', '1402280284', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1409', '0', '1402282478', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1410', '1', '1402282478', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1411', '1', '1402287030', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1412', '1', '1402287030', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1413', '1', '1402292594', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1414', '1', '1402292594', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1415', '0', '1402295585', 'login', '1', '14.127.65.109', '登录系统');
INSERT INTO `myr_log` VALUES ('1416', '1', '1402295585', 'login', '', '14.127.65.109', '登录成功');
INSERT INTO `myr_log` VALUES ('1417', '0', '1402301437', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1418', '1', '1402301437', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1419', '0', '1402301697', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1420', '1', '1402301697', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1421', '1', '1402301866', 'login', '1', '113.92.237.39', '登录系统');
INSERT INTO `myr_log` VALUES ('1422', '1', '1402301866', 'login', '', '113.92.237.39', '登录成功');
INSERT INTO `myr_log` VALUES ('1423', '0', '1402396846', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1424', '1', '1402396846', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1425', '0', '1402407332', 'login', '1', '14.217.113.219', '登录系统');
INSERT INTO `myr_log` VALUES ('1426', '1', '1402407332', 'login', '', '14.217.113.219', '登录成功');
INSERT INTO `myr_log` VALUES ('1427', '0', '1402451339', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1428', '1', '1402451339', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1429', '0', '1402451893', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1430', '1', '1402451893', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1431', '1', '1402456665', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1432', '1', '1402456665', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1433', '1', '1402464783', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1434', '1', '1402464783', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1435', '0', '1402466219', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1436', '1', '1402466219', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1437', '0', '1402483692', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1438', '1', '1402483692', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1439', '1', '1402486915', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1440', '1', '1402486915', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1441', '0', '1402487106', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1442', '1', '1402487106', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1443', '1', '1402488467', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1444', '1', '1402488467', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1445', '1', '1402489773', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1446', '1', '1402489773', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1447', '0', '1402540166', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1448', '1', '1402540166', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1449', '1', '1402540900', 'ModelEbayaccount', '79', '113.87.55.52', '信息被删除');
INSERT INTO `myr_log` VALUES ('1450', '0', '1402544216', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1451', '1', '1402544216', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1452', '1', '1402547444', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1453', '1', '1402547444', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1454', '0', '1402551218', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1455', '1', '1402551218', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1456', '1', '1402551334', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1457', '1', '1402551334', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1458', '0', '1402552151', 'login', '1', '113.87.55.52', '登录系统');
INSERT INTO `myr_log` VALUES ('1459', '1', '1402552151', 'login', '', '113.87.55.52', '登录成功');
INSERT INTO `myr_log` VALUES ('1460', '0', '1402558252', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1461', '1', '1402558252', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1462', '0', '1402562049', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1463', '1', '1402562049', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1464', '0', '1402626218', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1465', '1', '1402626218', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1466', '0', '1402642634', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1467', '1', '1402642634', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1468', '0', '1402646702', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1469', '1', '1402646702', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1470', '0', '1402650020', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1471', '1', '1402650020', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1472', '0', '1402714795', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1473', '1', '1402714795', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1474', '0', '1402715996', 'login', '1', '183.54.9.90', '登录系统');
INSERT INTO `myr_log` VALUES ('1475', '1', '1402715996', 'login', '', '183.54.9.90', '登录成功');
INSERT INTO `myr_log` VALUES ('1476', '0', '1402720536', 'login', '1', '59.40.22.68', '登录系统');
INSERT INTO `myr_log` VALUES ('1477', '1', '1402720536', 'login', '', '59.40.22.68', '登录成功');
INSERT INTO `myr_log` VALUES ('1478', '0', '1402734320', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1479', '1', '1402734320', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1480', '0', '1402756947', 'login', '1', '59.36.148.219', '登录系统');
INSERT INTO `myr_log` VALUES ('1481', '1', '1402756947', 'login', '', '59.36.148.219', '登录成功');
INSERT INTO `myr_log` VALUES ('1482', '0', '1402884187', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1483', '1', '1402884187', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1484', '0', '1402886140', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1485', '1', '1402886140', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1486', '1', '1402897644', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1487', '1', '1402897644', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1488', '1', '1402898196', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1489', '1', '1402898196', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1490', '1', '1402900988', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1491', '1', '1402900988', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1492', '0', '1402902832', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1493', '1', '1402902832', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1494', '1', '1402913557', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1495', '1', '1402913557', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1496', '1', '1402914925', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1497', '1', '1402914925', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1498', '1', '1402917140', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1499', '1', '1402917140', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1500', '0', '1402973882', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1501', '1', '1402973882', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1502', '0', '1402978077', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1503', '1', '1402978077', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1504', '0', '1402985910', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1505', '1', '1402985910', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1506', '0', '1402999117', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1507', '1', '1402999117', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1508', '0', '1403059835', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1509', '1', '1403059835', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1510', '0', '1403061721', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1511', '1', '1403061721', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1512', '0', '1403071786', 'login', '1', '183.11.53.97', '登录系统');
INSERT INTO `myr_log` VALUES ('1513', '1', '1403071786', 'login', '', '183.11.53.97', '登录成功');
INSERT INTO `myr_log` VALUES ('1514', '0', '1403078734', 'login', '1', '61.145.166.231', '登录系统');
INSERT INTO `myr_log` VALUES ('1515', '1', '1403078734', 'login', '', '61.145.166.231', '登录成功');
INSERT INTO `myr_log` VALUES ('1516', '1', '1442380935', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1517', '1', '1442380935', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1518', '1', '1442381089', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1519', '1', '1442381089', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1520', '0', '1442381157', 'login', '1', '119.123.115.117', '登录系统');
INSERT INTO `myr_log` VALUES ('1521', '1', '1442381157', 'login', '', '119.123.115.117', '登录成功');
INSERT INTO `myr_log` VALUES ('1522', '0', '1442381855', 'login', '1', '113.102.160.149', '登录系统');
INSERT INTO `myr_log` VALUES ('1523', '1', '1442381855', 'login', '', '113.102.160.149', '登录成功');
INSERT INTO `myr_log` VALUES ('1524', '0', '1442382028', 'login', '1', '119.123.115.117', '登录系统');
INSERT INTO `myr_log` VALUES ('1525', '1', '1442382028', 'login', '', '119.123.115.117', '登录成功');
INSERT INTO `myr_log` VALUES ('1526', '1', '1442382614', 'login', '1', '121.35.210.121', '登录系统');
INSERT INTO `myr_log` VALUES ('1527', '1', '1442382614', 'login', '', '121.35.210.121', '登录成功');
INSERT INTO `myr_log` VALUES ('1528', '0', '1442382955', 'login', '1', '121.35.210.121', '登录系统');
INSERT INTO `myr_log` VALUES ('1529', '1', '1442382955', 'login', '', '121.35.210.121', '登录成功');
INSERT INTO `myr_log` VALUES ('1530', '0', '1442383273', 'login', '1', '121.35.210.121', '登录系统');
INSERT INTO `myr_log` VALUES ('1531', '1', '1442383273', 'login', '', '121.35.210.121', '登录成功');
INSERT INTO `myr_log` VALUES ('1532', '0', '1442398475', 'login', '1', '183.14.226.192', '登录系统');
INSERT INTO `myr_log` VALUES ('1533', '1', '1442398475', 'login', '', '183.14.226.192', '登录成功');
INSERT INTO `myr_log` VALUES ('1534', '0', '1442467898', 'login', '1', '113.116.61.25', '登录系统');
INSERT INTO `myr_log` VALUES ('1535', '1', '1442467898', 'login', '', '113.116.61.25', '登录成功');
INSERT INTO `myr_log` VALUES ('1536', '0', '1442476325', 'login', '1', '113.116.61.25', '登录系统');
INSERT INTO `myr_log` VALUES ('1537', '1', '1442476325', 'login', '', '113.116.61.25', '登录成功');
INSERT INTO `myr_log` VALUES ('1538', '1', '1442481936', 'login', '2', '113.116.61.25', '登录系统');
INSERT INTO `myr_log` VALUES ('1539', '2', '1442481936', 'login', '', '113.116.61.25', '登录成功');
INSERT INTO `myr_log` VALUES ('1540', '2', '1442482001', 'login', '1', '183.14.226.156', '登录系统');
INSERT INTO `myr_log` VALUES ('1541', '1', '1442482001', 'login', '', '183.14.226.156', '登录成功');
INSERT INTO `myr_log` VALUES ('1542', '1', '1442483539', 'login', '10', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1543', '10', '1442483539', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1544', '10', '1442483567', 'login', '2', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1545', '2', '1442483567', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1546', '2', '1442483592', 'login', '1', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1547', '1', '1442483592', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1548', '0', '1442509785', 'login', '1', '58.251.194.65', '登录系统');
INSERT INTO `myr_log` VALUES ('1549', '1', '1442509785', 'login', '', '58.251.194.65', '登录成功');
INSERT INTO `myr_log` VALUES ('1550', '0', '1442540974', 'login', '1', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1551', '1', '1442540974', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1552', '0', '1442541748', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1553', '1', '1442541748', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1554', '1', '1442541860', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1555', '1', '1442541860', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1556', '0', '1442544820', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1557', '1', '1442544820', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1558', '1', '1442545077', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1559', '1', '1442545077', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1560', '0', '1442545111', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1561', '1', '1442545111', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1562', '0', '1442545152', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1563', '1', '1442545152', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1564', '1', '1442545278', 'login', '1', '183.14.226.156', '登录系统');
INSERT INTO `myr_log` VALUES ('1565', '1', '1442545278', 'login', '', '183.14.226.156', '登录成功');
INSERT INTO `myr_log` VALUES ('1566', '1', '1442545690', 'login', '2', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1567', '2', '1442545690', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1568', '2', '1442545712', 'login', '1', '113.116.61.25', '登录系统');
INSERT INTO `myr_log` VALUES ('1569', '1', '1442545712', 'login', '', '113.116.61.25', '登录成功');
INSERT INTO `myr_log` VALUES ('1570', '0', '1442547283', 'login', '1', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1571', '1', '1442547283', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1572', '0', '1442547730', 'login', '4', '183.14.226.132', '登录系统');
INSERT INTO `myr_log` VALUES ('1573', '4', '1442547730', 'login', '', '183.14.226.132', '登录成功');
INSERT INTO `myr_log` VALUES ('1574', '0', '1442653567', 'login', '1', '183.12.66.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1575', '1', '1442653567', 'login', '', '183.12.66.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1576', '0', '1442797833', 'login', '1', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1577', '1', '1442797834', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1578', '0', '1442798620', 'login', '1', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1579', '1', '1442798620', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1580', '0', '1442802839', 'login', '1', '118.195.134.89', '登录系统');
INSERT INTO `myr_log` VALUES ('1581', '1', '1442802839', 'login', '', '118.195.134.89', '登录成功');
INSERT INTO `myr_log` VALUES ('1582', '0', '1442806201', 'login', '4', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1583', '4', '1442806201', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1584', '0', '1442814904', 'login', '3', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1585', '3', '1442814904', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1586', '0', '1442815573', 'login', '13', '183.54.80.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1587', '13', '1442815573', 'login', '', '183.54.80.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1588', '0', '1442819111', 'login', '1', '183.14.227.8', '登录系统');
INSERT INTO `myr_log` VALUES ('1589', '1', '1442819111', 'login', '', '183.14.227.8', '登录成功');
INSERT INTO `myr_log` VALUES ('1590', '1', '1442820290', 'login', '1', '183.14.227.8', '登录系统');
INSERT INTO `myr_log` VALUES ('1591', '1', '1442820290', 'login', '', '183.14.227.8', '登录成功');
INSERT INTO `myr_log` VALUES ('1592', '1', '1442820716', 'ModelDd', '217', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1593', '4', '1442821169', 'login', '4', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1594', '4', '1442821169', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1595', '0', '1442821219', 'login', '4', '183.54.80.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1596', '4', '1442821219', 'login', '', '183.54.80.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1597', '1', '1442821401', 'goods', '1', '183.14.227.8', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1598', '1', '1442821458', 'goods', '1', '183.12.64.104', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1599', '1', '1442821497', 'goods', '1', '183.54.80.9', '批量更新产品库存');
INSERT INTO `myr_log` VALUES ('1600', '1', '1442822290', 'ModelDd', '11', '183.14.227.8', '信息被删除');
INSERT INTO `myr_log` VALUES ('1601', '1', '1442822293', 'ModelDd', '14', '183.54.80.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1602', '1', '1442822296', 'ModelDd', '45', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1603', '1', '1442822298', 'ModelDd', '215', '183.12.64.104', '信息被删除');
INSERT INTO `myr_log` VALUES ('1604', '1', '1442822303', 'ModelDd', '173', '183.12.64.104', '信息被删除');
INSERT INTO `myr_log` VALUES ('1605', '1', '1442822305', 'ModelDd', '214', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1606', '1', '1442822306', 'ModelDd', '221', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1607', '1', '1442822309', 'ModelDd', '222', '183.12.64.104', '信息被删除');
INSERT INTO `myr_log` VALUES ('1608', '1', '1442822312', 'ModelDd', '226', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1609', '1', '1442822313', 'ModelDd', '225', '183.54.80.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1610', '4', '1442824627', 'supplier', '3', '183.54.80.9', '供应商信息编辑');
INSERT INTO `myr_log` VALUES ('1611', '4', '1442824631', 'supplier', '3', '121.34.144.215', '供应商信息被删除');
INSERT INTO `myr_log` VALUES ('1612', '4', '1442824631', 'ModelSupplier', '3', '121.34.144.215', '信息被删除');
INSERT INTO `myr_log` VALUES ('1613', '1', '1442826059', 'login', '1', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1614', '1', '1442826059', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1615', '0', '1442826119', 'login', '3', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1616', '3', '1442826119', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1617', '1', '1442826257', 'ModelRma', '23', '183.54.80.9', '信息被删除');
INSERT INTO `myr_log` VALUES ('1618', '1', '1442827512', 'stockin', '96', '183.12.64.104', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1619', '1', '1442828172', 'stockin', '97', '183.54.80.9', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1620', '0', '1442828862', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1621', '0', '1442828871', 'login', '3', '183.14.227.8', '登录系统');
INSERT INTO `myr_log` VALUES ('1622', '3', '1442828871', 'login', '', '183.14.227.8', '登录成功');
INSERT INTO `myr_log` VALUES ('1623', '1', '1442829130', 'login', '1', '183.54.80.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1624', '1', '1442829130', 'login', '', '183.54.80.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1625', '0', '1442836650', 'login', '3', '183.54.80.9', '登录系统');
INSERT INTO `myr_log` VALUES ('1626', '3', '1442836650', 'login', '', '183.54.80.9', '登录成功');
INSERT INTO `myr_log` VALUES ('1627', '0', '1442848652', 'login', '1', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1628', '1', '1442848652', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1629', '1', '1442889670', 'stockin', '100', '183.14.227.8', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1630', '1', '1442889767', 'stockin', '101', '183.54.80.9', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1631', '0', '1442901376', 'login', '13', '121.34.144.215', '登录系统');
INSERT INTO `myr_log` VALUES ('1632', '13', '1442901376', 'login', '', '121.34.144.215', '登录成功');
INSERT INTO `myr_log` VALUES ('1633', '0', '1442913212', 'login', '13', '119.123.113.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1634', '13', '1442913212', 'login', '', '119.123.113.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1635', '0', '1442970063', 'login', '4', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1636', '4', '1442970063', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1637', '0', '1442974017', 'login', '1', '119.123.113.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1638', '1', '1442974017', 'login', '', '119.123.113.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1639', '0', '1442975924', 'login', '4', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1640', '4', '1442975924', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1641', '0', '1442977072', 'login', '5', '183.54.80.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1642', '5', '1442977072', 'login', '', '183.54.80.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1643', '0', '1442987397', 'login', '5', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1644', '5', '1442987397', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1645', '0', '1442987409', 'login', '4', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1646', '4', '1442987409', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1647', '0', '1442993871', 'login', '1', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1648', '1', '1442993871', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1649', '0', '1443002869', 'login', '4', '183.54.80.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1650', '4', '1443002869', 'login', '', '183.54.80.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1651', '1', '1443002911', 'login', '2', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1652', '2', '1443002911', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1653', '2', '1443002940', 'login', '4', '183.54.80.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1654', '4', '1443002940', 'login', '', '183.54.80.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1655', '0', '1443059956', 'login', '4', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1656', '4', '1443059956', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1657', '4', '1443059992', 'stockin', '99', '183.54.80.134', '入库单状态被更改');
INSERT INTO `myr_log` VALUES ('1658', '0', '1443065142', 'login', '5', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1659', '5', '1443065142', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1660', '4', '1443067680', 'login', '1', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1661', '1', '1443067680', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1662', '0', '1443075190', 'login', '13', '183.12.64.104', '登录系统');
INSERT INTO `myr_log` VALUES ('1663', '13', '1443075190', 'login', '', '183.12.64.104', '登录成功');
INSERT INTO `myr_log` VALUES ('1664', '5', '1443076559', 'login', '5', '119.123.113.177', '登录系统');
INSERT INTO `myr_log` VALUES ('1665', '5', '1443076559', 'login', '', '119.123.113.177', '登录成功');
INSERT INTO `myr_log` VALUES ('1666', '1', '1443077556', 'login', '1', '183.54.80.134', '登录系统');
INSERT INTO `myr_log` VALUES ('1667', '1', '1443077556', 'login', '', '183.54.80.134', '登录成功');
INSERT INTO `myr_log` VALUES ('1668', '0', '1443084449', 'login', '4', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1669', '4', '1443084449', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1670', '0', '1443085369', 'login', '4', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1671', '4', '1443085369', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1672', '1', '1443092889', 'login', '1', '59.40.96.31', '登录系统');
INSERT INTO `myr_log` VALUES ('1673', '1', '1443092889', 'login', '', '59.40.96.31', '登录成功');
INSERT INTO `myr_log` VALUES ('1674', '0', '1443143976', 'login', '4', '113.102.160.249', '登录系统');
INSERT INTO `myr_log` VALUES ('1675', '4', '1443143976', 'login', '', '113.102.160.249', '登录成功');
INSERT INTO `myr_log` VALUES ('1676', '0', '1443144095', 'login', '1', '119.123.114.225', '登录系统');
INSERT INTO `myr_log` VALUES ('1677', '1', '1443144095', 'login', '', '119.123.114.225', '登录成功');
INSERT INTO `myr_log` VALUES ('1678', '4', '1443150190', 'login', '4', '183.12.65.50', '登录系统');
INSERT INTO `myr_log` VALUES ('1679', '4', '1443150190', 'login', '', '183.12.65.50', '登录成功');
INSERT INTO `myr_log` VALUES ('1680', '1', '1443161712', 'login', '1', '119.123.114.225', '登录系统');
INSERT INTO `myr_log` VALUES ('1681', '1', '1443161712', 'login', '', '119.123.114.225', '登录成功');
INSERT INTO `myr_log` VALUES ('1682', '0', '1467797589', 'login', '1', '::1', '登录系统');
INSERT INTO `myr_log` VALUES ('1683', '1', '1467797589', 'login', '1', '::1', '登录成功');

-- ----------------------------
-- Table structure for myr_menu
-- ----------------------------
DROP TABLE IF EXISTS `myr_menu`;
CREATE TABLE `myr_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(20) NOT NULL,
  `sortnum` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `model` varchar(20) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `code` varchar(25) NOT NULL,
  `root` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=400234 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_menu
-- ----------------------------
INSERT INTO `myr_menu` VALUES ('400078', '系统设置', '9', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400079', '产品管理', '2', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400080', '采购管理', '4', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400081', '仓储管理', '3', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400082', '销售管理', '1', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400083', '客户', '11', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400084', '财务账款', '5', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400085', '统计报表', '7', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400086', '分析', '9', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400087', '模板设置', '8', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400089', '系统用户管理', '2', 'user', '', 'edit_user', '400078');
INSERT INTO `myr_menu` VALUES ('400091', '系统初始化', '4', 'system', 'init', 'sys_init', '400078');
INSERT INTO `myr_menu` VALUES ('400092', '系统操作日志', '11', 'log', '', 'list_log', '400078');
INSERT INTO `myr_menu` VALUES ('400093', '系统环境设置', '5', 'dd', '', 'list_dd', '400078');
INSERT INTO `myr_menu` VALUES ('400094', 'ERP系统设置', '1', 'system', '', 'view_system', '400078');
INSERT INTO `myr_menu` VALUES ('400095', '订单快递规则', '7', 'express', '', 'list_express', '400078');
INSERT INTO `myr_menu` VALUES ('400096', '平台账号管理', '8', 'ebayaccount', '', 'list_account', '400078');
INSERT INTO `myr_menu` VALUES ('400097', '同步订单', '2', 'order', '', 'load_order', '400082');
INSERT INTO `myr_menu` VALUES ('400098', '订单流程设置', '9', 'order', 'status', 'list_orderstatus', '400078');
INSERT INTO `myr_menu` VALUES ('400099', '订单Paypal核对', '3', 'order', 'checkpaypal', 'check_paypal', '400082');
INSERT INTO `myr_menu` VALUES ('400100', '客服审核', '4', 'order', 'servicecheck', 'service_check', '400082');
INSERT INTO `myr_menu` VALUES ('400101', '添加订单', '1', 'order', 'add', 'add_order', '400082');
INSERT INTO `myr_menu` VALUES ('400102', '库管审核', '5', 'order', 'depotmanager', 'depot_check', '400082');
INSERT INTO `myr_menu` VALUES ('400103', '普通订单', '6', 'order', 'orderhandle', 'order_handle', '400082');
INSERT INTO `myr_menu` VALUES ('400104', '产品类别', '1', 'goods', 'category', 'list_category', '400079');
INSERT INTO `myr_menu` VALUES ('400105', '新增产品', '6', 'goods', 'add', 'add_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400106', '产品管理', '2', 'goods', '', 'list_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400107', '供应商管理', '1', 'supplier', '', 'list_supplier', '400080');
INSERT INTO `myr_menu` VALUES ('400108', '采购询价', '2', 'Purchasequote', '', 'list_p_quote', '400080');
INSERT INTO `myr_menu` VALUES ('400109', '采购计划', '3', 'purchaseorder', 'plan', 'list_p_plan', '400080');
INSERT INTO `myr_menu` VALUES ('400110', '采购订单', '4', 'purchaseorder', '', 'list_p_order', '400080');
INSERT INTO `myr_menu` VALUES ('400111', '采购建议', '5', 'purchaseofs', '', 'list_p_advice', '400080');
INSERT INTO `myr_menu` VALUES ('400112', '采购退货', '6', 'purchasereturn', '', 'list_p_return', '400080');
INSERT INTO `myr_menu` VALUES ('400113', '入库单', '1', 'stockin', '', 'list_stockin', '400081');
INSERT INTO `myr_menu` VALUES ('400114', '出库单', '1', 'stockout', '', 'list_stockout', '400081');
INSERT INTO `myr_menu` VALUES ('400115', '当前库存', '3', 'Inventory', 'stock', 'list_stock', '400081');
INSERT INTO `myr_menu` VALUES ('400116', '库存盘点', '4', 'inventory', 'check', 'stock_check', '400081');
INSERT INTO `myr_menu` VALUES ('400118', '生成出库单', '22', 'order', 'outdepot', 'order_stockout', '400082');
INSERT INTO `myr_menu` VALUES ('400119', '退款订单', '15', 'order', 'refund', 'order_refund', '400082');
INSERT INTO `myr_menu` VALUES ('400120', '到付订单', '17', 'order', 'cod', 'order_cod', '400082');
INSERT INTO `myr_menu` VALUES ('400121', '所有订单', '16', 'order', 'allorder', 'order_all', '400082');
INSERT INTO `myr_menu` VALUES ('400122', '标记发货', '17', 'order', 'markorder', 'order_mark', '400082');
INSERT INTO `myr_menu` VALUES ('400123', '售后服务', '6', '', '', '', 'root');
INSERT INTO `myr_menu` VALUES ('400125', 'Feedback加载', '3', 'Ecase', 'load', 'load_case', '400123');
INSERT INTO `myr_menu` VALUES ('400128', '导入产品', '8', 'goods', 'import', 'import_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400129', '汇率管理', '10', 'currency', '', 'list_currency', '400078');
INSERT INTO `myr_menu` VALUES ('400130', 'Message加载', '5', 'message', 'load', 'load_message', '400123');
INSERT INTO `myr_menu` VALUES ('400131', '同步Ebay产品', '15', 'goods', 'load', 'load_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400132', '查看Ebay产品', '16', 'goods', 'checklisting', 'check_listing', '400079');
INSERT INTO `myr_menu` VALUES ('400133', 'Message处理', '6', 'message', 'handle', 'handle_message', '400123');
INSERT INTO `myr_menu` VALUES ('400135', 'E邮宝订单', '7', 'order', 'eubhandle', 'eub_order_handle', '400082');
INSERT INTO `myr_menu` VALUES ('400136', '订单解除锁定', '21', 'order', 'unlock', 'order_unlcok', '400082');
INSERT INTO `myr_menu` VALUES ('400137', 'Paypal流水', '19', 'order', 'paypal', 'paypal_order', '400082');
INSERT INTO `myr_menu` VALUES ('400139', '收款单', '4', 'finance', 'receipt', 'list_rf', '400084');
INSERT INTO `myr_menu` VALUES ('400140', '付款单', '2', 'finance', 'pay', 'list_gf', '400084');
INSERT INTO `myr_menu` VALUES ('400141', '费用单', '3', 'finance', 'fee', 'list_fee', '400084');
INSERT INTO `myr_menu` VALUES ('400145', '产品批量更新', '17', 'goods', 'update', 'goods_update', '400079');
INSERT INTO `myr_menu` VALUES ('400146', '缺货订单', '14', 'order', 'ofsorder', 'order_ofs', '400082');
INSERT INTO `myr_menu` VALUES ('400147', '导入订单', '1', 'order', 'import', 'order_import', '400082');
INSERT INTO `myr_menu` VALUES ('400148', '订单批量更新', '18', 'order', 'OrderUpdate', 'order_update', '400082');
INSERT INTO `myr_menu` VALUES ('400150', 'Message模板', '1', 'template', 'message', 'template_message', '400087');
INSERT INTO `myr_menu` VALUES ('400151', '联系客户message', '2', 'template', 'partner', 'template_partner', '400087');
INSERT INTO `myr_menu` VALUES ('400152', '拣货订单', '12', 'order', 'pickuporder', 'order_pickup', '400082');
INSERT INTO `myr_menu` VALUES ('400153', '库存调换', '4', 'inventory', 'stockchange', 'change_stock', '400081');
INSERT INTO `myr_menu` VALUES ('400154', '采购导入', '7', 'purchaseorder', 'import', 'porder_import', '400080');
INSERT INTO `myr_menu` VALUES ('400155', '导入入库单', '5', 'stockin', 'import', 'stockin_import', '400081');
INSERT INTO `myr_menu` VALUES ('400156', '导入出库单', '6', 'stockout', 'import', 'stockout_import', '400081');
INSERT INTO `myr_menu` VALUES ('400157', '导入供应商相关', '8', 'supplier', 'import', 'import_supplier_goods', '400080');
INSERT INTO `myr_menu` VALUES ('400158', '分仓调拨', '10', 'inventory', 'allocation', 'goods_allocation', '400081');
INSERT INTO `myr_menu` VALUES ('400160', '多SKU管理', '10', 'goods', 'sku', 'list_sku', '400079');
INSERT INTO `myr_menu` VALUES ('400165', 'Ebay待下架产品', '12', 'goods', 'listingsupport', 'listing_support', '400079');
INSERT INTO `myr_menu` VALUES ('400166', '仓库货架', '9', 'inventory', 'shelf', 'list_shelf', '400081');
INSERT INTO `myr_menu` VALUES ('400169', 'RMA订单', '7', 'rma', '', 'list_rma', '400123');
INSERT INTO `myr_menu` VALUES ('400170', '退换货处理', '8', 'rma', 'return', 'list_return', '400123');
INSERT INTO `myr_menu` VALUES ('400171', '导入调拨单', '10', 'inventory', 'import', 'allocation_import', '400081');
INSERT INTO `myr_menu` VALUES ('400172', '4PX订单', '9', 'order', '4pxhandle', 'list_4px', '400082');
INSERT INTO `myr_menu` VALUES ('400174', 'Feedback处理', '4', 'Ecase', 'feedback', 'list_feedback', '400123');
INSERT INTO `myr_menu` VALUES ('400176', '产品操作日志', '18', 'goods', 'goodslog', 'list_goods_log', '400079');
INSERT INTO `myr_menu` VALUES ('400177', '订单导出模版', '3', 'template', 'order', 'template_order', '400087');
INSERT INTO `myr_menu` VALUES ('400178', '产品导出模版', '4', 'template', 'goods', 'template_goods', '400087');
INSERT INTO `myr_menu` VALUES ('400179', '扫描入库', '11', 'stockin', 'scan', 'add_stockin', '400081');
INSERT INTO `myr_menu` VALUES ('400181', '内部公告管理', '14', 'news', '', 'list_news', '400078');
INSERT INTO `myr_menu` VALUES ('400187', 'Amazon Shedule管理', '9', 'amazon', '', 'amazon_config', '400078');
INSERT INTO `myr_menu` VALUES ('400188', 'AMZ报表管理', '2', 'amazon', 'report', 'load_amzorder', '400082');
INSERT INTO `myr_menu` VALUES ('400189', '管理Amazon产品', '11', 'amazon', 'listing', 'load_amzlisting', '400079');
INSERT INTO `myr_menu` VALUES ('400190', '查看Amazon产品', '9', 'goods', 'Amzlisting', 'check_listing', '400079');
INSERT INTO `myr_menu` VALUES ('400196', '线下EUB订单', '8', 'order', 'Eub1handle', 'eub1_order_handle', '400082');
INSERT INTO `myr_menu` VALUES ('400199', '账户管理', '1', 'finance', 'bank', 'list_bank', '400084');
INSERT INTO `myr_menu` VALUES ('400200', '账户日志', '1', 'finance', 'banklog', 'list_banklog', '400084');
INSERT INTO `myr_menu` VALUES ('400203', '三态订单', '10', 'order', 'sfchandle', 'list_sfc', '400082');
INSERT INTO `myr_menu` VALUES ('400207', '出口易订单', '11', 'order', 'ck1handle', 'list_ck1', '400082');
INSERT INTO `myr_menu` VALUES ('400223', '速卖通产品管理', '13', 'aliexpress', 'goods', 'ali_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400217', '产品属性', '3', 'attribute', '', 'goods_attribute', '400079');
INSERT INTO `myr_menu` VALUES ('400218', '产品属性组', '4', 'attribute', 'attributegroup', 'goods_attribute_set', '400079');
INSERT INTO `myr_menu` VALUES ('400219', '产品语言管理', '5', 'language', '', 'list_Language', '400079');
INSERT INTO `myr_menu` VALUES ('400221', '互联易订单', '11', 'order', 'icehkhandle', 'list_icehkpost', '400082');
INSERT INTO `myr_menu` VALUES ('400222', '已发货订单', '13', 'order', 'shippinghandle', 'order_shippinged', '400082');
INSERT INTO `myr_menu` VALUES ('400225', '扫描拣货订单', '12', 'order', 'collation', 'order_collation', '400082');
INSERT INTO `myr_menu` VALUES ('400228', '速邮宝订单', '9', 'order', 'Subhandle', 'Subhandle', '400082');
INSERT INTO `myr_menu` VALUES ('400229', '同步在线产品(Ali)', '20', 'aliexpress', 'load', 'load_aligood', '400079');
INSERT INTO `myr_menu` VALUES ('400230', '未刊登待上传产品(Ali)', '21', 'goods', 'Aliwaitupload', 'ali_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400231', '上架销售产品(Ali)', '22', 'aliexpress', 'goods', 'ali_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400232', '下架结束产品(Ali)', '23', 'goods', 'Aliendlisting', 'ali_goods', '400079');
INSERT INTO `myr_menu` VALUES ('400233', '图片银行管理(Ali)', '24', 'goods', 'image_bank', 'ali_goods_imgbank', '400079');

-- ----------------------------
-- Table structure for myr_message
-- ----------------------------
DROP TABLE IF EXISTS `myr_message`;
CREATE TABLE `myr_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_type` int(11) DEFAULT '0',
  `message_group` int(11) DEFAULT '0',
  `message_title` varchar(60) DEFAULT NULL,
  `content` text,
  `send_user_id` int(11) DEFAULT '0',
  `send_time` int(11) DEFAULT '0',
  `receive_user_id` int(11) DEFAULT '0',
  `receive_time` int(11) DEFAULT '0',
  `attach_id` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `receive_users` varchar(255) DEFAULT NULL,
  `is_prompt` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_message
-- ----------------------------

-- ----------------------------
-- Table structure for myr_message_keyword
-- ----------------------------
DROP TABLE IF EXISTS `myr_message_keyword`;
CREATE TABLE `myr_message_keyword` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `msg_type_id` mediumint(8) unsigned NOT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_message_keyword
-- ----------------------------

-- ----------------------------
-- Table structure for myr_news
-- ----------------------------
DROP TABLE IF EXISTS `myr_news`;
CREATE TABLE `myr_news` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(100) DEFAULT NULL COMMENT '标题',
  `create_user_id` smallint(5) DEFAULT '0' COMMENT '添加人',
  `create_time` int(10) DEFAULT '0' COMMENT '添加时间',
  `content` text COMMENT '内容',
  `modify_user_id` smallint(5) DEFAULT '0' COMMENT '修改人',
  `modify_time` int(10) DEFAULT '0' COMMENT '修改时间',
  `show_user_id` varchar(255) DEFAULT NULL,
  `set_user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_news
-- ----------------------------

-- ----------------------------
-- Table structure for myr_news_catalog
-- ----------------------------
DROP TABLE IF EXISTS `myr_news_catalog`;
CREATE TABLE `myr_news_catalog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nc_caption` varchar(50) DEFAULT NULL COMMENT '标题',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `parent_id` int(11) DEFAULT '0' COMMENT '低级ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_news_catalog
-- ----------------------------
INSERT INTO `myr_news_catalog` VALUES ('1', 'test', '', '0');

-- ----------------------------
-- Table structure for myr_news_revert
-- ----------------------------
DROP TABLE IF EXISTS `myr_news_revert`;
CREATE TABLE `myr_news_revert` (
  `news_id` mediumint(8) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `time` int(10) NOT NULL,
  `showType` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_news_revert
-- ----------------------------

-- ----------------------------
-- Table structure for myr_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_order`;
CREATE TABLE `myr_order` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `userid` varchar(100) NOT NULL,
  `shipping_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `depot_id` tinyint(3) NOT NULL DEFAULT '0',
  `track_no` varchar(30) NOT NULL,
  `eubpdf` varchar(255) DEFAULT NULL,
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `FinalValueFee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `pay_id` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '默认支付方式为paypal',
  `FEEAMT` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) NOT NULL,
  `rate` float unsigned NOT NULL DEFAULT '1',
  `Sales_channels` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '默认销售渠道为ebay',
  `Sales_account_id` tinyint(2) unsigned NOT NULL,
  `sellerID` varchar(50) NOT NULL,
  `paypalid` varchar(25) NOT NULL,
  `PayPalEmailAddress` varchar(100) NOT NULL,
  `consignee` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `street1` varchar(100) NOT NULL,
  `street2` varchar(100) NOT NULL,
  `city` varchar(80) NOT NULL,
  `state` varchar(80) NOT NULL,
  `country` varchar(80) NOT NULL,
  `CountryCode` varchar(2) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `tel` varchar(40) NOT NULL,
  `sales_site` varchar(18) NOT NULL,
  `pay_note` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL COMMENT '内部备注',
  `sellsrecord` varchar(8) NOT NULL DEFAULT '0',
  `ShippingService` varchar(100) NOT NULL,
  `paid_time` int(10) unsigned NOT NULL DEFAULT '0',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `end_time` int(10) DEFAULT NULL,
  `shipping_time` int(10) unsigned NOT NULL DEFAULT '0',
  `weight` decimal(10,3) unsigned NOT NULL DEFAULT '0.000',
  `shipping_cost` decimal(10,2) NOT NULL,
  `order_status` smallint(3) unsigned NOT NULL DEFAULT '111' COMMENT '默认订单状态',
  `print_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '打印状态',
  `is_mark` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已标记',
  `mark_with_no` tinyint(1) NOT NULL DEFAULT '1',
  `stockout_sn` varchar(20) DEFAULT NULL COMMENT '出库单号',
  `is_check` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否通过订单产品校对',
  `is_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已锁定库存',
  `is_upload` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `client_id` varchar(30) DEFAULT NULL,
  `track_no_2` varchar(30) DEFAULT NULL,
  `ali_status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `userid` (`userid`),
  KEY `order_status` (`order_status`),
  KEY `shipping_id` (`shipping_id`),
  KEY `paypalid` (`paypalid`),
  KEY `track_no` (`track_no`),
  KEY `sellsrecord` (`sellsrecord`),
  KEY `end_time` (`end_time`),
  KEY `Sales_account_id` (`Sales_account_id`),
  KEY `alistatus` (`ali_status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order
-- ----------------------------
INSERT INTO `myr_order` VALUES ('1', '092110001', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '6.3795', '1', '1', 'test', '2164513456', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('2', '092110002', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513457', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('3', '092110003', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513458', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('4', '092110004', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513459', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('5', '092110005', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513460', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('6', '092110006', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513461', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('7', '092110007', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '1', '0.00', '0.00', 'USD', '0', '1', '1', 'test', '2164513462', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442826928', '0', '0', '0.000', '0.00', '114', '0', '0', '1', null, '0', '1', '0', 'dddd', 'asdfasdf', null);
INSERT INTO `myr_order` VALUES ('8', '092210001', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '6.3795', '10', '2', 'admin', '2000009', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891255', '1442892066', '0', '0.000', '0.00', '139', '0', '0', '1', 'CKD15092224116', '1', '2', '0', '王生', '10000009', null);
INSERT INTO `myr_order` VALUES ('9', '092210002', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '2', 'admin', '2000008', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891255', '1442892066', '0', '0.000', '0.00', '139', '0', '0', '1', 'CKD15092224116', '1', '2', '0', '白小姐', '10000008', null);
INSERT INTO `myr_order` VALUES ('10', '092210003', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '2', 'admin', '2000007', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891255', '1442892066', '0', '0.000', '0.00', '139', '0', '0', '1', 'CKD15092224116', '1', '2', '0', '梦小姐', '10000007', null);
INSERT INTO `myr_order` VALUES ('11', '092210004', '125.505.457-37', '1', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '2', 'admin', '2000006', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891255', '0', '0', '0.000', '0.00', '117', '0', '0', '1', null, '0', '0', '0', '徐坤', '10000006', null);
INSERT INTO `myr_order` VALUES ('12', '092210005', '125.505.457-37', '0', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '6.3795', '10', '1', 'test', '6000009', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891447', '0', '0', '0.000', '0.00', '112', '0', '0', '1', null, '0', '0', '0', '王生', '50000009', null);
INSERT INTO `myr_order` VALUES ('13', '092210006', '125.505.457-37', '0', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '1', 'test', '6000008', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891447', '0', '0', '0.000', '0.00', '112', '0', '0', '1', null, '0', '0', '0', '白小姐', '50000008', null);
INSERT INTO `myr_order` VALUES ('14', '092210007', '125.505.457-37', '0', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '1', 'test', '6000007', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891447', '0', '0', '0.000', '0.00', '112', '0', '0', '1', null, '0', '0', '0', '梦小姐', '50000007', null);
INSERT INTO `myr_order` VALUES ('15', '092210008', '125.505.457-37', '0', '0', '', null, '0.00', '0.00', '3', '0.00', '0.00', 'USD', '0', '10', '1', 'test', '6000006', '', 'LUANA DE OLIVEIRA SANTOS', '', 'Rua Jabaira, 131 - Oswaldo Cruz - CASA', '', 'Rio de Janeiro', 'RJ', 'Brasil', 'US', '21340-400', '21340-400', '', '', '', '', '', '0', '1442891447', '0', '0', '0.000', '0.00', '112', '0', '0', '1', null, '0', '0', '0', '徐坤', '50000006', null);
INSERT INTO `myr_order` VALUES ('16', '09221300001', '1', '0', '0', '', null, '0.00', '0.00', '4', '0.00', '0.00', 'USD', '6.3795', '7', '2', 'admin', '1', '', 'TT', '1@1.COM', 'Nanshan Guangdong CHINA', '', 'SZX', 'GD', 'china', '+8', '518000', '', '', '', '', '', '', '1442851200', '1442914221', null, '0', '0.000', '0.00', '117', '0', '0', '1', null, '0', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for myr_order_collation
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_collation`;
CREATE TABLE `myr_order_collation` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `goods_img` varchar(255) DEFAULT NULL,
  `goods_sn` varchar(30) NOT NULL,
  `goods_name` varchar(120) NOT NULL,
  `out_qty` smallint(5) unsigned NOT NULL,
  `goods_qty` smallint(5) unsigned NOT NULL,
  `sn_control` tinyint(1) NOT NULL DEFAULT '0',
  `order_id` mediumint(8) unsigned NOT NULL,
  `user` tinyint(3) unsigned NOT NULL,
  `snlist` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_sn` (`goods_sn`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_collation
-- ----------------------------

-- ----------------------------
-- Table structure for myr_order_combined
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_combined`;
CREATE TABLE `myr_order_combined` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `root_id` mediumint(8) NOT NULL,
  `order_id` mediumint(8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `root_id` (`root_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_combined
-- ----------------------------

-- ----------------------------
-- Table structure for myr_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_goods`;
CREATE TABLE `myr_order_goods` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_sn` varchar(30) NOT NULL,
  `item_no` varchar(15) DEFAULT NULL COMMENT 'ebay itemNO',
  `goods_name` varchar(120) NOT NULL,
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `goods_weigth` decimal(10,2) NOT NULL,
  `goods_qty` smallint(5) NOT NULL,
  `bid_count` smallint(5) unsigned NOT NULL,
  `StartPrice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `TransactionID` varchar(20) DEFAULT NULL,
  `ebay_orderid` varchar(20) DEFAULT NULL,
  `ebay_CreatedDate` int(10) unsigned NOT NULL DEFAULT '0',
  `OrderLineItemID` varchar(50) NOT NULL,
  `sn_prefix` varchar(5) DEFAULT NULL,
  `stock_place` varchar(20) DEFAULT NULL,
  `good_line_img` varchar(255) DEFAULT NULL,
  `Attribute_note` text NOT NULL,
  `ali_qty` varchar(128) NOT NULL DEFAULT ' ',
  `ali_logistic` varchar(128) NOT NULL DEFAULT ' ',
  `ali_note` text NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `order_id` (`order_id`),
  KEY `orderlineitem` (`item_no`,`TransactionID`),
  KEY `stock_place` (`stock_place`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_goods
-- ----------------------------
INSERT INTO `myr_order_goods` VALUES ('1', '1', '61', '280666200145', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('2', '2', '61', '280666212815', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('3', '3', '61', '280666163494', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('4', '4', '61', '280666235375', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('5', '5', '61', '280666239083', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('6', '6', '61', '280666248843', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('7', '7', '61', '280666207600', 'C3072T-110v BL', '19.90', '0.00', '1', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('8', '8', '9020', '280666240505', '口红 玫瑰色20', '58.90', '0.00', '5', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('9', '8', '9019', '280666176068', '口红 玫瑰色19', '52.90', '0.00', '10', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('10', '9', '9020', '280666243862', '口红 玫瑰色20', '58.90', '0.00', '5', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('11', '10', '9019', '280666244247', '口红 玫瑰色19', '52.90', '0.00', '10', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('12', '11', '9018', '280666232203', '口红 玫瑰色18', '50.00', '0.00', '3', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('13', '11', '9017', '280666241297', '口红 玫瑰色17', '50.00', '0.00', '2', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('14', '11', '9016', '280666246037', '口红 玫瑰色16', '50.00', '0.00', '2', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('15', '11', '9015', '280666172376', '口红 玫瑰色15', '50.00', '0.00', '3', '0', '0.00', '', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('16', '12', '9020', '280666249394', '口红 玫瑰色20', '58.90', '0.00', '5', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('17', '12', '9019', '280666154738', '口红 玫瑰色19', '52.90', '0.00', '10', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('18', '13', '9020', '280666204296', '口红 玫瑰色20', '58.90', '0.00', '5', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('19', '14', '9019', '280666242968', '口红 玫瑰色19', '52.90', '0.00', '10', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('20', '15', '9018', '280666233153', '口红 玫瑰色18', '50.00', '0.00', '3', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('21', '15', '9017', '280666246528', '口红 玫瑰色17', '50.00', '0.00', '2', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('22', '15', '9016', '280666186513', '口红 玫瑰色16', '50.00', '0.00', '2', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('23', '15', '9015', '280666209762', '口红 玫瑰色15', '50.00', '0.00', '3', '0', '0.00', '', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('24', '16', '111', '11', '11', '1.00', '0.00', '1', '0', '0.00', '144291422186', null, '0', '', '', '', null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('25', '16', '9008', '', '口红 玫瑰色8', '0.00', '0.00', '1', '0', '0.00', '144291535177', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('26', '16', '9020', '', '口红 玫瑰色20', '0.00', '0.00', '1', '0', '0.00', '144291535112', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('27', '16', '9002', '', '口红 玫瑰色2', '0.00', '0.00', '1', '0', '0.00', '144291535187', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('28', '16', '9018', '', '口红 玫瑰色18', '0.00', '0.00', '1', '0', '0.00', '144291535164', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('29', '16', '9018', '', '口红 玫瑰色18', '0.00', '0.00', '1', '0', '0.00', '144291535168', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('30', '16', '9017', '', '口红 玫瑰色17', '0.00', '0.00', '1', '0', '0.00', '144291535138', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('31', '16', '9017', '', '口红 玫瑰色17', '0.00', '0.00', '1', '0', '0.00', '144291535121', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('32', '16', '9017', '', '口红 玫瑰色17', '0.00', '0.00', '1', '0', '0.00', '144291535138', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('33', '16', '9012', '', '口红 玫瑰色12', '0.00', '0.00', '1', '0', '0.00', '144291535133', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('34', '16', '9012', '', '口红 玫瑰色12', '0.00', '0.00', '1', '0', '0.00', '144291535149', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('35', '16', '9011', '', '口红 玫瑰色11', '0.00', '0.00', '1', '0', '0.00', '144291535147', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('36', '16', '9011', '', '口红 玫瑰色11', '0.00', '0.00', '1', '0', '0.00', '144291535165', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('37', '16', '9010', '', '口红 玫瑰色10', '0.00', '0.00', '1', '0', '0.00', '144291535199', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('38', '16', '0101011', '', 'Nutrilon牛栏奶粉 5段 800g', '0.00', '0.00', '1', '0', '0.00', '144291535164', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('39', '16', '0101010', '', 'Nutrilon牛栏奶粉 4段 800g', '0.00', '0.00', '1', '0', '0.00', '144291535118', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('40', '16', '0101009', '', 'Nutrilon牛栏奶粉 3段 800g', '0.00', '0.00', '1', '0', '0.00', '144291535139', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('41', '16', '0101008', '', 'Nutrilon牛栏奶粉 2段 850g', '0.00', '0.00', '1', '0', '0.00', '144291535170', null, '0', '', '', null, null, '', ' ', ' ', '');
INSERT INTO `myr_order_goods` VALUES ('42', '16', '0101012', '', 'Hero Baby玺乐奶粉 1段 800g', '0.00', '0.00', '1', '0', '0.00', '144291535143', null, '0', '', '', null, null, '', ' ', ' ', '');

-- ----------------------------
-- Table structure for myr_order_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_log`;
CREATE TABLE `myr_order_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `action` varchar(10) NOT NULL,
  `content` varchar(100) NOT NULL,
  `user_id` tinyint(3) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_log
-- ----------------------------
INSERT INTO `myr_order_log` VALUES ('1', '7', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('2', '2', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('3', '5', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('4', '1', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('5', '4', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('6', '3', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('7', '6', '更改状态', '订单状态被更改为113', '1', '1442827053');
INSERT INTO `myr_order_log` VALUES ('8', '3', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('9', '6', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('10', '2', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('11', '5', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('12', '1', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('13', '4', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('14', '7', '更改状态', '订单状态被更改为117', '1', '1442827070');
INSERT INTO `myr_order_log` VALUES ('15', '3', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('16', '6', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('17', '2', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('18', '5', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('19', '1', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('20', '4', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('21', '7', '更改状态', '订单状态被更改为117', '1', '1442827250');
INSERT INTO `myr_order_log` VALUES ('22', '3', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('23', '6', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('24', '2', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('25', '5', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('26', '1', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('27', '4', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('28', '7', '更改状态', '订单状态被更改为117', '1', '1442827377');
INSERT INTO `myr_order_log` VALUES ('29', '3', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('30', '3', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('31', '6', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('32', '6', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('33', '2', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('34', '2', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('35', '5', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('36', '5', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('37', '1', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('38', '1', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('39', '4', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('40', '4', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('41', '7', '更改状态', '订单状态被更改为114', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('42', '7', '库存变动', '库存已被锁定', '1', '1442827520');
INSERT INTO `myr_order_log` VALUES ('43', '8', '更改状态', '订单状态被更改为113', '1', '1442891794');
INSERT INTO `myr_order_log` VALUES ('44', '11', '更改状态', '订单状态被更改为113', '1', '1442891794');
INSERT INTO `myr_order_log` VALUES ('45', '10', '更改状态', '订单状态被更改为113', '1', '1442891794');
INSERT INTO `myr_order_log` VALUES ('46', '9', '更改状态', '订单状态被更改为113', '1', '1442891794');
INSERT INTO `myr_order_log` VALUES ('47', '11', '更改状态', '订单状态被更改为117', '1', '1442891882');
INSERT INTO `myr_order_log` VALUES ('48', '8', '更改状态', '订单状态被更改为114', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('49', '8', '库存变动', '库存已被锁定', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('50', '9', '更改状态', '订单状态被更改为114', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('51', '9', '库存变动', '库存已被锁定', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('52', '10', '更改状态', '订单状态被更改为114', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('53', '10', '库存变动', '库存已被锁定', '1', '1442891898');
INSERT INTO `myr_order_log` VALUES ('54', '10', '更改状态', '订单状态被更改为129', '1', '1442891992');
INSERT INTO `myr_order_log` VALUES ('55', '9', '更改状态', '订单状态被更改为129', '1', '1442891992');
INSERT INTO `myr_order_log` VALUES ('56', '8', '更改状态', '订单状态被更改为129', '1', '1442891992');
INSERT INTO `myr_order_log` VALUES ('57', '10', '库存变动', '订单库存已解锁', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('58', '10', '库存变动', '库存锁定结束', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('59', '10', '更改状态', '订单状态被更改为139', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('60', '9', '库存变动', '订单库存已解锁', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('61', '9', '库存变动', '库存锁定结束', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('62', '9', '更改状态', '订单状态被更改为139', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('63', '8', '库存变动', '订单库存已解锁', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('64', '8', '库存变动', '库存锁定结束', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('65', '8', '更改状态', '订单状态被更改为139', '1', '1442892066');
INSERT INTO `myr_order_log` VALUES ('66', '16', '新增订单', '添加订单', '13', '1442914221');
INSERT INTO `myr_order_log` VALUES ('67', '16', '订单编辑', 'pay_id值由3更新为4', '13', '1442914268');
INSERT INTO `myr_order_log` VALUES ('68', '16', '订单编辑', 'paypalid值由更新为1', '13', '1442914281');
INSERT INTO `myr_order_log` VALUES ('69', '16', '新增订单产品', '新增订单产品口红 玫瑰色8', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('70', '16', '新增订单产品', '新增订单产品口红 玫瑰色20', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('71', '16', '新增订单产品', '新增订单产品口红 玫瑰色2', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('72', '16', '新增订单产品', '新增订单产品口红 玫瑰色18', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('73', '16', '新增订单产品', '新增订单产品口红 玫瑰色18', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('74', '16', '新增订单产品', '新增订单产品口红 玫瑰色17', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('75', '16', '新增订单产品', '新增订单产品口红 玫瑰色17', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('76', '16', '新增订单产品', '新增订单产品口红 玫瑰色17', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('77', '16', '新增订单产品', '新增订单产品口红 玫瑰色12', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('78', '16', '新增订单产品', '新增订单产品口红 玫瑰色12', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('79', '16', '新增订单产品', '新增订单产品口红 玫瑰色11', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('80', '16', '新增订单产品', '新增订单产品口红 玫瑰色11', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('81', '16', '新增订单产品', '新增订单产品口红 玫瑰色10', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('82', '16', '新增订单产品', '新增订单产品Nutrilon牛栏奶粉 5段 800g', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('83', '16', '新增订单产品', '新增订单产品Nutrilon牛栏奶粉 4段 800g', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('84', '16', '新增订单产品', '新增订单产品Nutrilon牛栏奶粉 3段 800g', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('85', '16', '新增订单产品', '新增订单产品Nutrilon牛栏奶粉 2段 850g', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('86', '16', '新增订单产品', '新增订单产品Hero Baby玺乐奶粉 1段 800g', '13', '1442915351');
INSERT INTO `myr_order_log` VALUES ('87', '16', '编辑订单产品', '编辑订单产品11', '13', '1442915351');

-- ----------------------------
-- Table structure for myr_order_print_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_print_log`;
CREATE TABLE `myr_order_print_log` (
  `addtime` int(10) unsigned NOT NULL,
  `ids` text NOT NULL,
  `admin_id` smallint(5) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  KEY `admin_id` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_print_log
-- ----------------------------

-- ----------------------------
-- Table structure for myr_order_status
-- ----------------------------
DROP TABLE IF EXISTS `myr_order_status`;
CREATE TABLE `myr_order_status` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(30) NOT NULL,
  `next_id` tinyint(3) unsigned DEFAULT '0' COMMENT '通过状态',
  `hold_id` tinyint(3) unsigned DEFAULT '0' COMMENT '暂停状态',
  `refund_id` tinyint(3) unsigned DEFAULT '0' COMMENT '退款状态',
  `fail_id` tinyint(3) unsigned DEFAULT '0' COMMENT '未通过状态',
  `pay_status` tinyint(1) NOT NULL DEFAULT '1',
  `shipping_status` tinyint(1) NOT NULL DEFAULT '0',
  `start_end` tinyint(1) NOT NULL DEFAULT '2',
  `is_show` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_order_status
-- ----------------------------
INSERT INTO `myr_order_status` VALUES ('111', 'Ebay待Paypal校对', '112', '115', '0', '115', '1', '0', '0', '0', 'ebay加载订单');
INSERT INTO `myr_order_status` VALUES ('112', '待客服审核', '113', '116', '125', '116', '1', '0', '2', '0', '自动审核通过');
INSERT INTO `myr_order_status` VALUES ('113', '待库管审核', '114', '136', '126', '117', '1', '0', '2', '0', '客服审核通过');
INSERT INTO `myr_order_status` VALUES ('114', '待处理订单', '129', '121', '0', '121', '1', '0', '2', '0', '库管审核通过');
INSERT INTO `myr_order_status` VALUES ('115', 'Ebay/Amazon校对失败', '113', '116', '125', '116', '1', '0', '2', '0', '校对失败');
INSERT INTO `myr_order_status` VALUES ('116', '客服审核失败', '113', '116', '125', '116', '1', '0', '2', '0', '客服审核失败');
INSERT INTO `myr_order_status` VALUES ('117', '缺货订单', '114', '136', '126', '117', '1', '0', '2', '0', '库管审核失败');
INSERT INTO `myr_order_status` VALUES ('118', '现款录单', '0', '0', '0', '0', '1', '1', '1', '0', '现款录单');
INSERT INTO `myr_order_status` VALUES ('119', '货到付款录单', '122', '123', '119', '123', '0', '0', '0', '0', '货到付款录单');
INSERT INTO `myr_order_status` VALUES ('120', '合并作废订单', '0', '0', '0', '0', '0', '0', '1', '0', '合并作废');
INSERT INTO `myr_order_status` VALUES ('121', '订单处理暂停', '129', '121', '0', '121', '1', '0', '2', '0', '订单处理暂停');
INSERT INTO `myr_order_status` VALUES ('122', '货到付款待处理', '130', '128', '0', '128', '0', '0', '2', '0', '货到付款库管审核通过');
INSERT INTO `myr_order_status` VALUES ('123', '货到付款缺货订单', '122', '123', '123', '123', '0', '0', '2', '0', '货到付款库管审核失败');
INSERT INTO `myr_order_status` VALUES ('124', '作废订单', '0', '0', '0', '0', '0', '0', '1', '0', '订单作废');
INSERT INTO `myr_order_status` VALUES ('125', '客服审核退款中', '127', '0', '0', '0', '0', '0', '2', '0', '客服审核退款中');
INSERT INTO `myr_order_status` VALUES ('126', '库管审核退款中', '127', '0', '0', '0', '0', '0', '2', '0', '库管审核退款中');
INSERT INTO `myr_order_status` VALUES ('127', '退款完成', '0', '0', '127', '0', '0', '0', '1', '0', '退款完成');
INSERT INTO `myr_order_status` VALUES ('128', '货到付款订单处理暂停', '130', '128', '0', '128', '0', '0', '2', '0', '货到付款订单处理暂停');
INSERT INTO `myr_order_status` VALUES ('129', '待拣货订单', '139', '134', '0', '0', '1', '0', '2', '0', '订单处理完成');
INSERT INTO `myr_order_status` VALUES ('130', '货到付款待拣货', '132', '131', '0', '0', '0', '0', '2', '0', '到付处理完成');
INSERT INTO `myr_order_status` VALUES ('131', '已完成订单', '0', '0', '133', '0', '1', '1', '1', '0', '订单核对完成');
INSERT INTO `myr_order_status` VALUES ('132', '到付完成订单', '131', '0', '0', '0', '0', '1', '2', '0', '到付核对完成');
INSERT INTO `myr_order_status` VALUES ('133', '已完成订单退款', '127', '0', '0', '0', '0', '0', '2', '0', '已完成订单退款');
INSERT INTO `myr_order_status` VALUES ('134', '待拣货订单缺货', '129', '0', '0', '0', '1', '0', '2', '0', '处理完成缺货');
INSERT INTO `myr_order_status` VALUES ('135', '到付待拣货订单缺货', '130', '0', '0', '0', '0', '0', '2', '0', '到付处理缺货');
INSERT INTO `myr_order_status` VALUES ('110', 'Amazon加载异常', '112', '115', '0', '115', '1', '0', '2', '0', 'Amazon加载异常(需重新加载失败产品)');
INSERT INTO `myr_order_status` VALUES ('139', '已发货订单', '140', '0', '0', '0', '1', '0', '2', '0', '');

-- ----------------------------
-- Table structure for myr_paypal_account
-- ----------------------------
DROP TABLE IF EXISTS `myr_paypal_account`;
CREATE TABLE `myr_paypal_account` (
  `p_root_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `paypal_account` varchar(60) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  `signature` varchar(60) NOT NULL,
  PRIMARY KEY (`p_root_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_paypal_account
-- ----------------------------

-- ----------------------------
-- Table structure for myr_paypal_info
-- ----------------------------
DROP TABLE IF EXISTS `myr_paypal_info`;
CREATE TABLE `myr_paypal_info` (
  `p_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `p_root_id` tinyint(4) NOT NULL,
  `p_name` varchar(50) NOT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_paypal_info
-- ----------------------------

-- ----------------------------
-- Table structure for myr_paypal_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_paypal_order`;
CREATE TABLE `myr_paypal_order` (
  `p_id` tinyint(3) unsigned NOT NULL,
  `paypalid` varchar(25) NOT NULL,
  `email` varchar(100) NOT NULL,
  `consignee` varchar(100) NOT NULL,
  `street1` varchar(100) NOT NULL,
  `street2` varchar(100) NOT NULL,
  `city` varchar(80) NOT NULL,
  `state` varchar(80) NOT NULL,
  `country` varchar(80) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `tel` varchar(40) NOT NULL,
  `note` varchar(255) NOT NULL,
  `TRANSACTIONTYPE` varchar(15) NOT NULL,
  `AMT` decimal(10,2) NOT NULL,
  `CURRENCYCODE` varchar(3) NOT NULL,
  `FEEAMT` decimal(10,2) NOT NULL,
  `TAXAMT` decimal(10,2) NOT NULL,
  `EXCHANGERATE` varchar(17) NOT NULL,
  `SETTLEAMT` decimal(10,2) NOT NULL,
  `REASONCODE` varchar(20) NOT NULL,
  `PENDINGREASON` varchar(20) NOT NULL,
  `ORDERTIME` int(10) NOT NULL,
  `PAYMENTSTATUS` varchar(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `p_id` (`p_id`,`paypalid`),
  KEY `paypalid` (`paypalid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_paypal_order
-- ----------------------------

-- ----------------------------
-- Table structure for myr_paypal_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_paypal_order_goods`;
CREATE TABLE `myr_paypal_order_goods` (
  `paypalid` varchar(25) NOT NULL,
  `L_NAME` varchar(100) NOT NULL,
  `L_NUMBER` varchar(20) NOT NULL,
  `L_QTY` smallint(5) unsigned NOT NULL,
  `L_AMT` decimal(10,2) NOT NULL,
  KEY `paypalid` (`paypalid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_paypal_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for myr_paypal_transaction
-- ----------------------------
DROP TABLE IF EXISTS `myr_paypal_transaction`;
CREATE TABLE `myr_paypal_transaction` (
  `L_TYPE` varchar(30) NOT NULL,
  `L_EMAIL` varchar(100) NOT NULL,
  `L_NAME` varchar(100) NOT NULL,
  `L_TRANSACTIONID` varchar(30) NOT NULL,
  `L_STATUS` varchar(50) NOT NULL,
  `L_AMT` decimal(10,2) NOT NULL,
  `L_CURRENCYCODE` varchar(3) NOT NULL,
  `L_FEEAMT` decimal(10,2) NOT NULL,
  `L_NETAMT` decimal(10,2) NOT NULL,
  `L_TIMESTAMP` varchar(20) NOT NULL,
  `L_TIMEZONE` varchar(3) NOT NULL,
  `paypal_id` tinyint(3) unsigned NOT NULL,
  KEY `L_EMAIL` (`L_EMAIL`),
  KEY `L_TRANSACTIONID` (`L_TRANSACTIONID`,`paypal_id`),
  KEY `L_TIMESTAMP` (`L_TIMESTAMP`),
  KEY `paypal_id` (`paypal_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_paypal_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for myr_plan_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_plan_goods`;
CREATE TABLE `myr_plan_goods` (
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_sn` varchar(30) NOT NULL,
  `goods_name` varchar(80) NOT NULL,
  `SKU` varchar(20) NOT NULL,
  `goods_qty` smallint(4) NOT NULL,
  `warn_qty` tinyint(3) unsigned NOT NULL,
  `varstock` smallint(4) NOT NULL,
  `Purchase_qty` smallint(4) unsigned NOT NULL,
  `sold_qty` smallint(4) unsigned NOT NULL,
  `per_sold` float(7,2) unsigned NOT NULL DEFAULT '0.00',
  `supplier` varchar(50) NOT NULL,
  `period` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `plan_qty` smallint(4) unsigned NOT NULL,
  `comment` varchar(100) NOT NULL,
  `plan_day` mediumint(8) NOT NULL,
  `depot_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `goods_id` (`goods_id`),
  KEY `SKU` (`SKU`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_plan_goods
-- ----------------------------
INSERT INTO `myr_plan_goods` VALUES ('1', '62', 'Fashion jewelry J0003#6', '62', '84', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-69', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('2', '63', 'Fashion jewelry J0003#6', '63', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('3', '64', 'Fashion jewelry J0003#6', '64', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('4', '65', 'Fashion jewelry J0003#6', '65', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('5', '66', 'Fashion jewelry J0003#6', '66', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('6', '67', 'Fashion jewelry J0003#6', '67', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('7', '68', 'Fashion jewelry J0003#6', '68', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('8', '69', 'Fashion jewelry J0003#6', '69', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('9', '70', 'Fashion jewelry J0003#6', '70', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('10', '71', 'Fashion jewelry J0003#6', '71', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('11', '72', 'Fashion jewelry J0003#6', '72', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('12', '73', 'Fashion jewelry J0003#6', '73', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('13', '74', 'Fashion jewelry J0003#6', '74', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('14', '75', 'Fashion jewelry J0003#6', '75', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('15', '76', 'Fashion jewelry J0003#6', '76', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('16', '77', 'Fashion jewelry J0003#6', '77', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('17', '78', 'Fashion jewelry J0003#6', '78', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('18', '79', 'Fashion jewelry J0003#6', '79', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('19', '80', 'Fashion jewelry J0003#6', '80', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('20', '81', 'Fashion jewelry J0003#6', '81', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('21', '82', 'Fashion jewelry J0003#6', '82', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('22', '83', 'Fashion jewelry J0003#6', '83', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('23', '84', 'Fashion jewelry J0003#6', '84', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('24', '85', 'Fashion jewelry J0003#6', '85', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('25', '86', 'Fashion jewelry J0003#6', '86', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('26', '87', 'Fashion jewelry J0003#6', '87', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('27', '88', 'Fashion jewelry J0003#6', '88', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('28', '89', 'Fashion jewelry J0003#6', '89', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('29', '90', 'Fashion jewelry J0003#6', '90', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('30', '91', 'Fashion jewelry J0003#6', '91', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('31', '92', 'Fashion jewelry J0003#6', '92', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('32', '93', 'Fashion jewelry J0003#6', '93', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('33', '94', 'Fashion jewelry J0003#6', '94', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('34', '95', 'Fashion jewelry J0003#6', '95', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('35', '96', 'Fashion jewelry J0003#6', '96', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('36', '97', 'Fashion jewelry J0003#6', '97', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('37', '98', 'Fashion jewelry J0003#6', '98', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('38', '99', 'Fashion jewelry J0003#6', '99', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('39', '100', 'Fashion jewelry J0003#6', '100', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('40', '101', 'Fashion jewelry J0003#6', '101', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('41', '102', 'Fashion jewelry J0003#6', '102', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('42', '103', 'Fashion jewelry J0003#6', '103', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('43', '104', 'Fashion jewelry J0003#6', '104', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('44', '105', 'Fashion jewelry J0003#6', '105', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('45', '106', 'Fashion jewelry J0003#6', '106', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('46', '107', 'Fashion jewelry J0003#6', '107', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('47', '108', 'Fashion jewelry J0003#6', '108', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('48', '109', 'Fashion jewelry J0003#6', '109', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('49', '110', 'Fashion jewelry J0003#6', '110', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('50', '111', 'Fashion jewelry J0003#6', '111', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('51', '112', 'Fashion jewelry J0003#6', '112', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('52', '113', 'Fashion jewelry J0003#6', '113', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('53', '114', 'Fashion jewelry J0003#6', '114', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('54', '115', 'Fashion jewelry J0003#6', '115', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('55', '116', 'Fashion jewelry J0003#6', '116', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('56', '117', 'Fashion jewelry J0003#6', '117', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('57', '118', 'Fashion jewelry J0003#6', '118', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('58', '119', 'Fashion jewelry J0003#6', '119', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('59', '120', 'Fashion jewelry J0003#6', '120', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('60', '121', 'Fashion jewelry J0003#6', '121', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('61', '122', 'Fashion jewelry J0003#6', '122', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('62', '123', 'Fashion jewelry J0003#6', '123', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('63', '124', 'Fashion jewelry J0003#6', '124', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('64', '125', 'Fashion jewelry J0003#6', '125', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('65', '126', 'Fashion jewelry J0003#6', '126', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('66', '127', 'Fashion jewelry J0003#6', '127', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('67', '128', 'Fashion jewelry J0003#6', '128', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('68', '129', 'Fashion jewelry J0003#6', '129', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('69', '130', 'Fashion jewelry J0003#6', '130', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('70', '131', 'Fashion jewelry J0003#6', '131', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('71', '132', 'Fashion jewelry J0003#6', '132', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('72', '133', 'Fashion jewelry J0003#6', '133', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('73', '134', 'Fashion jewelry J0003#6', '134', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('74', '135', 'Fashion jewelry J0003#6', '135', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('75', '136', 'Fashion jewelry J0003#6', '136', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('76', '137', 'Fashion jewelry J0003#6', '137', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('77', '138', 'Fashion jewelry J0003#6', '138', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('78', '139', 'Fashion jewelry J0003#6', '139', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('79', '140', 'Fashion jewelry J0003#6', '140', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('80', '141', 'Fashion jewelry J0003#6', '141', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('81', '142', 'Fashion jewelry J0003#6', '142', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('82', '143', 'Fashion jewelry J0003#6', '143', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('83', '144', 'Fashion jewelry J0003#6', '144', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('84', '145', 'Fashion jewelry J0003#6', '145', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('85', '146', 'Fashion jewelry J0003#6', '146', '85', '15', '0', '0', '0', '0.00', '深圳市科极达盛投资有限公司', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('86', '147', 'Fashion jewelry J0003#6', '147', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('87', '148', 'Fashion jewelry J0003#6', '148', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('88', '149', 'Fashion jewelry J0003#6', '149', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('89', '150', 'Fashion jewelry J0003#6', '150', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('90', '151', 'Fashion jewelry J0003#6', '151', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('91', '152', 'Fashion jewelry J0003#6', '152', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('92', '153', 'Fashion jewelry J0003#6', '153', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('93', '154', 'Fashion jewelry J0003#6', '154', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('94', '155', 'Fashion jewelry J0003#6', '155', '85', '15', '0', '0', '0', '0.00', '深圳市科极达盛投资有限公司', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('95', '156', 'Fashion jewelry J0003#6', '156', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('96', '157', 'Fashion jewelry J0003#6', '157', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('97', '158', 'Fashion jewelry J0003#6', '158', '85', '15', '0', '0', '0', '0.00', '', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('98', '159', 'Fashion jewelry J0003#6', '159', '85', '15', '0', '0', '0', '0.00', '深圳市科极达盛投资有限公司', '0', '0', '建议采购-70', '0', '255');
INSERT INTO `myr_plan_goods` VALUES ('99', '61', 'Fashion jewelry J0003#6', '61', '7', '0', '7', '0', '0', '0.00', '深圳市科极达盛投资有限公司', '0', '0', '建议采购0', '0', '255');

-- ----------------------------
-- Table structure for myr_plan_goods_depot
-- ----------------------------
DROP TABLE IF EXISTS `myr_plan_goods_depot`;
CREATE TABLE `myr_plan_goods_depot` (
  `goods_plan_id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_sn` varchar(30) NOT NULL,
  `goods_name` varchar(80) NOT NULL,
  `SKU` varchar(20) NOT NULL,
  `goods_qty` smallint(4) NOT NULL,
  `warn_qty` tinyint(3) unsigned NOT NULL,
  `varstock` smallint(4) NOT NULL,
  `Purchase_qty` smallint(4) unsigned NOT NULL,
  `sold_qty` smallint(4) unsigned NOT NULL,
  `per_sold` float(7,2) unsigned NOT NULL DEFAULT '0.00',
  `supplier` varchar(50) NOT NULL,
  `period` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `plan_qty` smallint(4) unsigned NOT NULL,
  `comment` varchar(100) NOT NULL,
  `plan_day` mediumint(8) NOT NULL,
  `depot_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`goods_plan_id`),
  UNIQUE KEY `goods_id` (`goods_id`),
  KEY `SKU` (`SKU`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_plan_goods_depot
-- ----------------------------

-- ----------------------------
-- Table structure for myr_plan_goods_depot_ordergoods
-- ----------------------------
DROP TABLE IF EXISTS `myr_plan_goods_depot_ordergoods`;
CREATE TABLE `myr_plan_goods_depot_ordergoods` (
  `goods_plan_id` int(8) NOT NULL,
  `goods_id` int(8) unsigned NOT NULL,
  `order_id` int(8) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_plan_goods_depot_ordergoods
-- ----------------------------

-- ----------------------------
-- Table structure for myr_plan_goods_tmp
-- ----------------------------
DROP TABLE IF EXISTS `myr_plan_goods_tmp`;
CREATE TABLE `myr_plan_goods_tmp` (
  `supplier_id` smallint(5) NOT NULL,
  `goods_id` mediumint(8) NOT NULL,
  `supplier_goods_price` decimal(10,2) unsigned NOT NULL,
  `goods_qty` smallint(4) unsigned NOT NULL,
  `warn_qty` tinyint(3) unsigned NOT NULL,
  `varstock` smallint(4) unsigned NOT NULL,
  `Purchase_qty` smallint(4) unsigned NOT NULL,
  `sold_qty` float unsigned NOT NULL,
  `per_sold` float(7,2) unsigned NOT NULL DEFAULT '0.00',
  `period` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `plan_qty` smallint(4) unsigned NOT NULL,
  `comment` varchar(100) NOT NULL,
  `plan_day` mediumint(8) NOT NULL,
  `depot_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_plan_goods_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_attribute
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_attribute`;
CREATE TABLE `myr_product_attribute` (
  `attribute_id` int(8) NOT NULL AUTO_INCREMENT,
  `entity_type_id` smallint(5) NOT NULL,
  `attribute_code` varchar(30) NOT NULL,
  `attribute_label` varchar(100) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1必填   0可以为空',
  `is_unique` tinyint(1) NOT NULL DEFAULT '0' COMMENT '认默不唯一',
  `is_update_notice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认为不提示更新  设置1为提示更新',
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_defined
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_defined`;
CREATE TABLE `myr_product_defined` (
  `value_id` int(8) NOT NULL AUTO_INCREMENT,
  `language_id` smallint(5) NOT NULL,
  `goods_id` int(8) NOT NULL,
  `value` text NOT NULL,
  `attribute_ib` int(8) NOT NULL,
  PRIMARY KEY (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_defined
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_language
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_language`;
CREATE TABLE `myr_product_language` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `code` varchar(30) NOT NULL,
  `sort_order` smallint(5) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_language
-- ----------------------------
INSERT INTO `myr_product_language` VALUES ('1', '中文', 'zh-CN', '1', '1');
INSERT INTO `myr_product_language` VALUES ('2', '英文', 'en', '2', '1');
INSERT INTO `myr_product_language` VALUES ('3', '德语', 'de', '3', '1');
INSERT INTO `myr_product_language` VALUES ('4', '法语', 'fr', '4', '1');
INSERT INTO `myr_product_language` VALUES ('5', '日本', 'ja', '5', '1');
INSERT INTO `myr_product_language` VALUES ('6', '西班牙', 'es', '1', '1');

-- ----------------------------
-- Table structure for myr_product_option
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_option`;
CREATE TABLE `myr_product_option` (
  `option_id` int(8) NOT NULL AUTO_INCREMENT,
  `product_id` int(8) NOT NULL,
  `type` smallint(5) NOT NULL,
  `is_require` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1为默认 必填  0不是必填',
  `sku` varchar(100) NOT NULL,
  `max_characters` smallint(5) NOT NULL,
  `sort_order` int(8) NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_option
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_option_price
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_option_price`;
CREATE TABLE `myr_product_option_price` (
  `option_price_id` int(8) NOT NULL AUTO_INCREMENT,
  `option_id` int(8) NOT NULL,
  `language_id` smallint(5) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认为0  普通价格类型   1为百分比类型',
  PRIMARY KEY (`option_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_option_price
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_option_title
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_option_title`;
CREATE TABLE `myr_product_option_title` (
  `option_title_id` int(8) NOT NULL AUTO_INCREMENT,
  `option_id` int(8) NOT NULL,
  `language_id` smallint(5) NOT NULL,
  `sort_order` int(8) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`option_title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_option_title
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_option_value
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_option_value`;
CREATE TABLE `myr_product_option_value` (
  `product_id` int(8) NOT NULL AUTO_INCREMENT,
  `option_id` int(8) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_option_value
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_sync_list
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_sync_list`;
CREATE TABLE `myr_product_sync_list` (
  `product_sync_list_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT '0',
  `product_sku` varchar(32) DEFAULT NULL,
  `website_id` int(11) DEFAULT '0',
  `website_name` varchar(64) DEFAULT NULL,
  `language_id` int(11) DEFAULT '1',
  `language_code` varchar(10) DEFAULT NULL,
  `product_category` text,
  `product_title` varchar(255) DEFAULT NULL,
  `product_description` text,
  `product_attribute` text,
  `product_meta_title` varchar(255) DEFAULT NULL,
  `product_meta_keyword` varchar(255) DEFAULT NULL,
  `product_meta_description` text,
  `product_purchase_price` float(11,4) DEFAULT '0.0000',
  `product_price` float(11,4) DEFAULT '0.0000',
  `product_weight` float(11,2) DEFAULT '0.00',
  `product_length` float(11,2) DEFAULT '0.00',
  `product_width` float(11,2) DEFAULT '0.00',
  `product_height` float(11,2) DEFAULT '0.00',
  `product_stock` int(11) DEFAULT '0',
  `product_status` tinyint(1) DEFAULT '0',
  `sync_status` tinyint(1) DEFAULT '0',
  `sync_status_remark` varchar(255) DEFAULT '待同步',
  `sync_response_remark` varchar(255) CHARACTER SET ucs2 DEFAULT NULL,
  `upd_date` int(10) NOT NULL DEFAULT '0',
  `add_date` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_sync_list_id`),
  UNIQUE KEY `sync_product_id` (`product_id`,`website_id`,`language_id`),
  KEY `sync_status` (`sync_status`)
) ENGINE=MyISAM AUTO_INCREMENT=11011 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_sync_list
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_text
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_text`;
CREATE TABLE `myr_product_text` (
  `value_id` int(8) NOT NULL AUTO_INCREMENT,
  `entity_type_id` smallint(5) NOT NULL,
  `attribute_id` int(8) NOT NULL,
  `language_id` smallint(5) NOT NULL,
  `product_id` int(8) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_text
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_varchar
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_varchar`;
CREATE TABLE `myr_product_varchar` (
  `value_id` int(8) NOT NULL AUTO_INCREMENT,
  `entity_type_id` smallint(5) NOT NULL,
  `attribute_id` int(8) NOT NULL,
  `language_id` smallint(5) NOT NULL,
  `product_id` int(8) DEFAULT NULL,
  `value` varchar(255) NOT NULL,
  `cat_id` int(8) DEFAULT NULL,
  PRIMARY KEY (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_varchar
-- ----------------------------

-- ----------------------------
-- Table structure for myr_product_website_category
-- ----------------------------
DROP TABLE IF EXISTS `myr_product_website_category`;
CREATE TABLE `myr_product_website_category` (
  `product_id` int(8) NOT NULL AUTO_INCREMENT,
  `website_id` smallint(5) NOT NULL,
  `category_id` int(8) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_product_website_category
-- ----------------------------

-- ----------------------------
-- Table structure for myr_p_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_p_order`;
CREATE TABLE `myr_p_order` (
  `order_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `supplier_id` smallint(5) NOT NULL,
  `pre_time` int(10) NOT NULL,
  `add_time` int(10) NOT NULL,
  `arrive_time` int(10) unsigned DEFAULT NULL,
  `operator_id` smallint(5) NOT NULL,
  `add_user` smallint(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_pay` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) NOT NULL,
  `shipping_fee` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`,`supplier_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_p_order
-- ----------------------------
INSERT INTO `myr_p_order` VALUES ('1', '15092162632', '4', '1442827481', '1442827481', '1442827512', '1', '1', '3', '0', '', '0.00');
INSERT INTO `myr_p_order` VALUES ('2', '15092185684', '4', '1442764800', '1442828127', '1442828172', '0', '1', '3', '0', '', '0.00');
INSERT INTO `myr_p_order` VALUES ('3', '15092276397', '5', '1442851200', '1442889482', '1442889767', '0', '1', '3', '0', '', '0.00');

-- ----------------------------
-- Table structure for myr_p_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_p_order_goods`;
CREATE TABLE `myr_p_order_goods` (
  `rec_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) NOT NULL,
  `goods_id` mediumint(8) NOT NULL,
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `goods_qty` smallint(5) unsigned NOT NULL DEFAULT '0',
  `arrival_qty` smallint(5) unsigned NOT NULL DEFAULT '0',
  `return_qty` smallint(5) unsigned NOT NULL DEFAULT '0',
  `remark` varchar(100) NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_p_order_goods
-- ----------------------------
INSERT INTO `myr_p_order_goods` VALUES ('1', '1', '99', '0.00', '7', '7', '0', '');
INSERT INTO `myr_p_order_goods` VALUES ('2', '2', '99', '10.00', '3', '3', '0', '');
INSERT INTO `myr_p_order_goods` VALUES ('3', '3', '178', '20.00', '200', '200', '0', '');
INSERT INTO `myr_p_order_goods` VALUES ('4', '3', '177', '10.00', '100', '100', '0', '');

-- ----------------------------
-- Table structure for myr_p_quote
-- ----------------------------
DROP TABLE IF EXISTS `myr_p_quote`;
CREATE TABLE `myr_p_quote` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `supplier` varchar(50) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `product` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `remark` varchar(200) NOT NULL,
  `operator` varchar(10) NOT NULL,
  `add_time` int(10) NOT NULL,
  `add_user` smallint(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier` (`supplier`,`product`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_p_quote
-- ----------------------------

-- ----------------------------
-- Table structure for myr_p_return
-- ----------------------------
DROP TABLE IF EXISTS `myr_p_return`;
CREATE TABLE `myr_p_return` (
  `order_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `supplier_id` smallint(5) NOT NULL,
  `add_time` int(10) NOT NULL,
  `operator_id` smallint(5) NOT NULL,
  `add_user` smallint(5) NOT NULL,
  `relate_order_sn` varchar(20) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`,`supplier_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_p_return
-- ----------------------------

-- ----------------------------
-- Table structure for myr_p_return_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_p_return_goods`;
CREATE TABLE `myr_p_return_goods` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_qty` smallint(5) unsigned NOT NULL,
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `remark` varchar(100) DEFAULT NULL,
  `is_ok` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`,`goods_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_p_return_goods
-- ----------------------------

-- ----------------------------
-- Table structure for myr_return
-- ----------------------------
DROP TABLE IF EXISTS `myr_return`;
CREATE TABLE `myr_return` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `return_sn` varchar(20) NOT NULL DEFAULT '0',
  `deal_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '处理时间',
  `rma_sn` varchar(20) NOT NULL DEFAULT '0',
  `order_sn` varchar(20) NOT NULL,
  `order_id` mediumint(8) unsigned NOT NULL,
  `new_order_sn` varchar(20) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_return
-- ----------------------------

-- ----------------------------
-- Table structure for myr_rf_order
-- ----------------------------
DROP TABLE IF EXISTS `myr_rf_order`;
CREATE TABLE `myr_rf_order` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `relate_order_sn` varchar(20) NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL,
  `paypalid` varchar(25) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `feeamt` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amt` decimal(10,2) NOT NULL DEFAULT '0.00',
  `comment` varchar(200) NOT NULL,
  `paid_time` int(10) unsigned NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `add_user` smallint(5) unsigned NOT NULL,
  `paid_money` decimal(10,2) DEFAULT NULL,
  `confirm_user` int(11) DEFAULT NULL,
  `confirm_time` int(10) DEFAULT NULL,
  `account_id` mediumint(8) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 未确认款项 1 已确认款项 2 已收/付款',
  PRIMARY KEY (`rec_id`),
  KEY `order_sn` (`order_sn`,`relate_order_sn`,`paypalid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_rf_order
-- ----------------------------

-- ----------------------------
-- Table structure for myr_rma
-- ----------------------------
DROP TABLE IF EXISTS `myr_rma`;
CREATE TABLE `myr_rma` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `rma_sn` varchar(20) NOT NULL DEFAULT '0',
  `rma_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `return_form` varchar(80) DEFAULT NULL,
  `tracking` varchar(50) DEFAULT NULL,
  `return_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '退货时间',
  `goods_sn` varchar(30) NOT NULL,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT '1',
  `reason` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `country` varchar(80) NOT NULL,
  `order_sn` varchar(20) NOT NULL,
  `new_order_sn` varchar(20) NOT NULL,
  `order_id` mediumint(8) unsigned NOT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT '退货明细',
  `admin_id` tinyint(3) unsigned NOT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `reason_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_rma
-- ----------------------------
INSERT INTO `myr_rma` VALUES ('24', '15092103533', '1', '', '', '1442764800', '62', '1', '0', 'Brasil', '092110002', '092110003', '2', '', '1', '1442826241', '2');

-- ----------------------------
-- Table structure for myr_role
-- ----------------------------
DROP TABLE IF EXISTS `myr_role`;
CREATE TABLE `myr_role` (
  `role_id` tinyint(2) unsigned NOT NULL,
  `action_list` text NOT NULL,
  `account_list` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_role
-- ----------------------------
INSERT INTO `myr_role` VALUES ('2', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,export_goods,export_listing,view_supplier,del_goods,goods_update,load_goods,clear_varstock,list_sku,list_goods_log,goods_attribute,edit_attribute,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,list_p_plan,import_supplier_goods,list_p_return,list_p_advice,audit_p_order,template_message,template_partner,template_order,template_goods', '');
INSERT INTO `myr_role` VALUES ('1', 'del_account,edit_account,list_user,edit_user,del_user,list_log,list_dd,edit_dd,del_dd,view_system,edit_system,list_express,edit_express,list_account,edit_currency,list_currency,sys_init,printlog,amazon_config,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,list_cn,list_us,list_au,list_uk,list_de,list_fr,view_cost,edit_cost,view_price1,edit_price1,view_price2,edit_price2,view_price3,edit_price3,list_sp,edit_stock,export_goods,export_listing,view_supplier,del_goods,goods_update,check_listing,clear_varstock,list_sku,list_goods_log,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_downsale,ali_good_upsale,load_goods,load_amzlisting,load_order,edit_orderstatus,add_order,edit_order,check_paypal,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,paypal_order,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,list_4px,eub1_order_handle,list_sfc,edit_comorder,list_ck1,list_icehkpost,order_shippinged,order_collation,Subhandle,import_shipworks,load_amzorder,list_supplier,edit_supplier,list_p_quote,list_p_order,add_p_order,edit_p_order,edit_supplier_goods,porder_import,import_supplier_goods,audit_p_order,list_p_plan,list_p_advice,goods_allocation,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,change_stock,list_shelf,order_revocation,list_rma,list_return,list_feedback,handle_message,load_message,list_case,load_case,edit_template,del_template,template_message,template_partner,template_order,template_goods,template_message,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '77');
INSERT INTO `myr_role` VALUES ('3', 'edit_account,list_user,list_log,list_dd,edit_dd,view_system,list_express,edit_express,edit_currency,list_currency,list_goods,list_category,import_goods,edit_category,add_goods,edit_goods,view_price,view_price1,view_price2,goods_update,check_listing,list_goods_log,goods_attribute,goods_attribute_set,edit_attribute,edit_attribute_set,list_Language,edit_language,ali_goods,load_aligood,ali_goods_imgbank,ali_good_downsale,ali_good_upsale,load_goods,load_order,edit_orderstatus,add_order,edit_order,order_mark,service_check,depot_check,order_handle,order_refund,order_cod,order_all,order_stockout,order_unlcok,order_ofs,order_import,order_update,export_order,del_order,order_pickup,eub_order_handle,auto_checkorder,order_complete,eub1_order_handle,edit_comorder,list_ck1,order_shippinged,order_collation,Subhandle,import_shipworks,list_unpaid,list_stock,list_rma,list_return,list_feedback,handle_message,load_message,list_case,load_case,edit_template,del_template,template_message,template_partner,template_message', '77');
INSERT INTO `myr_role` VALUES ('4', 'edit_account,list_user,list_log,list_account,list_stockin,add_stockin,edit_in_order,list_stockout,add_stockout,edit_out_order,stock_change,stockout_import,stockin_import,list_stock,stock_check,goods_allocation,edit_db_order,change_stock,list_shelf,allocation_import,order_revocation', '');
INSERT INTO `myr_role` VALUES ('5', 'edit_template,del_template,template_message,template_partner,list_fee,edit_fee,list_rf,edit_rf,list_gf,edit_gf,list_bank,list_banklog', '');

-- ----------------------------
-- Table structure for myr_sales
-- ----------------------------
DROP TABLE IF EXISTS `myr_sales`;
CREATE TABLE `myr_sales` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `rate` tinyint(3) unsigned NOT NULL,
  `code` varchar(5) NOT NULL,
  `start_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_sales
-- ----------------------------

-- ----------------------------
-- Table structure for myr_sales_channels_rate
-- ----------------------------
DROP TABLE IF EXISTS `myr_sales_channels_rate`;
CREATE TABLE `myr_sales_channels_rate` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `sales_channels` tinyint(2) unsigned NOT NULL,
  `rate` tinyint(2) unsigned NOT NULL,
  `fix` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_sales_channels_rate
-- ----------------------------
INSERT INTO `myr_sales_channels_rate` VALUES ('2', '1', '19', '0.30');

-- ----------------------------
-- Table structure for myr_sales_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_sales_goods`;
CREATE TABLE `myr_sales_goods` (
  `rec_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `id` tinyint(3) NOT NULL,
  `sku` varchar(20) NOT NULL,
  `cost` decimal(6,2) unsigned NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_sales_goods
-- ----------------------------
INSERT INTO `myr_sales_goods` VALUES ('2', '1', 'J0149', '5.00');

-- ----------------------------
-- Table structure for myr_shipping_area
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_area`;
CREATE TABLE `myr_shipping_area` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `area` varchar(20) NOT NULL,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `area` (`area`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_area
-- ----------------------------

-- ----------------------------
-- Table structure for myr_shipping_cost
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_cost`;
CREATE TABLE `myr_shipping_cost` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `express_id` tinyint(3) unsigned NOT NULL,
  `value` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `express_id` (`express_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_cost
-- ----------------------------

-- ----------------------------
-- Table structure for myr_shipping_depot
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_depot`;
CREATE TABLE `myr_shipping_depot` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `shipping_id` tinyint(3) NOT NULL,
  `depot_id` tinyint(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shipping_id` (`shipping_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_depot
-- ----------------------------
INSERT INTO `myr_shipping_depot` VALUES ('1', '1', '0');
INSERT INTO `myr_shipping_depot` VALUES ('2', '2', '2');
INSERT INTO `myr_shipping_depot` VALUES ('3', '0', '0');
INSERT INTO `myr_shipping_depot` VALUES ('4', '3', '2');

-- ----------------------------
-- Table structure for myr_shipping_mark
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_mark`;
CREATE TABLE `myr_shipping_mark` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `express_id` tinyint(3) unsigned NOT NULL,
  `value` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `express_id` (`express_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_mark
-- ----------------------------

-- ----------------------------
-- Table structure for myr_shipping_ntmark
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_ntmark`;
CREATE TABLE `myr_shipping_ntmark` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `express_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `express_id` (`express_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_ntmark
-- ----------------------------

-- ----------------------------
-- Table structure for myr_shipping_unmark
-- ----------------------------
DROP TABLE IF EXISTS `myr_shipping_unmark`;
CREATE TABLE `myr_shipping_unmark` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `express_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `express_id` (`express_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_shipping_unmark
-- ----------------------------

-- ----------------------------
-- Table structure for myr_sourcinge_sp_cate
-- ----------------------------
DROP TABLE IF EXISTS `myr_sourcinge_sp_cate`;
CREATE TABLE `myr_sourcinge_sp_cate` (
  `id` int(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(8) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of myr_sourcinge_sp_cate
-- ----------------------------

-- ----------------------------
-- Table structure for myr_statistics_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_statistics_log`;
CREATE TABLE `myr_statistics_log` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `start` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `timetype` tinyint(1) unsigned NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `Sales_account_id` tinyint(3) unsigned NOT NULL,
  `Sales_channels` tinyint(3) unsigned NOT NULL,
  `is_before` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `from` (`start`,`end`,`type`,`timetype`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_statistics_log
-- ----------------------------

-- ----------------------------
-- Table structure for myr_statistics_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_statistics_order_goods`;
CREATE TABLE `myr_statistics_order_goods` (
  `goods_sn` varchar(30) NOT NULL,
  `goods_name` varchar(30) NOT NULL,
  `cost` decimal(10,2) unsigned NOT NULL,
  `shipping_fee` decimal(10,2) unsigned NOT NULL,
  `package_fee` decimal(10,2) unsigned NOT NULL,
  `fix_price` decimal(10,2) unsigned NOT NULL,
  `avrprice` decimal(10,2) unsigned NOT NULL,
  `total_qty` mediumint(8) unsigned NOT NULL,
  `amount` decimal(10,2) unsigned NOT NULL,
  `shippingcost` decimal(10,2) NOT NULL,
  `interest` tinyint(3) NOT NULL,
  `status` varchar(30) NOT NULL,
  `valid_qty` smallint(5) NOT NULL,
  `onarrive_qty` smallint(5) NOT NULL,
  `want_qty` smallint(5) unsigned NOT NULL,
  `admin_id` tinyint(3) unsigned NOT NULL,
  `grade` varchar(1) NOT NULL DEFAULT 'G',
  UNIQUE KEY `goods_sn` (`goods_sn`,`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_statistics_order_goods
-- ----------------------------
INSERT INTO `myr_statistics_order_goods` VALUES ('', 'Luxury White Crystal Glass Swi', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '61.38', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('10100035', 'free shipping 360 degree ceili', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '1109.06', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('DCT1810H01SUB', '', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '47.00', '13.45', '0', '', '0', '0', '0', '1', '');
INSERT INTO `myr_statistics_order_goods` VALUES ('DCZ1830W30000', 'universal travel plug ac adapt', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '170.00', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('DCZ1850W42USB', '110V 220V Universal World Wide', '0.00', '0.00', '0.00', '0.00', '0.00', '7', '425.20', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0103H00000', 'mini 12v pir infrared motion s', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '184.51', '12.83', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0103H0000L', 'passive infrared motion sensor', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '201.50', '15.07', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0123S00000', 'Newest automatic waving infrar', '0.00', '0.00', '0.00', '0.00', '0.00', '11', '4410.56', '24.06', '0', 'Normal', '0', '1000', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0172W00000', 'Cheap AC100-250V Infrared Save', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '1376.40', '16.77', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0202W00220', 'High quality Newest design Out', '0.00', '0.00', '0.00', '0.00', '0.00', '6', '1361.52', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0312W0B000', 'Free shipping 9m PIR Infrared ', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '248.00', '16.77', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0392W/T/H00000', '', '0.00', '0.00', '0.00', '0.00', '0.00', '8', '1796.76', '78.37', '0', '', '0', '0', '0', '1', '');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0392W00000', '220V automatic turn off  wall ', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '932.98', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG0412W00000', 'Discount outdoor motion detect', '0.00', '0.00', '0.00', '0.00', '0.00', '30', '4181.59', '655.28', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG3002W00000', 'Free shipping Light control se', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '1190.40', '18.35', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('GKG3022W00000', 'Free shipping Auto Induction L', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '122.64', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HDT0282W0000', '', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '43.52', '0.00', '0', '', '0', '0', '0', '1', '');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD0912W00000', 'AC220 V 8W white light pir mot', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '117.06', '33.17', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1222W06Wcw', 'Free shipping 6w E27  LED  mot', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '75.95', '15.07', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1232W07Wcw', 'E27 high quality 110V/220V mot', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '294.50', '27.96', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD137500wW00', 'Newest Super-fine quality body', '0.00', '0.00', '0.00', '0.00', '0.00', '5', '217.00', '94.30', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1375J0CW00', 'Newest  hot sale Super-fine qu', '0.00', '0.00', '0.00', '0.00', '0.00', '3', '303.92', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1375J0wW00', 'Newest Super-fine quality body', '0.00', '0.00', '0.00', '0.00', '0.00', '16', '694.40', '366.61', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1375S0CW00', 'Newest  hot sale Super-fine qu', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '52.39', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1375S0wW00', 'Newest Super-fine quality body', '0.00', '0.00', '0.00', '0.00', '0.00', '14', '607.60', '329.16', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('HGD1375W0wW00', 'Newest Super-fine quality body', '0.00', '0.00', '0.00', '0.00', '0.00', '22', '1050.59', '443.36', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('JSQ0044WE0000', 'High quality Ultrasonic Aroma ', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '257.92', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('JSQ0115BS0000', '2014 New arrived cartoon  Mini', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '111.17', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('LYX1455H0000/LYX1455', 'HOT SALE Wireless Bluetooth re', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '80.60', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('PML0K11WAK000', 'Home Security Alarm motion sen', '0.00', '0.00', '0.00', '0.00', '0.00', '4', '520.80', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('PYX1345H0000', 'Free Shipping 2013 Newest Wire', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '178.31', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('WKG0292W0A00', 'high sensitivity Microwave det', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '279.99', '9.18', '0', 'Normal', '0', '0', '0', '1', 'A');
INSERT INTO `myr_statistics_order_goods` VALUES ('WKG0292W0B000', 'Free shipping 360 degree 220V/', '0.00', '0.00', '0.00', '0.00', '0.00', '2', '180.79', '0.00', '0', 'Normal', '0', '0', '0', '1', 'A');

-- ----------------------------
-- Table structure for myr_statistics_order_goods_log
-- ----------------------------
DROP TABLE IF EXISTS `myr_statistics_order_goods_log`;
CREATE TABLE `myr_statistics_order_goods_log` (
  `admin_id` tinyint(3) unsigned NOT NULL,
  `starttime` varchar(20) NOT NULL,
  `totime` varchar(20) NOT NULL,
  `Sales_account_id` tinyint(3) unsigned NOT NULL,
  `timetype` tinyint(1) unsigned NOT NULL,
  UNIQUE KEY `admin_id` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_statistics_order_goods_log
-- ----------------------------
INSERT INTO `myr_statistics_order_goods_log` VALUES ('1', '2014-05-28', '2014-06-03', '0', '1');

-- ----------------------------
-- Table structure for myr_stockin
-- ----------------------------
DROP TABLE IF EXISTS `myr_stockin`;
CREATE TABLE `myr_stockin` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `out_time` int(10) unsigned DEFAULT NULL,
  `operator_id` tinyint(3) unsigned NOT NULL,
  `stockin_type` tinyint(1) unsigned NOT NULL,
  `depot_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `add_user` tinyint(3) unsigned NOT NULL,
  `comment` varchar(100) NOT NULL,
  `supplier` varchar(50) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_stockin
-- ----------------------------
INSERT INTO `myr_stockin` VALUES ('96', '15092133543', '1442827504', '1442827512', '1', '1', '0', '1', '1', '', '4');
INSERT INTO `myr_stockin` VALUES ('97', '15092187675', '1442828151', '1442828172', '1', '1', '0', '1', '1', '', '4');
INSERT INTO `myr_stockin` VALUES ('98', '15092155740', '1442831372', null, '3', '0', '0', '0', '3', '导入数据', '');
INSERT INTO `myr_stockin` VALUES ('99', '15092195441', '1442836915', '1443059992', '3', '0', '0', '1', '3', '导入数据', '');
INSERT INTO `myr_stockin` VALUES ('100', '15092289731', '1442889577', '1442889670', '1', '1', '0', '1', '1', '', '5');
INSERT INTO `myr_stockin` VALUES ('101', '15092293538', '1442889736', '1442889767', '1', '1', '0', '1', '1', '', '5');
INSERT INTO `myr_stockin` VALUES ('102', '15092480906', '1443076515', null, '13', '1', '0', '0', '13', '', '');

-- ----------------------------
-- Table structure for myr_stockin_detail
-- ----------------------------
DROP TABLE IF EXISTS `myr_stockin_detail`;
CREATE TABLE `myr_stockin_detail` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_qty` smallint(5) unsigned NOT NULL,
  `goods_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `remark` varchar(100) DEFAULT NULL,
  `relate_order_sn` varchar(20) DEFAULT NULL,
  `is_ok` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`,`goods_id`),
  KEY `relate_order_id` (`relate_order_sn`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_stockin_detail
-- ----------------------------
INSERT INTO `myr_stockin_detail` VALUES ('109', '96', '99', '7', '0.00', '', 'PO15092162632', '1');
INSERT INTO `myr_stockin_detail` VALUES ('110', '97', '99', '3', '10.00', '', 'PO15092185684', '1');
INSERT INTO `myr_stockin_detail` VALUES ('111', '98', '140', '238', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('112', '98', '141', '185', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('113', '98', '142', '597', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('114', '98', '143', '474', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('115', '98', '144', '1', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('116', '98', '145', '25', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('117', '98', '146', '672', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('118', '98', '147', '56', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('119', '98', '148', '0', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('120', '98', '149', '350', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('121', '98', '150', '395', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('122', '98', '151', '105', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('123', '98', '152', '113', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('124', '98', '153', '103', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('125', '98', '154', '46', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('126', '98', '155', '291', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('127', '98', '156', '297', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('128', '98', '157', '240', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('129', '98', '158', '240', '0.00', 'import', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('130', '99', '140', '238', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('131', '99', '141', '185', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('132', '99', '142', '597', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('133', '99', '143', '474', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('134', '99', '144', '1', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('135', '99', '145', '25', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('136', '99', '146', '672', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('137', '99', '147', '56', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('138', '99', '148', '0', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('139', '99', '149', '350', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('140', '99', '150', '395', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('141', '99', '151', '105', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('142', '99', '152', '113', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('143', '99', '153', '103', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('144', '99', '154', '46', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('145', '99', '155', '291', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('146', '99', '156', '297', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('147', '99', '157', '240', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('148', '99', '158', '240', '0.00', 'import', '', '1');
INSERT INTO `myr_stockin_detail` VALUES ('149', '100', '178', '100', '20.00', '', 'PO15092276397', '1');
INSERT INTO `myr_stockin_detail` VALUES ('150', '100', '177', '80', '10.00', '', 'PO15092276397', '1');
INSERT INTO `myr_stockin_detail` VALUES ('151', '101', '178', '100', '20.00', '', 'PO15092276397', '1');
INSERT INTO `myr_stockin_detail` VALUES ('152', '101', '177', '20', '10.00', '', 'PO15092276397', '1');
INSERT INTO `myr_stockin_detail` VALUES ('153', '102', '174', '1111', '1.00', '', '', '0');
INSERT INTO `myr_stockin_detail` VALUES ('154', '102', '179', '1111', '1.00', '', '', '0');

-- ----------------------------
-- Table structure for myr_stockout
-- ----------------------------
DROP TABLE IF EXISTS `myr_stockout`;
CREATE TABLE `myr_stockout` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL,
  `add_time` int(10) unsigned NOT NULL,
  `operator_id` tinyint(3) unsigned NOT NULL,
  `stockout_type` tinyint(1) unsigned NOT NULL,
  `depot_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `add_user` tinyint(3) unsigned NOT NULL,
  `out_time` int(10) unsigned DEFAULT NULL,
  `comment` varchar(100) NOT NULL,
  `supplier` varchar(50) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_sn` (`order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_stockout
-- ----------------------------
INSERT INTO `myr_stockout` VALUES ('61', '15092137898', '1442824995', '1', '1', '11', '1', '1', '1442824995', 'test账号2015-09-21销售出库', '');
INSERT INTO `myr_stockout` VALUES ('62', '15092224116', '1442892118', '1', '1', '0', '1', '1', '1442892118', 'admin账号2015-09-22销售出库', '');
INSERT INTO `myr_stockout` VALUES ('63', '15092466973', '1443076627', '13', '1', '0', '0', '13', '0', '', '10');

-- ----------------------------
-- Table structure for myr_stockout_detail
-- ----------------------------
DROP TABLE IF EXISTS `myr_stockout_detail`;
CREATE TABLE `myr_stockout_detail` (
  `rec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL,
  `goods_id` mediumint(8) unsigned NOT NULL,
  `goods_qty` smallint(5) unsigned NOT NULL,
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `remark` varchar(100) NOT NULL,
  `relate_order_sn` varchar(20) DEFAULT NULL,
  `is_ok` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rec_id`),
  KEY `order_id` (`order_id`,`goods_id`),
  KEY `relate_order_id` (`relate_order_sn`)
) ENGINE=MyISAM AUTO_INCREMENT=12808 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_stockout_detail
-- ----------------------------
INSERT INTO `myr_stockout_detail` VALUES ('12802', '61', '1', '1', '0.00', '', 'QSD092110002', '0');
INSERT INTO `myr_stockout_detail` VALUES ('12803', '62', '177', '10', '10.00', '', 'QSD092210001', '0');
INSERT INTO `myr_stockout_detail` VALUES ('12804', '62', '178', '5', '20.00', '', 'QSD092210001', '0');
INSERT INTO `myr_stockout_detail` VALUES ('12805', '62', '178', '5', '20.00', '', 'QSD092210002', '0');
INSERT INTO `myr_stockout_detail` VALUES ('12806', '62', '177', '10', '10.00', '', 'QSD092210003', '0');
INSERT INTO `myr_stockout_detail` VALUES ('12807', '63', '179', '6', '0.00', '', '', '0');

-- ----------------------------
-- Table structure for myr_stockout_tmp
-- ----------------------------
DROP TABLE IF EXISTS `myr_stockout_tmp`;
CREATE TABLE `myr_stockout_tmp` (
  `orderstr` text NOT NULL,
  `user` tinyint(3) unsigned NOT NULL,
  `depot_id` tinyint(3) NOT NULL DEFAULT '0',
  UNIQUE KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_stockout_tmp
-- ----------------------------

-- ----------------------------
-- Table structure for myr_supplier
-- ----------------------------
DROP TABLE IF EXISTS `myr_supplier`;
CREATE TABLE `myr_supplier` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sn` varchar(15) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `zip` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `skype` varchar(50) NOT NULL,
  `qq` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `add_time` int(10) NOT NULL,
  `period` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `user_id` int(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sn` (`sn`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_supplier
-- ----------------------------
INSERT INTO `myr_supplier` VALUES ('4', '深圳市科极达盛投资有限公司', 'KJDS', 'mark', '', '13695877896', '', '', '', '0', '', '1442824779', '0', '0');
INSERT INTO `myr_supplier` VALUES ('5', '美宝莲', 'MBL', '王生', '', '000000', '', '', '', '0', '', '1442889300', '0', '0');
INSERT INTO `myr_supplier` VALUES ('6', '美国联邦调查局', 'FBI', '奥巴马', '华盛顿特区西北区宾夕法尼亚大道935号', '911', '20509-935', 'michael.willburn@ic.fbi.gov', '', '0', '', '1442902352', '0', '0');

-- ----------------------------
-- Table structure for myr_supplier_goods
-- ----------------------------
DROP TABLE IF EXISTS `myr_supplier_goods`;
CREATE TABLE `myr_supplier_goods` (
  `rec_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) NOT NULL,
  `supplier_goods_sn` varchar(20) NOT NULL,
  `supplier_goods_name` varchar(60) NOT NULL,
  `supplier_goods_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `supplier_goods_remark` varchar(50) NOT NULL,
  `supplier_id` smallint(5) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`rec_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_supplier_goods
-- ----------------------------
INSERT INTO `myr_supplier_goods` VALUES ('14', '98', '31231131', 'Fashion jewelry J0003#6', '0.00', '', '4', '');
INSERT INTO `myr_supplier_goods` VALUES ('15', '85', '11313131', 'Fashion jewelry J0003#6', '0.00', '', '4', '');
INSERT INTO `myr_supplier_goods` VALUES ('16', '94', '11313131', 'Fashion jewelry J0003#6', '0.00', '', '4', '');
INSERT INTO `myr_supplier_goods` VALUES ('17', '99', '61', 'Fashion jewelry J0003#6', '0.00', '', '4', '');
INSERT INTO `myr_supplier_goods` VALUES ('18', '178', '9020', '口红 玫瑰色20', '20.00', '', '5', '');
INSERT INTO `myr_supplier_goods` VALUES ('19', '177', '9019', '口红 玫瑰色19', '10.00', '', '5', '');
INSERT INTO `myr_supplier_goods` VALUES ('20', '138', '123456789', '雅培1段奶粉/964g', '0.00', '', '6', '');

-- ----------------------------
-- Table structure for myr_template
-- ----------------------------
DROP TABLE IF EXISTS `myr_template`;
CREATE TABLE `myr_template` (
  `rec_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` tinyint(3) unsigned NOT NULL,
  `temp_name` varchar(30) NOT NULL,
  `temp_content` text NOT NULL,
  `temp_sn` int(11) DEFAULT '0',
  PRIMARY KEY (`rec_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_template
-- ----------------------------
INSERT INTO `myr_template` VALUES ('1', '1', 'test', 'dear {BUYERID}\nI\'d like to tell you ***\n111', '0');
INSERT INTO `myr_template` VALUES ('5', '2', 'send1', 'Dear {BUYERID}:\nYou bougt {ITEMNOLIST} From US.\nBut {OFSITEMNOLIST} out for stock.\n\n{SELLERID}', '0');

-- ----------------------------
-- Table structure for myr_trackinfo
-- ----------------------------
DROP TABLE IF EXISTS `myr_trackinfo`;
CREATE TABLE `myr_trackinfo` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) NOT NULL,
  `text` text NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_trackinfo
-- ----------------------------

-- ----------------------------
-- Table structure for myr_trackinfo_copy
-- ----------------------------
DROP TABLE IF EXISTS `myr_trackinfo_copy`;
CREATE TABLE `myr_trackinfo_copy` (
  `order_id` mediumint(8) unsigned NOT NULL,
  `text` text NOT NULL,
  `status` varchar(30) NOT NULL,
  `update_time` date NOT NULL,
  `last_info` varchar(255) DEFAULT NULL,
  KEY `order_id` (`order_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myr_trackinfo_copy
-- ----------------------------
