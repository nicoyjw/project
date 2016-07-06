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
 * 快递规则类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelExpress extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'express_rule';
		$this->MarktableName = CFG_DB_PREFIX . 'shipping_mark';
		$this->UnMarktableName = CFG_DB_PREFIX . 'shipping_unmark';
		$this->NtMarktableName = CFG_DB_PREFIX . 'shipping_ntmark';
		$this->CosttableName = CFG_DB_PREFIX . 'shipping_cost';
		$this->DepotableName = CFG_DB_PREFIX . 'shipping_depot';
		$this->AreatableName = CFG_DB_PREFIX . 'shipping_area';
	}
	
	/**
	 * 保存快递规则
	 *
	 * @param Array $info
	 */
	function save($info)
	{
		if (empty($info['id'])) {
			$this->db->insert($this->tableName,array(
				'rule_id' => $info['rule_id'],
				'value' => $info['value'],
				'express_id' => $info['express_id'],
				'order_by' => $info['order_by']
				));
			return $this->db->getInsertId();
              
		} else {
			$this->db->update($this->tableName,array(
				'rule_id' => $info['rule_id'],
				'value' => $info['value'],
				'express_id' => $info['express_id'],
				'order_by' => $info['order_by']
				),'id='.intval($info['id']));
            return $info['id'];
		}
	}
	function saveoption($option,$express_rule_id)
	{
        $is_option = $this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'express_rule_option where express_rule_id = '.$express_rule_id);
        if($is_option > 0){
            $this->db->execute('delete from '.CFG_DB_PREFIX.'express_rule_option where express_rule_id = '.$express_rule_id);
        } 
        foreach($option as $info){
            $this->db->insert(CFG_DB_PREFIX.'express_rule_option',array(
                'rule_id' => intval($info['rule_id']),
                'value' => $info['value'],
                'if_rule' => $info['if_rule'],
                'express_rule_id' => $express_rule_id
            ));    
        }       
	}
	
	/***
         *  国家    31
            国家区域  32
            订单金额  33
            订单重量  34
            产品SKU   35
            订单运费  36
            产品总数  37
            销售帐号  38
            销售站点  39
            销售渠道  40
            客选物流  41   
         */                 
	
	/**
	 * 快递规则选择
	 * 
	 * @param Array $info
	 */
	function getExpress($info){
		require(CFG_PATH_DATA . 'dd/currency.php');
		$object = new ModelOrder();
		$obs = $this->db->select('select id,rule_id,value,express_id,order_by from '.$this->tableName.' order by order_by desc');
		$account = ModelDd::getArray('allaccount'); 
		for($i=0;$i<count($obs);$i++){
            $is_ok = 1; /* 初始化为1 , 循环判断每个子选项，遇到真为0，推出该子选项判断。 */
            if($obs[$i]['rule_id'] == 0){ return $obs[$i]['express_id'];} /*  默认 直接返回 */ 
            /* 先判断小于30的 旧规则 */
            if($obs[$i]['rule_id'] < 30){
                $rules = $this->db->select('select rule_id,value,express_id from '.$this->tableName.' where order_by = '.$obs[$i]['order_by']);
                for($j=0;$j<count($rules);$j++){
                        if($rules[$j]['rule_id'] == 3 && $info['country'] <> $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 1 && $info['order_amount']*$currency[$info['currency']] <= $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 2 && $info['order_amount']*$currency[$info['currency']] > $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 12 && $info['shipping_fee']*$currency[$info['currency']] <= $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 13 && $info['shipping_fee']*$currency[$info['currency']] > $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 4 && $info['ShippingService'] <> $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 5 && $info['sellerID'] <> $rules[$j]['value']){
                            $is_ok = 0;break;
                            }
                        if($rules[$j]['rule_id'] == 7 && $info['sellerID'] <> $rules[$j]['value']){
                            $area = $this->db->getValue("SELECT content FROM ".$this->AreatableName." WHERE area ='".$rules[$j]['value']."'".' and user_id = '.$_SESSION['admin_id']);
                            if(!preg_match('/,*'.$info['country'].',*/', $area)) {$is_ok = 0;break;}
                            }
                        if($rules[$j]['rule_id'] == 6){
                            $is_ok = 0;
                            $goods_info = $object->order_goods_info($info['order_id']);
                            for($t=0;$t<count($goods_info);$t++){
                                if(preg_match("/^".$rules[$j]['value']."/",$goods_info[$t]['goods_sn'])){
                                    $is_ok = 1;break;
                                    }
                                }
                            }
                        if($rules[$j]['rule_id'] == 8){
                            $is_ok = 0;
                            $goods_info = $object->order_goods_info($info['order_id']);
                            for($t=0;$t<count($goods_info);$t++){
                                if(preg_match("/".$rules[$j]['value']."$/",$goods_info[$t]['goods_sn'])){
                                    $is_ok = 1;break;
                                    }
                                }
                            }
                        if($rules[$j]['rule_id'] == 9){
                            $goods_info = $object->order_goods_info($info['order_id']);
                            for($t=0;$t<count($goods_info);$t++){
                                if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id ='".$goods_info[$t]['goods_id']."' and goods_qty >= '".$goods_info[$t]['goods_qty']."' and shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot WHERE depot_id = '".$rules[$j]['value']."')")==0){
                                    $is_ok = 0;break;
                                }
                            }
                        }
                        if($rules[$j]['rule_id'] == 10){
                            $ordersize = $object->ordersize($info['order_id']);
                            if($ordersize['weight'] <= $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($rules[$j]['rule_id'] == 11){
                            $ordersize = $object->ordersize($info['order_id']);
                            if($ordersize['weight'] > $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($is_ok == 0) continue;
                        return $obs[$i]['express_id']; 
                    }
                    
            }else{
                $rules = $this->db->select('select id,rule_id,value,express_rule_id,if_rule from '.CFG_DB_PREFIX.'express_rule_option where express_rule_id = '.$obs[$i]['id']);  /* 查找该条下所有子选项 */
                 $is_ok = 1;
                 for($j=0;$j<count($rules);$j++){ 
                    $option_ok[$j] = true;          
                    if($rules[$j]['rule_id'] == 31){ /* 国家  in    not in  */
                        
                        if($rules[$j]['if_rule'] == 'in'){                                                                                              
                            if(!preg_match('/,*'.$info['country'].',*/', $rules[$j]['value'])) {$is_ok = 0;break;}  
                        } 
                        if($rules[$j]['if_rule'] == 'not in'){ 
                            if(preg_match('/,*'.$info['country'].',*/', $rules[$j]['value'])) {$is_ok = 0;break;}  
                        }
                    }
                    if($rules[$j]['rule_id'] == 33){   /*  订单金额      x(7) > 6    */
                        if($rules[$j]['if_rule'] == '<'){
                            if($info['order_amount']*$currency[$info['currency']] >= $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($rules[$j]['if_rule'] == '>'){
                            if($info['order_amount']*$currency[$info['currency']] <= $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($rules[$j]['if_rule'] == '><'){
                            $vs = explode(',',$rules[$j]['value']);
                            if( $info['order_amount']*$currency[$info['currency']] <= $vs[0] && $info['order_amount']*$currency[$info['currency']] >= $vs[1]) {
                                $is_ok = 0;break;
                            }
                        }
                    }
                    if($rules[$j]['rule_id'] == 34){  /* 订单重量 */
                        $ordersize = $object->ordersize($info['order_id']);
                        if($ordersize['weight'] <= $rules[$j]['value']) {
                            $is_ok = 0;break;
                        }  
                        if($rules[$j]['if_rule'] == '<'){
                            if($ordersize['weight'] >= $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($rules[$j]['if_rule'] == '>'){
                            if($ordersize['weight'] <= $rules[$j]['value']) {
                                $is_ok = 0;break;
                            }
                        }
                        if($rules[$j]['if_rule'] == '><'){
                            $vs = explode(',',$rules[$j]['value']);
                            if( $ordersize['weight'] <= $vs[0] && $ordersize['weight'] >= $vs[1]) {$is_ok = 0;break;}
                        }
                    }
                    
                    if($rules[$j]['rule_id'] == 37){    /* 产品数量 */
                        $goodsqty = $this->db->getValue("SELECT sum(goods_qty) as goods_qty from ".CFG_DB_PREFIX."order_goods where order_id = ".$info['order_id']);
                        if($rules[$j]['if_rule'] == '<'){
                            if($goodsqty >= $rules[$j]['value']) {$is_ok = 0;break;}
                        }
                        if($rules[$j]['if_rule'] == '>'){
                            if($goodsqty <= $rules[$j]['value']) {$is_ok = 0;break;}
                        }
                        if($rules[$j]['if_rule'] == '><'){
                            //return 'system error!';
                            $vs = explode(',',$rules[$j]['value']);
                            if($goodsqty <= $vs[0] && $goodsqty >= $vs[1]) {$is_ok = 0;break;}
                        }
                    }
                    if($rules[$j]['rule_id'] == 38){     /* 销售帐号 */
                        
                           
                        $accounts = explode(',',$rules[$j]['value']);
                         
                        if($rules[$j]['if_rule'] == 'in'){   
                            if(!preg_match('/,*'.$account[$info['Sales_account_id']].',*/', $rules[$j]['value'])) {$is_ok = 0;break;}
                        }
                        if($rules[$j]['if_rule'] == 'not in'){   
                            if(!preg_match('/,*'.$account[$info['Sales_account_id']].',*/', $rules[$j]['value'])) {$is_ok = 0;break;}
                        }
                    }
                    if($rules[$j]['rule_id'] == 41){     /* 客选物流 */ 
                        $shservice = explode(',',$rules[$j]['value']);
                        foreach($shservice as $ss){  
                            if($ss <> $info['ShippingService']) {$is_ok = 0;break;}    
                        }
                    }
                    if($rules[$j]['rule_id'] == 35){    /* 产品SKU */ 
                        $sku = $this->db->getValue("SELECT goods_sn from ".CFG_DB_PREFIX."order_goods where order_id = ".$info['order_id']);
                        $goods_info = $object->order_goods_info($info['order_id']); 
                        if($rules[$j]['if_rule'] == 'like'){  
                            for($t=0;$t<count($goods_info);$t++){ /* SKU包含 */
                                if(!preg_match("/^".$rules[$j]['value']."/",$goods_info[$t]['goods_sn'])){
                                   $is_ok = 0;break;
                                }
                            }
                        }
                        if($rules[$j]['if_rule'] == '$'){                              
                            for($t=0;$t<count($goods_info);$t++){
                                if(!preg_match("/".$rules[$j]['value']."$/",$goods_info[$t]['goods_sn'])){
                                    $is_ok = 0;break;
                                }
                            }
                        }
                        if($rules[$j]['if_rule'] == '><'){
                            $vs = explode(',',$rules[$j]['value']);
                            if( strlen($sku) <= $vs[0] && strlen($sku) >= $vs[1]){
                                $is_ok = 0;break;
                            }
                        }
                    }
                }
                if($is_ok == 0) continue;
                return $obs[$i]['express_id'];  
            }   
        }
        return $obs[0]['express_id'];                            
	}
	/**
	* 返回订单标记规则的列表
	*/
	function getList($from,$to)
	{
		$this->db->open('select * from '.$this->tableName.' order by order_by desc',$from,$to);
		$result = array();
		
		$rule = ModelDd::getArray('express_rule');
		
		while ($rs = $this->db->next()) {
			$rarr = explode(',',$rs['rule_id']);
			$rs['rule'] = '';
			if(count($rarr) > 1){
				foreach($rarr as $k => $v){
					
					$rs['rule'] .= $rule[$v].'<br/>';
				}
			}else{
				$rs['rule'] .= $rule[$rs['rule_id']];
			}
			
			$result[] = $rs;
		}
		return $result;
	}
	/**
	* 返回订单标记规则的列表
	*/
	function getMarkList($from,$to)
	{
		$this->db->open('select * from '.$this->MarktableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	* 返回忽略单号订单标记规则的列表
	*/
	function getUnMarkList($from,$to)
	{
		$this->db->open('select * from '.$this->UnMarktableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	* 返回必须追踪号订单标记规则的列表
	*/
	function getNtMarkList($from,$to)
	{
		$this->db->open('select * from '.$this->NtMarktableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	* 返回区域的列表
	*/
	function getareaList($from,$to)
	{
		$this->db->open('select * from '.$this->AreatableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}	
	
	/**
	* 返回物流仓库分配的列表
	*/
	function getDepotList($from,$to)
	{
		$depot = ModelDd::getArray('depot');
		$this->db->open('select * from '.$this->DepotableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['depot'] =$depot[$rs['depot_id']];
			$result[] = $rs;
		}
		return $result;
	}
	function depotdelete($ids)
	{
		return $this->db->execute('delete from '.$this->DepotableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	
	/**
	 * 返回订单标记规则总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getDepotCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->DepotableName.$where);
	}
	/**
	 * 保存订单标记规则
	 *
	 * @param Array $info
	 */
	function Depotsave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->DepotableName,array(
				'shipping_id' => $info['shipping_id'],
				'depot_id' => $info['depot_id']
				));
			} catch (Exception $e) {
						throw new Exception('保存仓库分配失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->DepotableName,array(
				'shipping_id' => $info['shipping_id'],
				'depot_id' => $info['depot_id']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存仓库分配失败','598');exit();
			}
		}
	}	
	
	/**
	 * 返回订单标记规则总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getMarkCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->MarktableName.$where);
	}
	/**
	 * 返回订单标记忽略单号规则总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getUnMarkCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->UnMarktableName.$where);
	}
	/**
	 * 返回订单标记必须单号规则总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getNtMarkCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->NtMarktableName.$where);
	}
	/**
	 * 返回区域总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getAreaCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->AreatableName.$where);
	}
	
	/**
	 * 保存订单标记规则
	 *
	 * @param Array $info
	 */
	function Marksave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->MarktableName,array(
				'value' => $info['value'],
                'express_id' => $info['express_id'],
				'name' => $info['name'],
                'url' => $info['url']
				));
			} catch (Exception $e) {
						throw new Exception('保存标记失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->MarktableName,array(
				'value' => $info['value'],
				'express_id' => $info['express_id'],
				'name' => $info['name'],
                'url' => $info['url']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存标记失败','598');exit();
			}
		}
	}
	
	/**
	 * 保存订单标记忽略单号规则
	 *
	 * @param Array $info
	 */
	function UnMarksave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->UnMarktableName,array(
				'express_id' => $info['express_id']
				));
			} catch (Exception $e) {
						throw new Exception('保存规则失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->UnMarktableName,array(
				'express_id' => $info['express_id']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存规则失败','598');exit();
			}
		}
	}
	/**
	 * 保存订单标记必须单号规则
	 *
	 * @param Array $info
	 */
	function NtMarksave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->NtMarktableName,array(
				'express_id' => $info['express_id']
				));
			} catch (Exception $e) {
						throw new Exception('保存规则失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->NtMarktableName,array(
				'express_id' => $info['express_id']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存规则失败','598');exit();
			}
		}
	}
	function delete($ids)
	{
		$this->db->execute('delete from myr_express_rule_option where express_rule_id in ('.$ids.')');
		return $this->db->execute('delete from '.$this->tableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	function Markdelete($ids)
	{
		return $this->db->execute('delete from '.$this->MarktableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	
	function UnMarkdelete($ids)
	{
		return $this->db->execute('delete from '.$this->UnMarktableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	function NtMarkdelete($ids)
	{
		return $this->db->execute('delete from '.$this->NtMarktableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	/*************
	*快递区域操作
	*
	*
	*************/	
	/**
	 * 保存订单标记规则
	 *
	 * @param Array $info
	 */
	function Areasave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->AreatableName,array(
				'area' => $info['area'],
				'content' => $info['content']
				));
			} catch (Exception $e) {
						throw new Exception('保存标记失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->AreatableName,array(
				'area' => $info['area'],
				'content' => $info['content']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存标记失败','598');exit();
			}
		}
	}
	function Areadelete($ids)
	{
		return $this->db->execute('delete from '.$this->AreatableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
	/**************
	*快递运费规则
	**************/
	
	function getCostList($from,$to)
	{
		$this->db->open('select * from '.$this->CosttableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 返回快递运费规则总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getCostCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->CosttableName.$where);
	}
	/**
	 * 保存快递运规则
	 *
	 * @param Array $info
	 */
	function Costsave($info)
	{
		if (empty($info['id'])) {
			try{
			$this->db->insert($this->CosttableName,array(
				'value' => $info['value'],
				'express_id' => $info['express_id']
				));
			} catch (Exception $e) {
						throw new Exception('保存公式失败','599');exit();
			}
		} else {
			try{
			$this->db->update($this->CosttableName,array(
				'value' => $info['value'],
				'express_id' => $info['express_id']
				),'id='.intval($info['id']));
			} catch (Exception $e) {
						throw new Exception('保存公式失败','598');exit();
			}
		}
	}
    /**
     * 删除运费计算
     *
     * @param String $ids
     */
	function Costdelete($ids)
	{
		return $this->db->execute('delete from '.$this->CosttableName.' where '.$this->primaryKey.' in ('.$ids.')');
	}
    /**
     * 删除运费计算
     *
     */
	function getArea(){
		$area = $this->db->select('select * from '.CFG_DB_PREFIX.'shipping_area');
		$result = array();
		for($i=0;$i<count($area);$i++){
			$result[$area[$i]['id']] = $area[$i]['area'];
		}
		return $result;
	}
    /**
     * 获取国家
     *
     */
	function getCountry(){
		$country = $this->db->select('select * from '.CFG_DB_PREFIX.'country');
		$result = array();
		for($i=0;$i<count($country);$i++){
			$result[$country[$i]['id']] = $country[$i]['country'].'('.$country[$i]['cn_country'].')';
		}
		return $result;
	}
    /**
     * 获取国家id根据国家名
     *
     * @param String $name
     */
	function getCountryIDByName($name){
		return $this->db->getValue("select id from ".CFG_DB_PREFIX."country where country = '".$name."'");
	}
    /**
     * 获取汇率
     *
     * @param Array $info
     */
	function getCurrency(){
		$currency = $this->db->select('select * from '.CFG_DB_PREFIX.'currency');
		$result = array();
		for($i=0;$i<count($currency);$i++){
			$result[$currency[$i]['id']] = $currency[$i]['currency'].' = '.$currency[$i]['rate'];
		}
		return $result;
	}
    /**
     * 获取快递规则子选项的值
     *
     * @param Int $id         规则id
     * @param Int $rule_id    规则选项id
     */
    function getExpressOption($id,$rule_id){
        return $this->db->getValue('select value,if_rule from '.CFG_DB_PREFIX.'express_rule_option where express_rule_id = '.$id.' and rule_id = '.$rule_id);        
    }
}
?>