<?php
// +--------------------------------------------------------------+
// | 这个文件是 MYOIS 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2006 - 2008 MYOIS.CN (www.myois.cn)            |
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// | 或者访问 http://www.myois.cn/ 获得详细信息                      |
// +--------------------------------------------------------------+

/**
 * 公告
 *
 * @copyright Copyright (c) 2006 - 2008 MYOIS.CN
 * @author 戴志君 <dzjzmj@gmail.com>
 * @package Model
 * @version v0.1
 */

class ModelNews extends Model {

	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'news';
	}

	/**
	 * 保存记录
	 *
	 * @param array $cat
	 */
	public function save($news)
	{
		$user = new ModelUser();
		$info = $user->getAuthInfo();
		if (!$news['id']) {
			$this->db->insert($this->tableName,array(
				'news_title' => $news['news_title'],
				'news_url' => $news['news_url'],
				'create_user_id' => $_SESSION['admin_id'],
				'create_time' => CFG_TIME,
				'content' => $news['content'],
			));
		} else {
			$this->db->update($this->tableName,array(
				'news_url' => $news['news_url'],
				'news_title' => $news['news_title'],
				'content' => $news['content'],
			),'id='.intval($news['id']));
		}
	}

	/**
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 */
	function getList($from,$to,$where=null)
	{
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, 'ice', CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		$query->update(CFG_DB_PREFIX.'admin_user',array('last_login' => CFG_TIME),"user_name='{$username}'");
		$query->open('SELECT * FROM '.$this->tableName.$where.' ORDER BY id DESC',$from,$to);
		$result = array();
		$now = time();
		$day_3 = 259200;  //三天的秒数
		while ($rs = $query->next()) {
			$rs['is_new'] = ($now - $rs['create_time']) > $day_3  ? 0 : 1;
			$rs['create_user_id'] = $query->getValue('select user_name from '.CFG_DB_PREFIX.'admin_user where user_id ='.$rs['create_user_id']);
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 生成查询条件
	 *
	 * @param array $info
	 * @return string
	 */
	function getWhere($info) {
		specConvert($info,array('news_title'));
		if ($info['news_title']) $wheres[] = 'news_title like \'%'.$info['news_title'].'\'%';
	}
	/**
	 * 取记录
	 *
	 * @param int $id ID
	 * @return array
	 */
	function getNews($id)
	{
		return $this->db->getValue('select * from '.$this->tableName.' where '.$this->primaryKey.'="'.$id.'"');
	}
	
	
	/**
	 * 使用关键字得到新闻信息
	 *
	 * @param int $id
	 * @return 新闻实体对象
	 */
	function getNewsInfo($id)
	{
		$news=$this->db->getValue('select * from '.$this->tableName.' where '.$this->primaryKey.'='.$id);
		if($news!=null){
			$news['create_user_id'] = ModelDd::getCaption("user",$news['create_user_id']);
			$create_user_id =$this->db->getValue('select show_user_id from '.$this->tableName.' where '.$this->primaryKey.'='.$id." and show_user_id REGEXP ',".$_SESSION['admin_id'].",'");
			if(!$create_user_id){
				$this->db->execute("update ".$this->tableName." set show_user_id = '". (($create_user_id == null)?(','.$_SESSION['admin_id'].','):($create_user_id.$_SESSION['admin_id'].','))."'  where id =".intval($news['id']));
			}
		}
		return $news;
	}
	function getNewslist($num)
	{
		$action_list = explode(',',$_SESSION['action_list']);
		$this->db->open("SELECT id,news_title,create_time FROM ".$this->tableName.$where." order by id desc limit 0,".$num);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['create_time'] = MyDate::transform('date',$rs['create_time']);
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 保存记录
	 *
	 */
	public function saveRevert($id,$data)
	{
		specConvert($news,array('showType','content'));
		$data['showType'] = ($data['showType'])?1:0;
		if ($id) {
			$this->db->insert(CFG_DB_PREFIX.'news_revert',array(
				'news_id' => $id,
				'user_id' => $_SESSION['admin_id'],
				'showType' => $data['showType'],
				'time' => CFG_TIME,
				'content' => $data['content']
			));
		}else return false;
		if($data['showType']){
			$news=$this->db->getValue('select create_user_id,show_user_id from '.$this->tableName.' 
				where '.$this->primaryKey.'='.$id.' and show_user_id like \'%,'.$info['user_id'].',%\' ');
			if($news['show_user_id']){
				$this->db->update($this->tableName,array('show_user_id' => strtr($news['show_user_id'], array(','.$news['create_user_id'].',' => ','))),'id='.intval($id));
			}else{
				return false;
			}
		}else{
			$this->db->update($this->tableName,array('show_user_id' => null),'id='.intval($id));
		}
		return true;
	}
	
	
	public function revertList($news_id)
	{
		$this->db->open('select a.* from `'.CFG_DB_PREFIX.'news_revert`  AS a LEFT JOIN  '.$this->tableName.' as c ON a.news_id=c.id where (a.news_id='.$news_id.' and c.create_user_id <> "'.$_SESSION['admin_id'].'" and a.showType <> 0) or (a.news_id='.$news_id.' and c.create_user_id = "'.$_SESSION['admin_id'].'")');
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['user_name'] = ModelDd::getCaption("user",$rs['user_id']);
			$result[] = $rs;
		}
		return $result;
	}
}
?>