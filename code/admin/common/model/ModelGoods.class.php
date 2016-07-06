<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 产品类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelGoods extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'goods';
		$this->cattableName = CFG_DB_PREFIX . 'category';
		$this->brandtableName = CFG_DB_PREFIX . 'brand';
		$this->primaryKey = 'goods_id';
	}
	
	/**
	 * 保存goods
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function save($info)
	{
			try {
				$this->db->insert($this->tableName,array(
						"plan_au" => $info['plan_au'],
						"plan_cn" => $info['plan_cn'],
						"plan_de" => $info['plan_de'],
						"plan_fr" => $info['plan_fr'],
						"plan_sp" => $info['plan_sp'],
						"plan_uk" => $info['plan_uk'],
						"plan_us" => $info['plan_us'],
						"price_au" => $info['price_au'],
						"price_cn" => $info['price_cn'],
						"price_de" => $info['price_de'],
						"price_fr" => $info['price_fr'],
						"price_sp" => $info['price_sp'],
						"price_uk" => $info['price_uk'],
						"price_us" => $info['price_us'],
						"price1" => $info['price1'],
						"price2" => $info['price2'],
						"price3" => $info['price3'],
						"sku" => ($info['sku'] == '')?$info['goods_sn']:$info['sku'],
						"status" => $info['status'],
						"l" => $info['l'],
						"w" => $info['w'],
						"h" => $info['h'],
						"weight" => $info['weight'],
						"grossweight" => $info['grossweight'],
						"keeptime" => MyDate::transform('timestamp',$info['keeptime']),
						"Grade_au" => $info['Grade_au'],
						"Grade_cn" => $info['Grade_cn'],
						"Grade_de" => $info['Grade_de'],
						"Grade_fr" => $info['Grade_fr'],
						"Grade_sp" => $info['Grade_sp'],
						"Grade_uk" => $info['Grade_uk'],
						"Grade_us" => $info['Grade_us'],
						"brand_id" => $info['brand_id'],
						"cat_id" => $info['cat_id'],
						"comment" => $info['comment'],
						"cost" => $info['cost'],
						"des_cn" => $info['des_cn'],
						"des_de" => $info['des_de'],
						"des_en" => $info['des_en'],
						"des_fr" => $info['des_fr'],
						"des_sp" => $info['des_sp'],
						"goods_name" => $info['goods_name'],
                        "Declared_weight" => $info["Declared_weight"],
						'goods_img' => $info['goods_img'],
						"dec_name" => $info['dec_name'],
						"code" => $info['code'],
						"dec_name_cn" => $info['dec_name_cn'],
						"Declared_value" => $info['Declared_value'],
						"goods_url" => $info['goods_url'],
						"goods_sn" => $this->checkSN($info['goods_sn'])?'':$info['goods_sn'],//sku存在自动设为空
						"is_group" => $info['is_group'],
						"has_child" => $info['has_child'],
						"is_control" => $info['is_control'],
						"goods_attribute" => $info['attrdata'],
						"add_time" => CFG_TIME
					));
				$goodsid =  $this->db->getInsertId();
				$this->db->insert(CFG_DB_PREFIX .'goods_gallery', array(
					'goods_id' => $goodsid,
					'url' => $url
				));
			} catch (Exception $e) {
					throw new Exception('新增产品失败,产品编码'.$info['goods_sn'],'601');exit();
			}
			if($info['is_group']){
				foreach($info['data'] as $goods){
						try{
						$this->db->insert(CFG_DB_PREFIX .'goods_combsplit', array(
									'comb_goods_id' => $goodsid,
									'goods_id' => $goods->goods_id,
									'goods_qty' => $goods->goods_qty
									));
						} catch (Exception $e) {
						throw new Exception('保存组合明细失败,组合产品编码'.$info['goods_sn'],'602');exit();
						}		
				}
			}
			if($info['has_child']){
				foreach($info['childdata'] as $goods){
					try{
					$this->db->insert(CFG_DB_PREFIX .'goods_child', array(
								'child_sn' => $goods->child_sn,
								'goods_id' => $goodsid,
								'color' => $goods->color,
								'size' => $goods->size,
								'price' => $goods->price,
								'stock' => $goods->stock
								));
					} catch (Exception $e) {
					throw new Exception('保存子产品失败,产品编码'.$info['goods_sn'],'602');exit();
					}		
				}
			}
			return $goodsid;
	}
	
	function importstock()
	{
		$this->db->execute("insert into ".CFG_DB_PREFIX."depot_stock(GOODS_ID,shelf_id)(select goods_id,'0' From ".$this->tableName." where goods_id not in (select goods_id FROM ".CFG_DB_PREFIX."depot_stock where shelf_id =0))");	
	}
	/****
	更新产品信息
	****/
	function update($arr)
	{
			try {
				$this->db->update($this->tableName,$arr,'goods_id='.intval($arr['goods_id']));
			} catch (Exception $e) {
				throw new Exception('保存产品失败,产品编码'.$arr['goods_sn'],'603');exit();
			}
	}
	/****
	批量更新产品信息
	****/
	function updategoods($arr,$goods_sn)
	{
			try {
				$this->db->update($this->tableName,$arr,"sku like '".$goods_sn."%' or goods_sn = '".$goods_sn."'");
			} catch (Exception $e) {
				throw new Exception('更新产品信息失败,编码'.$goods_sn,'603');exit();
			}
	}
	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function delete($ids)
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_child where goods_id = '.$ids);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_combsplit where  goods_id = '.$ids);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'depot_stock where  goods_id = '.$ids);
		//关联删除aliexpress
		$this->db->execute('delete from '.CFG_DB_PREFIX .'aliand_aligoods where  goods_id = '.$ids);
		return $this->db->execute('delete from '.$this->tableName
				.' where  goods_id = '.$ids);
	}

	/**
	 * 获取产品信息
	 *
	 * @param int $id 产品id
	 * @return array 产品信息
	 */
	public function goods_info($id,$sn = '',$depot=0){
		$shelf_id = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main =1 AND depot_id =".$depot);
		if($id > 0){
		$info = $this->db->getValue('select m.goods_id,m.goods_sn,m.cat_id,m.SKU,m.code,m.goods_name,m.brand_id,m.dec_name,m.dec_name_cn,m.Declared_value,m.Declared_weight,m.goods_img,m.goods_url,m.keyword,m.keeptime,m.weight,m.l,m.w,m.h,m.grossweight,m.cost,m.price1,m.price2,m.price3,m.status,m.comment,m.is_group,m.is_control,m.has_child,m.provider,m.Grade_cn,m.plan_cn,m.price_cn,m.des_cn,m.Grade_us,m.Grade_au,m.Grade_uk,m.Grade_de,m.Grade_fr,m.Grade_sp,m.plan_us,m.plan_au,m.plan_uk,m.plan_de,m.plan_fr,m.plan_sp,m.price_us,m.price_au,m.price_uk,m.price_de,m.price_fr,m.price_sp,m.des_en,m.des_de,m.des_fr,m.des_sp,m.add_time,m.is_delete,m.product_purchaser,m.products_developers,m.product_operation,m.product_quality_inspector,m.product_rights_checker,n.cat_name from '.$this->tableName.' as m left join '.$this->cattableName.' as n on m.cat_id = n.cat_id where m.goods_id = "'.$id.'"');
		}else{
		$info = $this->db->getValue('select m.goods_id,m.goods_sn,m.cat_id,m.SKU,m.code,m.goods_name,m.brand_id,m.dec_name,m.dec_name_cn,m.Declared_value,m.Declared_weight,m.goods_img,m.goods_url,m.keeptime,m.weight,m.l,m.w,m.h,m.grossweight,m.cost,m.price1,m.price2,m.price3,m.status,m.comment,m.is_group,m.is_control,m.has_child,m.provider,m.Grade_cn,m.plan_cn,m.price_cn,m.des_cn,m.Grade_us,m.Grade_au,m.Grade_uk,m.Grade_de,m.Grade_fr,m.Grade_sp,m.plan_us,m.plan_au,m.plan_uk,m.plan_de,m.plan_fr,m.plan_sp,m.price_us,m.price_au,m.price_uk,m.price_de,m.price_fr,m.price_sp,m.des_en,m.des_de,m.des_fr,m.des_sp,m.add_time,m.is_delete,m.product_purchaser,m.products_developers,m.product_operation,m.product_quality_inspector,m.product_rights_checker from '.$this->tableName.' as m where m.SKU = "'.$sn.'" or m.goods_sn = "'.$sn.'" order by goods_id desc');
		}
		if($info){
			$goodsqty = $this->getgoodsqty($info['goods_id'],0);
			$info['goods_qty'] = $goodsqty['goods_qty'];
			$info['varstock'] = $goodsqty['varstock'];
			$info['warn_qty'] = $goodsqty['warn_qty'];
			$info['stock_place'] = $goodsqty['stock_place'];
			/*$goodsali = $this->getalicat($info['cat_id']);
			$info['ali_cat_id'] = $goodsali['ali_cat_id'];
			$info['ali_cat_name'] = $goodsali['name_en'];*/
		}
		return $info;
	}
	/**********
	*
	* 获取产品数量
	*
	**********/
	
	function getgoodsqty($goods_id,$depot_id=0,$shelf_id=null)
	{
		if(!$goods_id){ return;}
		if(!is_null($shelf_id)){
			$where = " AND shelf_id = ".$shelf_id;
		}else{
		 $where = " AND shelf_id in (SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where depot_id = '".$depot_id."')";
		}
		return $this->db->getValue("SELECT goods_qty,varstock,warn_qty,STOCK_PLACE FROM ".CFG_DB_PREFIX."depot_stock where goods_id ='".$goods_id."'".$where);
	}
	function getalicat($cat_id)
	{
		return $this->db->getValue("SELECT c.ali_cat_id,a.name_en,a.cat_name FROM ".$this->cattableName." as c left join myr_alicategory as a on c.ali_cat_id = a.cat_id where c.cat_id ='".$cat_id."'"." ");
	}
	/**
	 * 保存category
	 *
	 * @param 对象ID $id
	 * @param 模块 $p_root_id,$p_name
	 */
	function catsave($info)
	{
		if (empty($info['cat_id'])) {
			try{
			$this->db->insert($this->cattableName,array(
				'code' => $info['code'],
				//'ali_cat_id' => $info['ali_cat_id'],
				'customs_code' => $info['customs_code'],
				'dec_cn_name' => $info['dec_cn_name'],
				'dec_en_name' => $info['dec_en_name'],
				'product_operation' => ($info['product_operation']) ? $info['product_operation'] : 3,
				'product_purchaser' => ($info['product_purchaser']) ? $info['product_purchaser'] : 2,
				'product_quality_inspector' => ($info['product_quality_inspector']) ? $info['product_quality_inspector'] : 4,
				'product_rights_checker' => ($info['product_rights_checker']) ?  $info['product_rights_checker'] : 4,
				'products_developers' => ($info['products_developers']) ? $info['products_developers'] : 3,
				'shipping_fee' => $info['shipping_fee'],
				'attribute_group_id' => $info['attribute_group_id'],
				'defaul_title' => $info['defaul_title'],
				'defalut_summary' => $info['defalut_summary'],
				'cat_name' => $info['cat_name'],
				'shipping_fee' => $info['shipping_fee'],
				'package_fee' => $info['package_fee'],
				'parent_id' => $info['parent_id']
				));
			} catch (Exception $e) {
						throw new Exception('新增分类失败','601');exit();
			}
		} else {
			try{
			$this->db->update($this->cattableName,array(
				'code' => $info['code'],
				//'ali_cat_id' => $info['ali_cat_id'],
				'customs_code' => $info['customs_code'],
				'dec_cn_name' => $info['dec_cn_name'],
				'dec_en_name' => $info['dec_en_name'],
				'product_operation' => ($info['product_operation']) ? $info['product_operation'] : 3,
				'product_purchaser' => ($info['product_purchaser']) ? $info['product_purchaser'] : 2,
				'product_quality_inspector' => ($info['product_quality_inspector']) ? $info['product_quality_inspector'] : 4,
				'product_rights_checker' => ($info['product_rights_checker']) ?  $info['product_rights_checker'] : 4,
				'products_developers' => ($info['products_developers']) ? $info['products_developers'] : 3,
				'shipping_fee' => $info['shipping_fee'],
				'attribute_group_id' => $info['attribute_group_id'],
				'defaul_title' => $info['defaul_title'],
				'defalut_summary' => $info['defalut_summary'],
				'cat_name' => $info['cat_name'],
				'shipping_fee' => $info['shipping_fee'],
				'package_fee' => $info['package_fee'],
				'parent_id' => $info['parent_id']
				),'cat_id='.intval($info['cat_id']));
			} catch (Exception $e) {
						throw new Exception('编辑分类失败','602');exit();
			}
		}
		ModelDd::cacheCat();
	}
	/**
	 * 保存brand
	 *
	 * @param 对象ID $id
	 * @param 模块 $p_root_id,$p_name
	 */
	function brandsave($info)
	{
		if (empty($info['brand_id'])) {
			try{
			$this->db->insert($this->brandtableName,array(
				'brand_name' => $info['brand_name']
				));
			} catch (Exception $e) {
						throw new Exception('新增品牌失败','601');exit();
			}
		} else {
			try{
			$this->db->update($this->brandtableName,array(
				'brand_name' => $info['brand_name']
				),'brand_id='.intval($info['brand_id']));
			} catch (Exception $e) {
						throw new Exception('编辑品牌失败','602');exit();
			}
		}
		ModelDd::cacheBrand();
	}	
	/**
	 * category总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getCatCount($where=null) {
		return $this->db->getValue('select count(*) from '.$this->cattableName.$where);
	}
	/**
	 * 取category列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getCatList($from,$to)
	{
		$this->db->open('select * from '.$this->cattableName,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$parent_name = $this->db->getValue("select cat_name from ".$this->cattableName." where cat_id =".$rs['parent_id']);
			$rs['parent_name'] = ($parent_name)?$parent_name:'顶级分类';
			$rs['haschild'] = $this->db->getValue("select count(*) from ".$this->cattableName." where parent_id =".$rs['cat_id']);
			$rs['ali_cat_name'] = $this->db->getValue("select count(*) from ".CFG_DB_PREFIX .'alicategory'." where parent_id =".$rs['cat_id']);
			
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 删除category
	 *
	 * @param 对象ID $p_id
	 *
	 */
	function delCat($ids)
	{
		$this->db->execute('delete from '.$this->cattableName
				.' where cat_id in ('.$ids.')');
		echo "{success:true,msg:'OK'}";exit;
	}
	/**
	 * 删除brand
	 *
	 * @param 对象ID $p_id
	 *
	 */
	function delBrand($ids)
	{
		$this->db->execute('delete from '.$this->brandtableName
				.' where brand_id in ('.$ids.')');
		echo "{success:true,msg:'OK'}";exit;
	}

	/**
	 * 获取组合产品信息
	 * @param   int     $goods_id   商品编号
	 * @return  array  组合产品信息
	 */
	function combine_goods_info($goods_id,$goods_sn = ''){
		if($goods_id > 0)
		{
			return $this->db->select("select m.rec_id,m.goods_id,m.goods_qty,n.goods_img,n.goods_sn,n.goods_name from ".CFG_DB_PREFIX .'goods_combsplit'." as m left join ".$this->tableName."  as n on m.goods_id = n.goods_id where m.comb_goods_id ='$goods_id'");
		}
		else
		{
			return $this->db->select("select m.rec_id,m.goods_id,m.goods_qty,n.goods_img,n.goods_sn,n.goods_name from ".CFG_DB_PREFIX .'goods_combsplit'." as m left join ".$this->tableName."  as n on m.goods_id = n.goods_id where m.comb_goods_id =(select goods_id from ".$this->tableName." where SKU = '$goods_sn' order by goods_id desc limit 1)");
		}
	}
	/**
	 * 获取子产品信息
	 * @param   int     $goods_id   商品编号
	 * @return  array  组合产品信息
	 */
	function child_goods_info($goods_id,$goods_sn = ''){
		if($goods_id > 0)
		{
			return $this->db->select("select m.rec_id,m.child_sn,m.color,m.size,m.price,m.stock,m.varstock from ".CFG_DB_PREFIX .'goods_child'." as m  where m.goods_id ='$goods_id'");
		}
		else
		{
			return $this->db->select("select m.rec_id,m.child_sn,m.color,m.size,m.price,m.stock,m.varstock from ".CFG_DB_PREFIX .'goods_child'." as m left join ".$this->tableName."  as n on m.goods_id = n.goods_id where m.goods_id =(select goods_id from ".$this->tableName." where SKU = '$goods_sn' order by goods_id desc limit 1)");
		}
	}
	/**
	 * 删除组合产品子产品信息
	 * @param   string     $ids   商品编号
	 * @return  array  组合产品信息
	 */
	function deletecomgoods($id){
			return $this->db->execute('delete from '.CFG_DB_PREFIX .'goods_combsplit'.' where rec_id ='.$id);
	}
	/**
	 * 删除组合产品子产品信息
	 * @param   string     $ids   商品编号
	 * @return  array  组合产品信息
	 */
	function deletechildgoods($id){
			return $this->db->execute('delete from '.CFG_DB_PREFIX .'goods_child'.' where rec_id ='.$id);
	}
	/**
	 * 获取category树状列表
	 * 
	 * @return  array  
	 */
	function catTree($com=1){
		$this->db->open('select * FROM '.$this->cattableName);
		$trees = array();
		while ($rs = $this->db->next()) {
			if($rs['parent_id'] == 0){
				$has_child = $this->db->getValue('select count(*) from '.$this->cattableName.' where parent_id ='.$rs['cat_id']);
				$trees['root'][] = array('id'=>$rs['cat_id'],'text'=>'('.$rs['code'].')'.$rs['cat_name'],'leaf'=>(($has_child > 0)?false:true), 'cls'=>(($has_child>0)?'folder':'file'));
				if($has_child>0) $trees = $this->getchildtree($rs['cat_id'],$trees);
			}
		}
		if($com==1){ $trees['root'][] = array('id'=>'65535','text'=>'组合产品','leaf'=>true, 'cls'=>'file');
		$trees['root'][] = array('id'=>'0','text'=>'所有分类','leaf'=>true, 'cls'=>'file');
		}
		return $trees;
	}
	/*************
	循环tree列表
	*************/
	function getchildtree($id,$trees)
	{
		$list = $this->db->select('select * FROM '.$this->cattableName.' where parent_id ='.$id.' order by cat_name');
		for ($i=0;$i<count($list);$i++) {
			$has_child = $this->db->getValue('select count(*) from '.$this->cattableName.' where parent_id ='.$list[$i]['cat_id']);
			$trees[$id][] = array('id'=>$list[$i]['cat_id'],'text'=>'('.$list[$i]['code'].')'.$list[$i]['cat_name'],'leaf'=>(($has_child > 0)?false:true), 'cls'=>(($has_child>0)?'folder':'file'));
			if($has_child>0)	$trees = $this->getchildtree($list[$i]['cat_id'],$trees);
		}
		return $trees;
	}
	function getcatcode($cat_id)
	{
		$code = $this->db->getValue('SELECT code From '.$this->cattableName.' WHERE cat_id = '.$cat_id);
		$lastcode = $this->db->getValue('SELECT code From '.$this->cattableName.' WHERE parent_id = '.$cat_id.' order by code desc');
		if(!$lastcode) return $code.'01';
		$a = substr($lastcode,strlen($code));
		if(is_numeric($a)){
			return $code.str_pad($a+1, strlen($a), "0", STR_PAD_LEFT);
		}else{
			$b = substr($a,-1);
			if(is_numeric($b)) return $code.substr($a,0,-1).($b+1);
			else{ 
				$b1 =ord($b)+1;
				if( $b1> 122) $b1='01';
				else $b1 = chr($b1);
				return $code.substr($a,0,-1).$b1;
			}
		}
	}
	/**
	 * 检测货号是否存在
	 * @param   string     $goods_sn   商品编号
	 * @return  Bool  
	 */
	function checkSN($sn)
	{
		return $this->db->getValue('select count(*) from '.$this->tableName.' where goods_sn = "'.$sn.'"');
	}

	/**
	 * 为某商品生成唯一的货号
	 * @param   string     $cat_id   产品分类id
	 * @return  string  唯一的货号
	 */
	function generate_goods_sn($cat_id)
	{
		$code = $this->db->getValue('select code from '.$this->cattableName.' where cat_id = "'.$cat_id.'"');
		$codelen = strlen($code);
		if(CFG_GOODSSN_AUTOLENGTH){
				$len = CFG_GOODSSN_LENGTH;
		}
		$count = $this->db->getValue("select goods_sn from myr_goods WHERE goods_sn LIKE '".$code."%' order by goods_sn desc");
		
		if($count) {
			$lastsn = $this->db->getValue("select goods_sn from ".$this->tableName.
						" WHERE goods_sn LIKE '".$code."%' order by goods_sn desc");
			$new_sn = $code.str_pad((substr($lastsn,strlen($code)) + 1 ),$len-strlen($code),'0',STR_PAD_LEFT);  
		}else{
			$new_sn = $code.str_pad(1,$len-strlen($code),'0',STR_PAD_LEFT);
		}
		return $new_sn;
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhere($info) {
		specConvert($info,array('keyword','brand_id','keytype','key','cat_id','starttime','status','totime'));
		$wheres = array();
		if ($info['keyword']) {
			$wherearr = explode(' ',$info['keyword']);
            if(count($wherearr) >1 ){
                $wheres[] = '(m.goods_sn like \'%'.$wherearr[0].'%\' and m.goods_sn like \'%'.$wherearr[1].'%\' and m.goods_sn like \'%'.$wherearr[2].'%\' or m.SKU like \'%'.$wherearr[0].'%\' and m.SKU like \'%'.$wherearr[1].'%\' and m.SKU like \'%'.$wherearr[2].'%\' or m.goods_name like \'%'.$wherearr[0].'%\' and m.goods_name like \'%'.$wherearr[1].'%\' and m.goods_name like \'%'.$wherearr[2].'%\')';
            
            }else{
                $wheres[] = '(m.goods_sn like \'%'.$info['keyword'].'%\' or m.SKU like \'%'.$info['keyword'].'%\' or m.code like \'%'.$info['keyword'].'%\' or m.goods_name like \'%'.$info['keyword'].'%\')';
            }
            //$wheres[] = '(m.goods_sn like \'%'.$info['keyword'].'%\' or m.SKU like \'%'.$info['keyword'].'%\' or m.code like \'%'.$info['keyword'].'%\' or m.goods_name like \'%'.$info['keyword'].'%\')';
		}elseif($info['advsearch']){
			$wheres[] = '(m.goods_name in ('.$info['sn_list'].') or m.SKU in ('.$info['sn_list'].'))';
			}else{
			if ($info['brand_id'] != 0) {
				$wheres[] = 'm.brand_id=\''.$info['brand_id'].'\'';
			}
			if ($info['cat_id'] != 0) {
				$wheres[] = 'm.cat_id=\''.$info['cat_id'].'\'';
			}
			if ($info['key']) {
				if($info['keytype'] == 1) $wheres[] = 'm.goods_sn=\''.$info['key'].'\'';
				if($info['keytype'] == 2) $wheres[] = 'm.goods_name like \'%'.$info['key'].'%\'';
				if($info['keytype'] == 3) $wheres[] = 'm.SKU=\''.$info['key'].'\'';
				if($info['keytype'] == 4) $wheres[] = 'p.stock_place=\''.$info['key'].'\'';
				if($info['keytype'] == 5) $wheres[] = 'm.dec_name=\''.$info['key'].'\'';
				if($info['keytype'] == 0) $wheres[] = '(m.goods_sn=\''.$info['key'].'\' or m.goods_name=\''.$info['key'].'\' or m.SKU=\''.$info['key'].'\' or p.stock_place=\''.$info['key'].'\' or m.dec_name=\''.$info['key'].'\')';
			}
			if ($info['status'] != 0) {
				$wheres[] = 'm.status=\''.$info['status'].'\'';
			}
			if($info['totime'] <> "" && $info['starttime'] <> "") $wheres[] = 'm.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'm.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
			if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'm.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		}
		if(isset($info['is_ali']) && $info['is_ali'] == 1) 
		{
			$wheres[] = 'm.is_ali='.$info['is_ali'];
		}
		if($info['products_developers'] > 0){
			$wheres[] = 'm.products_developers=\''.$info['products_developers'].'\'';
		}
		$wheres[] = 'p.shelf_id = 0';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	/**
	*获取产品列表
	*
	*
	**/
	function getGoodsList($from,$to,$where=null,$export=null,$sort=null){
		if($sort){
			if(preg_match("/goods_qty/i",$sort)){
				$sort = "p.".$sort;
				}else{
			 	$sort = 'm.'.$sort;
			 }
		}
		if($export){
		$this->db->open('select m.goods_id,m.goods_sn,m.SKU,m.goods_name,m.cat_id,m.add_time,m.l,m.w,m.h,m.grossweight,m.weight,m.dec_name,m.code,m.goods_img,m.keeptime,m.cost,m.price1,m.goods_url,m.price2,m.price3,m.comment,m.status,m.is_group,m.is_control,m.has_child,m.Declared_value,m.Grade_cn,m.plan_cn,m.price_cn,m.des_cn,m.Grade_us,m.Grade_au,m.Grade_uk,m.Grade_de,m.Grade_fr,m.Grade_sp,m.plan_us,m.plan_au,m.plan_uk,m.plan_de,m.plan_fr,m.plan_sp,m.price_us,m.price_au,m.price_uk,m.price_de,m.price_fr,m.price_sp,m.des_en,m.des_de,m.des_fr,m.des_sp,m.products_developers,p.goods_qty,p.warn_qty,p.stock_place from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as p on m.goods_id = p.goods_id '.$where.' order by '.$sort.' m.'.$this->primaryKey.' desc');
		}else{
		$this->db->open('select m.goods_id,m.goods_sn,m.SKU,m.goods_name,m.cat_id,m.add_time,m.l,m.w,m.h,m.grossweight,m.weight,m.dec_name,m.code,m.goods_img,m.keeptime,m.cost,m.goods_url,m.price1,m.price2,m.price3,m.comment,m.status,m.is_group,m.is_control,m.has_child,m.Declared_value,m.Grade_cn,m.plan_cn,m.price_cn,m.des_cn,m.Grade_us,m.Grade_au,m.Grade_uk,m.Grade_de,m.Grade_fr,m.Grade_sp,m.plan_us,m.plan_au,m.plan_uk,m.products_developers,m.plan_de,m.plan_fr,m.plan_sp,m.price_us,m.price_au,m.price_uk,m.price_de,m.price_fr,m.price_sp,m.des_en,m.des_de,m.des_fr,m.des_sp,p.goods_qty,p.warn_qty,p.stock_place from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as p on m.goods_id = p.goods_id '.$where.' order by '.$sort.' m.'.$this->primaryKey.' desc',$from,$to);
		}
		/*$text = '请选择帐号:<select id="aliaccountId">';
		$aliaccount = ModelDd::getArray('aliaccount');
		if(count($aliaccount) >= 1){
				foreach(@$aliaccount as $key => $value){
					$text .= '<option value="'.$key.'">'.$value.'</option>';
				}
		}
		
		$text .= '</select>';*/
		$result = array();
		require(CFG_PATH_DATA . 'dd/currency.php');
		while ($rs = $this->db->next()) {
			$aliarr = $this->db->select('select * from myr_aligood_lib where goods_id = '.$rs['goods_id']);
			if(count($aliarr) > 1){
				$rs['alitext'] = '已刊登在';
				foreach($aliarr as $keyindex => $accountname){
					$rs['alitext'] .= ($keyindex == 0) ? $accountname : ','.$accountname;
				}
			}
			$rs['aliuploadtext'] = $text;
			$rs['cat_name'] = ModelDd::getCaption('goods_cat',$rs['cat_id']);
			$rs['keeptime'] = date('Y-m-d',$rs['keeptime']);
			$rs['add_time'] = date('Y-m-d',$rs['add_time']);
			$rs['products_developers'] = $this->db->getValue('select user_name from '.CFG_DB_PREFIX.'admin_user where user_id = '.$rs['products_developers']);
			$rs['fix_price'] = '<br>';
			foreach($currency as $k=>$v){
				$rs['fixprice'][$k] = $this->getfixprice($rs['goods_id'],$k);
				$rs['fix_price'] .= $k.':'.$rs['fixprice'][$k]."<br>";
			}
			$result[] = $rs;
		}
		return $result;
	}
	function getAliCatPath($id){
		$parentId = $this->db->getValue("select count(*) from ".CFG_DB_PREFIX.'alicategory where parent_id = '.$id);
		
	}
	/*******************
	*
	*参考售价公式
	*
	*******************/
	
	function getfixprice($goods_id,$cur='USD')
	{
		if($this->db->getValue("SELECT cost FROM ".CFG_DB_PREFIX . "goods WHERE goods_id = '".$goods_id."'")==0) return 0;
		$result = $this->db->getValue('SELECT m.cost,n.shipping_fee,n.package_fee From '.CFG_DB_PREFIX . 'goods as m left join '.CFG_DB_PREFIX . 'category as n on m.cat_id = n.cat_id where m.goods_id = "'.$goods_id.'"');
		require(CFG_PATH_DATA . 'dd/currency.php');
		$fix_price = CFG_CAL_PRICE;
		if(!$result['shipping_fee']) $result['shipping_fee'] =0;
		if(!$result['package_fee']) $result['package_fee'] =0;
		$fix_price = str_replace('{$cost}',$result['cost'],$fix_price);
		$fix_price = str_replace('{$shipping_fee}',$result['shipping_fee'],$fix_price);
		$fix_price = str_replace('{$package_fee}',$result['package_fee'],$fix_price);
		$fix_price = str_replace('{$rate}',$currency[$cur],$fix_price);
		@eval("\$fix_price = \'$fix_price\';");
		return number_format(floatval($fix_price),2,'.','');
	}
	/**
	 * 总数
	 *
	 * @param string $where 条件
	 * @return int
	 */
	function getGoodsCount($where=null) {
		return $this->db->getValue('select count(distinct m.goods_id) from '.$this->tableName.' as m left join '.CFG_DB_PREFIX.'depot_stock as p on m.goods_id = p.goods_id '.$where);
	}
	/**
	 * 是否为组合产品
	 *
	 * @param string $sn 产品sku码
	 * @return bool
	 */
	function checkisgroup($sn)
	{
		$sn = addslashes_deep($sn);
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX . 'goods where SKU = "'.$sn.'" and is_group = 1');
	}
	/**
	 * 检查保存ebay产品文件
	 *
	 * @param arrya $info
	 * @param int $value
	 * @return string
	 */
	function saveEbayGoods($info)
	{
		$verb = 'GetMyeBaySelling';
		$page = 1;
		$hasmore = 1;
		$count =0;
		$this->dellisting($info['id']);
		$retry = 1;
		while($hasmore == 1){
			try{
				$this->saveEbayxml($info['id'],$verb,$page);
			} catch (Exception $e) {
							throw new Exception('保存Page'.$page.'失败','999');exit();
			}
			try{
				$result = $this->loadXml($info['id'],$page);
			} catch (Exception $e) {
							throw new Exception($e->getMessage(),'999');exit();
			}
			if($result['hasmore'] == 2){
				if($retry == 3) {throw new Exception('加载Page'.$page.'失败','999');exit();}
				$retry++;			//retry
				}else{
				$retry = 1;	
				$hasmore = $result['hasmore'];
				$count += $result['num'];
				$page++;
				}
		}
		$this->updateoff($info['id']);
		$page =$page - 1;
		return $page.'|'.$count;
	}
	
	
	function updateoff($id)
	{
		$list1 = $this->db->select("SELECT ItemID FROM ".CFG_DB_PREFIX."ebayselling where endtime >".CFG_TIME." and account_id = ".$id);
		$list2 = $this->db->select("SELECT ItemID FROM ".CFG_DB_PREFIX."ebayselling_temp where account_id = ".$id);
		$list = array_diff($list1,$list2);
		if(count($list)>0) $this->db->execute("UPDATE ".CFG_DB_PREFIX."ebayselling set endtime = ".CFG_TIME." where account_id =".$id." and ItemID in(".implode(",",$list).")");
	}
	/**
	 * 检查保存ebay store分类目录
	 *
	 * @param arrya $info
	 * @param int $value
	 * @return string
	 */
	function loadcategory($id)
	{
		$verb = 'GetStore';
		$page = 1;
			try{
				$this->saveEbayxml($id,$verb,$page);
			} catch (Exception $e) {
							throw new Exception('保存Page'.$page.'失败','999');exit();
			}
		return $this->loadcatXml($id,$page);
	}
	
	
	function loadcatXml($id)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/GetStore_'. $id .'_1.xml');
			if($data=XML_unserialize($xml)){
				$cat = @$data['GetStoreResponse']['Store'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$this->db->execute("delete From ".CFG_DB_PREFIX."ebay_category where account_id =".$id);
		$Trans = (@array_key_exists('CategoryID', $cat['CustomCategories']['CustomCategory']))?@$cat['CustomCategories']:@$cat['CustomCategories']['CustomCategory'];
		foreach((array)$Trans as $Transaction){
			$this->db->insert(CFG_DB_PREFIX."ebay_category",array(
				"account_id" => $id,
				"cat_id" =>$Transaction['CategoryID'],
				"cat_name" => addslashes($Transaction['Name']),
				"order_id" => $Transaction['Order']
			));
			if($Transaction['ChildCategory']){
					if(count(@$Transaction['ChildCategory'])){
						foreach($Transaction['ChildCategory'] as $child){
									$this->db->insert(CFG_DB_PREFIX."ebay_category",array(
													"account_id" => $id,
													"cat_id" =>$child['CategoryID'],
													"cat_name" => addslashes($child['Name']),
													"order_id" => $child['Order'],
													"parent_id" =>$Transaction['CategoryID']
												));
										}
						}		
				}
		}
	}
	
	/**
	 * 检查保存ebay产品文件
	 *
	 * @param array $info
	 * 
	 * @return bool
	 */
	function saveEbaybestmatch($info,$id_cat)
	{
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$verb = 'findBestMatchItemDetailsBySeller';
		$page = 1;
		try {
				$this->saveEbaybestmatchxml($info['id'],$id_cat,$verb,1);
		} catch (Exception $e) {
					throw new Exception('保存ebay case失败','499');exit();
		}
			$xml = file_get_contents(CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id_cat .'_'. $info[id] .'_'.$page.'.xml');
			if($data=XML_unserialize($xml)){
				$getcase = $data['findBestMatchItemDetailsBySellerResponse'];
				if($getcase['errorMessage']){
						$errormsg = 'Ebay返回错误:'.$getcase['errorMessage']['error']['errorId'] ." " .	$getcase['errorMessage']['error']['message'];
						throw new Exception($errormsg,'400');exit();
				}
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
			$totalcount = $getcase['paginationOutput']['totalPages'];
		for($page = 2;$page <= $totalcount; $page++ ){
			try {
					$this->saveEbaybestmatchxml($info['id'],$id_cat,$verb,$page);
			} catch (Exception $e) {
						throw new Exception('保存Page'.$page.'失败','999');exit();
			}
		}
		return $info['id'].'|'.$totalcount.'|'.$getcase['paginationOutput']['totalEntries'];
	}
	
	function saveEbaybestmatchxml($id,$id_cat,$verb,$page)
	{
		require(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php');
		require(CFG_PATH_DATA . 'ebay/eub_' . $id .'.php');
		$cat_id = $id_cat;
		require_once(CFG_PATH_LIB . 'ebay/eBayBestmatchSession.php');
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id_cat .'_'. $id .'_'.$page.'.xml';
		$session = new eBayBestmatchSession($userToken, $verb, 'EBAY-US');
		$responseXml = $session->sendHttpRequest($requestXmlBody);
		if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400');
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 		throw new Exception('不能写入数据','101');
		 }
	}
	
	/*******
	*param int $id
	*
	*******/
	function dellisting($id)
	{
		return $this->db->execute('delete from '.CFG_DB_PREFIX.'ebayselling_temp where account_id='.$id);
	}
	
	/**
	 * 保存ebay产品文件XML文件
	 *
	 * @param string $id  ebay_account_id
	 * @param string $verb  ebay api type
	 * @param $page load page
	 * @param $data include what used to send
	 */
	function saveEbayxml($id,$verb,$page){
		require(CFG_PATH_DATA . 'ebay/ebay_' . $id .'.php');
		require(CFG_PATH_LIB . 'ebay/'.$verb.'.php');
		$file = CFG_PATH_DATA . 'ebay/'.$verb.'_'. $id .'_'.$page.'.xml';
		$session = new eBaySession($userToken, $devID, $appID, $certID, $verb);
		$responseXml = $session->sendHttpRequest($requestXmlBody);
		if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400');
		if($fp=fopen($file,'w')){
			 if(!fwrite($fp,$responseXml)){
			 	throw new Exception('不能写入数据','100');
			 }
			 fclose($fp);
		 }else{
		 		throw new Exception('不能写入数据','101');
		 }
	}
	/**
	 * 加载ebay bestmatch文件XML文件
	 *
	 * @param string $info
	 * @return $counter 加载的数量
	 */
	function loadbestmatchXml($xml,$id_cat)
	{
		$id = $xml['id'];
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/findBestMatchItemDetailsBySeller_'. $id_cat.'_'. $id .'_'.$xml['page'].'.xml');
			if($data=XML_unserialize($xml)){
				$getorder = $data['findBestMatchItemDetailsBySellerResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$Trans = @$getorder['searchResult']['searchItemGroup']['item'];
		$count=0;
		foreach((array)$Trans as $Transaction){
			$info['itemid'] = $Transaction['itemId'];
			$info['addtime'] = CFG_TIME;
			$info['quantityAvailable'] = $Transaction['quantityAvailable'];
			$info['quantitySold'] = $Transaction['quantitySold'];
			if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."ebay_bestmatch WHERE itemid = '".$info['itemid']."' and addtime = ".$info['addtime'])>0){
				 $this->db->execute("update ".CFG_DB_PREFIX."ebay_bestmatch set quantityAvailable=quantityAvailable+".$info['quantityAvailable'].",quantitySold = quantitySold+".$info['quantitySold']);
				 continue;
			}
			$info['account_id'] = $id;
			$info['bidcount'] = $Transaction['sellingStatus']['bidCount'];
			$info['currentprice'] = $Transaction['sellingStatus']['currentPrice'];
			$info['itemrank'] = $Transaction['itemRank'];
			$info['salesCount'] = @$Transaction['bestMatchData']['salesCount'];
			$info['viewItemCount'] = @$Transaction['bestMatchData']['viewItemCount'];
			$info['watchCount'] = @$Transaction['bestMatchData']['watchCount'];
			$info['salesPerImpression'] = @$Transaction['bestMatchData']['salesPerImpression'];
			$info['salesPerViewItem'] = @$Transaction['bestMatchData']['salesPerViewItem'];
			$info['viewItemPerImpression'] = @$Transaction['bestMatchData']['viewItemPerImpression'];
			if($info['viewItemPerImpression'] > 0) $info['impression'] = floor($info['viewItemCount']/$info['viewItemPerImpression']);
			if(!$info['salesCount'])  $info['salesCount'] =0;
			if(!$info['viewItemCount']) $info['viewItemCount']=0;
			if(!$info['watchCount']) $info['watchCount']=0;
			if(!$info['salesPerImpression']) $info['salesPerImpression']=0;
			if(!$info['salesPerViewItem']) $info['salesPerViewItem']=0;
			if(!$info['viewItemPerImpression']) $info['viewItemPerImpression']=0;
			if(!$info['impression']) $info['impression']=0;
			$this->db->insert(CFG_DB_PREFIX."ebay_bestmatch",$info);
			$count++;
		}
		return $count;
	}
	/**
	 * 加载ebay产品文件XML文件
	 *
	 * @param string $info
	 * @return $counter 加载的数量
	 */
	function loadXml($id,$page){
		require_once(CFG_PATH_LIB . 'util/xmlhandle.php');
		$xml =file_get_contents(CFG_PATH_DATA . 'ebay/GetMyeBaySelling_'. $id .'_'.$page.'.xml');
			if($data=XML_unserialize($xml)){
				if($data['eBay']['Errors']){
					$result['num'] = 0;
					$result['hasmore'] = 2;//重复
					return $result;
				}
				$getorder = @$data['GetMyeBaySellingResponse'];
			}else{
				throw new Exception('读取数据失败','103');exit();
			}
		$Trans = @$getorder['ActiveList']['ItemArray']['Item'];
		//$timestamp= date("Y-m-d");
		$result['num'] = 0;
		$result['hasmore'] = 1; 
		foreach((array)$Trans as $Transaction){
			$item['account_id'] = $id;
			$item['ItemID'] = $Transaction['ItemID'];
			$item['ListingDuration'] = $Transaction['ListingDuration'];
			$item['Title'] = addslashes_deep($Transaction['Title']);
			$item['Quantity'] = $Transaction['Quantity'];
			$item['buyitnowprice']=$Transaction['BuyItNowPrice'];
			$item['SKU'] = array_key_exists('SKU',$Transaction)?$Transaction['SKU']:'';
			if($item['SKU'] == '') {
				$SKU_L = (@array_key_exists('SKU', $Transaction['Variations']['Variation']))?$Transaction['Variations']['Variation']:@$Transaction['Variations']['Variation'][0];
				$SKUlist=explode("#",$SKU_L['SKU']);
				$item['SKU'] = $SKUlist[0];
			}
			if(substr($item['SKU'],0,1) == '-') $item['SKU']=substr($item['SKU'],1).'#';
			$item['bidcount'] = $Transaction['SellingStatus']['BidCount']?$Transaction['SellingStatus']['BidCount']:0;
			$item['ShippingServiceCost'] = $Transaction['ShippingDetails']['ShippingServiceOptions']['ShippingServiceCost'];
			$item['endtime'] = $timestamp + $this->timeleft($Transaction['TimeLeft']);
			if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX.'ebayselling_temp where account_id='.$item['account_id'].' and ItemID ='.$item['ItemID']) == 0) $this->db->insert(CFG_DB_PREFIX.'ebayselling_temp', array('account_id'=>$item['account_id'],'ItemID'=>$item['ItemID']));
			if($item['ListingDuration'] == 'GTC') $this->db->execute("Update ".CFG_DB_PREFIX."ebayselling set endtime=".$item['endtime'].",SKU = '".$item['SKU']."',buyitnowprice = '".$item['buyitnowprice']."',Quantity = '".$item['Quantity']."',Title = '".$item['Title']."' ,bidcount = '".$item['bidcount']."' ,ShippingServiceCost = '".$item['ShippingServiceCost']."' where ItemID = '".$item['ItemID']."' and account_id=".$item['account_id']);
			if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."ebayselling WHERE ItemID='".$item['ItemID']."'")>0) continue;
			$item['ViewItemURL'] = $Transaction['ListingDetails']['ViewItemURL'];
			$time = substr($Transaction['ListingDetails']['StartTime'],0,4).'-'.substr($Transaction['ListingDetails']['StartTime'],4,2).'-'.substr($Transaction['ListingDetails']['StartTime'],6,2);
			$item['starttime'] = strtotime($time);
			$item['ListingDuration'] = $Transaction['ListingDuration'];
			$item['ListingType'] = $Transaction['ListingType'];
			$item['StartPrice'] = $Transaction['StartPrice'];
			$item['currency'] = $Transaction['SellingStatus']['CurrentPrice attr']['currencyID'];
			$item['endtime'] = $timestamp + $this->timeleft($Transaction['TimeLeft']);
			$item['GalleryURL'] = $Transaction['PictureDetails']['GalleryURL'];
								try {
										$this->db->insert(CFG_DB_PREFIX.'ebayselling', $item);
											} catch (Exception $e) {
										throw new Exception($e->getMessage(),'999');
									}
								/*if($item['BidCount']>0 && CFG_LOCK_BID) {
									$is_exsit = $this->db->getValue('SELECT count(*) FROM '.CFG_DB_PREFIX.'bid_log WHERE itemid =\''.$item['ItemID']
													.'\' AND account_id=\''.$item['account_id'].'\'');
									if(!$is_exsit){//不存在锁定记录
									$has_child = $this->db->getValue('SELECT count(*) FROM '.$this->tableName.' WHERE SKU = \''.substr($item['SKU'],0,CFG_GOODSSN_LENGTH)
													.'\' AND has_child = 1');
									if($has_child){
										$this->db->execute('UPDATE '.CFG_DB_PREFIX.'goods_child set varstock = varstock+1 where child_sn=\''.$item['SKU'].'\'');
										}else{
										$this->db->execute('UPDATE '.$this->tableName.' set varstock = varstock+1 where SKU=\''.$item['SKU'].'\'');
									}
									//插入锁定记录
									$this->db->insert(CFG_DB_PREFIX.'bid_log', array(
											'itemid' => $item['ItemID'],
											'account_id' => $item['account_id'],
											'sku' => $item['SKU']
											));
									}
								}*/
								$result['num']++;
		}
		if($page == $getorder['ActiveList']['PaginationResult']['TotalNumberOfPages']) $result['hasmore'] = 0;
		return $result;
	}
	
	
	/******
	*Ebay timeleft 格式转换
	******/
	function timeleft($str){
		$day = $this->getstr($str,'P','D');
		$hour = $this->getstr($str,'T','H');
		$min = $this->getstr($str,'H','M');
		$sec = $this->getstr($str,'M','S');
		return $day*3600*24+$hour*3600+$min*60+$sec;
	}
	function getstr($str,$p1,$p2){
		preg_match("'$p1(.+)$p2's",$str,$arr);
			if($arr){
			   return $arr["1"];
			}else{
				return 0;
			}
	}
	
	function getListingList($from,$to,$where=null,$export=null,$sort=null)
	{
		if($export){
		$this->db->open('select * from '. CFG_DB_PREFIX . 'ebayselling' .$where);
		}else{
		$this->db->open('select * from '. CFG_DB_PREFIX . 'ebayselling' .$where.' order by '.$sort.' rec_id desc',$from,$to);
		}
		$result = array();
		$account = ModelDd::getArray('ebaycount');
		while ($rs = $this->db->next()) {
			$rs['starttime'] = date('Y-m-d',$rs['starttime']);
			$rs['endtime'] = date('Y-m-d',$rs['endtime']);
			$rs['account_id'] = $account[$rs['account_id']];
			$result[] = $rs;
		}
		return $result;
	}
	function getListingCount($where)
	{
		return $this->db->getValue('select count(*) from '. CFG_DB_PREFIX . 'ebayselling '.$where);
	}
	function getListingWhere($info) {
		specConvert($info,array('keyword','account','is_check','duration'));
		$wheres = array();
		if($info['keyword']) $wheres[] = '(Title like \'%'.$info['keyword'].'%\' or sku = \''.$info['keyword'].'\' or ItemID = \''.$info['keyword'].'\')';
		if($info['account'] && $info['account'] <> 'undefined') $wheres[] = 'account_id = "'.$info['account'].'"';
		if($info['duration']) $wheres[] = 'ListingDuration = "'.$info['duration'].'"';
		//$wheres[] = 'endtime > '.CFG_TIME;
		if($info['is_check'] == 1){
				/*
				$checkwhere = 'sku in ( select a.sku from '. CFG_DB_PREFIX . 'ebayselling as a,'. CFG_DB_PREFIX . 'ebayselling as b where 1 ';
				if($info['account']) $checkwhere .= ' and a.account_id = '.$info['account'].' and b.account_id = '.$info['account'];
				$checkwhere .= ' and a.SKU = b.SKU and a.ListingType = b.ListingType and a.ItemID <> b.ItemID group by sku)';
				*/
				$checkwhere = '((ListingType = "FixedPriceItem" AND sku in ( select sku from (select sku,listingtype,count(*) from '.CFG_DB_PREFIX . 'ebayselling where sku != "" and ListingType = "FixedPriceItem"';
				if($info['account']) $checkwhere .= ' and account_id = '.$info['account'];
				$checkwhere .= ' and endtime > '.CFG_TIME.' group by sku,listingtype having count(*)>1) as a))';
				$checkwhere .=  ' or (ListingType = "Chinese" AND sku in ( select sku from (select sku,listingtype,count(*) from '.CFG_DB_PREFIX . 'ebayselling where sku != "" and ListingType = "Chinese"';
				if($info['account']) $checkwhere .= ' and account_id = '.$info['account'];
				$checkwhere .= ' and endtime > '.CFG_TIME.' group by sku,listingtype having count(*)>1) as a)))';
				$wheres[] = $checkwhere;
			}elseif($info['is_check'] == 2){
				$checkwhere = '((ListingType = "FixedPriceItem" AND Title in ( select Title from ( select Title,listingtype,count(*) from '.CFG_DB_PREFIX . 'ebayselling where ListingType = "FixedPriceItem"';
				if($info['account']) $checkwhere .= ' and account_id = '.$info['account'];
				$checkwhere .= ' and endtime > '.CFG_TIME.' group by sku,listingtype having count(*)>1) as a))';
				$checkwhere .= ' or (ListingType = "Chinese" AND Title in ( select Title from ( select Title,listingtype,count(*) from '.CFG_DB_PREFIX . 'ebayselling where ListingType = "Chinese"';
				if($info['account']) $checkwhere .= ' and account_id = '.$info['account'];
				$checkwhere .= ' and endtime > '.CFG_TIME.' group by sku,listingtype having count(*)>1) as a)))';
				$wheres[] = $checkwhere;
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getAmzListingList($from,$to,$where=null,$export=null,$sort=null)
	{
		if($export){
		$this->db->open('select * from '. CFG_DB_PREFIX . 'amazon_listing' .$where);
		}else{
		$this->db->open('select * from '. CFG_DB_PREFIX . 'amazon_listing' .$where.' order by id desc',$from,$to);
		}
		$result = array();
		$account = ModelDd::getArray('amazonaccount');
		while ($rs = $this->db->next()) {
			$rs['account_id'] = $account[$rs['account_id']];
			$result[] = $rs;
		}
		return $result;
	}
	function getAmzListingWhere($info)
	{
		$wheres = array();
		if($info['keyword']) $wheres[] = '(item_name like \'%'.$info['keyword'].'%\' or seller_sku = \''.$info['keyword'].'\' or product_id = \''.$info['keyword'].'\')';
		if($info['account'] && $info['account'] <> 'undefined') $wheres[] = 'account_id = "'.$info['account'].'"';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getAmzListingCount($where)
	{
		return $this->db->getValue('select count(*) from '. CFG_DB_PREFIX . 'amazon_listing '.$where);
	}
	
	function getunlist($id)
	{
		$this->db->open('select goods_id,goods_sn,goods_name,SKU from '.$this->tableName .' where status in ('.CFG_GOODS_STATUS.')');
		while ($rs = $this->db->next()) {
			$sku = explode("#",$rs['SKU']);
			if($this->db->getValue('SELECT count(*) FROM '. CFG_DB_PREFIX . 'ebayselling where (SKU = "'.$sku[0].'" or SKU = "'.$rs['SKU'].'") AND endtime >'.CFG_TIME.' AND account_id ='.$id)>0) continue;
			$goods_qty = $this->getgoodsqty($rs['goods_id']);
			$rs['goods_qty'] = $goods_qty['goods_qty'];
			$rs['varstock'] = $goods_qty['varstock'];
			$result[] = $rs;
		}
		return $result;
	}
	
	/*****
	*修改产品字段值并记录
	*****/
	function modify($info)
	{
		if($info['value'] == 'false') $info['value'] = 0;
		$old_value = $this->db->getValue('SELECT '.$info['field'].' FROM '.CFG_DB_PREFIX.'goods where goods_id = "'.$info['id'].'"');
		if($info['field'] == 'is_group' || $info['field'] == 'is_control' || $info['field'] == 'has_child') $info['value'] = ($info['value'])?1:0;
		if($info['re_value']) $info['value'] = $old_value - $info['re_value'];
		if($info['ae_value']) $info['value'] = $old_value + $info['ae_value'];
		$this->db->execute('UPDATE '.$this->tableName.' SET '.$info['field'].'= \''.$info['value'].'\' WHERE goods_id = "'.$info['id'].'"');
		$log['goods_id'] = $info['id'];
		$log['action'] = ($info['action'])?$info['action']:'产品编辑';
		$log['field'] = $info['field'];
		$log['content'] = '值由'.$old_value.'更新为'.$info['value'];
		$log['admin_id'] = $_SESSION['admin_id'];
		$log['addtime'] = CFG_TIME;
		$this->goods_log($log);
	}
	
	
	
	function checkshelf($shelf_id)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot where is_main=1 and shelf_id=".$shelf_id);
	}
	function changeshelfstock($info)
	{
		$shelf = ModelDd::getArray('shelf');
		if($info['type'] == 1) $field = 'goods_qty';
		if($info['type'] == 2) $field = 'stock_place';
		if($info['type'] == 3) $field = 'warn_qty';
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."depot_stock where goods_id=".$info['goods_id']." and shelf_id=".$info['shelf_id'])>0){
			$old_value = $this->db->getValue("SELECT $field FROM ".CFG_DB_PREFIX."depot_stock where goods_id=".$info['goods_id']." and shelf_id=".$info['shelf_id']);
			$this->db->execute("UPDATE ".CFG_DB_PREFIX."depot_stock set $field ='".$info['value']."' where goods_id=".$info['goods_id']." and shelf_id=".$info['shelf_id']);
			}else{
			$old_value = 0;
			$this->db->insert(CFG_DB_PREFIX."depot_stock",array(
						"goods_id" => $info['goods_id'],
						$field=>$info['value'],
						"shelf_id" =>$info['shelf_id']
						));	
		}
		$log['goods_id'] = $info['goods_id'];
		$log['action'] ='产品编辑';
		$log['field'] = $field;
		$log['content'] = $shelf[$info['shelf_id']].'值由'.$old_value.'更新为'.$info['value'];
		$log['admin_id'] = $_SESSION['admin_id'];
		$log['addtime'] = CFG_TIME;
		$this->goods_log($log);
	}
	function clearvar($info)
	{
		$this->db->execute("UPDATE ".CFG_DB_PREFIX."depot_stock set varstock =0 where goods_id=".$info['goods_id']." and shelf_id=".$info['shelf_id']);
	}
	/**********
	*
	* 更新产品数量
	*
	**********/
	function updategoodsqty($goods_id,$depot_id=0,$goods_qty,$type)
	{
		$shelf_id = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main=1 and depot_id=".$depot_id);
		$shelf_id = $shelf_id?$shelf_id:0;
		if($type == 0){
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set goods_qty =goods_qty-".$goods_qty." where goods_id ='".$goods_id."' and shelf_id = ".$shelf_id);
		}else{
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set goods_qty =goods_qty +".$goods_qty." where goods_id ='".$goods_id."' and shelf_id = ".$shelf_id);
		}
	}
	/***************
	**更新货架库存
	*
	*
	***************/
	function updatestock($info)
	{   
		if($this->db->getValue("SELECT count(*) FROM ". CFG_DB_PREFIX ."depot_stock where goods_id =".intval($info['goods_id'])." and shelf_id =".$info['shelf_id'])>0){
			$this->db->update(CFG_DB_PREFIX."depot_stock",$info,"goods_id=".$info['goods_id']." AND shelf_id=".$info['shelf_id']);
		}else{
			$this->db->insert(CFG_DB_PREFIX ."depot_stock",$info);	
		}	
	}
	/**********
	*
	* 更新产品锁定库存
	*
	**********/
	function updatevarqty($goods_id,$depot_id=0,$goods_qty,$type)
	{
		$shelf_id = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main=1 and depot_id=".$depot_id);
		$shelf_id = $shelf_id?$shelf_id:0;
		if($type == 0){
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set varstock = varstock-".$goods_qty." where goods_id ='".$goods_id."' and shelf_id = ".$shelf_id);
		}else{
			$this->db->execute("update ".CFG_DB_PREFIX."depot_stock set varstock = varstock+".$goods_qty." where goods_id ='".$goods_id."' and shelf_id = ".$shelf_id);
		}
	}

	
	/****************
	*
	*取发货货架id
	*
	****************/
	function getshelfid($depot_id)
	{
		return $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main=1 and depot_id=".$depot_id);
	}
	
	/*******
	****保存子产品
	*******/
	function savechild($info)
	{
				foreach($info['data'] as $goods){
					if($goods->rec_id == 0){
						try{
							$this->db->insert(CFG_DB_PREFIX .'goods_child', array(
										'child_sn' => $goods->child_sn,
										'goods_id' => $info['goods_id'],
										'color' => $goods->color,
										'size' => $goods->size,
										'price' => $goods->price,
										'stock' => $goods->stock
										));
										} catch (Exception $e) {
									throw new Exception('新增子明细失败','604');exit();
								}	
					}else{
						try{
							$this->db->update(CFG_DB_PREFIX .'goods_child', array(
										'child_sn' => $goods->child_sn,
										'goods_id' => $info['goods_id'],
										'color' => $goods->color,
										'size' => $goods->size,
										'price' => $goods->price,
										'stock' => $goods->stock
									),'rec_id='.intval($goods->rec_id));
							} catch (Exception $e) {
								throw new Exception('保存子产品明细失败','605');exit();
							}				
					}
				}
				$this->updatechildstock($info['goods_id']);
	}
	function updatechildstock($goods_id,$child_sn=null){
		if(!$goods_id) $goods_id = $this->db->getValue('SELECT goods_id FROM '.CFG_DB_PREFIX .'goods_child'.' WHERE child_sn = \''.$child_sn.'\'');
		$this->db->execute('UPDATE '.CFG_DB_PREFIX .'goods set goods_qty = (SELECT sum(stock) FROM '
								.CFG_DB_PREFIX .'goods_child WHERE goods_id = \''.$goods_id.'\'),varstock=(SELECT sum(varstock) FROM '
								.CFG_DB_PREFIX .'goods_child WHERE goods_id = \''.$goods_id.'\') where goods_id = \''.$goods_id.'\'');
	}
	/*******
	****保存组合产品
	*******/
	function savecom($info)
	{
				foreach($info['data'] as $goods){
					if($goods->rec_id == 0){
						try{
						$this->db->insert(CFG_DB_PREFIX .'goods_combsplit', array(
									'comb_goods_id' => $info['goods_id'],
									'goods_id' => $goods->goods_id,
									'goods_qty' => $goods->goods_qty
									));
										} catch (Exception $e) {
									throw new Exception('新增组合明细失败','604');exit();
								}	
					}else{
						try{
							$this->db->update(CFG_DB_PREFIX .'goods_combsplit', array(
									'comb_goods_id' => $info['goods_id'],
									'goods_id' => $goods->goods_id,
									'goods_qty' => $goods->goods_qty
									),'rec_id='.intval($goods->rec_id));
							} catch (Exception $e) {
								throw new Exception('保存组合产品明细失败','605');exit();
							}				
					}
				}
	}
	/*****************
	*
	*获取产品名称
	*
	*****************/	
	function getNameBySKU($sku)
	{
		$sku1 = getbySKU($sku);
		$goods = $this->db->getValue("SELECT goods_id,goods_name,cost FROM ".$this->tableName.' where SKU="'.$sku.'" or goods_sn = "'.$sku.'" or SKU="'.$sku1.'" or goods_sn = "'.$sku1.'"');	
		if($goods){
			return '1|'.$goods['goods_id'].'|'.$goods['goods_name'].'|'.$goods['cost'];
			}else{
			return '0';
		}
	}
	/*****************
	*
	*获取产品id
	*
	*****************/
	function getidBySKU($sku)
	{
		$sku = addslashes_deep($sku);
		return ($sku <>'')?$this->db->getValue("SELECT goods_id FROM ".CFG_DB_PREFIX.'goods where SKU="'.$sku.'" or goods_sn = "'.$sku.'"'):0;	
	}
	
	function goods_log($info)
	{
		$this->db->insert(CFG_DB_PREFIX . 'goods_log',$info);	
	}
	/********
	*
	*产品日志列表
	*
	********/
	function getlog($from,$to,$where,$field=null)
	{
		$this->db->open("SELECT * FROM ".CFG_DB_PREFIX . "goods_log ".$where." order by id desc",$from,$to);
		$result = array();
		$userlist = ModelDd::getArray("user");
		$goodslist = ModelDd::getArray("goods_field");
		while ($rs = $this->db->next()) {
			$rs['goods_sn'] = $this->db->getValue("SELECT goods_sn FROM ".$this->tableName." WHERE goods_id =".$rs['goods_id']);
			$rs['admin_id'] = $userlist[$rs['admin_id']];
			$rs['addtime'] = MyDate::transform('standard',$rs['addtime']);
			$rs['field'] = $goodslist[$rs['field']];
			$result[] = $rs;
		}
		return $result;
	}
	
	function getlogwhere($info)
	{
		$info = addslashes_deep($info);
		$wheres = array();
		if ($info['id']) $wheres[] = 'goods_id = '.$info['id'];
		if ($info['field']) $wheres[] = 'field = "'.$info['field'].'"';
		$action_list = explode(',',$_SESSION['action_list']);
		if(!in_array('view_cost',$action_list) && $_SESSION['action_list'] != 'all') $wheres[] = "field <>'cost'";
		if(!in_array('view_price1',$action_list) && $_SESSION['action_list'] != 'all') $wheres[] = "field <>'view_price1'";
		if(!in_array('view_price2',$action_list) && $_SESSION['action_list'] != 'all') $wheres[] = "field <>'view_price2'";
		if(!in_array('view_price3',$action_list) && $_SESSION['action_list'] != 'all') $wheres[] = "field <>'view_price3'";
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getgoodslogCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX . "goods_log ".$where);	
	}
	
	function getgalleryList($id)
	{
		$this->db->open("SELECT * FROM ".CFG_DB_PREFIX."goods_gallery WHERE goods_id =".$id);
		$result = array();
		while($rs = $this->db->next()){
			$result[] = $rs;
			}
		return $result;		
	}
	function Uploadgoodsimg($info)
	{
		$goods_img = $this->db->getValue("SELECT goods_img FROM ".$this->tableName." where goods_id ='".$info['goods_id']."'");
		if(substr($goods_img ,-14,14) == 'no_picture.gif' ||  $goods_img =='') $this->db->execute("update ".$this->tableName." set goods_img = '".$info['url']."' where goods_id ='".$info['goods_id']."'");
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_gallery where goods_id ='".$info['goods_id']."' and url='".$info['url']."'")==0){
			$this->db->insert(CFG_DB_PREFIX."goods_gallery",$info);
		}
	}
	function delgallery($id)
	{
		$this->db->execute("DELETE FROM ".CFG_DB_PREFIX."goods_gallery WHERE rec_id =".$id);
	}
	/***************
	*
	* 外部SKU操作
	*
	****************/
	function savesku($info)
	{
		unset($info['create']);
		if($this->db->getValue("SELECT count(*) FROM ".CFG_DB_PREFIX."goods_sku WHERE sku='".$info['sku']."' and out_sku='".$info['out_sku']."'" )>0) {throw new Exception('该SKU和外部SKU已添加','605');exit();}
		if (empty($info['rec_id'])) {
			$this->db->insert(CFG_DB_PREFIX."goods_sku",$info);
		}else{
			$this->db->update(CFG_DB_PREFIX."goods_sku",$info,'rec_id='.$info['rec_id']);
		}
	}
	
	function getSKUWhere($info)
	{
		$wheres = array();
		if ($info['keyword']) {
			$wheres[] = 'sku like \'%'.$info['keyword'].'%\' or out_sku like \'%'.$info['keyword'].'%\'';
		}
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	function getSKUList($from,$to,$where)
	{
		$this->db->open('select * from '. CFG_DB_PREFIX . 'goods_sku' .$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	function getSKUCount($where)
	{
		return $this->db->getValue("SELECT count(*) FROM ". CFG_DB_PREFIX . 'goods_sku' .$where);	
	}
	function skudel($ids)
	{
		$this->db->execute("DELETE FROM ". CFG_DB_PREFIX . 'goods_sku WHERE rec_id in('.$ids.')');
	}
	
	/*****************
	*
	*Ebay listing 操作相关
	*
	*
	*****************/
	function getsupportWhere($info)
	{
		$wheres = array();
		if ($info['goods_sn']) $wheres[] = 'm.SKU like \'%'.$info['keyword'].'%\' or m.ItemID = "'.$info['keyword'].'"';
		if($info['account']) $wheres[] = 'm.account_id = \'%'.$info['account'];
		$wheres[] = 'm.endtime >'.CFG_TIME;
		$wheres[] = '(p.goods_qty = p.varstock or p.goods_qty =0)';
		$where = '';
		if ($wheres) {
			$where = ' where ' . implode(' and ', $wheres);
		}
		return $where;
	}
	
	function getsupportList($from,$to,$where)
	{
		$this->db->open('select m.rec_id,m.ItemID,m.SKU,m.Title,m.starttime,m.endtime,m.ListingType,m.ListingDuration,p.goods_qty,n.goods_id,m.ViewItemURL from '. CFG_DB_PREFIX . 'ebayselling as m left join '.CFG_DB_PREFIX.'goods as n on m.SKU = n.sku left join '.CFG_DB_PREFIX.'depot_stock as p on p.goods_id = n.goods_id ' .$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['Purchase_qty'] = $this->db->getValue('SELECT sum(m.goods_qty) FROM '.CFG_DB_PREFIX.'p_order_goods as m left join '.CFG_DB_PREFIX.'p_order as n on m.order_id = n.order_id where m.goods_id ='.$rs['goods_id'].' and n.status=0');
			$rs['starttime'] = MyDate::transform('date',$rs['starttime']);
			$rs['endtime'] = MyDate::transform('date',$rs['endtime']);
			$result[] = $rs;
		}
		return $result;
	}
	function getsupportCount($where)
	{
		return $this->db->getValue('select count(*) from '. CFG_DB_PREFIX . 'ebayselling as m left join '.CFG_DB_PREFIX.'goods as n on m.SKU = n.sku left join '.CFG_DB_PREFIX.'depot_stock as p on p.goods_id = n.goods_id ' .$where);
	}
	
	function savegrade($info)
	{
		$fp = fopen(CFG_PATH_DATA.'dd/goods.conf.php','w');
		fputs($fp,'<?php return '.var_export($info,true).';?>');
		fclose($fp);
		$info['account'] =0;
		$sta = new ModelStatistics();
		$sta->initorderlist($info);
		$this->db->execute("UPDATE ".$this->tableName." set grade = 'G'");
		if($info['af'] <> '' || $info['ae'] <> ''){
		$sqlA = "UPDATE ".$this->tableName." set grade = 'A' where sku in(";
		if($info['af'] <> "" && $info['ae'] <> "") $sqlA .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['af']." AND ".$info['ae'];
		if($info['af'] <> "" && $info['ae'] == "") $sqlA .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['af'];
		if($info['af']  == "" && $info['ae'] <> "") $sqlA .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['ae'];
		$sqlA .= ")";
		$this->db->execute($sqlA);
		}
		if($info['bf'] <> '' || $info['be'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'B' where sku in(";
		if($info['bf'] <> "" && $info['be'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['bf']." AND ".$info['be'];
		if($info['bf'] <> "" && $info['be'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['bf'];
		if($info['bf']  == "" && $info['be'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['be'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
		if($info['cf'] <> '' || $info['ce'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'C' where sku in(";
		if($info['cf'] <> "" && $info['ce'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['cf']." AND ".$info['ce'];
		if($info['cf'] <> "" && $info['ce'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['cf'];
		if($info['bf']  == "" && $info['ce'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['ce'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
		if($info['df'] <> '' || $info['ce'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'D' where sku in(";
		if($info['df'] <> "" && $info['ce'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['df']." AND ".$info['ce'];
		if($info['df'] <> "" && $info['ce'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['df'];
		if($info['df']  == "" && $info['ce'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['ce'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
		if($info['ef'] <> '' || $info['ee'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'E' where sku in(";
		if($info['ef'] <> "" && $info['ee'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['ef']." AND ".$info['ee'];
		if($info['ef'] <> "" && $info['ee'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['ef'];
		if($info['ef']  == "" && $info['ee'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['ee'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
		if($info['ff'] <> '' || $info['fe'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'F' where sku in(";
		if($info['ff'] <> "" && $info['fe'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['ff']." AND ".$info['fe'];
		if($info['ff'] <> "" && $info['fe'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['ff'];
		if($info['ff']  == "" && $info['fe'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['fe'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
		if($info['gf'] <> '' || $info['ge'] <> ''){
		$sqlB = "UPDATE ".$this->tableName." set grade = 'G' where sku in(";
		if($info['gf'] <> "" && $info['ge'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty between ".$info['gf']." AND ".$info['ge'];
		if($info['gf'] <> "" && $info['ge'] == "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty > ".$info['gf'];
		if($info['gf']  == "" && $info['ge'] <> "") $sqlB .="SELECT goods_sn FROM ".CFG_DB_PREFIX."statistics_order_goods  where total_qty < ".$info['ge'];
		$sqlB .= ")";
		$this->db->execute($sqlB);
		}
	}
	/********
	**加载amazon完整产品文件
	***
	*********/
	function loadfile($content,$id)
	{
		$trans = explode("\n",$content);
		for($i=1;$i<count($trans);$i++){
			$goods = explode("	",$trans[$i]);
			$info['listing_id'] = $goods[2];
			if(!$info['listing_id']) continue;
			$info['account_id'] = $id;
			$info['item_name'] = $goods[0];
			$info['item_description'] = $goods[1];
			$info['seller_sku'] = $goods[3];
			$info['price'] = $goods[4];
			$info['quantity'] = $goods[5];
			$info['open_date'] = $goods[6];
			$info['image_url'] = $goods[7];
			$info['item_is_marketplace'] = $goods[8];
			$info['product_id_type'] = $goods[9];
			$info['item_note'] = $goods[11];
			$info['item_condition'] = $goods[12];
			$info['item_will_ship_internationally'] = $goods[19];
			$info['expedited_shipping'] = $goods[20];
			$info['product_id'] = $goods[22];
			$info['fulfillment_channel'] = $goods[26];
			if($this->db->getValue("SELECT count(*) FROM " .CFG_DB_PREFIX."amazon_listing where account_id = '".$id."' and `listing_id` = '".$info['listing_id']."'") >0) $this->db->update(CFG_DB_PREFIX."amazon_listing",addslashes_deep($info),"account_id = '".$id."' and `listing_id` = '".$info['listing_id']."'");
			else $this->db->insert(CFG_DB_PREFIX."amazon_listing",addslashes_deep($info));
		}
	}
	
	function loadlitefile($content,$id)
	{
		$trans = explode("\n",$content);
		for($i=1;$i<count($trans);$i++){
			$goods = explode("	",$trans[$i]);
			$info['account_id'] = $id;
			$info['product_id'] = $goods[3];
			$info['price'] = $goods[2];
			$info['quantity'] = $goods[1];
			if($this->db->getValue("SELECT count(*) FROM " .CFG_DB_PREFIX."amazon_listing where account_id = '".$id."' and `product_id` = '".$info['product_id']."'") >0) $this->db->update(CFG_DB_PREFIX."amazon_listing",addslashes_deep($info),"account_id = '".$id."' and `product_id` = '".$info['product_id']."'");
		}
	}
	/**
	 * 获取导出外部sku列表
	 * @param   string     $where   关键字条件 
	 * @return  array  符合条件列表 
	 */
	function getexportSku($where){
		$this->db->open('select sku,out_sku from '. CFG_DB_PREFIX . 'goods_sku' .$where);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 清空图库 
	 */
	function emptygallery(){
		$this->db->execute("DELETE FROM ". CFG_DB_PREFIX . 'goods_gallery');
	}
	/**
	 * 获取所有图库 
	 */
	function getallgallerylist(){
		$this->db->open('SELECT g.goods_sn,gg.url FROM '. CFG_DB_PREFIX . 'goods_gallery as gg LEFT JOIN '. CFG_DB_PREFIX .'goods as g on gg.goods_id=g.goods_id');
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	/**
	 * 删除
	 * @param   array     $info    
	 */
	 function delDeopRecord($info){
		$this->db->execute("DELETE FROM ". CFG_DB_PREFIX . "depot_stock WHERE shelf_id=".$info['depo']." AND goods_id=(SELECT goods_id FROM ". CFG_DB_PREFIX ."goods WHERE SKU='".$info['sku']."')");
	}
	/**
	 * 获取分类操作人员
	 * @param   int  $id  cat_id   
	 */
	function getUser($id){
		return $this->db->getValue('SELECT product_purchaser,products_developers,product_operation,product_quality_inspector,product_rights_checker from '.$this->cattableName.' where cat_id = '.$id);
	}
	function saveCatAttr($info){
		
		$this->db->update($this->cattableName,array(
			'attribute_group_id' => $info['set_id']
		),"cat_id = ".$info['cat_id']);
	}
	/**
	 * 获取category树状列表
	 * 
	 * @return  array  
	 */
	function B2ccatTree($com=1){
		$this->db->open('select * FROM myr_sourcinge_sp_cate');
		$trees = array();
		while ($rs = $this->db->next()) {
			if($rs['parent_id'] == 0){
				$trees['root'][] = array('id'=>$rs['id'],'text'=> $rs['name'],'leaf'=>true, 'cls'=>'file');
			}
		}
		return $trees;
	}
	function UpdateSyncStatus($info){
		try{
			$this->db->update(CFG_DB_PREFIX .'product_sync_list', array(
						'product_category' => $info['cat_id'],
						'sync_status' => 1,
						'sync_status_remark' => '同步中'
						),'product_id = '.$info['goods_id'].' AND website_id=4 AND language_id =6');
			} catch (Exception $e) {
				throw new Exception('更新状态失败','602');exit();
			}	
	}
	/**
	 * 保存ebay goods
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function saveebay($info)
	{
		try {
			if($info['id']){
				$this->db->insert(CFG_DB_PREFIX.'ebay_activity',array(
					"Title" => $info['Title'],
					"SKU" => $info['SKU'],
					"ListingType" => $info['ListingType'],
					"ListingDuration" => $info['ListingDuration'],
					"StartPrice" => $info['StartPrice'],
					"Quantity" => $info['Quantity'],
					"Site" => $info['Site'],
					"Description" => $info['Description'],
					"CategoryID" => $info['CategoryID'],
					"BuyItNowPrice" => $info['BuyItNowPrice'],
					"DispatchTimeMax" => $info['DispatchTimeMax'],
					"ViewItemURL" => $info['ViewItemURL'],
					"PictureURL01" => $info['PictureURL01'],
					"PictureURL02" => $info['PictureURL02'],
					"PictureURL03" => $info['PictureURL03'],
					"PictureURL04" => $info['PictureURL04'],
					'ReservePrice' => $info['ReservePrice'],
					"ebay_listingreturnmethodid" => $info['ebay_listingreturnmethodid'],
					"ebay_listingshippingmethodid" => $info['ebay_listingshippingmethodid'],
					"ConditionID" => $info['ConditionID'],
					"ebay_account" => $info['ebay_account'],
					"StoreCategoryID" => $info['StoreCategoryID'],
					"status" => 2
				));
				$goodsid =  $this->db->getInsertId();
			}else{
				$this->db->update(CFG_DB_PREFIX.'ebay_activity',array(
					"Title" => $info['Title'],
					"SKU" => $info['SKU'],
					"ListingType" => $info['ListingType'],
					"ListingDuration" => $info['ListingDuration'],
					"StartPrice" => $info['StartPrice'],
					"Quantity" => $info['Quantity'],
					"Site" => $info['Site'],
					"Description" => $info['Description'],
					"CategoryID" => $info['CategoryID'],
					"BuyItNowPrice" => $info['BuyItNowPrice'],
					"DispatchTimeMax" => $info['DispatchTimeMax'],
					"ViewItemURL" => $info['ViewItemURL'],
					"PictureURL01" => $info['PictureURL01'],
					"PictureURL02" => $info['PictureURL02'],
					"PictureURL03" => $info['PictureURL03'],
					"PictureURL04" => $info['PictureURL04'],
					'ReservePrice' => $info['ReservePrice'],
					"ebay_listingreturnmethodid" => $info['ebay_listingreturnmethodid'],
					"ebay_listingshippingmethodid" => $info['ebay_listingshippingmethodid'],
					"ConditionID" => $info['ConditionID'],
					"ebay_account" => $info['ebay_account'],
					"StoreCategoryID" => $info['StoreCategoryID'],
					"status" => 2
				),'id='.$info['id']);
				return $info['id'];
			}
		} catch (Exception $e) {
				throw new Exception('新增产品失败','601');exit();
		}
		
		return $goodsid;
	}
	/**
	 * 获取产品信息
	 *
	 * @param int $id 产品id
	 * @return array 产品信息'
	 */
	function ebay_goods_info($id){
		//$shelf_id = $this->db->getValue("SELECT shelf_id FROM ".CFG_DB_PREFIX."depot where is_main =1 AND depot_id =".$depot);
		
		$info = $this->db->getValue('select * from myr_ebay_activity where id = '.$id);
		//$info['Description'] = html_entity_decode($info['Description']);
 		
		return $info;
	}
	/**
	 * 保存Aliexpress goods
	 *
	 * @param 对象ID $id
	 * @param 模块 $model
	 * @param 内容 $content
	 */
	function saveAligoods($info){
		try {
			if(!$info['id']){
				$this->db->insert(CFG_DB_PREFIX.'aligoods',array(
					"goods_name" => addslashes($info['goods_name']),
					"skuCode" => $info['skuCode'],
					"deliveryTime" => $info['deliveryTime'],
					"categoryId" => $info['cat_id'],
					"keyword" => addslashes($info['keyword']),
					"productPrice" => $info['productPrice'],
					"freightTemplateId" => $info['freightTemplateId'],
					"productUnit" => $info['productUnit'],
					"groupId" => $info['groupId'],
					"packageType" => $info['packageType'],
					"lotNum" => $info['lotNum'],
					"wsValidNum" => $info['wsValidNum'],
					"bulkOrder" => $info['bulkOrder'],
					"bulkDiscount" => $info['bulkDiscount'],
					"account_id" => $info['account_id'],
					'goods_img' => $info['goods_img'],
					"packageLength" => $info['packageLength'],
					"packageWidth" => $info['packageWidth'],
					"packageHeight" => $info['packageHeight'],
					"grossWeight" => $info['grossWeight'],
					"aeopAeProductPropertys" => $info['attribute'],
					"detail" => addslashes($info['detail'])
				));
				$goodsid =  $this->db->getInsertId();
			}else{
				$this->db->update(CFG_DB_PREFIX.'aligoods',array(
					"goods_name" => addslashes($info['goods_name']),
					"skuCode" => $info['skuCode'],
					"deliveryTime" => $info['deliveryTime'],
					"categoryId" => $info['cat_id'],
					"keyword" => addslashes($info['keyword']),
					"productPrice" => $info['productPrice'],
					"freightTemplateId" => $info['freightTemplateId'],
					"productUnit" => $info['productUnit'],
					"groupId" => $info['groupId'],
					"packageType" => $info['packageType'],
					"lotNum" => $info['lotNum'],
					"wsValidNum" => $info['wsValidNum'],
					"bulkOrder" => $info['bulkOrder'],
					"bulkDiscount" => $info['bulkDiscount'],
					"account_id" => $info['account_id'],
					//'imageURLs' => $info['goods_img'],
					'goods_img' => $info['goods_img'],
					"packageLength" => $info['packageLength'],
					"packageWidth" => $info['packageWidth'],
					"packageHeight" => $info['packageHeight'],
					"grossWeight" => $info['grossWeight'],
					"aeopAeProductPropertys" => $info['attribute'],
					"detail" => addslashes($info['detail'])
				),'id='.$info['id']);
				$goodsid = $info['id'];
			}
		} catch (Exception $e) {
				throw new Exception('新增产品失败','601');exit();
		}
		return $goodsid;
	}
	function deletealigood($ids){
		$goods = $this->db->select('select ali_good_id from myr_aligoods where id in ('.$ids.')');
		for($i=0;$i<count($goods);$i++){
			$this->db->execute('delete from '.CFG_DB_PREFIX .'aliand_aligoods where ali_goods_id = '.$goods[$i]);
		}
		$this->db->execute('delete from '.CFG_DB_PREFIX .'aligoods where id in ('.$ids.')');
		
	}
	function getgoodsDes($id){
		return $this->db->getValue('select description from '.CFG_DB_PREFIX.'goods_des where goods_id = '.$id);
	}
	function getAligoodUpload($id){
		$account = ModelDd::getArray('aliaccount');
		$ex_list = explode(",",$_SESSION['account_list']);
		$newaccount = array();
		foreach($ex_list as $accountkey => $accountid){
			foreach($account as $keyid => $value){
				if($accountid == $keyid) {
					$newaccount[$accountid] =  $account[$keyid];
				}
			}	
		}
		$newaccount;
		$html = '<link rel="stylesheet" type="text/css" href="common/lib/ext-4/resources/css/ext-all-neptune.css"/>
<link rel="stylesheet" type="text/css" href="themes/default/css/common.css"/>
<script type="text/javaScript" src="common/lib/ext-4/ext-all.js" ></script>
<script type="text/javascript">function ttest(id,idd){
		
			 Ext.getBody().mask("Updating Data .waiting...", "x-mask-loading");
                        Ext.Ajax.request({
                            url: "index.php?model=aliexpress&action=joinuploadgood",
                            loadMask: true,
                            params: {
                                id: id,account_id:idd
                            },
                            success: function(response, opts) {
                                var res = Ext.decode(response.responseText);
                                Ext.getBody().unmask();
                                if (res.success) {
                                    Ext.Msg.alert("MSG", res.msg)
									location.reload();
                                } else {
                                    Ext.Msg.alert("ERROR", res.msg)
                                }
                            }
                        })
			 }
			 </script><h5 style="margin-top:-15px;">产品Aliexpress刊登情况</h5>
			 
			 <form id="joinuploadform" name="form1 method="post"><table style="font-size:12px;" align="left" cellpadding="5" cellspacing="0" width="80%"><tr height="30px;" style="border:1px solid #ccc"><td width="30%">帐号</td><td width="15%">货号</td><td width="15%">本地状态</td><td width="15%">在线状态</td><td>操作</td></tr>';
		$aliobject = new ModelAliexpress();
		foreach($newaccount as $k => $v){
			$good = $this->db->getValue('select * from '.CFG_DB_PREFIX.'aliand_aligoods where account_id = '.$k.' and  goods_id = '.$id);
			$check = '';
			$status = '';
			if($good){
				$aliinfo = $this->db->getValue('select id,goods_name,skuCode,keyword,productPrice,categoryId,goods_status,ali_good_id from myr_aligoods where id ='.$good['ali_rec_id'].' group by id');
				//$status = $aliinfo['goods_status'];
				if($aliinfo['goods_status'] == ''){
					$status = 'waitUpload';
				}
				$status = $aliobject->ChangeAliStatus($aliinfo['goods_status']);
				$html .= '<tr height="25px;" style="border:1px solid #CCC"><td>'.$v.'</td><td width="15%">'.$aliinfo['skuCode'].'</td><td><img width="16px;" src="themes/default/images/dialog_apply.png" /></td><td>'.$status.'</td><td><a href="javascript:void(0)"></a></td></tr>';
			}else{
				$html .= '<tr height="25px;"><td>'.$v.'</td><td width="15%">'.$aliinfo['skuCode'].'</td><td><img width="16px;" src="themes/default/images/red_up.png" /></td><td>'.$status.'</td><td><a href="javascript:void(0)" onclick="ttest('.$id.','.$k.')">加入待刊登</a></td></tr>';
			}
		}
		$html .= '</table></form>';
		return $html;
	}
     /**
     * 检查保存ebay产品文件
     *
     * @param arrya $info   ItemID  SKU
     * @param int $value
     * @return string
     */
    function GetEbayOnlineGoods($info)
    {
        
        if(!isset($info['page']))$info['page'] = 1;
        $info['limit'] = isset($info['limit']) ? $info['limit'] : 200; 
        
        $verb = 'GetMyeBaySelling';
        $page = $info['page'];
        
        $i = ceil(($info['page'] * $info['limit'])/200);
        $fileName = 'ebaygoods/onlineList_'.$_SESSION['admin_id'].'_'.$info['account'].'_'.$i;
        $rs = array(); 
                     
        if(is_file(CFG_PATH_DATA.$fileName.'.php')){ 
                 
            $filetime = fileatime(CFG_PATH_DATA.$fileName.'.php');      
            $etime = time()-604800;                        
            if($filetime > $etime) {    

                $re = require(CFG_PATH_DATA.$fileName.'.php');

                if(isset($info['searchField']) && !empty($info['searchField']) && $info['searchField'] !== '' && $info['searchField'] !== NULL){
                    $re = $this->searchEbay($re,'ItemID|SKU|name',$info['searchField']);
                        if(!$re) return array('list'=>array(null),'total'=>0);
                }
                
                
                $start = ($info['page']-1)*$info['limit']-(($i-1)*200);
                $rs['list'] = array_slice($re['list'],$start,$info['limit']);
                $total = array_slice($re,1);
                $rs = array_merge($rs,$total);         
                return $rs;
                
                
                
                
            }    
        }
        require(CFG_PATH_DATA . 'ebay/ebay_' . $info['account'] .'.php');
        require(CFG_PATH_LIB . 'ebay/GetMyeBaySelling.php');
        
        $session = new eBaySession($userToken, $devID, $appID, $certID, 'GetMyeBaySelling');
        
        $responseXml = $session->sendHttpRequest($requestXmlBody);
        if(stristr($responseXml, 'HTTP 404') || $responseXml == '') throw new Exception('发送请求失败','400'); 
        
        
        $rs = array();
        
        $xmlBody = simplexml_load_string($responseXml);  
       
        $Body = $this->xml2array($xmlBody->ActiveList); 
               
        foreach($Body['ActiveList']['ItemArray']['Item'] as $key => $v){                                          
            $rs['list'][] = array(
                'ItemID' => $v['ItemID'],
                'SKU' => $v['SKU'],
                'name' => $v['Title'],
                'qty' => $v['QuantityAvailable'],
                'img' => $v['PictureDetails']['GalleryURL'] 
            );
        }  
        $rs['total'] =  $Body['ActiveList']['PaginationResult']['TotalNumberOfEntries'];   
        $rs['pages'] =  $Body['ActiveList']['PaginationResult']['TotalNumberOfPages'];   
        $fp = fopen(CFG_PATH_DATA.$fileName.'.php', 'w');
        fputs($fp, '<?php return '.var_export($rs, true) . '; ?>');
        fclose($fp); 
        
        $start = ($info['page']-1)*$info['limit']-(($i-1)*200); 
        $rs['list'] = array_slice($rs['list'],$start,$info['limit']);
        $total = array_slice($rs,1);
        $rs = array_merge($rs,$total);  
          
                                                 
        return $rs;
        
    }
    
    function searchEbay($arr,$key,$val){
        $rs = array();
        $str = json_encode($arr['list']);
        preg_match_all("/\{[^\{]*\"(?:".$key.")\"\:\"[^\"]*".$val."[^\"]*\"[^\}]*\}/i",$str,$arr);
        $total = '';
        if($arr && $arr[0]){
            foreach($arr[0] as $k=>$v){
                $total = $k;
                $rs['list'][] = json_decode($v,true);
            }
            $rs['total'] = $total+1;
            return $rs;
        }
        return false;
    }
    
     function xml2array($simpleXmlElementObject, &$recursionDepth = 0) {
        
        // 最大递归的深度
        define("MAX_RECURSION_DEPTH_ALLOWED", 25);
        //空字符串
        define("EMPTY_STR", "");
        // SimpleXMLElement 对象属性名
        define("SIMPLE_XML_ELEMENT_OBJECT_PROPERTY_FOR_ATTRIBUTES", "@attributes");
        // SimpleXMLElement 对象名
        define("SIMPLE_XML_ELEMENT_PHP_CLASS", "SimpleXMLElement");
        
        
        //判断数组的深度，超过指定深度 返回null
        if ($recursionDepth > MAX_RECURSION_DEPTH_ALLOWED) {
            return (null);
        }

        if ($recursionDepth == 0) {
            //判断输入的参数 是不是 SimpleXMLElement 对象
            if (get_class($simpleXmlElementObject) != SIMPLE_XML_ELEMENT_PHP_CLASS) {
                return null;
            } else {
                $callerProvidedSimpleXmlElementObject = $simpleXmlElementObject;
            }
        }

        //判断是否为对象，以及是不是SimpleXMLElement对象
        if (is_object($simpleXmlElementObject) && get_class($simpleXmlElementObject) == SIMPLE_XML_ELEMENT_PHP_CLASS) {
            $copyOfsimpleXmlElementObject = $simpleXmlElementObject;
            //获取对象属性数组
            $simpleXmlElementObject = get_object_vars($simpleXmlElementObject);
        }

        //判断是否是数组
        if (is_array($simpleXmlElementObject)) {
            // 初始化一个结果数组
            $resultArray = array();
            //如果数组长度 小于等于0 ，那么就要使用 CDATA text 处理
            if (count($simpleXmlElementObject) <= 0) {
                // 返回为空的元素
                return (trim(strval($copyOfsimpleXmlElementObject)));
            }
            // 处理数组子元素
            foreach($simpleXmlElementObject as $key =>$value) {
                // 下列内容是处理有属性的xml，将属性插入到结果数组中
                $recursionDepth++;
                //判断是否有属性的xml
                if (is_string($key) && ($key == SIMPLE_XML_ELEMENT_OBJECT_PROPERTY_FOR_ATTRIBUTES)) {
                    foreach(xml2array($value, $recursionDepth) as $k => $v) {
                        $resultArray[$k] = $v;
                    }
                } else {
                    $resultArray[$key] = $this->xml2array($value, $recursionDepth);
                }
                $recursionDepth--;
            }
            if ($recursionDepth == 0) {
                $tempArray = $resultArray;
                $resultArray = array();
                $resultArray[$callerProvidedSimpleXmlElementObject -> getName()] = $tempArray;
            }
            return ($resultArray);
        } else {
            return (trim(strval($simpleXmlElementObject)));
        }
    } 
}
?>