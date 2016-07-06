<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015   
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+

/**
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */

class Attribute extends Controller  {

	/**
	 * 初始化页面信息
	 */
	public function __construct()
	{
		parent::__construct();
		$this->title .= 'Attribute';
		$this->dir = 'goods';
	}
	/**
	 * 属性管理 默认页面
	 *
	 */
	public function actionIndex()
	{
		parent::actionPrivilege('goods_attribute');
		$option_type_arr = ModelDd::getArray('attribute_option_type');
		$this->tpl->assign('attribute_option_type',ModelDd::arrayFormat($option_type_arr));
		$language_arr = ModelDd::getArray('languages');
		$this->tpl->assign('languages',ModelDd::arrayFormat($language_arr));
		$option = array();
		$tag = array();
		foreach($language_arr as $key => $value){
			if($key == 1) $option[$key] = 'value';
			else $option[$key] = $key.'_value';
			$tag[$key] = $key.'_tag';
		}
		$this->tpl->assign('option',ModelDd::arrayFormat($option));
		$this->tpl->assign('tag',ModelDd::arrayFormat($tag));
		$this->name = 'attribute';
		$this->show();
	}
	/**
	 * 获取属性Json列表
	 */
	public function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelAttribute();
		$where = $object->getlistwhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 获取属性值Json列表
	 */
	public function actiongetValueList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelAttribute();
		$where = $object->getvaluewhere($_REQUEST);
		$list = $object->getValueList($pageLimit['from'],$pageLimit['to'],$where,$_REQUEST['entity_type_id']);
		$result['totalCount'] = $object->getValueCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 保存属性
	 */
	function actionUpdate() {
		if(parent::actionCheck('edit_attribute')) {
			$object = new ModelAttribute();
			try {
					$object->save($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}

	/**
	 * 删除属性
	 *
	 */
	function actionDelete()
	{
		if(parent::actionCheck('edit_attribute')) {
			$object = new ModelAttribute();
			$object->delattribute($_GET['ids']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**
	 * 保存属性值
	 */
	function actionValueupdate(){
		if(parent::actionCheck('edit_attribute')) {
			$object = new ModelAttribute();
			try {
					$object->saveattrvalue($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删除属性值
	 *
	 */
	function actionvalueDelete()
	{
		if(parent::actionCheck('edit_attribute')) {
			$object = new ModelAttribute();
			$object->delattributevalue($_GET['id']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**
	 * 清空属性值
	 *
	 */
	function actionvalueClear()
	{
		if(parent::actionCheck('edit_attribute')) {
			$object = new ModelAttribute();
			$object->clearattributevalue($_REQUEST['id']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**
	 * 保存属性值
	 */
	function actionsaveAttrValue() {
		if(parent::actionCheck('edit_attribute')) {
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			$attrsarr = $json->decode(stripslashes($_POST['data']));
			$language_arr = ModelDd::getArray('languages');
			$object = new ModelAttribute();
			try {
				foreach($attrsarr as $key => $attr ){
					$object->saveparent($attr->value_id,$attr->value);
					$object->saveson($attr->value_id,$attr->{'2_value'},2);
					$object->saveson($attr->value_id,$attr->{'3_value'},3);
					$object->saveson($attr->value_id,$attr->{'4_value'},4);
					$object->saveson($attr->value_id,$attr->{'5_value'},5);
					$object->saveson($attr->value_id,$attr->{'6_value'},6);
					$object->saveson($attr->value_id,$attr->{'7_value'},7);
					$object->saveson($attr->value_id,$attr->{'8_value'},8);
					$object->saveson($attr->value_id,$attr->{'9_value'},9);
					$object->saveson($attr->value_id,$attr->{'10_value'},10);
				}
				echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
				}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 属性标签翻译
	 */
	function actiontranslateword(){
		$object = new ModelAttribute();
		$language = new ModelLanguage();
		$language_arr = ModelDd::getArray('languages');
		$str = '';
		$translates = array();
		foreach($language_arr as $key => $attr ){
			$code = $language->getLanguageCode($key);
			$translates[$key] = utf8_encode(html_entity_decode($object->translateattr($_REQUEST['value_cn'],'zh-CN|'.$code)));
		}
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($translates);
	}
	/**
	 * 属性组
	 */
	function actionAttributeGroup(){
		$this->name='attriburegroup';
		$this->show();
	}
	/**
	 * 获取属性Json列表
	 */
	public function actiongroupList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelAttribute();
		$list = $object->getGroupList($pageLimit['from'],$pageLimit['to']/*,$where*/);
		$result['totalCount'] = $object->getGroupCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 编辑属性组属性
	 */
	function actionedit(){
		parent::actionPrivilege('edit_attribute_set');
		$arr = explode(',',$_GET['id']);
		$object = new ModelAttribute();
		$this->tpl->assign('group_id', $_GET['group_id']);
		$this->tpl->assign('id',$_GET['id']);
		$this->tpl->assign('privlist', $object->getGroupAttr($arr));
		$this->tpl->assign('sort_order', $object->getAttrSort($_GET['group_id']));
		$this->name = 'editgroup';
		$this->show();
	}
	/**
	 * 保存属性组属性
	 */
	function actionsavegroupattr(){
		if(parent::actionCheck('edit_attribute_set')) {
			$object = new ModelAttribute();
			try {
					$object->savegroupattr($_POST);
					echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 删除属性组
	 *
	 */
	function actionGroupDelete()
	{
		if(parent::actionCheck('edit_attribute_set')) {
			$object = new ModelAttribute();
			$object->delGroup($_GET['ids']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	/**
	 * 保存属性组
	 */
	function actionGroupUpdate(){
		if(parent::actionCheck('edit_attribute_set')) {
			$object = new ModelAttribute();
			try {
					$object->saveGroup($_POST);
					echo "{success:true,msg:'OK'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 设置默认属性值
	 */
	function actionSetDefault(){
		//echo "{success:true,msg:'" . $_REQUEST['value_id'] . "'}";exit;
		$object = new ModelAttribute();
		//到这里的只能是 单选、下拉、复选  attribute_option_value
		try {
				$object->saveDefault($_REQUEST);
				echo "{success:true,msg:'操作已成功'}";exit;
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 获取属性
	 *
	 * @param int 分类id
	 */
	function actionshowAttribute(){
		$object = new ModelAttribute();
		try {
				$result = $object->getCatGroupAttr($_REQUEST['id'],$_REQUEST['language_id']);
				/*echo '<pre>';
				var_dump($result);
				echo '</pre>';exit();*/
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				echo $json->encode($result);exit();
		} catch (Exception $e) {
				$errorMsg = $e->getMessage();
		}
		echo "{success:false,msg:'" . $errorMsg . "'}";exit;
	}
	/**
	 * 获取产品自动描述
	 *
	 * @param int 分类id
	 */
	function actiongetAttributeField(){
		$object = new ModelAttribute();
		try{
				$arr = explode(',',$_REQUEST['id']);
				$result= $object->getAttributeFieldByID($arr);
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				echo $json->encode($result);
			}catch (Exception $e){
				$msg = $e->getMessage();
				echo "{success:false,msg:'$msg'}";exit;
			}
	}
}
?>