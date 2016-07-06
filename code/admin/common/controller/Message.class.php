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

class Message extends Controller  {

	/**
	 * 初始化页面信息
	 */
	function __construct() {
		parent::__construct();
		$this->title .= '消息';
		$this->name = 'message';
		$this->dir = 'message';
	}
	/**
	 * 返回json列表
	 */
	function actionList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelMessage();
		$result = $object->getList($_GET['box'],$pageLimit['from'],$pageLimit['to']);
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * load email header list
	 */
	function actionLoadEmailHeader()
	{
		$db = new ModelMessage();
		$msg='加载邮件成功！';
		try {
			if($db->loadDownEmailHeader($msg)){
				echo "{success:true,msg:'{$msg}'}";
				exit;
			}else{
				echo "{success:true,msg:'{$msg}'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}
	/**
	 * get mail detail
	 *
	 */
	function actiongetMailDetail()
	{
		$db = new ModelMessage();
		$result = $db->getMailDetail();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * get mail detail
	 *
	 */
	function actiongetMailAttach()
	{
		if(!empty($_GET['name'])){
			$attachPath='email_attaches/'.trim($_GET['path']).'/'.trim($_GET['name']);
			header('Location: '.$attachPath); 
		}
	}
	/**
	 * get mail detail
	 *
	 */
	function actionDelMail()
	{
		if(!empty($_GET['uid'])){
			$db = new ModelMessage();
			$msg='删除失败！';
			try {
				if($db->delMail($msg)){
					echo "{success:true,msg:'{$msg}'}";
					exit;
				}else{
					echo "{success:false,msg:'{$msg}'}";
					exit;
				}
			} catch (Exception $e) {
				echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
				exit;
			}
		}
	}
	/**
	 * return attach list
	 *
	 */
	function actionAttachList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelCustomer();
		$list = $object->getAttachList($pageLimit['from'],$pageLimit['to']);
		$result['totalCount'] = $object->getCount();
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * email configure
	 */
	function actionEmailCfg()
	{
		$this->name = 'emailcfg';
		$this->show();
	}
	/**
	 * return email json form list
	 */
	function actionEmailList()
	{
		$object = new ModelMessage();
		$list = $object->getEmailList();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($list);
	}
	/**
	 * add/mod email
	 *
	 */
	function actionAddModEmail()
	{
		$object = new ModelMessage();
		try {
			if($object->saveEmail($_POST)){
				echo "{success:true,msg:'OK'}";
				exit;
			}else{
				echo "{success:false,msg:'failure'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}	
	/**
	 * test receive mail server 
	 *
	 */
	function actionTestInServer()
	{
		$db = new ModelMessage();
		$msg='连接失败！';
		try {
			if($db->testInServer($msg)){
				echo "{success:true,msg:'{$msg}'}";
				exit;
			}else{
				echo "{success:true,msg:'{$msg}'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}
	/**
	 * test send mail server 
	 *
	 */
	function actionTestOutServer()
	{
		$object = new ModelMessage();
		try {
			if($object->testOutServer($_POST)){
				echo "{success:true,msg:'OK'}";
				exit;
			}else{
				echo "{success:false,msg:'failure'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}
	
	/**
	 * get outbox 
	 *
	 */
	function actionGetOutBox()
	{
		$object = new ModelMessage();
		$list = $object->getOutBox();
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($list);
	}
	/**
	 * reply inbox's one message
	 *
	 */
	function actionReply()
	{
		$db = new ModelMessage();
		$msg='操作失败！';
		try {
			if($db->reply($msg)){
				echo "{success:true,msg:'{$msg}'}";
				exit;
			}else{
				echo "{success:false,msg:'{$msg}'}";
				exit;
			}
		} catch (Exception $e) {
			echo "{success:'exception',msg:'" . $e->getMessage() . "'}";
			exit;
		}
	}	
	/**
	 * 发送消息页
	 *
	 */
	function actionSend()
	{
		$this->name = 'send';
		if ($_GET['type']=='revert') {
			$message = new ModelMessage();
			$info = $message->getInfo($_GET['id']);
			$info['message_title'] = 're: '.$info['message_title'];
			$info['send_user_id'] = ModelUser::getName($info['send_user_id']);
			$info['content'] = '';
			$info['id'] = '';
			$this->tpl->assign('info',$info);
		} else if ($_GET['id']) {
			$message = new ModelMessage();
			$info = $message->getInfo($_GET['id']);
			$info['message_title'] = $info['message_title'];
			$info['send_user_id'] = $info['receive_users'];
			$info['content'] = $info['content'];
			$info['id'] = $info['id'];
			$this->tpl->assign('info',$info);
		}
		$this->show();
	}
	/**
	 * 查看
	 */
	function actionSee()
	{
		$this->name = 'see';
		$message = new ModelMessage();
		$info = $message->getInfo($_GET['id']);
		$info['send_time'] = MyDate::transform('standard',$info['send_time']);
		$info['send_user_id'] = ModelUser::getName($info['send_user_id']);
		$this->tpl->assign('info',$info);
		$this->show();
		
	}
	/**
	 * 删 除
	 *
	 */
	function actionDelete()
	{
		parent::actionDelete('ModelMessage');
	}
	/**
	 * 逻辑删除
	 *
	 */
	function actionRemove()
	{
		$message = new ModelMessage();
		$message->remove($_GET['ids']);
	}
	/**
	 * 还原删除
	 *
	 */
	function actionRenew()
	{
		$message = new ModelMessage();
		$message->renew($_GET['ids']);
	}
	/**
	 * 保存
	 *
	 */
	function actionSave()
	{
		$object = new ModelMessage();
		try {
			$object->save($_POST);
			echo "{success:true,msg:'OK'}";exit;
		} catch (Exception $e) {
			echo "{success:true,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	/*********
	*****Message加载页面
	*********/
	function actionLoad(){
		parent::actionPrivilege('load_message');
		$d 			= date('Y-m-d');
		$time1 		= strtotime(date("Y-m-d",strtotime("$d -1 day")));
		$time		= date('Y-m-d',$time1);
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('yesterday',$time);
		$this->tpl->assign('today',$d);
		$this->name = 'loadmessage';
		$this->show();
	}
	/*********
	*****Message加载处理
	*********/
	function actionloadebay(){
			$object = new ModelChannel();
			try {
				$msg = explode('|',$object->saveEbaymessage($_GET));
				echo '<br>共有'.$msg[1].'页共'.$msg[2].'条记录';
				if($msg[1] == 0) die('<br>加载完成');
				for($i=1;$i<=$msg[1];$i++){
					$info['id'] = $_GET['id'];
					$info['page'] = $i;
					$msg1 = $object->loadMSGXml($info);
					echo "<br>第".$i."页加载完成，共有".$msg1."条Message被加载";
					if($i == $msg[1]) echo '<br>加载额外message条数'.$object->saveMymessage($_GET);
				}
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			if($errorMsg <>'') echo "<br>加载过程中发生以下错误:'" . $errorMsg . "'";
		$this->name = 'loading';
		$this->dir = 'system';
		$this->show();
	}
	/*********
	*****Message处理页面
	*********/
	function actionHandle(){
		parent::actionPrivilege('handle_message');
		$this->tpl->assign('account',ModelDd::getComboData('ebaycount'));
		$this->tpl->assign('template',ModelDd::getComboData('message_template'));
		$this->tpl->assign('msg_type',ModelDd::getComboData('msg_type'));
		$this->name = 'handlemessage';
		$this->show();
	}
	/*********
	*****Message处理页面
	*********/
	function actiongetmessagelist(){
		$pageLimit = getPageLimit();
		$goods = new ModelMessage();
		$where = $goods->getWhere($_REQUEST);
		$list = $goods->getMessageList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $goods->getMessageCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);		
	}
	/*********
	*****保存message回复
	*********/
	function actionreplyanswer(){
		$object = new ModelChannel();
		try {
			$object->replyanswer($_POST);
			echo "{success:true,msg:'回复成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	function actionchangestatus(){
		$object = new ModelMessage();
		try {
			$object->changestatus($_GET);
			echo "{success:true,msg:'状态更改成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	function actionToPartner()
	{
		$this->tpl->assign('template',ModelDd::getComboData('parnter_template'));
		$this->tpl->assign('order_id',($_GET['order_id'])?$_GET['order_id']:0);
		$this->tpl->assign('title',($_GET['type']==1)?'邮件':'Message');
		$this->tpl->assign('type',(isset($_GET['type']))?$_GET['type']:0);
		$this->tpl->assign('ids',(isset($_GET['ids']))?$_GET['ids']:0);
		$this->name = 'sendmessage';
		$this->show();
	}
	function actionSendmessage()
	{
		$object = new ModelChannel();
		try {
			$object->replypartner($_POST);
			echo "{success:true,msg:'发送成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	/*****
	获取历史message记录
	*****/
	function actiongethistory()
	{
		$object = new ModelMessage();
		$mesagelist = $object->getHistory($_REQUEST);
		$msg ='';
		for($i=0;$i<count($mesagelist);$i++)
		{
			$msg.='<table border="0" cellspacing="0" cellpadding="0" width="100%">';
			$msg.='<tr>';
			$msg.='<th rowspan="3" width="140px" valign="top" align="center" >'.date('Y-m-d',$mesagelist[$i]['CreationDate']).'</th>';
			$msg.='<th><b>'.$mesagelist[$i]['subject'].'</b></th>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#F00"><p>&nbsp;&nbsp;'.$mesagelist[$i]['body'].'</p></td>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#69C">'.($mesagelist[$i]['answer']?(date('Y-m-d',$mesagelist[$i]['endtime']).':<br /><p>&nbsp;&nbsp;'.$mesagelist[$i]['answer'].'</p>'):'').'</td>';
			$msg.='</tr>';
			$msg.='</table>';
			$msg.='<hr/>';
		}
		echo $msg;
	}
	
	function actiongetordermsg()
	{
		$object = new ModelMessage();
		$mesagelist = $object->getordermsg($_REQUEST['order_id']);
		$msg ='';
		for($i=0;$i<count($mesagelist);$i++)
		{
			$msg.='<table border="0" cellspacing="0" cellpadding="0" width="100%">';
			$msg.='<tr>';
			$msg.='<th rowspan="3" width="140px" valign="top" align="center" >'.date('Y-m-d',$mesagelist[$i]['CreationDate']).'</th>';
			$msg.='<th><b>'.$mesagelist[$i]['subject'].'</b></th>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#F00"><p>&nbsp;&nbsp;'.$mesagelist[$i]['body'].'</p></td>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#69C">'.($mesagelist[$i]['answer']?(date('Y-m-d',$mesagelist[$i]['endtime']).':<br /><p>&nbsp;&nbsp;'.$mesagelist[$i]['answer'].'</p>'):'').'</td>';
			$msg.='</tr>';
			$msg.='</table>';
			$msg.='<hr/>';
		}
		echo $msg;
	}
	
	/**
	***查看回复历史MEssage
	*/
	function actionlookmessage()
	{
		$this->tpl->assign('info_SenderID',$_GET['info_SenderID']);
		$this->tpl->assign('info_itemid',$_GET['info_itemid']);
		$this->tpl->assign('info_id',$_GET['info_id']);
		$object = new ModelMessage();
		$mesagelist = $object->getHistory($_GET);
		$msg ='';
		for($i=0;$i<count($mesagelist);$i++)
		{
			$msg.='<table border="0" cellspacing="0" cellpadding="0" width="100%">';
			$msg.='<tr>';
			$msg.='<th rowspan="3" width="140px" valign="top" align="center" >'.date('Y-m-d',$mesagelist[$i]['CreationDate']).'</th>';
			$msg.='<th><b>'.$mesagelist[$i]['subject'].'</b></th>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#F00"><p>&nbsp;&nbsp;'.$mesagelist[$i]['body'].'</p></td>';
			$msg.='</tr>';
			$msg.='<tr>';
			$msg.='<td style="color:#69C">'.($mesagelist[$i]['answer']?(date('Y-m-d',$mesagelist[$i]['endtime']).':<br /><p>&nbsp;&nbsp;'.$mesagelist[$i]['answer'].'</p>'):'').'</td>';
			$msg.='</tr>';
			$msg.='</table>';
			$msg.='<hr/>';
		}
		//var_dump($msg);exit();
		$this->tpl->assign('msg',$msg);
		$this->name = 'lookmessage';
		$this->show();
	}

	function actionchangetype()
	{
		$object = new ModelMessage();
		try {
			$object->changetype($_GET);
			echo "{success:true,msg:'操作成功'}";exit;
		} catch (Exception $e) {
			echo "{success:false,msg:'" . $e->getMessage() . "'}";exit;
		}
	}
	function actiongetallorder()
	{
		$object = new ModelMessage();
		$where = $object->getorderWhere($_POST);
		$list = $object->getorderList($where);
		$result['totalCount'] = $object->getorderCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);		
	}
	/**
	回复者回复数量统计
	*/
	function actionReplyStat()
	{
		$this->name = 'replystat';
		$this->tpl->assign('sales_account',ModelDd::getComboData('account'));
		$this->tpl->assign('admin_id',ModelDd::getComboData('admin_account'));
		$this->show();
	}
	/**
	获取回复者回复数量数据
	*/
	function actionGetReplyStat()
	{
		$pageLimit = getPageLimit();
		$object = new ModelMessage();
		$where = $object->getReplyStatWhere($_POST);
		$list = $object->getReplyStat($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getReplyStatCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);		
	}
	/**
	 * Messagekeyword列表
	 */
	function actionMessagekeyword() {
		$this->tpl->assign('msg_type',ModelDd::getComboData('msg_type'));
		$this->name = 'Messagekeyword';
		$this->show();
	}
	/**
	 *
	 * 返回json列表
	 */
	function actionMessagekeywordWithSearchList()
	{
		$pageLimit = getPageLimit();
		$object = new ModelMessage();
		$where=$object->getWithSearchListWhere($_POST);
		$list = $object->getWithSearchList($pageLimit['from'],$pageLimit['to'],$where);
		$result['totalCount'] = $object->getWithSearchListCount($where);
		$result['topics'] = $list;
		require(CFG_PATH_LIB.'util/JSON.php');
		$json = new Services_JSON();
		echo $json->encode($result);
	}
	/**
	 * 保存Messagekeyword
	 *
	 */
	function actionMessagekeywordSave()
	{
		try {
			$object = new ModelMessage();
			$object->Messagekeywordsave($_POST);
			echo "{success:true,msg:'OK'}";exit;	
		} catch (Exception $e) {
			echo '{success:true,msg:"'.$e->getMessage().'"}';exit;
		}

	}
	function actionMessagekeywordDel()
	{
		$object = new ModelMessage();
		$object->Messagekeyworddelete($_GET['ids']);
		echo "{success:true,msg:'OK'}";exit;
	}
	function actionmodify()
	{
		$object = new ModelMessage();
			try {
					$object->modify($_POST);
					echo "{success:true,msg:'操作已成功'}";exit;
			} catch (Exception $e) {
					$errorMsg = $e->getMessage();
			}
			echo "{success:true,msg:'" . $errorMsg . "'}";exit;
	}		
}
?>