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
 * 用户帮助类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Common
 * @version v0.1
 */
class Helps extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '常见问题';
		$this->name = 'helps';
		$this->dir = 'system';
	}
	
	/**
	 * 默认页面---常见问题
	 */
	function actionIndex() {
        
        $this->tpl->assign('content_2',$this->actiongetList(1,100,$_GET['page']));   /* 亚马逊 */
        $this->tpl->assign('page',$_GET['page']);   
		$this->show();
	}
    function actiongetList($from,$to,$type){
        $object = new ModelHelps();
        return $object->getHelpsList($from,$to,$type+1);
        
       // $j = "<div class='helpFAQ notopradius'><h4 class='innerRightTitle2'></h4><ul class='newslist'><div class='helpFAQInfo'>h4><strong>问：</strong>我是Amazon卖家我想发线下E邮宝，如何操作?</h4><p><strong style='color:#0088CC;'>答：</strong>  贸易宝能对接中国邮政，可以获取E邮宝正规的标签，标签是一个压缩包的格式。里面有PDF的标签文件。</p></div></ul><ul class='newslist'><div class='helpFAQInfo'>h4><strong>问：</strong>可以添加多个Amazon帐号吗？会不会造成关联？可以添加多个亚马逊帐号，可以在系统内操作多个帐号。由于系统是用Api接口调用亚马逊数据，亚马逊官方没有对API方式做出关联限制，所以不会造成帐号关联。但是授权给我们的开发者帐号的时候，需要分开不同的网络进行授权。</h4><p><strong style='color:#0088CC;'>答：</strong>  可以添加多个亚马逊帐号，可以在系统内操作多个帐号。由于系统是用Api接口调用亚马逊数据，亚马逊官方没有对API方式做出关联限制，所以不会造成帐号关联。但是授权给我们的开发者帐号的时候，需要分开不同的网络进行授权。</p></div></ul><ul class='newslist'><div class='helpFAQInfo'>h4><strong>问：</strong>贸易宝能跟Amazon对接吗？</h4><p><strong style='color:#0088CC;'>答：</strong>  可以的，不同国家站点需要到对应国家网址授权，得到Merchant ID与Marketplace ID，与系统绑定即可使用Api获取订单信息。详细可参考&nbsp;&nbsp; <<<a style='color:orange;font-size:14px;font-weight:bold;' onclick=\"parent.newTab('amazon_pdf','账户授权说明书','common/lib/download/Amazon账户授权说明书.pdf')\" href='javascript:void(0)'>如何添加Amazon帐号</a>>>。</p></div></ul></div>";
    } 
    
}
?>
