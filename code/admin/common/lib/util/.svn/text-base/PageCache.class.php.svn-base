<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * PageCache 页面缓存类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Util
 * @version v0.1
 */

/**
 * PageCache 页面缓存类
 * @package Util
 */
class PageCache {

	/**
	 * @var string $file 缓存文件地址
	 * @access public
	 */
	public $file;
	
	/**
	 * @var int $cacheTime 缓存时间
	 * @access public
	 */
	public $cacheTime = 3600;
	
	/**
	 * 构造函数
	 * @param string $file 缓存文件地址
	 * @param int $cacheTime 缓存时间
     */
	function __construct($file, $cacheTime = 3600) {
		$this->file = $file;
		$this->cacheTime = $cacheTime;
	}
	
	/**
	 * 取缓存内容
	 * @param bool 是否直接输出，true直接转到缓存页,false返回缓存内容
	 * @todo 修改file_get_contents
	 * @return mixed
     */
	public function get($output = true) {
		if (is_file($this->file) && (time()-filemtime($this->file))<=$this->cacheTime && !$_GET['nocache']) {
			if ($output) {
				header('location:' . $this->file);
				exit;
			} else {
				return file_get_contents($this->file); // todo 修改
			}
		} else {
			return false;
		}
	}
	
	/**
	 * 设置缓存内容
	 * @param $content 内容html字符串
     */
	public function set($content) {
		$fp = fopen($this->file, 'w');
		fwrite($fp, $content);
		fclose($fp);
	}
}
?>