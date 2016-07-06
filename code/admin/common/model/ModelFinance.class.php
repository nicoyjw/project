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
 * case操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelFinance extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'cf_order';
		$this->rftableName = CFG_DB_PREFIX . 'rf_order';
		$this->gftableName = CFG_DB_PREFIX . 'gf_order';
		$this->primaryKey = 'rec_id';
	}
	function getTableCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.$where);
	}

	function saveFee($info)
	{
		if (empty($info['rec_id'])) {
			try{
			$this->db->insert($this->tableName,array(
				'order_sn' => $this->get_order_sn(),
				'fee_type' => $info['fee_type'],
				'amt' => $info['amt'],
				'currency' => $info['currency'],
				'add_time' => CFG_TIME,
				'add_user' => $_SESSION['admin_id'],
				'comment' => $info['comment'],
				'account_id' =>$info['account_id'],
				'status'=> 0
				));
			} catch (Exception $e) {
				throw new Exception('新增费用单失败','601');exit();
			}
		} else {
			try{
			$this->db->update($this->tableName,array(
				'fee_type' => $info['fee_type'],
				'amt' => $info['amt'],
				'currency' => $info['currency'],
				'comment' => $info['comment'],
				'account_id' =>$info['account_id']
				),'rec_id='.intval($info['rec_id']));
			} catch (Exception $e) {
				throw new Exception('费用单失败','602');exit();
			}
		}
	}
	function getFeeInfo($id)
	{
		return $this->db->getValue("SELECT * FROM ".$this->tableName." WHERE rec_id = '".$id."'");
	}
	
	function getFeeList($from=null,$to=null,$where=null)
	{
		$user = ModelDd::getArray('user');
		$type = ModelDd::getArray('fee_type');
		$status=array(0=>'未确认款项',1=>'已确认款项', 2=>'已付款');
		if($from && $to){
		$this->db->open('select b.account,cf.* from '.$this->tableName.' cf left join '.CFG_DB_PREFIX.'bank b on cf.account_id=b.id '.$where.' order by rec_id desc',$from,$to);
		}else{
		$this->db->open('select b.account,cf.* from '.$this->tableName.' cf left join '.CFG_DB_PREFIX.'bank b on cf.account_id=b.id '.$where.' order by rec_id desc');
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_CF_ORDER_PREFIX.$rs['order_sn'];
			$rs['add_time'] =  MyDate::transform('date',$rs['add_time']);
			$rs['confirm_time'] =  MyDate::transform('date',$rs['confirm_time']);
			$rs['fee_type_name'] = $type[$rs['fee_type']];
			$rs['add_user'] = $user[$rs['add_user']];
			$rs['confirm_user'] = $user[$rs['confirm_user']];
			$rs['account_id'] = $rs['account'];
			$rs['status'] = $status[$rs['status']];
			$result[] = $rs;
		}
		return $result;
	}
	
	function getFeeCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.' cf '.$where);
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhereFee($info) {
		$wheres = array();
		if($info['totime'] <> '' && $info['starttime'] <> '') 
		$wheres[] = 'cf.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'cf.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'cf.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function delFee($ids)
	{
		$this->db->execute("delete  FROM ".$this->tableName." WHERE ".$this->primaryKey." in (".$ids.")");	
	}
	
	/*********
	****保存收款单
	**param array $info
	
	*********/
	function saverf($info)
	{
		if(substr($info['relate_order_sn'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX) $info['relate_order_sn'] = substr($info['relate_order_sn'],strlen(CFG_ORDER_PREFIX));
		if (empty($info['rec_id'])) {
			try{
			$this->db->insert($this->rftableName,array(
				'order_sn' => $this->get_order_sn(),
				'relate_order_sn' => $info['relate_order_sn'],
				'payment_id' => $info['payment_id'],
				'paypalid' => $info['paypalid'],
				'amt' => $info['amt'],
				'feeamt' => $info['feeamt'],
				'currency' => $info['currency'],
				'paid_time' =>MyDate::transform('timestamp',$info['paid_time']),
				'add_time' => CFG_TIME,
				'add_user' => $_SESSION['admin_id'],
				'comment' => $info['comment'],
				'paid_money'=>$info['paid_money'],
				'account_id' =>$info['account_id'],
				'status'=> 0
				));
			} catch (Exception $e) {
				throw new Exception('新增收款单失败','601');exit();
			}
			if($info['paypalid']) $this->db->execute("update ".CFG_DB_PREFIX."paypal_order  set status = 1 WHERE paypalid = '".$info['paypalid']."'");
			
		} else {
			try{
			$this->db->update($this->rftableName,array(
				'relate_order_sn' => $info['relate_order_sn'],
				'payment_id' => $info['payment_id'],
				'paypalid' => $info['paypalid'],
				'amt' => $info['amt'],
				'feeamt' => $info['feeamt'],
				'currency' => $info['currency'],
				'paid_time' =>MyDate::transform('timestamp',$info['paid_time']),
				'comment' => $info['comment'],
				'paid_money'=>$info['paid_money'],
				'account_id' =>$info['account_id']
				),'rec_id='.intval($info['rec_id']));
			} catch (Exception $e) {
						throw new Exception('编辑收款单失败','602');exit();
			}
		}
	}
	
	function getRfInfo($id)
	{
		$info=$this->db->getValue("SELECT * FROM ".$this->rftableName." WHERE rec_id = '".$id."'");
		if($info){
			$info['CURRENCYCODE']=$info['currency'];
			$info['FEEAMT']=$info['feeamt'];
			$info['AMT']=$info['amt'];
			$info['ORDERTIME']=$info['paid_time'];
			$info['note']=$info['comment'];
		}
		return $info;
	}
	
	function getRfList($from=null,$to=null,$where=null)
	{
		$user = ModelDd::getArray('user');
		$type = ModelDd::getArray('payment');
		$status=array(0=>'未确认款项',1=>'已确认款项', 2=>'已收款');
		if($from && $to){
			$this->db->open('select b.account,rf.* from '.$this->rftableName.' rf left join '.CFG_DB_PREFIX.'bank b on rf.account_id=b.id '.$where.' order by rf.rec_id desc',$from,$to);
		}else{
			$this->db->open('select b.account,rf.* from '.$this->rftableName.' rf left join '.CFG_DB_PREFIX.'bank b on rf.account_id=b.id '.$where.' order by rf.rec_id desc');
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_RF_ORDER_PREFIX.$rs['order_sn'];
			$rs['relate_order_sn'] = CFG_ORDER_PREFIX.$rs['relate_order_sn'];
			$rs['add_time'] =  MyDate::transform('date',$rs['add_time']);
			$rs['paid_time'] =  MyDate::transform('date',$rs['paid_time']);
			$rs['payment'] = $type[$rs['payment_id']];
			$rs['status'] = $status[$rs['status']];
			$rs['add_user'] = $user[$rs['add_user']];
			$rs['account_id'] = $rs['account'];
			$rs['confirm_time'] =  MyDate::transform('date',$rs['confirm_time']);
			$rs['confirm_user'] = $user[$rs['confirm_user']];
			$result[] = $rs;
		}
		return $result;
	}	
	
	function getRfCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.' rf '.$where);
	}
	
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhereRf($info) {
		$wheres = array();
		if($info['totime'] <> '' && $info['starttime'] <> '') 
		$wheres[] = 'rf.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'rf.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'rf.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function delrf($ids)
	{
		$this->db->execute("delete  FROM ".$this->rftableName." WHERE ".$this->primaryKey." in (".$ids.")");	
	}
	/*********
	****保存付款单
	**param array $info
	*********/
	function savegf($info)
	{
		if(substr($info['relate_order_sn'],0,strlen(CFG_ORDER_PREFIX)) == CFG_ORDER_PREFIX) $info['relate_order_sn'] = substr($info['relate_order_sn'],strlen(CFG_ORDER_PREFIX));
		if (empty($info['rec_id'])) {
			try{
			$this->db->insert($this->gftableName,array(
				'order_sn' => $this->get_order_sn(),
				'relate_order_sn' => $info['relate_order_sn'],
				'payment_id' => $info['payment_id'],
				'paypalid' => $info['paypalid'],
				'amt' => $info['amt'],
				'currency' => $info['currency'],
				'paid_time' =>MyDate::transform('timestamp',$info['paid_time']),
				'add_time' => CFG_TIME,
				'add_user' => $_SESSION['admin_id'],
				'comment' => $info['comment'],
				'account_id' =>$info['account_id'],
				'status'=> 0
				));
			if($info['paypalid']) $this->db->execute("update ".CFG_DB_PREFIX."paypal_order  set status = 1 WHERE paypalid = '".$info['paypalid']."'");
			if($info['relate_order_sn']) $this->db->execute("update ".CFG_DB_PREFIX."rma  set rma_status = 3 WHERE rma_status=0 and order_sn = '".$info['relate_order_sn']."'");
			} catch (Exception $e) {
				throw new Exception('新增付款单失败','601');exit();
			}
		} else {
			try{
			$this->db->update($this->gftableName,array(
				'order_sn' => $this->get_order_sn(),
				'relate_order_sn' => $info['relate_order_sn'],
				'payment_id' => $info['payment_id'],
				'paypalid' => $info['paypalid'],
				'amt' => $info['amt'],
				'currency' => $info['currency'],
				'paid_time' =>MyDate::transform('timestamp',$info['paid_time']),
				'comment' => $info['comment'],
				'account_id' =>$info['account_id']
				),'rec_id='.intval($info['rec_id']));
			} catch (Exception $e) {
						throw new Exception('编辑付款单失败','602');exit();
			}
		}
	}
	function getGfInfo($id)
	{
		$info=$this->db->getValue("SELECT * FROM ".$this->gftableName." WHERE rec_id = '".$id."'");
		$info['CURRENCYCODE']=$info['currency'];
		$info['FEEAMT']=$info['feeamt'];
		$info['AMT']=$info['amt'];
		$info['ORDERTIME']=$info['paid_time'];
		$info['note']=$info['comment'];
		return $info;
	}
	
	function getGfList($from=null,$to=null,$where=null)
	{
		$user = ModelDd::getArray('user');
		$type = ModelDd::getArray('payment');
		$status=array(0=>'未确认款项',1=>'已确认款项', 2=>'已付款');
		if($from && $to){
			$this->db->open('select b.account,gf.* from '.$this->gftableName.' gf left join '.CFG_DB_PREFIX.'bank b on gf.account_id=b.id '.$where.' order by rec_id desc',$from,$to);
		}else{
			$this->db->open('select b.account,gf.* from '.$this->gftableName.' gf left join '.CFG_DB_PREFIX.'bank b on gf.account_id=b.id '.$where.' order by rec_id desc');
		}
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['order_sn'] = CFG_RF_ORDER_PREFIX.$rs['order_sn'];
			$rs['relate_order_sn'] = CFG_ORDER_PREFIX.$rs['relate_order_sn'];
			$rs['add_time'] =  MyDate::transform('date',$rs['add_time']);
			$rs['paid_time'] =  MyDate::transform('date',$rs['paid_time']);
			$rs['status'] = $status[$rs['status']];
			$rs['payment'] = $type[$rs['payment_id']];
			$rs['add_user'] = $user[$rs['add_user']];
			$rs['account_id'] = $rs['account'];
			$rs['confirm_time'] =  MyDate::transform('date',$rs['confirm_time']);
			$rs['confirm_user'] = $user[$rs['confirm_user']];
			$result[] = $rs;
		}
		return $result;
	}
	
	function getGfCount($table,$where=null) {
		return $this->db->getValue('select count(*) from '.$table.' gf '.$where);
	}
	
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhereGf($info) {
		$wheres = array();
		if($info['totime'] <> '' && $info['starttime'] <> '') 
		$wheres[] = 'gf.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'gf.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'gf.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	
	function delgf($ids)
	{
		 $this->db->execute("delete  FROM ".$this->gftableName." WHERE ".$this->primaryKey." in (".$ids.")");	
	}
	
	/*********
	**获取paypal交易流水信息
	*******/
	function getpaypalinfo($pid)
	{
		return $this->db->getValue("SELECT * FROM ".CFG_DB_PREFIX."paypal_order WHERE paypalid = '".$pid."'");
	}
	/*********
	**关联付款单
	*******/
	function relategf($info)
	{
		if($this->db->execute("UPDATE ".$this->gftableName." set paypalid = '".$info['paypalid']."' where order_sn = '".substr($info['ordersn'],strlen(CFG_RF_ORDER_PREFIX))."'")) $this->db->execute("update ".CFG_DB_PREFIX."paypal_order  set status = 1 WHERE paypalid = '".$info['paypalid']."'");
	}
	/**
	 * 得到新订单号
	 * @return  string
	 */
	function get_order_sn()
	{
		/* 选择一个随机的方案 */
		mt_srand((double) microtime() * 1000000);
		return date('ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
	}
	
	/**
	 * 得到账户信息
	 * @return  string
	 */
	function getBankInfo($id)
	{
		return $this->db->getValue("SELECT * FROM ".CFG_DB_PREFIX."bank WHERE id = '".$id."'");
	}
	/**
	 * 得到账户信息
	 * @return  string
	 */
	function getBankInfoByAccount($account)
	{
		return $this->db->getValue("SELECT * FROM ".CFG_DB_PREFIX."bank WHERE account = '".$account."'");
	}
	/**
	 *保存账户信息
	 * @return  string
	 */
	function saveBank($info)
	{
		$log=array('deal_type'=>3,'balance'=>$info['money'],'add_user'=>$_SESSION['admin_id']);
		
		if (empty($info['id'])) {
			$this->db->insert(CFG_DB_PREFIX.'bank',array(
				'account'=>$info['account'],
				'money'=>$info['money'],
				'users'=>','.$info['users'].',',
				'add_user'=>$_SESSION['admin_id'],
				'add_time'=>CFG_TIME
				));
			$log['account_id']=$this->db->getInsertId();
			$log['comment']='新增账户'.$info['account'].'的记录';
		} else {
			$log['account_id']=$info['id'];
			//取得原始账户对象
			$bank=$this->getBankInfo($log['account_id']);
			//增加备注
			$log['comment']='更改账户'.$bank['account'].'的记录';
			//计算增加金额
			$log['money']=round($info['money']-$bank['money'],2);
			//更新账户
			$this->db->update(CFG_DB_PREFIX.'bank',array(
				'money'=>$info['money'],
				'users'=>','.$info['users'].',',
				),'id='.intval($info['id']));
		}
		$this->saveBankLog($log);
	}
	/**
	*删除账户
	*/
	function delBank($ids)
	{
		$log=array('deal_type'=>3,'balance'=>0,'add_user'=>$_SESSION['admin_id']);
		foreach(explode(',',$ids) as $id){
			$log['account_id']=$id;
			//取得原始账户对象
			$bank=$this->getBankInfo($id);
			//增加备注
			$log['comment']='删除账户'.$bank['account'].'的记录';
			//计算增加金额
			$log['money']=round(0-$bank['money'],2);
			$this->saveBankLog($log);
		}
		return $this->db->execute('delete FROM '.CFG_DB_PREFIX.'bank WHERE id in ('.$ids.')');	
	}
	/**
	 *账户List 分页
	 * @return  string
	 */
	function getBankList($from,$to,$where=null){
		if($from && $to){
			$this->db->open('select * from '.CFG_DB_PREFIX.'bank '.$where.' ORDER BY add_time DESC',$from,$to);
		}else{
			$this->db->open('select * from '.CFG_DB_PREFIX.'bank '.$where.' ORDER BY add_time DESC');
		}
		while ($rs = $this->db->next()) {		
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);	
			$result[]=$rs;
		}
		return $result;
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhereBank($info) {
		$wheres = array();
		if($info['totime'] <> '' && $info['starttime'] <> '') 
		$wheres[] = 'add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	/**
	 * 得到账户流水
	 * @return  string
	 */
	function saveBankLog($info)
	{
		return $this->db->insert(CFG_DB_PREFIX.'bank_log',array(
			'account_id'=>$info['account_id'],
			'deal_type'=>$info['deal_type'],
			'order_sn'=>$info['order_sn'],
			'money'=>$info['money'],
			'time'=>CFG_TIME,
			'add_user'=>$info['add_user'],
			'confirm_user'=>$_SESSION['admin_id'],
			'comment'=>$info['comment'],
			'balance'=>$info['balance']
			));
	}
	/**
	 * 得到用户使用账户的权限
	 * @return  string
	 */
	function getPowerBank()
	{
		$this->db->open('select id,account from '.CFG_DB_PREFIX.'bank where users like \'%,'.$_SESSION['admin_id'].',%\' ORDER BY add_time DESC');
		
		while ($rs = $this->db->next()) {
			$result[]='['.$rs['id'].',\''.$rs['account'].'\']';
		}
		return $result?implode(',',$result):'';
	}
	/**
	 *账户日志List
	 * @return  string
	 */
	function getBankLogList($from,$to,$where=null){
		if($from && $to){
			$this->db->open('select b.account,bg.* from '.CFG_DB_PREFIX.'bank b left join '.CFG_DB_PREFIX.'bank_log bg on bg.account_id=b.id '.$where.' ORDER BY bg.time DESC',$from,$to);
		}else{
			$this->db->open('select b.account,bg.* from '.CFG_DB_PREFIX.'bank b left join '.CFG_DB_PREFIX.'bank_log bg on bg.account_id=b.id '.$where.' ORDER BY bg.time DESC');
		}
		while ($rs = $this->db->next()) {
			//0为收款 1为付款 2为费用 3为更改
			switch($rs['deal_type']){
				case 0:
					$rs['deal_type']='收款';
					$rs['order_sn']=$rs['order_sn']?'FKD'.$rs['order_sn']:'';
				break;
				case 1:
					$rs['deal_type']='付款';
					$rs['order_sn']=$rs['order_sn']?'FKD'.$rs['order_sn']:'';
				break;
				case 2:
					$rs['deal_type']='费用';
					$rs['order_sn']=$rs['order_sn']?'FYD'.$rs['order_sn']:'';
				break;
				case 3:
					$rs['deal_type']='账户改动';
					$rs['order_sn']=$rs['order_sn']==0?'':$rs['order_sn'];
				break;
			}
			$rs['time'] =  MyDate::transform('date',$rs['time']);
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['confirm_user'] = ModelDd::getCaption("user",$rs['confirm_user']);
			$rs['type']=$rs['money']>0?'收入':'支出';
			$rs['money']=abs($rs['money']);
			$result[]=$rs;
		}
		return $result;
	}
	
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhereBankLog($info) {
		$wheres = array();
		if ($info['type'] != -1 && $info['type']<> '') $wheres[] = 'bg.money '.($info['type']==0?'>':'<='). '0';
		if ($info['account_id'] != -1 && $info['account_id']<> '') $wheres[] = 'bg.account_id=\''.$info['account_id'].'\'';
		if ($info['deal_type'] != -1 && $info['deal_type']<> '') $wheres[] = 'bg.deal_type=\''.$info['deal_type'].'\'';
		if($info['totime'] <> '' && $info['starttime'] <> '') 
		$wheres[] = 'bg.time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> '' && $info['starttime'] == '') $wheres[] = 'bg.time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> '') $wheres[] = 'bg.time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	
	function getBankLogCount($where) {
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'bank b left join '.CFG_DB_PREFIX.'bank_log bg on bg.account_id=b.id '.$where);
	}	
	function getUpdateConfirm($info) {
		//更改账款状态
		$objs=array();
		$objs['status']=$info['status'];
		if($info['status']==2){
			$objs['confirm_user']=$_SESSION['admin_id'];
			$objs['confirm_time']=CFG_TIME;
		}
		switch($info['deal_type']){
			case 0:
				$this->db->update($this->rftableName,$objs,'rec_id='.intval($info['id']));
				$result=$this->db->getValue("SELECT * FROM ".$this->rftableName." WHERE rec_id = '".$info['id']."'");
			break;
			case 1:
				$this->db->update($this->gftableName,$objs,'rec_id='.intval($info['id']));
				$result=$this->db->getValue("SELECT * FROM ".$this->gftableName." WHERE rec_id = '".$info['id']."'");
				$result['paid_money']=$result['amt'];
			break;
			case 2:
				$this->db->update($this->tableName,$objs,'rec_id='.intval($info['id']));
				$result=$this->db->getValue("SELECT * FROM ".$this->tableName." WHERE rec_id = '".$info['id']."'");
				$result['paid_money']=$result['amt'];
			break;
		}
		//更新账户金额
		if($result && $info['status']==1){
			$bank=$this->getBankInfo($result['account_id']);
			if($info['deal_type']!=0){
				$datas['pay_money']=round($bank['pay_money']+$result['paid_money'],2);
			}else{
				$datas['collect_money']=round($bank['collect_money']+$result['paid_money'],2);
			}
			$this->db->update(CFG_DB_PREFIX.'bank',$datas,'id='.intval($result['account_id']));
		}elseif($result && $info['status']==2){
			if($result){
				$this->updateBank($result,$info['deal_type']);
			}
		}
	}
	
	/**
	 *更新账户余额
	 * @return  string
	 */
	function updateBank($info,$deal_type)
	{
		//进行汇率计算
		require_once(CFG_PATH_DATA . 'dd/currency.php');
		$info['paid_money']=round($info['paid_money']*($currency[$info['currency']]?$currency[$info['currency']]:1),2);
		//增减款项用提交方式确定
		if($deal_type!=0){
			$info['paid_money']=round(0-$info['paid_money'],2);
		}
		$log=array('deal_type'=>$deal_type,'money'=>$info['paid_money']);
		if (empty($info['rec_id'])) {
			$log['add_user']=$info['add_user'];
		}else{
			$log['add_user']=$_SESSION['admin_id'];
		}
		$log['order_sn']=$info['order_sn'];
		$log['comment']=$info['comment'];
		$log['account_id']=$info['account_id'];
		
		$bank=$this->getBankInfo($info['account_id']);
		$log['balance']=round($bank['money']+$log['money'],2);
		$this->saveBankLog($log);
		
		$datas=array('money'=>$log['balance']);
		if($deal_type!=0){
			$datas['pay_money']=round($bank['pay_money']-abs($info['paid_money']),2);
		}else{
			$datas['collect_money']=round($bank['collect_money']-abs($info['paid_money']),2);
		}
		$this->db->update(CFG_DB_PREFIX.'bank',$datas,'id='.intval($log['account_id']));
	}
}
?>