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
 * 消息系统
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelMessage extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'email_msg';
	}
	/**
	 * 保存记录
	 *
	 * @param array $info
	 */
	function save($info)
	{
		$user = new ModelUser();
		$user_id = $user->getAuthInfo('user_id');
		if ($_GET['type']=='draft') {
			$this->db->insert($this->tableName,array(
				'message_title' => $info['message_title'],
				'content' => $info['content'],
				'receive_users' => $info['receive_user'],
				'status' => 1,
				'receive_user_id' => $user_id,
				'send_user_id' => $user_id,
				'send_time' => time(),
				));
		} else {
			$info['receive_user_id'] = $user->getUserIdForName($info['receive_user']);
			if (!$info['receive_user_id']) {
				throw new Exception('该用户不存在！');
			}
			$this->db->insert($this->tableName,array(
				'message_title' => $info['message_title'],
				'content' => $info['content'],
				'send_user_id' => $user_id,
				'receive_user_id' => $info['receive_user_id'],
				'send_time' => time(),
				));
			if ($info['save_send_box']) {
				$this->db->insert($this->tableName,array(
					'message_title' => $info['message_title'],
					'content' => $info['content'],
					'receive_users' => $info['receive_user'],
					'status' => 3,
					'receive_user_id' => $user_id,
					'send_user_id' => $user_id,
					'send_time' => time(),
					));
			}
			if ($info['id']) {
				$this->delete($info['id']);
			}
		
		}
	}
	/**
	 * get email list
	 *
	 * @param array $arr
	 */
	function getEmailList()
	{
		/*if(isset($_POST['email'])&&!empty($_POST['email'])){
		$whstr='WHERE email=\''.trim($_POST['email']).'\'';
		}else**/
		$whstr='';
		$flds='emailcfg_id,email,in_server_addr,in_port,in_protocol,out_server_addr,out_port,out_protocol,addtime,remark';
		$this->db->open('SELECT '.$flds.'
			FROM '.CFG_DB_PREFIX.'email_cfg '.$whstr.' ORDER BY emailcfg_id DESC');
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * save Email
	 *
	 * @param array $arr
	 */
	function saveEmail($arr)
	{
		if(isset($arr['password'])&&!empty($arr['password'])){
			$arr['password']=$arr['password'];
		}else{
		unset($arr['password']);
		}
		if(isset($arr['emailcfg_id'])){
			return $this->db->update(CFG_DB_PREFIX.'email_cfg',$arr,'`emailcfg_id`='.intval($arr['emailcfg_id']));
		}else{
			return $this->db->insert(CFG_DB_PREFIX.'email_cfg',$arr);
		}
	}
	/**
	 *  test send mail server
	 * @param string $whstr
	 */
	function testInServer(&$msg)
	{
		if(empty($_POST['email']))
		return false;
		if(empty($_POST['password'])){
			$email_cfg = $this->db->getValue('select password from '.CFG_DB_PREFIX.'email_cfg where `email`=\''.trim($_POST['email']).'\'');
			if(empty($email_cfg))
			return false;
			$_POST['password']=$email_cfg;
		}
		require(CFG_PATH_LIB.'util/Email.php');
		$mail = new Smllbo_Email();
		$protocol=array('pop3','imap');
		if(isset($_POST['n_ssl']))
		$connect = $mail->mailConnect($_POST['in_server_addr'],$_POST['in_port'],$_POST['email'],$_POST['password'],'INBOX','ssl',$protocol[$_POST['in_protocol']]);
		else
		$connect = $mail->mailConnect($_POST['in_server_addr'],$_POST['in_port'],$_POST['email'],$_POST['password'],'INBOX',$protocol[$_POST['in_protocol']]);
		if($connect){
			$msg='连接成功！';
			return true;
		}else{
			$msg='连接失败！';
			return false;
		}
	}
	/**
	 *  test send mail server
	 * @param string $whstr
	 */
	function testOutServer(&$msg)
	{
		if(!empty($_GET['email'])){
			$whstr=' where `to` like \'%<'.trim($_GET['email']).'>\'';
		}
		else
		return false;
		require(CFG_PATH_LIB.'util/Email.php');
		$mail = new Smllbo_Email();
		$protocol=array('pop3','imap');
		$connect = $mail->mailConnect($_POST['in_server_addr'],$_POST['in_port'],$_POST['email'],$_POST['password'],'INBOX',$protocol[$_POST['in_protocol']]);
		if($connect){
			$msg='连接成功！';
			return true;
		}else{
			$msg='连接失败！';
			return false;
		}
	}			
	/**
	 * get message list
	 *
	 * @param int $from
	 * @param int $to
	 * @return array
	 */
	function getList($box,$from,$to)
	{

		switch ($box) {
			case 'inbox':
				$whstr=' WHERE `boxtype`=0';
				break;
			case 'outbox':
				$whstr=' WHERE `boxtype`=1';
				break;
			default :
				return false;
				break;
		}
		$result['totalCount'] = $this->db->getValue('select count(*) from '.$this->tableName.$whstr);
		$this->db->open('SELECT `email_msg_id`,`from`,`fromName`,`toOther`,`toOtherName`,`subject`,`to`,`uid`,`seen`,`date`,`is_reply` FROM '.$this->tableName.' '.$whstr.' ORDER BY email_msg_id DESC',$from,$to);
		$mailList = array();
		while ($rs = $this->db->next()) {
			$mailList[] = $rs;
		}
		$result['topics'] = $mailList;
		return $result;
	}	
	/**
	 * loaddown email head parts
	 * @param string $whstr
	 */
	function loadDownEmailHeader(&$msg)
	{
		if(!empty($_GET['email'])){
			$whstr=' where `to` like \'%<'.trim($_GET['email']).'>\'';
		}
		else
		return false;
		$email_cfg = $this->db->getValue('select email,password,in_server_addr,in_port,in_protocol,in_ssl from '.CFG_DB_PREFIX.'email_cfg where `email`=\''.trim($_GET['email']).'\'');
		if(empty($email_cfg))
		return false;
		require(CFG_PATH_LIB.'util/Email.php');
		$mail = new Smllbo_Email();
		$protocol=array('pop3','imap');
		if($email_cfg['in_ssl']=='0')
		$connect = $mail->mailConnect($email_cfg['in_server_addr'],$email_cfg['in_port'],$email_cfg['email'],$email_cfg['password'],'INBOX',$protocol[$email_cfg['in_protocol']]);
		else
		$connect = $mail->mailConnect($email_cfg['in_server_addr'],$email_cfg['in_port'],$email_cfg['email'],$email_cfg['password'],'INBOX','ssl',$protocol[$email_cfg['in_protocol']]);
		$attachPath=str_replace('/','\\',CFG_PATH_ROOT.'email_attaches/');
		if($connect){
			$totalCount = $mail->mailTotalCount();
			$result['totalCount'] = $this->db->getValue('select count(*) from '.$this->tableName.$whstr);
			if(!$result['totalCount']) {
				$set_seen_str='';
				for ($i = $totalCount; $i > 0 ; $i --) {
					$mailheader=$mail->mailHeader($i);
					if(!($mailheader['seen']=='U'))
					break;					
					if($mailheader['id'])
					$mailheader['uid']= imap_uid ($connect,$i);
					
					$mailheader['body']=$mail->getBody($i);
					
					if(!isset($value_str)&&empty($value_str)){
						$set_seen_str.=$i;
						$value_str.='(\''.$mailheader['from'].'\',\''.$mailheader['fromName'].'\',\''.$mailheader['toOther'].'\',\''.$mailheader['toOtherName'].'\',\''.$mailheader['subject'].'\',\''.$mailheader['to'].'\',\''.$mailheader['uid'].'\',\''.$mailheader['seen'].'\',\''.$mailheader['date'].'\',\''.$mailheader['body'].'\')';				
					}else{
						$set_seen_str.=','.$i;
						$value_str.=',(\''.$mailheader['from'].'\',\''.$mailheader['fromName'].'\',\''.$mailheader['toOther'].'\',\''.$mailheader['toOtherName'].'\',\''.$mailheader['subject'].'\',\''.$mailheader['to'].'\',\''.$mailheader['uid'].'\',\''.$mailheader['seen'].'\',\''.$mailheader['date'].'\',\''.$mailheader['body'].'\')';				
					}
					 $attach=$mail->getAttach($i,$attachPath.'/'.$mailheader['uid']);
					 $this->saveEmailAttach($attach,$mailheader['uid']);
				}
			}else{
				 $max_uid=$this->db->getValue('select max(uid) FROM '.$this->tableName);
				 $net_max_uid=imap_uid($connect,$totalCount);
				 if($net_max_uid>$max_uid){
					for ($i = $totalCount; $i > 0 ; $i --) {
						$mailheader=$mail->mailHeader($i);
						if(!($mailheader['seen']=='U'))
						break;					
						if($mailheader['id'])
						$mailheader['uid']= imap_uid ($connect,$i);
						
						if($mailheader['uid']==$max_uid)
						break;					
						$mailheader['body']=$mail->getBody($i);
						if(!isset($value_str)&&empty($value_str)){
							$set_seen_str.=$i;
							$value_str.='(\''.$mailheader['from'].'\',\''.$mailheader['fromName'].'\',\''.$mailheader['toOther'].'\',\''.$mailheader['toOtherName'].'\',\''.$mailheader['subject'].'\',\''.$mailheader['to'].'\',\''.$mailheader['uid'].'\',\''.$mailheader['seen'].'\',\''.$mailheader['date'].'\',\''.$mailheader['body'].'\')';				
						}else{
							$set_seen_str.=','.$i;
							$value_str.=',(\''.$mailheader['from'].'\',\''.$mailheader['fromName'].'\',\''.$mailheader['toOther'].'\',\''.$mailheader['toOtherName'].'\',\''.$mailheader['subject'].'\',\''.$mailheader['to'].'\',\''.$mailheader['uid'].'\',\''.$mailheader['seen'].'\',\''.$mailheader['date'].'\',\''.$mailheader['body'].'\')';				
						}
						 $attach=$mail->getAttach($i,$attachPath.'/'.$mailheader['uid']);
						 $this->saveEmailAttach($attach,$mailheader['uid']);
					}
				 }
			}
			if(!empty($value_str)){
				$mail->mailRead('\''.$set_seen_str.'\'');
				$flds='(`from`,`fromName`,`toOther`,`toOtherName`,`subject`,`to`,`uid`,`seen`,`date`,`body`)';
				return $this->db->execute('INSERT INTO `'.$this->tableName.'` '.$flds.' VALUES'.$value_str);
			}else{
				$msg='没有可加载的邮件！';
				return false;
			}
		}else{
			$msg='连接失败！';
			return false;
		}
	}
	function saveEmailAttach($attach,$email_uid){
		$flds='(`path`,`email_uid`)';
		
		if(!(is_array($attach)&&count($attach)>2))
		return false;
		 $attach=array_slice($attach,1);
		foreach($attach as $val){
		
			if(!isset($value_str)&&empty($value_str)){
			$value_str.="('{$val}','{$email_uid}')";
			}else{
			$value_str.=",('{$val}','{$email_uid}')";
			}	
				
		}
		return $this->db->execute('INSERT INTO `'.CFG_DB_PREFIX.'email_attach` '.$flds.' VALUES'.$value_str);	
	}
	/**
	 * get message  detail
	 * @return array
	 */
	function getMailDetail()
	{
		if(intval($_GET['id'])<0)
		return false;
		$mail_info=$this->db->getValue('select * from '.$this->tableName.' where `email_msg_id`=\''.intval($_GET['id']).'\'');
		if(!empty($mail_info)){
			$mail_info['to']=str_replace(array('<','>'),array('&lt;','&gt;'),$mail_info['to']);
			$mail_info['attaches']=$this->getAttachList($mail_info['uid']);
		}
		return $mail_info;
	}
	function delMail(&$msg){
		$result1=$this->db->execute('DELETE FROM `'.CFG_DB_PREFIX.'email_attach` WHERE `'.CFG_DB_PREFIX.'email_attach`.`email_uid` = \''.$_GET['uid'].'\'');
		$result2=$this->db->execute('DELETE FROM `'.$this->tableName.'` WHERE `'.$this->tableName.'`.`uid` = \''.$_GET['uid'].'\' LIMIT 1');
		$attachPath=str_replace('/','\\',CFG_PATH_ROOT.'email_attaches/');
		@unlink($attachPath.$_GET['uid'].'/'.'*');
		@unlink($attachPath.$_GET['uid']);
		if($result1&&$result2){
			$msg='删除成功！';
			return true;
		}else{
			$msg='删除失败！';
			return false;
		}
	}	
	/**
	 * get CustomerOrder
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getAttachList($uid)
	{
		if(intval($uid)>0){
		$whstr='WHERE email_uid=\''.intval($uid).'\'';
		}else
		return false;
		$flds='`path`';
		$this->db->open('SELECT '.$flds.'
			FROM '.CFG_DB_PREFIX.'email_attach '.$whstr.' ORDER BY email_attach_id DESC');
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * get OutBox list
	 *
	 */
	function getOutBox()
	{
		if(isset($_GET['id'])){
		$whstr='WHERE email_msg_id=\''.trim($_GET['id']).'\'';
		}else
		return '[]';
		$this->db->open('SELECT *
			FROM '.CFG_DB_PREFIX.'outbox '.$whstr.' ORDER BY outbox_id DESC');
			
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$rs['manage_user'] = 'admin';
			$result[] = $rs;
		}
		
		return $result;
	}	
	/**
	 * reply inbox's one message
	 *
	 */
	function reply(&$msg)
	{
		if(intval($_POST['email_msg_id'])>0){
			// leave placeholder for send message really
			$msg='操作成功！';
			$_POST['addtime']=CFG_TIME;
			$_POST['user_id']=1;
			$this->db->update($this->tableName,array('is_reply'=>'1'),'`email_msg_id`='.intval($_POST['email_msg_id']));
			return $this->db->insert(CFG_DB_PREFIX.'outbox',$_POST);	
		}else
		return false;	
	}		
	/**
	 * 逻辑删除
	 *
	 * @param int $id
	 */
	function remove($id)
	{
		$this->db->update($this->tableName,array('status'=>2),'id in ('.$id.')');
	}
	/**
	 * 还原删除
	 *
	 * @param int $id
	 */
	function renew($id)
	{
		$this->db->update($this->tableName,array('status'=>0),'id in ('.$id.')');
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhere($info) {
		specConvert($info,array('answerstatus','accountid','key','starttime','totime'));
		$wheres = array();
			if ($info['answerstatus'] != 2 && $info['answerstatus'] !='') {
				$wheres[] = 'answerstatus=\''.$info['answerstatus'].'\'';
			}
			if ($info['accountid'] != 0 && $info['accountid'] != '') {
				$wheres[] = 'accountid=\''.$info['accountid'].'\'';
			}
			if ($info['msg_type'] != '') {
				$wheres[] = 'msg_type=\''.$info['msg_type'].'\'';
			}
			if ($info['key'] != '') {
				$wheres[] = 'SenderID=\''.$info['key'].'\' or body like \'%'.$info['key'].'%\'';
			}
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'CreationDate between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'CreationDate < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'CreationDate > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	*获取message列表
	*
	*
	**/
	function getMessageList($from,$to,$where=null){
		$this->db->open('select * from '.CFG_DB_PREFIX . 'ebaymessage '.$where.' order by id desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['CreationDate'] = date('Y-m-d',$rs['CreationDate']);
			$rs['itemEndTime'] = (date('Y-m-d',$rs['add_time']) > date('Y-m-d'))?'Active':'Ended';
			$rs['has_history'] = ($this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX . 'ebaymessage WHERE itemid="'.$rs['itemid'].'" and SenderID = "'.$rs['SenderID'].'" and id !='.$rs['id'])>0)?1:0;
			
			$rs['body'] = nl2br($rs['body']);
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getMessageCount($where=null) {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'ebaymessage '.$where);
	}
	
	function changestatus($info)
	{
		return $this->db->execute("UPDATE ".CFG_DB_PREFIX . "ebaymessage set answerstatus ='".$info['statustype']."' where id in(".$info['ids'].")");
	}
	/*****************
	***param array $info
	****return  array
	******************/
	function getHistory($info)
	{
		return $this->db->select('SELECT subject,answer,body,CreationDate,endtime FROM '.CFG_DB_PREFIX . 'ebaymessage WHERE itemid="'.$info['info_itemid'].'" and SenderID = "'.$info['info_SenderID'].'" and id !='.$info['info_id']);
	}
	
	function getordermsg($orderid)
	{
		$userid = $this->db->getValue("SELECT userid FROM ".CFG_DB_PREFIX."order where order_id = '".$orderid."'");
		return $this->db->select('SELECT subject,answer,body,CreationDate,endtime FROM '.CFG_DB_PREFIX . 'ebaymessage WHERE itemid in ( select item_no FROM '.CFG_DB_PREFIX.'order_goods where order_id = "'.$orderid.'") and SenderID = "'.addslashes($userid).'"');
	}
	
	function changetype($info)
	{
		return $this->db->execute("UPDATE ".CFG_DB_PREFIX . "ebaymessage set msg_type ='".$info['msg_type']."' where id in(".$info['ids'].")");	
	}
	
	
	function getorderWhere($info)
	{
		$wheres = array();
		$wheres[] = 'm.Sales_account_id = "'.$info['Sales_account_id'].'"';
		$wheres[] = 'n.item_no = "'.$info['itemid'].'"';
		$wheres[] = 'm.userid = "'.$info['buyerid'].'"';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;			
	}
	
	function getorderList($where)
	{
		$this->db->open("SELECT m.order_id,m.order_sn,m.track_no,m.order_status,m.end_time,m.street1,m.street2,m.consignee,m.city,m.state,m.zipcode,m.country,m.tel FROM ".CFG_DB_PREFIX."order as m left join ".CFG_DB_PREFIX."order_goods as n on m.order_id = n.order_id".$where." order by m.order_id desc");
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_ORDER_PREFIX.$rs['order_sn'];
			$rs['order_status'] = ModelDd::getCaption('orderstatus',$rs['order_status']);
			$rs['end_time'] = MyDate::transform('date',$rs['end_time']);
			$result[] = $rs;
		}
		return $result;
	}
	function getorderCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM  ".CFG_DB_PREFIX."order as m left join ".CFG_DB_PREFIX."order_goods as n on m.order_id = n.order_id".$where);
	}
	/**
	 * 获取回复者回复数量数据
	 * @param int $from
	 * @param int $to
	 */
	function getReplyStat($from,$to,$where)
	{
		$sql='SELECT count(id) as message_count,admin_id FROM '.$this->tableName.$where.' group by admin_id order by id desc';
		$this->db->open($sql,$from,$to);
		$list = array();
		while ($rs = $this->db->next()) {
			$list[] = $rs;
		}
		return $list;
	}
	function getReplyStatWhere($arr){
		return ' where endtime between '.strtotime($arr['starttime']).' and '.strtotime($arr['endtime']).(empty($arr['Sales_account'])?'':' and accountid='.$arr['Sales_account']);
	}
	function getReplyStatCount($where){
		return $this->db->getValue('SELECT count(*) FROM '.$this->tableName.$where.' group by admin_id');
	}
	
	function getWithSearchList($from,$to,$where='')
	{
		$this->db->open('SELECT * FROM '.CFG_DB_PREFIX . 'message_keyword'.$where.' order by id desc',
		$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['addtime'] = MyDate::transform('date',$rs['addtime']);
			$result[] = $rs;
		}
		return $result;
	}
	function getWithSearchListWhere($info)
	{
		$wheres = array();
		if(!empty($info['msg_type_id']))
			$wheres[] = 'msg_type_id='.$info['msg_type_id'];
		if(!empty($info['keywords']))
			$wheres[] = 'keywords like\'%'.$info['keywords'].'%\'';
		$where = '';
		if ($wheres) {
			$where = ' where ' .implode(' and ', $wheres);
		}
		return $where;	
			
	}
	function getWithSearchListCount($where)
	{
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'message_keyword'.$where);
	}
	/**
	*根据关键字设定ebaymessage分类
	*@param  strings $str
	*return  分类id
	*/
	function getMatchKeywordToMsgType($str){
		$this->db->open('SELECT msg_type_id,keywords FROM '.CFG_DB_PREFIX . 'message_keyword');
		while ($rs = $this->db->next()) 
		{
			if (preg_match ('/'.$rs['keywords'].'/i', $str)) {
				return $rs['msg_type_id'];
			}
		}
		return 0;
	}
	/**
	 * 保存记录
	 * @param array $info
	 */
	public function Messagekeywordsave($info)
	{
		if(isset($info['create'])) unset($info['create']);
		if (empty($info['id'])) {
			$info['addtime'] = CFG_TIME;
			$this->db->insert(CFG_DB_PREFIX . 'message_keyword',$info);
		} else {
			$this->db->update(CFG_DB_PREFIX . 'message_keyword',$info,'id='.intval($info['id']));
		}
	}
	/**
	 * 删除记录
	 * @param array $info
	 */
	public function Messagekeyworddelete($ids)
	{
		return $this->db->execute('delete from '.CFG_DB_PREFIX . 'message_keyword'
				.' where id in ('.$ids.')');
	}
	
	function modify($info)
	{
		$this->db->execute('UPDATE '.CFG_DB_PREFIX . 'ebaymessage SET '.$info['field'].'= \''.addslashes($info['value']).'\' WHERE id = '.$info['id']);
	}
}
?>	