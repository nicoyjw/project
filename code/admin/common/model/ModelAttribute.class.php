<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 产品属性类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelAttribute extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'product_attribute';
		$this->GrouptbName = CFG_DB_PREFIX . 'attribute_group';
		$this->primaryKey = 'attribute_id';
	}
	/**
	 * 属性查询条件
	 *
	 * @param array $info
	 */
	function getlistwhere($info){
		specConvert($info,array('keyword','entity_type_id','is_required','is_unique','is_update_notice'));
		$wheres = array();
		if (isset($info['keyword']) && !empty($info['keyword'])) {
			$wheres[] = 'attribute_code like \'%'.$info['keyword'].'%\' or attribute_label like \'%'.$info['keyword'].'%\'';
		}
		if (isset($info['entity_type_id']) && $info['entity_type_id'] > 0) {
			$wheres[] =  'entity_type_id ='.$info['entity_type_id'];
		}
		if (isset($info['is_required'])  && $info['is_required'] >= 0) {
			$wheres[] = ($info['is_required'] == 0) ? 'is_required = 0' :  'is_required = 0';
		}
		if (isset($info['is_unique']) && $info['is_unique'] >= 0) {
			$wheres[] = ($info['is_unique'] == 0) ? 'is_unique = 0' : 'is_unique = 1';
		}
		if (isset($info['is_update_notice']) && $info['is_update_notice'] >= 0) {
			$wheres[] = ($info['is_update_notice'] == 0) ? 'is_update_notice = 0' : 'is_update_notice = 1';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	 * 属性总数
	 *
	 * @param string $where
	 */
	function getCount($where=NULL){
		return $this->db->getValue('select count(*) from '.$this->tableName.$where);
	}
	function getList($from,$to,$where=NULL){
		$this->db->open('select * from '.$this->tableName.$where,$from,$to);
		$result = array();
		$language_arr = ModelDd::getArray('languages');
		$type = ModelDd::getArray('attribute_option_type');
		while ($rs = $this->db->next()) {
			$rs['type_name'] = $type[$rs['entity_type_id']];
			foreach($language_arr as $key => $value){
				$othertag = $this->getOtherLanguageTag($rs['attribute_id'],$key);
				$rs[$key.'_tag'] = ($othertag) ? $othertag : '';
			}
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 属性值查询条件
	 *
	 * @param array $info
	 */
	function getvaluewhere($info){
		specConvert($info,array('keyword','attribute_id'));
		$wheres = array();
		if (isset($info['attribute_id']) && !$info['attribute_id'] == '') {
			$option_id = $this->db->getValue('select option_id from myr_attribute_option where attribute_id='.$info['attribute_id']);
			$wheres[] = ($info['attribute_id']) ? 'aov.option_id =  '.$option_id : '';
		}
		if ($info['keyword']) {
			
			$wheres[] = ($info['keyword']) ? 'value like \'%'.$info['keyword'].'%\'' : '';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/*
	 * 属性标签类型3:单选、、4:复选、5:下拉  返回标签选项值 
	 * 1:文本 、2:多行文本 、 6:价格 、 7:时间日期 、 8:是否 值都为NULL
	 */
	function getValueList($from,$to,$where=NULL,$id){
		$this->db->open('SELECT aov.*,ao.attribute_id FROM '. CFG_DB_PREFIX .'attribute_option_value as aov left join '. CFG_DB_PREFIX .'attribute_option as ao on aov.option_id = ao.option_id '.$where.' and language_id = 1 order by value_id desc',$from,$to);
		$result = array();
		$language_arr = ModelDd::getArray('languages');
		while ($rs = $this->db->next()) {
			foreach($language_arr as $key => $value){
				$othervalue = $this->getOtherLanguageValue($rs['value_id'],$key);
				if($key !== 1) $rs[$key.'_value'] = ($othervalue) ? $othervalue : '';
			}
			$result[] = $rs;
		}
		return $result;
	}
	function getValueCount($where){
		return $this->db->getValue('SELECT count(*) from '. CFG_DB_PREFIX .'attribute_option_value as aov '.$where.' and language_id = 1');
	}
	function getOtherLanguageValue($id,$language){
		return $this->db->getValue('select value from '. CFG_DB_PREFIX .'attribute_option_value where parent_value_id ='.$id.'  and language_id = '.$language);
	}
	function getOtherLanguageTag($id,$language){
		return $this->db->getValue('select value from '. CFG_DB_PREFIX .'attribute_tag where attribute_id ='.$id.'  and language_id = '.$language);
	}
	/**
	 * 保存/更新属性
	 *
	 * @param array $info
	 */
	public function save($info)
	{
		if (!$info['attribute_id']) {
			$this->db->insert($this->tableName,array(
				'entity_type_id' => $info['entity_type_id'],
				'attribute_code' => $info['attribute_code'],
				'attribute_label' => $info['1_tag'], //默认为多语言中文标签
				'is_required' => $info['is_required'],
				'is_unique' => $info['is_unique'],
				'is_update_notice' => $info['is_update_notice'],
				'note' => $info['note']
			));
			$id = $this->db->getInsertId();
			$languages = ModelDd::getArray('languages');
			foreach($languages as $key => $value){
				$this->db->insert(CFG_DB_PREFIX .'attribute_tag',array(
					'language_id' => $key,
					'attribute_id' => $id,
					'value' => $info[$key.'_tag']
				));
			}
			$this->db->insert(CFG_DB_PREFIX .'attribute_option',array(
				'attribute_id' => $id,
				'sort_order' => $this->db->getValue('select MAX(sort_order) from '. CFG_DB_PREFIX .'attribute_option')+1
			));
		} else {
			$this->db->update($this->tableName,array(
				'entity_type_id' => $info['entity_type_id'],
				'attribute_code' => $info['attribute_code'],
				'attribute_label' => $info['1_tag'], //默认为多语言中文标签
				'is_required' => $info['is_required'],
				'is_unique' => $info['is_unique'],
				'is_update_notice' => $info['is_update_notice'],
				'note' => $info['note']
			),'attribute_id='.intval($info['attribute_id']));
			$languages = ModelDd::getArray('languages');
			foreach($languages as $key => $value){
				$result = $this->db->getValue('select count(*) from '. CFG_DB_PREFIX .'attribute_tag where attribute_id='.intval($info['attribute_id']).' and language_id = '.$key);
				if(!$result){
					$this->db->insert(CFG_DB_PREFIX .'attribute_tag',array(
						'language_id' => $key,
						'attribute_id' => $info['attribute_id'],
						'value' => $info[$key.'_tag']
					));
				}
				$this->db->update(CFG_DB_PREFIX .'attribute_tag',array(
					'value' => $info[$key.'_tag']
				),'attribute_id='.intval($info['attribute_id']).' and language_id='.$key);
			}
			savelog($info['attribute_id'],'attribute','编辑属性',$_SESSION['admin_id']);
		}
	}
	/**
	 * 删除属性
	 *
	 * @param int $id
	 */
	function delattribute($id){
		savelog($id,'attribute','属性被删除',$_SESSION['admin_id']);
		$this->db->execute('delete from '.$this->tableName
.' where attribute_id = '.$id);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_tag where attribute_id = '.$id);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_option_value where option_id = '.$this->getOptionID($id));
		return $this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_option where attribute_id = '.$id);	
	}
	/**
	 * 根据属性ID获取OptionID
	 *
	 * @param int $id
	 */
	function getOptionID($id){
		return $this->db->getValue('select option_id from '. CFG_DB_PREFIX .'attribute_option where attribute_id ='.$id);
	}
	/**
	 * 根据OptionID获取属性ID
	 *
	 * @param int $id
	 */
	function getAttributeID($id){
		return $this->db->getValue('select attribute_id from '. CFG_DB_PREFIX .'attribute_option where option_id ='.$id);
	}
	/**
	 * 保存属性值
	 *
	 * @param array $info
	 */
	function saveattrvalue($info){
		$id = $info['attribute_id'];
		unset($info['attribute_id']);
		$option_id = $this->getOptionID($id);
		$parent_id = '';
		foreach($info as $key => $value){
			$newKey = explode('_',$key);
			$newKey = intval($newKey[0]);
			try {
				$this->db->insert(CFG_DB_PREFIX .'attribute_option_value',array(
					'language_id' => $newKey,
					'option_id' => $option_id,
					'value' => $value,
					'parent_value_id' => ($newKey == 1) ? 0 : $parent_id
				));
				if($newKey == 1) $parent_id = $this->db->getInsertId();
			} catch (Exception $e) {
				throw new Exception('更新属性值失败','603');exit();
			}
		}
		savelog($info['attribute_id'],'attribute','编辑属性值',$_SESSION['admin_id']);
	}
	/**
	 * 删除属性值
	 *
	 * @param int $id
	 */
	function delattributevalue($id){
		savelog($id,'attribute','属性值被删除',$_SESSION['admin_id']);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_option_value where value_id = '.$id);
		return $this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_option_value where parent_value_id = '.$id);
	}
	/**
	 * 清空属性下的所有属性值
	 *
	 * @param int $id
	 */
	function clearattributevalue($id){
		savelog($id,'attribute','属性值被清空',$_SESSION['admin_id']);
		$option_id = $this->getOptionID($id);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'attribute_option_value where option_id = '.$option_id);
	}
	
	/**
	 * 保存/更新属性
	 *
	 * @param array $info
	 */
	function saveparent($id,$value){
		try{
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value', array(
				'value' => $value,
			),'value_id='.intval($id));
			
			} catch (Exception $e) {
				throw new Exception('保存属性值失败','605');exit();
			}	
	}
	function saveson($id,$value,$language){
		try{
			$result = $this->db->getValue('select option_id from '. CFG_DB_PREFIX .'attribute_option_value where parent_value_id ='.$id.' and language_id ='.$language);
			if(!$result){
				$option_id = $this->db->getValue('select option_id from '. CFG_DB_PREFIX .'attribute_option_value where value_id ='.$id);
				$this->db->insert(CFG_DB_PREFIX .'attribute_option_value',array(
					'language_id' => $language,
					'option_id' => $option_id,
					'value' => $value,
					'parent_value_id' => ($language == 1) ? 0 : $id
				));
			}
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value', array(
				'value' => $value,
			),'parent_value_id='.intval($id).' and language_id='.$language);
			
			} catch (Exception $e) {
				throw new Exception('保存属性值失败','605');exit();
			}	
	}
	/**
	 * 多语言翻译
	 *
	 * @param string $text  翻译的内容
	 * @param int $language 语言编码
	 * @return string 
	 */
	function translateattr($text,$language){
		return translate($text,$language);
	}
	/**
	 * 属性组总数
	 *
	 * @param string $where
	 * @return int 
	 */
	function getGroupCount($where=NULL){
		return $this->db->getValue('select count(*) from '.$this->GrouptbName.$where);
	}
	/**
	 * 属性组列表
	 *
	 * @param string $where
	 * @return array 
	 */
	function getGroupList($from,$to,$where=NULL){
		$this->db->open('select * from '.$this->GrouptbName.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取属性组的属性
	 *
	 * @param array $list  属性id集
	 * @return array 
	 */
	function getGroupAttr($list){
		$this->db->open('select attribute_id,attribute_code from '.$this->tableName,0,1000);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['cando'] = 0;
			for($i = 0; $i < count($list); $i++){
				if($rs['attribute_id'] == $list[$i]){
					$rs['cando'] = 1;
				}
			}
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 获取属性组的属性排序
	 *
	 * @param int $id  属性组id
	 * @return array 
	 */
	function getAttrSort($id){
		$sort_str = $this->db->getValue('select attribute_sort_order from '.$this->GrouptbName.' where attribute_group_set_id ='.$id);
		return explode(',',$sort_str);
	}
	/**
	 * 保存属性组属性
	 *
	 * @param array $info 
	 */
	function savegroupattr($info){
		try{
			$this->db->update($this->GrouptbName, array(
				'attribute_set_id' => $info['itemlist'],
				//'attribute_sort_order' => $info['sort_order']
			),'attribute_group_set_id='.intval($info['group_id']));
			
			} catch (Exception $e) {
				throw new Exception('保存失败','605');exit();
			}
	}
	/**
	 * 保存属性组
	 *
	 * @param array $info 
	 */
	function saveGroup($info){
		if (!$info['attribute_group_set_id']) {
			$this->db->insert($this->GrouptbName,array(
				'attribute_group_name' => $info['attribute_group_name'],
				'sort_order' => $info['sort_order']
			));
		} else {
			$this->db->update($this->GrouptbName,array(
				'attribute_group_name' => $info['attribute_group_name'],
				'sort_order' => $info['sort_order']
			),'attribute_group_set_id='.intval($info['attribute_group_set_id']));
			savelog($info['attribute_group_set_id'],'attribute','编辑属性组',$_SESSION['admin_id']);
		}
		$dd = new ModelDd();
		$dd->cacheAttributeGroup();
	}
	/**
	 * 删除属性组
	 *
	 * @param int $id 
	 */
	function delGroup($id){
		savelog($id,'attribute','属性组被删除',$_SESSION['admin_id']);
		return $this->db->execute('delete from '.$this->GrouptbName.' where attribute_group_set_id = '.$id);
	}
	/**
	 * 设置默认值
	 *
	 * @param array $info  id = option_id  value_id = value_id
	 */
	function saveDefault($info){
		$attr_id = $this->db->getValue('select attribute_id from '.CFG_DB_PREFIX .'attribute_option where option_id='.$info['id']);
		$type = $this->db->getValue('select entity_type_id from '.$this->tableName.' where attribute_id='.$attr_id);
		if($type == 4){ //复选框 可以选多个
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value',array(
				'is_default' => 'yes'
			),'value_id ='.intval($info['value_id']).' AND parent_value_id = '.intval($info['value_id']));
		}else{  //单选或下拉 只能有一个默认值
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value',array(
				'is_default' => 'yes'
			),'value_id ='.intval($info['value_id']));
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value',array(
				'is_default' => 'yes'
			),'parent_value_id ='.intval($info['value_id']));
			$this->db->update(CFG_DB_PREFIX .'attribute_option_value',array(
				'is_default' => 'no'
			),'option_id = '.intval($info['id']).' and value_id <>'.intval($info['value_id']).' AND parent_value_id <> '.intval($info['value_id']));
		}
		savelog($info['id'],'attribute','更新属性默认值',$_SESSION['admin_id']);
	}
	/**
	 * 获取属性组所有ID
	 */
	function getGroupID(){
		$re = $this->db->select('select attribute_group_set_id from '.CFG_DB_PREFIX.'attribute_group order by sort_order');
		$result = array();
		foreach($re as $v){
			$result[$v] = $v;
		}
		return $result;
	}
	/**
	 * 获取分类选取的属性组属性列表
	 *
	 * @param int $id
	 * @param int $language_id
	 * @return array
	 */
	function getCatGroupAttr($id,$language_id)
	{
		$groupID = $this->db->getValue('select attribute_group_id from '.CFG_DB_PREFIX.'category where cat_id='.$id);
		if(empty($groupID)) throw new Exception('该分类没有属性','999');
		$arr = explode(',',$groupID);
		//return count($arr);
		$result = array();
		//遍历属性组
		for( $c = 0; $c < count($arr); $c++)
		{   //v = myr_attribute_group -> attribute_group_set_id -> 查找同表attribute_set_id			
			//astr_set 属性组下的属性集 
			
			$astr_set1 = $this->db->getValue('select attribute_set_id from '.CFG_DB_PREFIX.'attribute_group where attribute_group_set_id='.$arr[$c]);
			$astr_set2 = $this->db->getValue('select attribute_sort_order from '.CFG_DB_PREFIX.'attribute_group where attribute_group_set_id='.$arr[$c]);
			
			$aid_set = explode(',',$astr_set1);
			$asort_set = explode(',',$astr_set2);
			if(empty($astr_set1)) continue;
			$i = 0;
			foreach( $aid_set as $key => $attribute )
			{
				$aaid = /*(isset($asort_set[$key])) ? $asort_set[$key] : */$attribute;
				$attributeList = $this->db->select('select entity_type_id,attribute_label,is_required from '.$this->tableName.' where attribute_id='.$aaid);//属性排序
				// $attrValue['entity_type_id'] 判断类型  3/4/5 -> myr_attribute_option_value
				foreach($attributeList as $attrValue)
				{
					if($attrValue['entity_type_id'] == 5)
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$option_id = $this->getOptionID($aaid);
						$valueList = $this->db->select('select * from '.CFG_DB_PREFIX.'attribute_option_value where option_id='.$option_id.' and language_id = '.$language_id);
						//遍历属性值
						$j = 0;
						foreach( $valueList as $valueKey => $value )
						{
							$result[$i]['attribute_value'][$j]['value_id'] = $value['value_id'];
							$result[$i]['attribute_value'][$j]['value'] = $value['value'];
							$j++;
						}	
						$i++;
					}
					// $attrValue['entity_type_id'] 判断类型  3/4/5 -> myr_attribute_option_value
					elseif($attrValue['entity_type_id'] == 1)
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$result[$i]['attribute_value'] = NULL;
						$i++;
					}
					elseif($attrValue['entity_type_id'] == 2)
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$result[$i]['attribute_value'] = NULL;
						$i++;
					}
					elseif($attrValue['entity_type_id'] == 4)
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$option_id = $this->getOptionID($aaid);
						$valueList = $this->db->select('select * from '.CFG_DB_PREFIX.'attribute_option_value where option_id='.$option_id.' and language_id = '.$language_id);
						//遍历属性值
						$j = 0;
						foreach( $valueList as $valueKey => $value )
						{
							$result[$i]['attribute_value'][$j]['value_id'] = $value['value_id'];
							$result[$i]['attribute_value'][$j]['value'] = $value['value'];
							$j++;
						}	
						$i++;
					}
					elseif($attrValue['entity_type_id'] == 3)
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$option_id = $this->getOptionID($aaid);
						$valueList = $this->db->select('select * from '.CFG_DB_PREFIX.'attribute_option_value where option_id='.$option_id.' and language_id = '.$language_id);
						//遍历属性值
						$j = 0;
						foreach( $valueList as $valueKey => $value )
						{
							$result[$i]['attribute_value'][$j]['value_id'] = $value['value_id'];
							$result[$i]['attribute_value'][$j]['value'] = $value['value'];
							$j++;
						}	
						$i++;
					}
					elseif( $attrValue['entity_type_id'] == 6 )
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$result[$i]['attribute_value'] = NULL;
						$i++;
					}
					elseif( $attrValue['entity_type_id'] == 7 )
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['is_required'] = $attrValue['is_required'];
						$result[$i]['attribute_value'] = NULL;
						$i++;
					}
					elseif( $attrValue['entity_type_id'] == 8 )
					{
						$result[$i]['attribute_id'] = $aaid;
						$result[$i]['entity_type_id'] = $attrValue['entity_type_id'];
						$result[$i]['entity_type_name'] = $this->switchType($attrValue['entity_type_id']);
						$result[$i]['attribute_label'] = $this->db->getValue('select value from '.CFG_DB_PREFIX.'attribute_tag where attribute_id='.$aaid.' and language_id = '.$language_id);
						$result[$i]['attribute_value'] = NULL;
						$result[$i]['is_required'] = $attrValue['is_required'];
						$i++;
					}
				}
			}
		}
		return $result;
	}
	/**
	 * 属性标签类型转换
	 *
	 * @param int $typeID 类型ID -> Ext.form 的组件类型
	 * @return string 
	 */
	function switchType($typeID){
		switch($typeID){
			case 1:
			$type = 'textfield';
			break;
			case 2:
			$type = 'textarea';
			break;
			case 3:
			$type = 'radio';
			break;
			case 4:
			$type = 'checkboxgroup';
			break;
			case 5:
			$type = 'combo';
			break;
			case 6:
			$type = 'numberfield';
			break;
			case 7:
			$type = 'datefield';
			break;
			case 8:
			$type = 'combo';
			break;
		}
		return $type;
	}
	/**
	 * 属性标签类型转换类型ID
	 *
	 * @param int $typeID 类型ID -> Ext.form 的组件类型
	 * @return string 
	 */
	function switchTypeID($type){
		switch($type){
			case 'textfield':
			$type = 1;
			break;
			case 'textarea':
			$type = 2;
			break;
			case 'radio':
			$type = 3;
			break;
			case 'checkboxgroup':
			$type = 4;
			break;
			case 'combo':
			$type = 5;
			break;
			case 'numberfield':
			$type = 6;
			break;
			case 'datefield':
			$type = 7;
			break;
			case 'combo':
			$type = 8;
			break;
		}
		return $typeID;
	}
	/**
	 * 处理产品属性
	 *
	 * @param int $valueID
	 * @param int $catID
	 * @return array
	 */
	function getInfoByValueID($valueID,$catID){
		//typeid value value_id groupid attribute_id languageID
		$result = array();
		$languages = ModelDd::getArray('languages');
		try{
			$info = $this->db->getValue("SELECT value,language_id,parent_value_id,option_id,is_default FROM ".CFG_DB_PREFIX."attribute_option_value where value_id = ".$valueID);
			$info['attribute_id'] = $this->getAttributeID($info['option_id']);
			$group_info = $this->db->getValue('SELECT attribute_group_id FROM '. CFG_DB_PREFIX .'category WHERE cat_id = '.$catID);
			$arr = explode(',',$group_info);
			foreach($arr as $id){
				if($info['attribute_id'] == $id){
					$group_id = $id;
					$group_name = $this->db->getValue('SELECT attribute_group_name FROM '. CFG_DB_PREFIX .'attribute_group WHERE attribute_group_set_id = '.$id);
				}
			}
			if($info['parent_value_id'] == 0){
				$result[1]['attribute_tag'] = $this->db->getValue('select value FROM '. CFG_DB_PREFIX .'attribute_tag where attribute_id='.intval($info['attribute_id']).' and language_id = 1');
				$result[1]['value'] = $info['value'];
				$result[1]['value_id'] = $valueID;
				$result[1]['group_name'] = $group_name;
				$result[1]['group_id'] = $group_id;
				$result[1]['is_default'] = $info['is_default'];;
				$result[1]['language_id'] = 1;
				$result[1]['language_code'] = 'zh-CN';
			}
			for($i = 2; $i<=count($languages); $i++ ){
				$otherinfo = $this->db->getValue("SELECT value_id,value,language_id,parent_value_id,option_id,is_default FROM ".CFG_DB_PREFIX."attribute_option_value WHERE parent_value_id = ".$valueID." AND language_id =".$languages[$i]);
				$result[$i]['attribute_tag'] = $this->db->getValue('SELECT value FROM '. CFG_DB_PREFIX .'attribute_tag WHERE attribute_id='.intval($info['attribute_id']).' AND language_id = '.$languages[$i]);
				$result[$i]['value'] = $otherinfo['value'];
				$result[$i]['value_id'] = $otherinfo['value_id'];
				$result[$i]['group_name'] = $group_name;
				$result[$i]['group_id'] = $group_id;
				$result[$i]['is_default'] = $otherinfo['is_default'];;
				$result[$i]['language_id'] = $i;
				$result[$i]['language_code'] = $this->db->getValue('SELECT language_code  FROM '. CFG_DB_PREFIX .'product_language WHERE id = '.$languages[$i]);
			}
			return $result;
		} catch (Exception $e) {
			throw new Exception('保存属性失败','605');exit();
		}	
	}
	/**
	 * 根据属性ID获取属性标签
	 *
	 * @param int $arr
	 * @return string
	 */
	function getAttributeFieldByID($arr){
		$result = array();
		foreach($arr as $attribute_id){
			$result[] = $this->db->getValue('SELECT value FROM '.CFG_DB_PREFIX.'attribute_tag WHERE attribute_id ='.$attribute_id.' AND language_id = 1');
		}
		return $result;
	}
}
?>