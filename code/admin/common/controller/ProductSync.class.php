<?php
		
	/*
	 * 
	 */
	class ProductSync extends Controller {
		
		/**
		 * 
		 * 构造函数
		 */
		function __construct() {
			parent::__construct();
			$this->title .= '产品同步列表';
			$this->name = 'product_sync';
			$this->dir = 'goods'; 
		}
		
		public function actionIndex() {
			$language_arr = ModelDd::getArray('languages');
			$this->tpl->assign('languages',ModelDd::arrayFormat($language_arr));
			print_r($language_arr);	
			$this->show();
		}
		
		public function actionList() {
			$pageLimit = getPageLimit();
			$object = new ModelProductSync();
			$where = $object->getlistwhere($_REQUEST);
			$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
			$result['totalCount'] = $object->getCount($where);
			$result['topics'] = $list;
			require(CFG_PATH_LIB.'util/JSON.php');
			$json = new Services_JSON();
			echo $json->encode($result);			
		}
		
	}
?>