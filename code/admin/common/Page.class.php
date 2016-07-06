<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Page 页面信息类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Common
 * @version v0.1
 */
/**
 * Page 页面信息类
 * @package Common
 */
class Page extends Html {
	/**
	 * 模板对象
	 *
	 * @var object
	 */
	public $tpl;
	
	/**
	 * 缓存对象
	 *
	 * @var object
	 */
	public $cache;
	/**
	 * 构造函数
	 */
	function __construct() {
		$GLOBALS['cfg']['page'] = array();
		$this->title = '';
		$this->action = $_REQUEST['action'];
	}
	/**
	 * 添加页面属性
	 *
	 * @param sting $key
	 * @param sting $value
	 */
	public function __set($key, $value) {
		$GLOBALS['cfg']['page'][$key] = $value;
	}
	
	/**
	 * 取页面属性
	 *
	 * @param sting $key
	 * @return sting
	 */
	public function __get($key) {
		return $GLOBALS['cfg']['page'][$key];
	}
	
	/**
	 * 添加一个JS文件包含
	 * @param string $file 文件名
	 * @access public
	 * @return void
	 */
	public function addJs($file) {
		if (strpos($file,'/')==false) {
			$file = CFG_PATH_JS . $file;
		}
		$GLOBALS['cfg']['page']['jsfiles'][$file] = $file;
	}
	
	/**
	 * 取生成的包含JS HTML
	 * @access public
	 * @return string
	 */
	public function getJsHtml() {
		$html = '';
		if (!$GLOBALS['cfg']['page']['jsfiles']) {
			return;
		}
		foreach ($GLOBALS['cfg']['page']['jsfiles'] as $value) {
			$html .= $this->jsInclude($value,true)."\n";
		}
		return $html;
	}
	
	/**
	 * 添加一个CSS文件包含
	 * @param string $file 文件名
	 * @access public
	 * @return void
	 */
	public function addCss($file) {
		if (strpos($file,'/')==false) {
			$file = CFG_PATH_CSS . $file;
		}
		$GLOBALS['cfg']['page']['cssfiles'][$file] = $file;
	}
	
	/**
	 * 取生成的包含CSS HTML
	 * @access public
	 * @return string
	 */
	public function getCssHtml() {
		if (!$GLOBALS['cfg']['page']['cssfiles']) {
			return;
		}
		$html = '';
		foreach ($GLOBALS['cfg']['page']['cssfiles'] as $value) {
			$html .= $this->cssInclude($value,true)."\n";
		}
		return $html;
	}
	
	/**
	 * 显示输出页面
	 * @access public
	 * @return string
	 */
	public function show() {
		$path = $this->getPath();
		$this->tpl->display($path);
	}
	
	/**
	 * 转到URL,并提示信息
	 * @param string $url URL
	 * @param string $msg 提示信息
	 * @access public
	 * @return void
	 */
	public function todo($url, $msg=NULL) {
		if ($msg) {
			$this->jsAlert($msg);
		}
		$this->js('document.location="' . $url . '";');
		$this->output(true);exit;
	}
	/**
	 * replace方式转到URL,并提示信息
	 * @param string $url URL
	 * @param string $msg 提示信息
	 * @access public
	 * @return void
	 */
	public function replace($url, $msg=NULL) {
		if ($msg) {
			$this->jsAlert($msg);
		}
		$this->js('location.replace("' . $url . '");');
		$this->output(true);exit;
	}
	
	/**
	 * 返回,并提示信息
	 * @param string $msg 提示信息
	 * @access public
	 * @return void
	 */
	public function back($msg=NULL){
		if ($msg) {
			$this->jsAlert($msg);
		}
		$this->js('history.back();');
		$this->output(true);exit;
	}
	/**
	 * 确认操作
	 *
	 * @param string $msg 提示消息
	 * @param string $yes 确定后的js操作
	 * @param string $no  取消后的操作
	 */
	public function confirm ($msg,$yes,$no) {
		$this->js('if (confirm("'.$msg.'")) {'
			. $yes.'} else {'.$no
			. '}');
		$this->output(true);exit;
	}
	/**
	 * 开始页面缓存
	 * @param string $file 文件名
	 * @param string $time 有效时间
	 * @param string $output 是否输出
	 * @access public
	 * @return void
	 */
	public function cache($file, $time, $output) {
		global $cfg;
		require_once(CFG_PATH_LIB . 'util/PageCache.class.php');
		$this->cache = new PageCache($file, $time);
		$this->cache->get($output);
	}
	
	/**
	 * 保存页面缓存
	 * @access public
	 * @return void
	 */
	public function save() {
		$path = $this->getPath();
		$content = $this->tpl->fetch($path);
		if (is_object($this->cache)) {
			$this->cache->set($content);
		}
	}
	
	/**
	 * 取模板路径
	 *
	 * @return string
	 */
	private function getPath () {
		$path = '';
		if ($this->dir) {
			$path = $this->dir . '/';
		}
		$path .= $this->name . '.tpl';
		
		$this->tpl->assign('jsFiles',$this->getJsHtml());
		$this->tpl->assign('cfg',$GLOBALS['cfg']);
		$this->tpl->assign('cssFiles',$this->getCssHtml());
		return $path;
	}
	/**
	 * 注册一个公共变量
	 *
	 * @param string $key
	 * @param mixed $value
	 */
	public static function setRegistry($key, $value) {
		if (isset($GLOBALS['registry'][$key])) {
			throw new Exception($key.'已被注册');
		}		
		$GLOBALS['registry'][$key] = $value;
	}
	/**
	 * 返回已注册的公共变量
	 *
	 * @param string $key
	 * @return mixed
	 */
	public static function getRegistry($key) {
		if (!isset($GLOBALS['registry'][$key])) {
			throw new Exception('没有'.$key.'这个注册变量！');
		}
		return $GLOBALS['registry'][$key];
	}
}
?>
