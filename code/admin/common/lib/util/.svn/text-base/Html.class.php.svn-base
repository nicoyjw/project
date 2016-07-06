<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Html html操作类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Util
 * @version v0.1
 */

/**
 * Html html操作类
 * @package Util
 */
class Html {
	/**
	 * @var string $output html内容
	 * @access private
	 */
	private $output = '';
	/**
	 * @var bool $inJsArea 是否在js代码区域内
	 * @access private
	 */
	private $inJsArea = false;
	/**
	 * 构造函数
	 */
	public function __construct() {}
	/**
	 * 添加html标签
	 * @param string $tag 标签名
	 * @param mixed $attribute 属性
	 * @param string $content 内容
	 * @return string
	 */
	public function addTag($tag, $attribute = NULL, $content = NULL) {
		$this->js();
		$html = '';
		$tag = strtolower($tag);
		$html .= '<'.$tag;
		if ($attribute!=NULL) {
			if (is_array($attribute)) {
				foreach ($attribute as $key=>$value) {
					$html .= ' '.strtolower($key).'="'.$value.'"';
				}
			} else {
				$html .= ' '.$attribute;
			}
		}
		if ($content) {
			$html .= '>'.$content.'</'.$tag.'>';
		} else {
			$html .= ' />';
		}
		
		$this->output .= $html;
		return $html;
	
	}
	/**
	 * 添加html文本
	 * @param string $content 内容
	 * @return string
	 */
	public function addText($content) {
		$this->js();
		$content = htmlentities($content);
		$this->output .= $content;
		return $content;
	}
	/**
	 * 添加js代码
	 * @param string $jscode js代码
	 * @param bool $end 是否关闭js 代码块
	 * @return void
	 */
	public function js($jscode = NULL, $end = false) {
		
		if (!$this->inJsArea && $jscode) {
			$this->output .= "\n<script language='JavaScript' type='text/javascript'>\n//<![CDATA[\n";
			$this->inJsArea = true;
		}
		if ($jscode==NULL && $this->inJsArea==true) {
			$this->output .= "\n//]]>\n</script>\n";
			$this->inJsArea = false;
		} else {
			$this->output .= "\t$jscode\n";
			if ($end) {
				$this->js();
			}
		}
		return;
	}
	/**
	 * 添加js提示代码
	 * @param string $message 提示内容
	 * @param bool $end 是否关闭js 代码块
	 * @return void
	 */
	public function jsAlert($message, $end = false) {
		$this->js('alert("' . strtr($message, '"', '\\"') . '");', $end);
	}
	/**
	 * 添加js文件包含
	 * @param string $fileName 文件名
	 * @param bool $defer 是否添加defer标记
	 * @return string
	 */
	public function jsInclude($fileName,$return = false, $defer = false) {
		if (!$return) {
			$this->js();
		}
		$html = '<script language="JavaScript" type="text/javascript" src="' 
				. $fileName . '"' . ( ($defer) ? ' defer' : '' ) 
				. '></script>';
		if (!$return) {
			$this->output .= $html;
		} else {
			return $html;
		}
	}
	/**
	 * 添加css文件包含
	 * @param string $fileName 文件名
	 * @return string
	 */
	public function cssInclude($fileName,$return = false) {
		if (!$return) {
			$this->js();
		}
		$html = '<link href="' . $fileName . '" rel=stylesheet>' . chr(13);
		if (!$return) {
			$this->output .= $html;
		} else {
			return $html;
		}
	}
	/**
	 * 输出html内容
	 * @param bool $print 是否直接输出，可选，默认返回
	 * @return void
	 */
	public function output($print = false) {
		$this->js(); // end js
		if ($print) {
			echo $this->output;
			$this->output = '';
			return;
		} else {
			$output = $this->output;
			$this->output = '';
			return $output;
		}
		
	}
}
?>