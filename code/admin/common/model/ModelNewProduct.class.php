<?
/**
 * 新品数据库操作类
 * @author 尹阿雄 <yinaxiong@qq.com>
 * @package Model
 * @version v0.1
 */

class ModelNewProduct extends Model {
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'goods_new';
		$this->primaryKey = 'goods_id';
	}
	/**
	 * 保存记录
	 *
	 * @param array $cat
	 */
	public function save($goods)
	{
		$goods['goods_url']=strstr($goods['goods_url'],'http://')?$goods['goods_url']:('http://'.$goods['goods_url']);
		if (!$goods['goods_id']) {
			$this->db->insert($this->tableName,array(
				'goods_name'=>$goods['goods_name'],
				'sku'=>$goods['sku'],
				'brand_id'=>$goods['brand_id'],
				'cat_id'=>$goods['cat_id'],
				'goods_img'=>$goods['goods_img']?$goods['goods_img']:'/data/upload/no_picture.gif',
				'goods_url'=>$goods['goods_url'],
				'weight'=>$goods['weight'],
				'status'=>$goods['status'],
				'goods_title'=>$goods['goods_title'],
				'goods_attribute'=>$goods['goods_attribute'],
				'resume'=>$goods['resume'],
				'depict'=>$goods['depict'],
				'l'=>$goods['l'],
				'w'=>$goods['w'],
				'h'=>$goods['h'],
				'suttle'=>$goods['suttle'],
				'comment'=>$goods['comment'],
				'price' => $goods['price'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME,
				'colors' =>','.$goods['color'].',',
				'sizes' =>','.$goods['size'].','
			));
			return $this->db->getInsertId();
		} else {
			$this->db->update($this->tableName,array(
			    'goods_name'=>$goods['goods_name'],
				'sku'=>$goods['sku'],
				'brand_id'=>$goods['brand_id'],
				'cat_id'=>$goods['cat_id'],
				'goods_img'=>$goods['goods_img'],
				'goods_url'=>$goods['goods_url'],
				'weight'=>$goods['weight'],
				'status'=>$goods['status'],
				'goods_title'=>$goods['goods_title'],
				'goods_attribute'=>$goods['goods_attribute'],
				'resume'=>$goods['resume'],
				'depict'=>$goods['depict'],
				'l'=>$goods['l'],
				'w'=>$goods['w'],
				'h'=>$goods['h'],
				'suttle'=>$goods['suttle'],
				'comment'=>$goods['comment'],
				'price' => $goods['price'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME,
				'colors' =>','.$goods['color'].',',
				'sizes' =>','.$goods['size'].','
			),$this->primaryKey.'='.intval($goods['goods_id']));
			return $goods['goods_id'];
		}
	}
	
	public function saveImg($goods)
	{
		if (!$goods['rec_id']) {
			$audit_status=$this->db->getValue('select audit_status from '.CFG_DB_PREFIX .'goods_img where goods_id='.$goods['goods_id'].' group by audit_status');
			
			if(!$audit_status){
				$this->db->update($this->tableName,array('img_status'=>3),$this->primaryKey.'='.intval($goods['goods_id']));
			}
			return $this->db->insert(CFG_DB_PREFIX .'goods_img',array(
				'goods_id'=>$goods['goods_id'],
				'url'=>$goods['url'],
				'img_assign'=>$goods['img_assign'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME,
				'audit_status' =>$audit_status
			));
		} else {
			return $this->db->update(CFG_DB_PREFIX .'goods_img',array(
				'url'=>$goods['url'],
				'img_assign'=>$goods['img_assign'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME
			),'rec_id'.'='.intval($goods['rec_id']));
		}
	}
	public function saveDes($goods)
	{
		$relanguages=array_flip(ModelDd::getArray('languages'));
		$goods['des_lang_id']=$relanguages[$goods['type']];
		
		$des_id=$this->db->getValue('select des_id from '.CFG_DB_PREFIX .'goods_inter_des where goods_id='.$goods['goods_id'].' and des_lang_id='.$goods['des_lang_id'].' group by audit_status');
		if (!$des_id && !$goods['des_id']) {
			return $this->db->insert(CFG_DB_PREFIX .'goods_inter_des',array(
				'des_lang_id'=>$goods['des_lang_id'],
				'goods_id'=>$goods['goods_id'],
				'des_text'=>$goods['des_text'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME
			));
		} else {
			return $this->db->update(CFG_DB_PREFIX .'goods_inter_des',array(
				'des_text'=>$goods['des_text'],
				'add_user' => $_SESSION['admin_id'],
				'add_time' => CFG_TIME
			),'des_id'.'='.intval($goods['des_id']?$goods['des_id']:$des_id));
		}
	}
	public function saveAudit($goods)
	{
		return $this->db->insert(CFG_DB_PREFIX .'goods_audit',array(
			'goods_id'=>$goods['goods_id'],
			'audit_advice'=>$goods['audit_advice'],
			'audit_status'=>$goods['audit_status'],
			'audit_type'=>$goods['audit_type'],
			'audit_user' => $_SESSION['admin_id'],
			'audit_time' => CFG_TIME
		));
	}
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhere($info) {
		$wheres = array();
		switch($info['action_type']){
			case 0:
				$wheres[] ='n.status in (0,1)';
				break;
			case 1:
				$wheres[] ='n.status = 2';
				break;
			case 2:
				$wheres[] ='((n.status =3 and n.img_status is null) or n.img_status in (3,6))';
				break;
			case 3:
				$wheres[] ='n.img_status =4';
				break;
			case 6:
				$wheres[] ='n.status =3 and n.img_status =8 and n.des_status =9';
				break;
			case 8:
				$wheres[] ='(n.status =3 or n.assign_status=0 or (n.img_status is not null and n.des_status is not null and n.status<> 10))';
				break;
			default:
				break;
		}
		if ($info['sku']<> "") $wheres[] = 'n.sku like \'%'.$info['sku'].'%\'';
		if ($info['goods_name']<> "") $wheres[] = 'n.goods_name like \'%'.$info['goods_name'].'%\'';
		if ($info['brand_id'] != 0) $wheres[] = 'n.brand_id=\''.$info['brand_id'].'\'';
		if ($info['cat_id'] != 0)   $wheres[] = 'n.cat_id=\''.$info['cat_id'].'\'';
		if ($info['status'] != -1 && $info['status']<> '')   $wheres[] = 'n.status=\''.$info['status'].'\'';
		if($info['totime'] <> "" && $info['starttime'] <> "") 
		$wheres[] = 'n.add_time between \''.MyDate::transform('timestamp',$info['starttime']).'\' and  \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] <> "" && $info['starttime'] == "") $wheres[] = 'n.add_time < \''.MyDate::transform('timestamp',substr($info['totime'],0,11).'23:59:59').'\'';
		if($info['totime'] == "" && $info['starttime'] <> "") $wheres[] = 'n.add_time > \''.MyDate::transform('timestamp',$info['starttime']).'\'';
		return $wheres?' where ' . implode(' and ', $wheres):'';
	}
	function getListCount($where=null){
		return $this->db->getValue('select count(*) from '.$this->tableName.' n '.$where);
	}
	
	
	/**
	 * 取列表
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to,$where=null)
	{	if($from && $to){
			$this->db->open('select * from '.$this->tableName.' n '.$where.' ORDER BY n.add_time DESC',$from,$to);
		}else{
			$this->db->open('select * from '.$this->tableName.' n '.$where.' ORDER BY n.add_time DESC');
		}
		while ($rs = $this->db->next()) {
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['cat_id'] = ModelDd::getCaption('goods_cat',$rs['cat_id']);
			$rs['brand_id'] = ModelDd::getCaption('goods_brand',$rs['brand_id']);
			$rs['assign_status']= ($rs['assign_status']==1? '已分配':'未分配');
			$rs['img_status'] = $rs['img_status']==null|| $rs['img_status']=='' ?'未提交图片':ModelDd::getCaption('goods_audit_status',$rs['img_status']);
				 
			$counts=$this->db->getValue('select count(audit_status) from (select audit_status from '.CFG_DB_PREFIX .'goods_inter_des  where goods_id='.$rs['goods_id'].'  group by audit_status) y ');
			if($counts==0){
				$rs['des_status'] ='未提交描述';
			}elseif($counts==1){
				$desCount=$this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'goods_inter_des where goods_id ='. $rs['goods_id']);
				$assCount=$this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_assign  where type <> 0 and goods_id='. $rs['goods_id']);
				if($desCount==$assCount){
					$rs['des_status']=ModelDd::getCaption("goods_audit_status",$rs['des_status']?$rs['des_status']:$this->db->getValue('select audit_status from '.CFG_DB_PREFIX .'goods_inter_des  where goods_id='.$rs['goods_id'].'  group by audit_status'));
				}else{
					$rs['des_status'] ='描述未全部完成';
				}
			}else{
				$rs['des_status'] ='描述未全部完成';
			}
			$rs['status'] = ModelDd::getCaption("goods_audit_status",$rs['status']);
			
			//获取已选择的颜色集合
			$colors = array_flip(explode(",",substr($rs['colors'],1,strlen($rs['colors'])-1)));
			$goods_colors = ModelDd::getArray('goods_color');
			foreach($colors as $k=>$v){
				if($goods_colors[$k]){
					$color.=$goods_colors[$k].','; 
				}
			}
			$rs['colors']=$color?$color:'';
			$color='';
			//获取已选择的尺码集合
			$sizes = array_flip(explode(",",substr($rs['sizes'],1,strlen($rs['sizes'])-1)));
			$goods_sizes = ModelDd::getArray('goods_size');
			foreach($sizes as $k=>$v){
				if($goods_sizes[$k]){
					$size.=$goods_sizes[$k].','; 
				}
			}
			$rs['sizes']=$size?$size:'';
			$size='';
			
			$result[]=$rs;
		}
		return $result;
	}
	
	
	/**
	 *取得未封装的goods对象
	 */
	function goodsInfo($goods_id)
	{
		return $this->db->getValue('select * from '.$this->tableName.'  where goods_id='.$goods_id.' ORDER BY add_time DESC');
	}
	
	/**
	 *取得封装好的goods对象
	 */
	function goods_info($goods_id)
	{	$info=$this->goodsInfo($goods_id);
		$info['cat_name'] = ModelDd::getCaption('goods_cat',$info['cat_id']);
		$info['brand_name'] = ModelDd::getCaption('goods_brand',$info['brand_id']);
		$auditList=$this->goodsAuditList($goods_id);
		foreach ($auditList as $audit) {
			 $str=('<br />审核人：'.ModelDd::getCaption("user",$audit['audit_user']).' 于'.$audit['audit_time'].'审核:<br />状态:'.$audit['audit_status'].'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;审核结果:'.$audit['audit_type'].($audit['audit_advice']?(';<br />审核意见:'.$audit['audit_advice']):'').'<br />');
			$info['goods_audit']=$info['goods_audit'].$str;
		}
		return $info;
	}
	/**
	 *取得审核意见列表
	 */
	function goodsAuditList($goods_id)
	{	
		$this->db->open('select * from '.CFG_DB_PREFIX .'goods_audit where goods_id='.$goods_id.' order by audit_time desc');
		$result = array();
		while ($rs = $this->db->next()) {
			switch($rs['audit_type']){
				case 0:
					$rs['audit_type'] = '审核通过';
				break;
				case 1:
					$rs['audit_type'] = '审核失败'; //$rs['audit_status']==2?'审核失败':'审核信息失败';
				break;
				case 2:
					$rs['audit_type'] = '审核图片失败';
				break;
				case 3:
					$rs['audit_type'] = '审核描述失败';
				break;
			}
			$rs['audit_user'] = ModelDd::getCaption('user',$rs['audit_user']);
			$rs['audit_status'] = ModelDd::getCaption('goods_audit_status',$rs['audit_status']);
			$rs['audit_time'] = MyDate::transform('date',$rs['audit_time']);
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function delete($ids)
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_audit where goods_id = '.$ids);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_img where goods_id = '.$ids);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_inter_des where  goods_id = '.$ids);
		return $this->db->execute('delete from '.$this->tableName.' where  goods_id = '.$ids);
	}
	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function deleteImg($ids)
	{
		return $this->db->execute('delete from '.CFG_DB_PREFIX .'goods_img where goods_id = '.$ids);
	}
	/**
	 * 删除
	 *
	 * @param string $ids ID列表
	 * @return bool
	 */
	function deleteDes($ids)
	{
		return $this->db->execute('delete from '.CFG_DB_PREFIX .'goods_inter_des where  goods_id = '.$ids);
	}
	/**
	 * 更改状态
	 * @param string $ids ID列表
	 * @return bool
	 */
	function updatestatus($goods_id,$status,$type) 
	{
		if($status==4|| $status==6 || $status==8 || $status==10){
			$this->db->update($this->tableName,array('img_status'=>$status),$this->primaryKey.'='.intval($goods_id));
			$this->db->update(CFG_DB_PREFIX .'goods_img',array('audit_status'=>$status),'goods_id ='.intval($goods_id));
		}
		if($status==5|| $status==7 || $status==9 || $status==10){
			$languages=ModelDd::getArray('languages');	
			$relanguages=array_flip($languages);
			if(($status==5|| $status==7 || $status==9) && $type){
				$this->db->update(CFG_DB_PREFIX.'goods_inter_des',array('audit_status'=>$status),'goods_id ='.intval($goods_id)
					.' and des_lang_id='.$relanguages[$type]);
				if($status==9){
					 $desCount=$this->db->getValue('select count(*) from '.CFG_DB_PREFIX.'goods_inter_des where goods_id ='.intval($goods_id));
					 $assCount=$this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_assign  where type <> 0 and goods_id='.intval($goods_id));
					 $desStatusCount=$this->db->getValue('select count(audit_status) from (select audit_status from '.CFG_DB_PREFIX .'goods_inter_des  where goods_id='.intval($goods_id).'  group by audit_status) y ');
					 if($desCount==$assCount && $desStatusCount==1){
						$this->db->update($this->tableName,array('des_status'=>$status),$this->primaryKey.'='.intval($goods_id));
					 }
				}
			}else{
				$this->db->update(CFG_DB_PREFIX.'goods_inter_des',array('audit_status'=>$status),'goods_id ='.intval($goods_id));
				$this->db->update($this->tableName,array('des_status'=>$status),$this->primaryKey.'='.intval($goods_id));
			}
		}
		if($status<=3 || $status==10){
			$this->db->update($this->tableName,array('status'=>$status),'goods_id ='.intval($goods_id));
		}
	}
	
	function getDesStatus($goods_id){
		$this->db->open('select audit_status from '.CFG_DB_PREFIX .'goods_inter_des where goods_id='.$goods_id.' order by audit_status,add_time desc');
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	} 
	function getstatus($action_type,$audit_status){
		switch($action_type){
			case 0:
				$status=2;
				break; 
			case 1: 
				$status=($audit_status==1?1:3);
				break;
			case 2:
				$status=4;
				break;
			case 3:
				$status=($audit_status==1?6:8);
				break;
			case 4:
				$status=5;
				break;
			case 5:
				$status=($audit_status==1?7:9);
				break;
			case 6:
				switch($audit_status){
					case 0:
						$status=10;
						break; 
					case 1: 
						$status=1;
						break;
					case 2:
						$status=6;
						break;
					case 3:
						$status=7;
						break;
					}
				break;
		}
		return $status;
	}
	/**
	 *取得描述列表
	 */
	function goodsDesList($from,$to,$goods_id)
	{	
		if($from && $to){
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_inter_des where goods_id='.$goods_id.' order by audit_status,add_time desc',$from,$to);
		}else{
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_inter_des where goods_id='.$goods_id.' order by audit_status,add_time desc');
		}
		$result = array();
		while ($rs = $this->db->next()) {			
			$rs['des_lang_id'] = ModelDd::getCaption('languages',$rs['des_lang_id']);
			$rs['audit_status'] = ModelDd::getCaption('goods_audit_status',$rs['audit_status']);
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 *取得图片列表
	 */
	function goodsImgList($from,$to,$goods_id)
	{	
		if($from && $to){
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_img where goods_id='.$goods_id.' order by img_assign,add_time desc',$from,$to);
		}else{
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_img where goods_id='.$goods_id.' order by img_assign,add_time desc');
		}
		while ($rs = $this->db->next()) {
			$rs['img_assign'] = ModelDd::getCaption('goods_img_place',$rs['img_assign']);
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$result[] = $rs;
		}
		return $result;
	}
	
	function imgcount($goods_id){
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_img where goods_id='.$goods_id);
	}
	/**
	 *重新分配
	 */
	function reAssign($goods_id) 
	{
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_assign where goods_id = '.$goods_id);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_img where goods_id = '.$goods_id);
		$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_inter_des where  goods_id = '.$goods_id);
		return $this->assignStatus($goods_id,0);
	}
	/**
	 *分配任务
	 */
	function insertAssign($info){
		$counts=$this->db->getValue('select count(goods_id) from '.CFG_DB_PREFIX .'goods_assign where goods_id = '.$info['goods_id'].' and type='.$info['task']);
		if($counts>0){
			$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_assign where goods_id = '.$info['goods_id'].' and type='.$info['task']);
		}
		$this->db->insert(CFG_DB_PREFIX .'goods_assign',array(
					'goods_id' => $info['goods_id'],
					'add_time' => CFG_TIME,
					'add_user'=> $_SESSION['admin_id'],
					'user_id' => $info['user'],
					'type' => $info['task']
					));
		return $this->assignStatus($info['goods_id'],1);
	}
	/**
	 *
	 */
	function assignStatus($goods_id,$status) 
	{
		return $this->db->update($this->tableName,array('assign_status'=>$status),$this->primaryKey.'='.intval($goods_id));
	}
	
	function getGoodsDesListCount($where=null){
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_assign a LEFT JOIN '.$this->tableName.' n on n.goods_id=a.goods_id  LEFT JOIN '.CFG_DB_PREFIX .'goods_inter_des d on (n.goods_id=d.goods_id and a.type=d.des_lang_id)'.$where);
	}
	/**
	 * 描述列表
	 * @param int $from
	 * @param int $to
	 */
	function getGoodsDesList($from,$to,$where=null)
	{	
		if($from && $to){
			$this->db->open('select n.*,a.type,a.add_time times,a.user_id,d.audit_status,d.des_id from '.CFG_DB_PREFIX .'goods_assign a LEFT JOIN '.$this->tableName.' n on n.goods_id=a.goods_id  LEFT JOIN '.CFG_DB_PREFIX .'goods_inter_des d on (n.goods_id=d.goods_id and a.type=d.des_lang_id)'.$where.' ORDER BY n.add_time DESC',$from,$to);
		}else{
			$this->db->open('select n.*,a.type,a.add_time times,a.user_id,d.audit_status,d.des_id from '.CFG_DB_PREFIX .'goods_assign a LEFT JOIN '.$this->tableName.' n on n.goods_id=a.goods_id  LEFT JOIN '.CFG_DB_PREFIX .'goods_inter_des d on (n.goods_id=d.goods_id and a.type=d.des_lang_id)'.$where.' ORDER BY n.add_time DESC');
		}
		
		while ($rs = $this->db->next()) {
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['user_id'] = ModelDd::getCaption("user",$rs['user_id']);
			$rs['times'] = MyDate::transform('date',$rs['times']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['cat_id'] = ModelDd::getCaption('goods_cat',$rs['cat_id']);
			$rs['brand_id'] = ModelDd::getCaption('goods_brand',$rs['brand_id']);
			$rs['type'] = $rs['type']<>0? ModelDd::getCaption('languages',$rs['type']):'images';
			$rs['img_status'] = $rs['img_status']==null|| $rs['img_status']=='' ?'未提交图片':ModelDd::getCaption('goods_audit_status',$rs['img_status']);
			$rs['des_status'] = $rs['audit_status']==null|| $rs['audit_status']=='0' ||$rs['audit_status']=='' ?'未提交描述':ModelDd::getCaption("goods_audit_status",$rs['audit_status']);
			
			
			$rs['status'] = ModelDd::getCaption("goods_audit_status",$rs['status']);
			
			//获取已选择的颜色集合
			$colors = array_flip(explode(",",substr($rs['colors'],1,strlen($rs['colors'])-1)));
			$goods_colors = ModelDd::getArray('goods_color');
			foreach($colors as $k=>$v){
				if($goods_colors[$k]){
					$color.=$goods_colors[$k].','; 
				}
			}
			$rs['colors']=$color?$color:'';
			//获取已选择的尺码集合
			$sizes = array_flip(explode(",",substr($rs['sizes'],1,strlen($rs['sizes'])-1)));
			$goods_sizes = ModelDd::getArray('goods_size');
			foreach($sizes as $k=>$v){
				if($goods_sizes[$k]){
					$size.=$goods_sizes[$k].','; 
				}
			}
			$rs['sizes']=$size?$size:'';
			
			$result[]=$rs;
		}
		return $result;
	}
	
	
	function getGoodsImgListCount($where=null){
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_assign a left join '.$this->tableName.' n  on n.goods_id=a.goods_id '.$where);
	}
	/**
	 * 描述列表
	 * @param int $from
	 * @param int $to
	 */
	function getGoodsImgList($from,$to,$where=null)
	{	
		if($from && $to){
			$this->db->open('select n.*,a.type,a.add_time times,a.user_id from '.CFG_DB_PREFIX .'goods_assign a LEFT JOIN '.$this->tableName.' n on n.goods_id=a.goods_id '.$where.' ORDER BY n.add_time DESC',$from,$to);
		}else{
			$this->db->open('select n.*,a.type,a.add_time times,a.user_id from '.CFG_DB_PREFIX .'goods_assign a LEFT JOIN '.$this->tableName.' n on n.goods_id=a.goods_id '.$where.' ORDER BY n.add_time DESC');
		}
		while ($rs = $this->db->next()) {
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['user_id'] = ModelDd::getCaption("user",$rs['user_id']);
			$rs['times'] = MyDate::transform('date',$rs['times']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$rs['cat_id'] = ModelDd::getCaption('goods_cat',$rs['cat_id']);
			$rs['brand_id'] = ModelDd::getCaption('goods_brand',$rs['brand_id']);
			$rs['type'] = $rs['type']<>0? ModelDd::getCaption('languages',$rs['type']):'images';
			$rs['img_status'] = $rs['img_status']==null|| $rs['img_status']=='' ?'未提交图片':ModelDd::getCaption('goods_audit_status',$rs['img_status']);
			$rs['des_status'] = $rs['des_status']==null|| $rs['img_status']=='' ?'未提交描述':ModelDd::getCaption("goods_audit_status",$rs['des_status']);
			$rs['status'] = ModelDd::getCaption("goods_audit_status",$rs['status']);
			
			//获取已选择的颜色集合
			$colors = array_flip(explode(",",substr($rs['colors'],1,strlen($rs['colors'])-1)));
			$goods_colors = ModelDd::getArray('goods_color');
			foreach($colors as $k=>$v){
				if($goods_colors[$k]){
					$color.=$goods_colors[$k].','; 
				}
			}
			$rs['colors']=$color?$color:'';
			//获取已选择的尺码集合
			$sizes = array_flip(explode(",",substr($rs['sizes'],1,strlen($rs['sizes'])-1)));
			$goods_sizes = ModelDd::getArray('goods_size');
			foreach($sizes as $k=>$v){
				if($goods_sizes[$k]){
					$size.=$goods_sizes[$k].','; 
				}
			}
			$rs['sizes']=$size?$size:'';
			
			$result[]=$rs;
		}
		return $result;
	}
	
	function goodsAssignList($from,$to,$goods_id){
		if($from && $to){
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_assign  where goods_id='.$goods_id.' order by type,add_time desc',$from,$to);
		}else{
			$this->db->open('select * from '.CFG_DB_PREFIX .'goods_assign  where goods_id='.$goods_id.' order by type,add_time desc');
		}
		while ($rs = $this->db->next()) {
			$rs['img_assign'] = ModelDd::getCaption('goods_img_place',$rs['assign']);
			$rs['type'] = $rs['type']<>0? ModelDd::getCaption('languages',$rs['type']):'images';
			$rs['user_name'] = ModelDd::getCaption("user",$rs['user_id']);
			$rs['add_user'] = ModelDd::getCaption("user",$rs['add_user']);
			$rs['add_time'] = MyDate::transform('date',$rs['add_time']);
			$result[] = $rs;
		}
		return $result;
	}
	function assignListCount($goods_id){
		return $this->db->getValue('select count(*) from '.CFG_DB_PREFIX .'goods_assign  where goods_id='.$goods_id);
	}
	
	function deleteAssign($assign_id){
		$goodsAssign=$this->db->getValue('select goods_id,type from '.CFG_DB_PREFIX .'goods_assign  where assign_id = '.$assign_id);
		if($goodsAssign['type']==0){
			$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_img where goods_id = '.$goodsAssign['goods_id']);
		}else{
			$this->db->execute('delete from '.CFG_DB_PREFIX .'goods_inter_des where goods_id = '.$goodsAssign['goods_id'].' and des_lang_id='.$goodsAssign['type']);
		}
		return $this->db->execute('delete from '.CFG_DB_PREFIX .'goods_assign where assign_id = '.$assign_id);
	}
}
?>