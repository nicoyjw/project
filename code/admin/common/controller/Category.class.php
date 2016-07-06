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
 * 文件说明
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Controller
 * @version v0.1
 */

class Category extends Controller  {

	/**
	 * 初始化页面信息
	 */
	public function __construct()
	{
		parent::__construct();
		$this->title .= '公告分类';
		$this->name = 'category_list';
		$this->dir = 'news';
	}

	/**
	 * 分类列表
	 */
	public function actionIndex()
	{
		$this->show();
	}

	/**
	 * 获得分类列表数据
	 */
	public function actionList()
	{
		parent::actionList('ModelCategory');
	}

	/**
	 * 添加(修改)窗口
	 */
	public function actionAdd()
	{
		$cat  = new ModelCategory();
		$this->name = 'category_add';
		if ($_GET['id']) {
			$info = $cat->getInfo($_GET['id']);
			$this->tpl->assign('info', $info);
		}
		$this->tpl->assign('category', $cat->getCatData());
		$this->show();
	}

	/**
	 * 保存分类
	 */
	public function actionSave()
	{
		parent::actionSave('ModelCategory');
	}

	/**
	 * 删除分类
	 */
	public function actionDelete()
	{
		parent::actionDelete('ModelCategory');
	}
}
?>