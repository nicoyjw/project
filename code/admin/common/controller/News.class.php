<?php
// +--------------------------------------------------------------+
// | 这个文件是 MYOIS 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2006 - 2008 MYOIS.CN (www.myois.cn)            |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// | 或者访问 http://www.myois.cn/ 获得详细信息                      |
// +--------------------------------------------------------------+

/**
 * 文件说明
 *
 * @copyright Copyright (c) 2006 - 2008 MYOIS.CN
 * @author 戴志君 <dzjzmj@gmail.com>
 * @package Controller
 * @version v0.1
 */

class News extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '消息';
		$this->name = 'news_list';
		$this->dir = 'news';
	}

	/**
	 * 公告列表
	 */
	function actionIndex() {
		parent::actionPrivilege('list_news');
		$this->show();
	}

	/**
	 * 返回json列表
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$news = new ModelNews();
		$where = $news->getWhere($_REQUEST);
		$list = $news->getList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $news->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}

	/**
	 * 添加页
	 */
	function actionAdd() {
		parent::actionPrivilege('add_news');
		$this->name = 'news_add';
		$news = new ModelNews();
		$info = $news->getNews($_GET['id']);
		$set_user = array_flip(explode(",",substr($info['set_user_id'],1,strlen($info['set_user_id'])-1)));
		$user = ModelDd::getArray('user');
		foreach($set_user as $k=>$v){
			$suser[$k] =  $user[$k]; //已选择用户
		}
		$info['ds'] = (count($suser)>1)?ModelDd::arrayFormat(array_diff($user,$suser)):ModelDd::arrayFormat($user);
		$info['ds1'] = (count($suser)>1)?ModelDd::arrayFormat($suser):'';
		$this->tpl->assign('role', ModelDd::getComboData('role'));
		$this->tpl->assign('info', $info);
		$this->show();
	}

	/**
	 * 保存文章
	 */
	function actionSave() {
		parent::actionSave('ModelNews');
	}

	/**
	 * 删除文章
	 */
	public function actionDelete()
	{
		parent::actionPrivilege('del_news');
		parent::actionDelete('ModelNews');
	}
	
	/**
	 * 查看页
	 */
	function actionShow() {
		$this->name = 'news_show';
		if ($_GET['id']) {
			$news = new ModelNews();
			$this->tpl->assign('info', $news->getNewsInfo($_GET['id']));
			$this->tpl->assign('revertList',$news->revertList($_GET['id']));
		}
		$this->show();
	}
	/**
	 * 回复文章
	 */
	function actionSaveRevert() {
		$news = new ModelNews();
		try {
			echo "{success:true,msg:'".($news->saveRevert($_GET['id'],$_POST)?'回复成功！':'回复失败！')."'}";
		}catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
		}
		exit;
	}
}
?>