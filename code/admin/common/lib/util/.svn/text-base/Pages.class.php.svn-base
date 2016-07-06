<?php 
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Pages 分页类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Util
 * @version v0.1
 */

/**
 * Pages 分页类
 * @package Util
 */
class Pages {
	/**
	 * 使用该类的文件
	 * @var string
	 */
	public $fileName;
	/** 
	 * 每页行数
	 * @var int
	 */
	public $lines;
	/**
	 * 当前页
	 * @var int
	 */
	public $currentPage;
	/**
	 *总行数
	 *@var int
	 */
	public $lineCount;
	/**
	 * 总页数
	 * @var int
	 */
	public $pageCount;
	/**
	 * 模版文件名
	 * @var strint
	 */
	public $templateFile;
	/**
	 * 构析函数
	 * @param int $count
	 * @param string $templata_file
	 * @param int $lines
	 * @return void
	 */
	public function __construct($count, $lines=20
				, $template_file='pages.tpl') {
		$this->lineCount = intval($count);
		if (intval($_GET['lines'])>0) {
			$this->lines = intval($_GET['lines']);
		} else {
			$this->lines = $lines;
		}
		if ($this->lineCount<=0) {
			$this->pageCount = 1;
		} else {
			$this->pageCount = ceil($this->lineCount / $this->lines);
		}	
		$this->templateFile = $template_file;
		$uri = preg_replace('/&(pageno|lines)\=[^&]*/','', '&' . $_SERVER['QUERY_STRING']);
		$ext = '&';
		$uri = substr($uri . $ext,1);
		$this->fileName = $_SERVER['SCRIPT_NAME'] . '?' . $uri ;
		$currentPage = intval($_GET['pageno']);
		
		if ($currentPage<=0) {
			$this->currentPage = 1;
		} elseif ($currentPage>$this->pageCount) {
			$this->currentPage = $this->pageCount;
		} else {
			$this->currentPage = intval($_GET['pageno']);
		}
	}
	/**
	 * 生成sql分页
	 * @param string $sql
	 * @return string
	 */
	public function getLimit() {
		$lineFrom = ($this->currentPage-1) * $this->lines + 1;
		$lineTo = $lineFrom + $this->lines - 1;
		return array('rowFrom'=>$lineFrom,'rowTo'=>$lineTo);
	}
	/**
	 * 生成控制条
	 * @return string
	 */
	public function showCtrlPanel()	{
		global $tpl;
		$vars = array(
			'lineCount'				=> $this->lineCount,	//总行数
			'pageCount'				=> $this->pageCount,	//总页数
			'lines'					=> $this->lines,	//每页行数
			'formName'				=> $this->formName,	//表单名称
			'lineFrom'				=> $lineFrom,	//从第几行开始
			'lineTo'				=> $lineTo,		//到第几行结束
			'currentPage'			=> $this->currentPage,	//当前页
			'is_disabled_cp'		=> (($this->pageCount<=1)?' disabled style="background-color:#EEEEEE"':''),
			'is_disabled_scroll'	=> (($this->currentPage<=1)?' disabled':''), //是否可用
			'is_disabled_left'		=> (($this->currentPage<=1)?' disabled':''), //是否可用
			'is_disabled_right'		=> (($this->currentPage>=$this->pageCount)?' disabled':''), //是否可用
			'pageName'				=> $this->fileName,
			'nextPage'				=> $this->currentPage+1,
			'prePage'				=> $this->currentPage-1,
			);
		$tpl->assign($vars);
		
		$pageList = array();
		for($i=1; $i<=$this->pageCount; $i++){
			// $p 存储页的数组
			if($i == $this->currentPage){
				$pageList[$i] = ' selected="selected"'; // 当前页时下拉菜单默认选中该页
			} else {
				$pageList[$i] = '';
			}
			
		}
		$tpl->assign('pageList',$pageList);
		
		// 输出模板
		return $tpl->fetch($this->templateFile);
	}
}
?>