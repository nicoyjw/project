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
 * 供应商
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
 * @package Model
 * @version v0.1
 */

class ModelSupplier extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'supplier';
		$this->goodstableName = CFG_DB_PREFIX . 'supplier_goods';
	}

	/**
	 * 保存供应商
	 *
	 * @param array $info
	 */
     //供应商管理
	public function save($info)
	{
		specConvert($info,array('name', 'contact','address','tel','zip','Email','skype','qq','comment'));
		if (!$info['id']) {
			$this->db->insert($this->tableName,array(
				'name' => $info['name'],
				'sn' => $info['sn'],
				'contact' => $info['contact'],
				'add_time' => CFG_TIME,
				'address' => $info['address'],
				'tel' => $info['tel'],
				'zip' => $info['zip'],
				'Email' => $info['Email'],
				'skype' => $info['skype'],
				'qq' => $info['qq'],
				'period' => $info['period'],
				'comment' => $info['comment']
			));
		} else {
			$this->db->update($this->tableName,array(
				'name' => $info['name'],
				'sn' => $info['sn'],
				'contact' => $info['contact'],
				'address' => $info['address'],
				'tel' => $info['tel'],
				'zip' => $info['zip'],
				'Email' => $info['Email'],
				'skype' => $info['skype'],
				'qq' => $info['qq'],
				'period' => $info['period'],
				'comment' => $info['comment']
			),'id='.intval($info['id']));
			savelog($info['id'],'supplier','供应商信息编辑',$_SESSION['admin_id']);
		}
			$array = $this->db->select('select id,name from '.$this->tableName, 'hashmap');
			$fp = fopen(CFG_PATH_DATA . 'dd/supplier.php', 'w');
			fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
			fclose($fp);
	}
	function getsupplierid($sn)
	{
		$id =0;
		if($sn) $id = $this->db->getValue("SELECT id FROM ".$this->tableName." where sn = '".addslashes($sn)."'");
		return $id;
	}
	function geturl($spid,$goodsid)
	{
		return $this->db->getValue("SELECT url FROM ".CFG_DB_PREFIX . "supplier_goods where supplier_id = '".$spid."' and goods_id = '".$goodsid."'");	
	}
	/**
	 * 保存供应商产品
	 *
	 * @param array $info
	 */
	public function save_goods($info)
	{
		foreach($info['data'] as $goods){
			if($goods->rec_id == 0){
				try{
					$this->db->insert($this->goodstableName, array(
							'supplier_goods_sn' => $goods->supplier_goods_sn,
							'supplier_goods_name' => $goods->supplier_goods_name,
							'supplier_goods_price' => $goods->supplier_goods_price,
							'url' => $goods->url,
							'supplier_goods_remark' => $goods->supplier_goods_remark,
							'goods_id' => $goods->goods_id,
							'supplier_id' => $goods->supplier_id
							));
				} catch (Exception $e) {
					throw new Exception('保存供应商产品明细失败,产品编码'.$info['goods_sn'],'604');exit();
				}	
			}else{
				try{
					$this->db->update($this->goodstableName, array(
							'supplier_goods_sn' => $goods->supplier_goods_sn,
							'supplier_goods_name' => $goods->supplier_goods_name,
							'supplier_goods_price' => $goods->supplier_goods_price,
							'url' => $goods->url,
							'supplier_goods_remark' => $goods->supplier_goods_remark,
							'goods_id' => $goods->goods_id,
							'supplier_id' => $goods->supplier_id
							),'rec_id='.intval($goods->rec_id));
					savelog($goods->rec_id,'supplier','供应商产品信息编辑',$_SESSION['admin_id']);
				} catch (Exception $e) {
					throw new Exception('保存组合明细失败,组合产品编码'.$info['goods_sn'],'605');exit();
				}				
			}
		}
	}
	/**
	 * 供应商产品查询条件
	 *
	 * @param array $info
	 */
	function getGoodsWhere($info){
		return ' Where supplier_id ='.$info['supplier_id'].(($info['keyword'])?' AND (goods_sn = "'.$info['keyword'].'" or supplier_goods_sn = "'.$info['keyword'].'" )':'');
	}
	/**
	 * 产品供应商查询条件
	 *
	 * @param array $info
	 */
	function getSearchWhere($info){
		return ' Where goods_id ='.$info['goods_id'];
	}
	/**
	 * 产品供应商数量
	 *
	 * @param array $info
	 */
	function getSearchCount($where){
		return $this->db->getValue('select count(*) from '.$this->goodstableName.$where);
	}
	/**
	 * 产品供应商列表
	 *
	 * @param array $info
	 */
	function getsearchGoods($from,$to,$where=null){
		$this->db->open('select m.rec_id,p.comment,m.supplier_goods_sn,m.supplier_goods_name,m.supplier_goods_price,m.url,m.supplier_goods_remark,p.name,p.contact,p.tel,p.Email as mail from '.$this->goodstableName.' as m left join '. $this->tableName . ' as p on m.supplier_id = p.id '.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	function getUserList($from,$to,$where=null){
		$this->db->open('SELECT id,name From '.$this->tableName.$where.' order by sn,id desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	function getlistwhere($info)
	{

        $wheres = array(); 
        if($info['keyword']){
            if($info['keyword'] <> '') $wheres[] = 'name like \'%'.$info['keyword'].'%\' or sn = \''.$info['keyword'].'\'';
        }
        $wheres[] = 'user_id = 0 or user_id = '.$_SESSION['admin_id'];
        $where = '';
        if ($wheres) {
            $where = ' where ' . implode(' and ', $wheres);
        }                                                                                   
		return $where;
	}
	function getlistCount($where)
	{
		return $this->db->getValue('SELECT count(*) FROM '.$this->tableName.$where);
	}
	/**
	 * 供应商产品数量
	 *
	 * @param array $info
	 */
	function getGoodsCount($where){
		return $this->db->getValue('select count(*) from '.$this->goodstableName.' as m left join '. CFG_DB_PREFIX . 'goods as p on m.supplier_id = p.goods_id '.$where);
	}
	/**
	 * 供应商产品列表
	 *
	 * @param array $info
	 */
	function getGoodsList($from,$to,$where=null,$checkcombine=null){
		$this->db->open('select m.*,p.goods_sn from '.$this->goodstableName.' as m left join '. CFG_DB_PREFIX . 'goods as p on m.goods_id = p.goods_id '.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 供应商产品删除
	 *
	 * @param array $info
	 */
	function delsupplier($id){
		savelog($id,'supplier','供应商信息被删除',$_SESSION['admin_id']);
		$this->db->execute('delete from '.$this->goodstableName
.' where supplier_id = '.$id);
		return $this->db->execute('delete from '.$this->tableName
.' where id = '.$id);
	}
	function delsuppliergoods($ids)
	{
		$this->db->execute('delete from '.$this->goodstableName
.' where rec_id in ('.$ids.')');
		savelog($ids,'supplier','供应商产品已被删除',$_SESSION['admin_id']);
	}
	function goodsclear($id)
	{
		$this->db->execute('delete from '.$this->goodstableName.' where supplier_id = '.$id);
		savelog($id,'supplier','供应商所有产品已被删除',$_SESSION['admin_id']);
	}
	/****************
	*导入供应商产品
	*@param array $info
	*@
	****************/
	
	function import($info)
	{
		/*if($this->db->getValue("SELECT COUNT(*) FROM ".$this->goodstableName." WHERE goods_id=".$info['goods_id']." AND supplier_id =".$info['supplier_id'])>0){
			$this->db->update($this->goodstableName,$info,"goods_id=".$info['goods_id']." AND supplier_id =".$info['supplier_id']);
			}else{*/
			$this->db->insert($this->goodstableName,$info);
			/*}*/
	}
	/**
	 * 供应商产品查询条件
	 *
	 * @param array $info
	 */
	function getSupplierGoodsWhere($info){
		$wheres = array();
		if ($info['keyword']&& $info['keyword']<>'') {
			$wheres[] = " s.name LIKE '%" . mysql_like_quote($info['keyword']) . "%' or sn LIKE '%" . mysql_like_quote($info['keyword']) . "%'";
		}
		if ($info['sku']&& $info['sku']<>'') {
			$wheres[] = " g.sku ='".$info['sku']."' ";
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	/****************
	*供应商产品供采购询价使用
	*@param array $info
	*@
	****************/
	function getSupplierGoods($where=null){
		$this->db->open('select s.id as supplier_id,s.name as supplier_name,g.goods_sn,sg.supplier_goods_sn,sg.url,sg.supplier_goods_name,sg.supplier_goods_price,sg.url,sg.supplier_goods_remark from '.$this->tableName.' as s left join '.$this->goodstableName.' as sg left join '. CFG_DB_PREFIX . 'goods as g on sg.goods_id = g.goods_id on sg.supplier_id=s.id '.$where.' ORDER BY s.id,g.goods_sn');
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
}
?>