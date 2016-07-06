<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 登录
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Controller
 * @version v0.1
 */
class Login extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		$this->useAuth = false;
		parent::__construct();
		$this->title .= '首页';
		$this->name = 'login';
		$this->user = new ModelUser();
	}

	/**
	 * 登录界面
	 */
	function actionIndex() {
		$this->show();
	}
	
	/**
	 * 登录程序
	 */
	function actionLogin()
	{
			try {
				$userinfo = $this->user->checkUser(strtolower(addslashes(trim($_REQUEST['company']))),strtolower(addslashes(trim($_REQUEST['username']))),$_REQUEST['passwd']);
				savelog((CFG_RUN_MODE ==1)?$userinfo['id']:$userinfo['user_id'],'login','登录成功',$userinfo['user_id']);
				//if(CFG_RUN_MODE ==1) $userinfo['user_id'] = $userinfo['id'];
				set_admin_session($userinfo);
				echo '<div style="color:#F15628;">欢迎您<b style="font-size:14px">'.$userinfo['user_name'].'</b></div>';exit;
			    
            } catch (Exception $e) {
				$errorMsg = $e->getMessage();
			}
		
		/*} else {
			$errorMsg = '验证码错误';
		}*/
		echo '<font color="red">'.$errorMsg."</font>";exit;
	}

	/**
	 * 退出程序
	 */
	function actionLogout()
	{
		destroy_session();
		page::todo('index.php');
	}

	
	/**
	 * 显示验证码
	 */
	function actionShowimg()
	{
		$cookieName = $_GET['cookieName'] ? $_GET['cookieName'] :'validString';
		$image = new Image();
		define('VALID_WIDTH',55);
		define('VALID_HEIGHT',22);
		define('VALID_CODE_TYPE', 1);
		define('VALID_CODE_LENGTH', 4);
		$valid = $image->imageValidate(VALID_WIDTH, VALID_HEIGHT,VALID_CODE_LENGTH, VALID_CODE_TYPE,'#3e3e3e','#B6B6B6');
		$this->user->saveValid($cookieName,$valid);
		header("Pragma: no-cache");
		header("Cache-control: no-cache");
		$image->display();
	}
	/**
	 * 显示条形码
	 */
	function actionBarcode()
	{
		$image = new Image();
		if(!$_GET['scale']) $_GET['scale'] = 1;
		$rs = $image->imageBarcode($_GET['number'],$_GET['height'],$_GET['type'],$_GET['scale']);
		header("Pragma: no-cache");
		header("Cache-control: no-cache");
		ob_clean();  //防止出现'图像因其本身有错无法显示'的问题
		$image->display('',300);
	}
	function actionadminloginuser(){
		$object = new ModelUser();
		//username
		$userinfo = $object->AdminLogin($_REQUEST['username']);
		set_admin_session($userinfo);
		echo '<script language="javascript">document.location="index.php?model=main"</script>';exit;
		
	}
}
?>
