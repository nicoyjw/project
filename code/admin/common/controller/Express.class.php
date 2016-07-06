<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2010 - 2015  |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// |                       |
// +--------------------------------------------------------------+

/**
 * 快递规则
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Express extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		parent::actionPrivilege('list_express');
		$this->title .= '快递规则';
		$this->name = 'express';
		$this->dir = 'system';
	}
	/**
	 * 
	 */
	function actionIndex() {
		
		/*if($_SERVER['REMOTE_ADDR'] !== '116.76.106.124'){
			echo "正在更新内容。请稍后重试。";exit;
		}*/
		$object = new ModelExpress();
		$country = $object->getCountry();
		$area = $object->getArea();
		$currency = $object->getCurrency();
		$this->tpl->assign('currency',ModelDd::arrayFormat($currency));
		$this->tpl->assign('country',ModelDd::arrayFormat($country));
		$this->tpl->assign('allaccount',ModelDd::getComboData('allaccount'));
		$this->tpl->assign('Sales_channels',ModelDd::getComboData('Sales_channels'));
		$this->tpl->assign('depot',ModelDd::getComboData('depot'));
		$this->tpl->assign('shipping',ModelDd::getComboData('shipping'));
		$this->tpl->assign('express_rule',ModelDd::getComboData('express_rule'));
		$this->show();
	}
	/**
	 * 返回json列表
	 *
	 */
	function actionList()
	{
		parent::actionList('ModelExpress');
	}
	/**
	 * 保存规则
	 *
	 */
	function actionUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			
		    $rulearr = ModelDd::getArray('express_rule');
			
			try {
				require(CFG_PATH_LIB.'util/JSON.php');
				$json = new Services_JSON();
				$rulesarr = $json->decode(stripslashes($_POST['ruledata']));
				$info = array();
				$ruleid = '';
				$rulevalue = '';
				$if_rule = '';
				$optionid = array();
                $option = array();
				foreach($rulesarr as $rule){
					$rule->value = addslashes_deep($rule->value);
                    
                    if($rule->rule_id == 35){
                        
                        if($rule->rule === 'like'){
                            $rulevalue .= '包含('.$rule->value.')<br/>';
                        }
                        if($rule->rule === '$'){
                            $rulevalue .= '结尾包含('.$rule->value.')<br/>';
                        }
                        if($rule->rule === '><'){
                            $valarr = explode(',',$rule->value);
                            $rulevalue .= '长度 > ('.$valarr[0].') < ('.$valarr[1].')<br/>' ;
                        }
                    }elseif($rule->rule_id !== 0){
                        
                        $rulevalue .= $rule->rule.'('.$rule->value.')<br/>'; 
                    }else{
                        $rulevalue .= '';
                    }    
					$ruleid .= $ruleid=='' ? $rule->rule_id : ','.$rule->rule_id;
					
					$if_rule .= $rule->rule;
					
					$option[] = array(
						'rule_id' => $rule->rule_id,
						'value' => $rule->value,
						'if_rule' => $rule->rule,
					);
				}
                $info = array(
                        'rule_id' => $ruleid,
                        'value' => $rulevalue,
                        'express_id' => $_POST['express_id'],
                        'order_by' => $_POST['order_by']
                    );
                if($_POST['id'] && $_POST['type']=='update'){
                    $info['id'] = $_POST['id'];    
                }
                $express_insert_id = $object->save($info);
                $object->saveoption($option,$express_insert_id);
				echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 返回Mark json列表
	 *
	 */
	function actionMarkList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getMarkList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getMarkCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回Mark json列表
	 *
	 */
	function actionUNMarkList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getUnMarkList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getUnMarkCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回需要追踪单号标记发货列表
	 *
	 */
	function actionNTMarkList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getNtMarkList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getNtMarkCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回Mark json列表
	 *
	 */
	function actionAreaList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getareaList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getAreaCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 返回物流仓库 json列表
	 *
	 */
	function actionDepotList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getDepotList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getDepotCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 保存物流仓库分配规则
	 *
	 */
	function actiondepotUpdate() 
	{
			$object = new ModelExpress();
			try {
					$object->Depotsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}
	 /**
	 * 删除物流仓库分配规则
	 */
	function actiondepotdelete()
	{
		$object = new ModelExpress();
		$object->depotdelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	
	/**
	 * 保存Mark规则
	 *
	 */
	function actionMarkUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			try {
					$object->Marksave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 保存忽略单号Mark规则
	 *
	 */
	function actionUnMarkUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			try {
					$object->UNMarksave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 保存必须要单号Mark规则
	 *
	 */
	function actionNtMarkUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			try {
					$object->NtMarksave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	/**
	 * 保存Area
	 *
	 */
	function actionAreaUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			try {
					$object->Areasave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	
	/**
	 * 删除快递规则
	 */
	function actionDelete()
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			$object->delete($_GET['ids']);
			echo "{success:true,msg:'OK'}";exit;
		}
	}
	 /**
	 * 删除Mark规则
	 */
	function actionMarkDelete()
	{
		$object = new ModelExpress();
		$object->markdelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	 /**
	 * 删除Mark规则
	 */
	function actionUnMarkDelete()
	{
		$object = new ModelExpress();
		$object->Unmarkdelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	 /**
	 * 删除必须要追踪号Mark规则
	 */
	function actionNtMarkDelete()
	{
		$object = new ModelExpress();
		$object->Ntmarkdelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	 /**
	 * 删除Area
	 */
	function actionAreaDelete()
	{
		$object = new ModelExpress();
		$object->areadelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	/**
	 * 返回运费 json列表
	 *
	 */
	function actionCostList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelExpress();
		$list = $object ->getCostList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getCostCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}	
	/**
	 * 保存运费规则
	 *
	 */
	function actionCostUpdate() 
	{
		if(parent::actionCheck('edit_express'))
		{
			$object = new ModelExpress();
			try {
					$object->Costsave($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
		}
	}
	 /**
	 * 删除运费规则
	 */
	function actionCostDelete()
	{
		$object = new ModelExpress();
		$object->costdelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
    /**
     * 获取快递规则子选项的值
     *
     */
    function actiongetExpressOption() 
    {          
        $object = new ModelExpress();
        try {
            $value = $object->getExpressOption($_GET['express_rule_id'],$_GET['rule_id']);
            echo "{value:'".$value['value']."',if_rule:'".$value['if_rule']."'}";exit;
        } catch (Exception $e) {
            $errorMsg = $e->getMessage();
        }
        echo "{success:true,msg:'" . $errorMsg . "'}";exit;
    }
}	
?>