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
 * WIKI管理
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Wiki extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '知识库管理';
		$this->name = 'wiki';
		$this->dir = 'aftersell';
	}
	
	/**
	 * 默认页面
	 */
	function actionIndex() {
		parent::actionPrivilege('list_wiki');
		$this->tpl->assign('wikitype',ModelDd::getComboData('wikitype'));
		$this->show();
	}


	/**
	*获取wiki josn列表
	*/
	function actionList(){
		$pageLimit = getPageLimit();
		$object = new ModelWiki();
		$where=$object->getwhere($_REQUEST);
		$list = $object->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getCount($whstr);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	
	/*********
	*保存wiki记录
	*********/
	
	function actionsave()
	{
		parent::actionCheck('edit_wiki');
			if($_FILES['attachment']['name']){//上传附件
				require(CFG_PATH_LIB.'util/UploadFile.class.php');
				$upload = new UploadFile();
				try{
					$_POST['attachment'] = $upload->upload($_FILES['attachment'],CFG_PATH_UPLOAD.'wiki/');
					$_POST['attachment'] = str_replace(CFG_PATH_ROOT, '', CFG_PATH_UPLOAD).'wiki/'.$_POST['attachment'];
				}catch (Exception $e){
					$msg = $e->getMessage();
					echo "{success:false,msg:'$msg'}";exit;
				}
			}
			unset($_POST['create']);
			$object = new ModelWiki();
			$object->save($_POST);
			echo "{success:true,msg:'ok'}";exit;
	}
	/*****
	**获取知识库明细
	*****/
	function actiongetdetail()
	{
		$object = new ModelWiki();
		$detail = $object->getdetail($_GET['id']);
		if($detail['attachment'] <> '') echo "<a href='".$detail['attachment']."' target='_blank'>下载附件</a><br>";
		echo $detail['description'];exit();
	}
	
	function actiondelete()
	{
		parent::actionCheck('del_wiki');
		$object = new ModelWiki();
		$object->delete($_GET['ids']);
		savelog($_GET['ids'],'ModelWiki','信息被删除',$_SESSION['admin_id']);
		echo "{success:true,msg:'OK'}";exit;
	}
}
?>