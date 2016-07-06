<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * 用户操作类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Model
 * @version v0.1
 */

class ModelUser extends Model {
	
	/**
	 * 构造函数
	 *
	 * @param object $query
	 */
	function __construct($query=null) {
		parent::__construct($query);
		$this->tableName = CFG_DB_PREFIX . 'admin_user';
		$this->primaryKey = 'user_id';
	}
	
	/**
	 * 检查验证码是否正确
	 *
	 * @param string $name
	 * @param string $value
	 * @return bool
	 */
	function checkValid($name, $value)
	{
		return md5(strtolower($value))==$_COOKIE[$name];
	}
	function getLasttime(){
		return $this->db->getValue('select last_login from myr_admin_user where user_id ='.$_SESSION['admin_id']);
	}
	/**
	 * 保存验证码
	 *
	 * @param string $name
	 * @param string $value
	 */
	function saveValid($name,$value)
	{
		setcookie($name, md5(strtolower($value)));
	}
	
	function getUserList($from,$to)
	{
		$this->db->open('select user_id,user_name from '.$this->tableName.$where.' order by '.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;
	}
	
	/**
	 * 检查用户信息
	 *
	 * @param string $username
	 * @param string $passwd
	 * @return bool
	 */
	function checkUser($company,$username,$passwd)
	{
		if($company){
			$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, $company, CFG_DB_ADAPTER, true );
			$query = new DbQueryForMysql($db);
			$query->prefix = CFG_DB_PREFIX;
			$sql = 'select user_id,user_name,password,action_list,account_list,last_login,now_login,versions from ' .$this->tableName.' where user_name=\''.$username.'\'';
			$userInfo = $query->getValue($sql);
			if ($userInfo) {
				if ($userInfo['password']==md5($passwd)) {
					$this->login($userInfo['user_id'],$passwd);
					$this->db->update(CFG_DB_PREFIX.'admin_user',array('last_login' => $userInfo['now_login'],'now_login' => CFG_TIME),'user_id ='.$userInfo['user_id']);
					savelog($userInfo['user_id'],'login','登录系统',$_SESSION['admin_id']);
				} else {
					$errorMsg = '密码错误';
				}
			} else {
				$errorMsg = '用户不存在';
			}
			if ($errorMsg) {
				throw new Exception($errorMsg);
			}
			$userInfo['company'] = $company;
		}else{
			//单用户模式
		}
		return $userInfo;
	}
	/**
	 * 更新用户上次登录时间
	 *
	 * @param int $userId
	 * @param string $passwd
	 * @return bool
	 */
	function updatelogtime($username){
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		$query->update(CFG_DB_PREFIX.'admin_user',array('last_login' => CFG_TIME),"user_name='{$username}'");
	}
	/**
	 * 登录用户信息
	 *
	 * @param int $userId
	 * @param string $passwd
	 * @return bool
	 */
	function login($userId,$passwd)
	{
		setcookie(CFG_COOKIE_PREFIX.'AUTH_STRING',
			authcode($userId . "\t" . md5($passwd), 'ENCODE', CFG_HASH_KEY)
			);
	}
	/**
	 * 用户登出
	 * @access public
	 * @return mixed
	 */
	function logout() {
		setcookie(CFG_COOKIE_PREFIX.'AUTH_STRING', 0, time()-1);
		header('location:' . CFG_URL);
	}
	/**
	 * 取当前用户信息
	 * @access public
	 * @return array
	 */
	function getAuthInfo($field=NULL) {
		$authInfo = authcode($_COOKIE[CFG_COOKIE_PREFIX.'AUTH_STRING'], 'DECODE', CFG_HASH_KEY);
		$authInfo = explode("\t",$authInfo);
		$result['user_id'] = $authInfo[0];
		$result['password'] = $authInfo[1];
		if ($field) {
			if ($result[$field]) {
				return $result[$field];
			} else {
				$info = $this->db->getValue('select * from ' . CFG_DB_PREFIX . 'admin_user where user_id=' 
						. intval($result['user_id']));
				return $info[$field];
			}
		}
		return $result;
	}
	/**
	 * 检查认证信息
	 * @access public
	 * @return NULL
	 */
	function auth() {
		$authSuc = false;
		if ($_COOKIE[CFG_COOKIE_PREFIX.'AUTH_STRING']) {
			if (!$_COOKIE[CFG_COOKIE_PREFIX.'AUTH_CHECKTIME']) {
				// 间隔AUTH_CHECKTIME时间检查一次cookie信息是否和数据库一至
				$authInfo = $this->getAuthInfo();
				$user = $this->db->getValue('select * from '
					 . CFG_DB_PREFIX . 'admin_user where user_id=\''
					 . $authInfo['user_id'] . '\' and  password=\''.$authInfo['password'].'\'');

				if ($user['user_id']) {
					$authSuc = true;
					setcookie(CFG_COOKIE_PREFIX.'AUTH_CHECKTIME',1, 
							time()+300);
				}
			} else {
				$authSuc = true;
			}
		}
		if ($authSuc===false) {
			$this->logout();
		}
	}
	/**
	 * 保存记录
	 *
	 * @param array $info
	 */
	function save($info)
	{
		//specConvert($info,array('user_name','email','pwd','role_id'));
		$user = new ModelUser();
		$user_id = $user->getAuthInfo('user_id');
		if (!$info['user_id']) {
			$action_list = $this->getroleright($info['role_id']);
			$account_list = $this->getaccountlist($info['role_id']);
			$this->db->insert($this->tableName,array(
				'user_name' => $info['user_name'],
				'email' => $info['email'],
				'password' => md5($info['pwd']),
				'add_time' => CFG_TIME,
				'role_id' => $info['role_id'],
				'action_list' => $action_list,
				'account_list' => $account_list,
				'company' => $_SESSION['company']
				));
			$info['user_id'] = $this->db->getInsertId();
			$this->cacheUser($info['user_id']);
				/*if(CFG_RUN_MODE ==1){
					$userinfo = $this->db->getValue("SELECT * FROM ".$this->tableName." WHERE user_id = ".$info['user_id']);
					$userinfo['company'] = $_SESSION['company'];
					$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
					$query = new DbQueryForMysql($db);
					$query->prefix = CFG_DB_PREFIX;
					try{
						$query->insert($this->tableName,$userinfo);
					} catch (Exception $e) {
						throw new Exception("该用户名不可用,请先修改后才能正常登陆");exit;
					}
				}*/
			} else {
			if($info['pwd']){
			$this->db->update($this->tableName,array(
				'user_name' => $info['user_name'],
				'email' => $info['email'],
				'password' => md5($info['pwd']),
				'role_id' => $info['role_id']
				),'user_id='.intval($info['user_id']));
			}else{
			$this->db->update($this->tableName,array(
				'user_name' => $info['user_name'],
				'email' => $info['email'],
				'role_id' => $info['role_id']
				),'user_id='.intval($info['user_id']));
			}
			$this->cacheUser($info['user_id']);
			if(CFG_RUN_MODE ==1){
				$userinfo = $this->db->getValue("SELECT * FROM ".$this->tableName." WHERE user_id = ".$info['user_id']);
				$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
				$query = new DbQueryForMysql($db);
				$query->prefix = CFG_DB_PREFIX;
				$query->update($this->tableName,$userinfo,'user_id='.intval($info['user_id']).' and company="'.$_SESSION['company'].'"');
			}
		}
		ModelDd::cacheUsermenu($info['user_id']);
	}
	function delete($ids)
	{
		$this->db->execute('delete from '.$this->tableName.' where '.$this->primaryKey.' in ('.$ids.')');
			if(CFG_RUN_MODE ==1){
				$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, CFG_DB_NAME, CFG_DB_ADAPTER, true );
				$query = new DbQueryForMysql($db);
				$query->prefix = CFG_DB_PREFIX;
				$query->execute('delete from '.$this->tableName.' where user_id in ('.$ids.') and company="'.$_SESSION['company'].'"');
			}
		return;
	}
	/**
	 * 保存个人信息
	 *
	 * @param array $info
	 */
	function saveSelf($info)
	{
		$user = new ModelUser();
		$user_id = $user->getAuthInfo('user_id');
		specConvert($info,array('telephone','mobile',
				'email','address'));
		$this->db->update(CFG_DB_PREFIX.'user',array(
				'telephone' => $info['telephone'],
				'mobile' => $info['mobile'],
				'email' => $info['email'],
				'address' => $info['address'],
				),'user_id='.$user_id);
		$this->cacheUser($user_id);
	}
	/**
	 * 获取用户权限
	 *
	 * @param array $info
	 */
	function getRight($id)
	{
        
		return $this->db->getValue('select action_list from ' . CFG_DB_PREFIX . 'admin_user where user_id=' 
						. intval($id));
	}
	/**
	 * 获取用户管理账户
	 *
	 * @param array $info
	 */
	function getAccount($id)
	{
		return $this->db->getValue('select account_list from ' . CFG_DB_PREFIX . 'admin_user where user_id=' 
						. intval($id));
	}

	/**
	 * 保存权限
	 *
	 * @param array $info
	 */
	function saveRight($info)
	{
		$var = '<?php return '.var_export($info,true).'; ?>';
		$fp = fopen(CFG_PATH_DATA.'right.php','w');
		fputs($fp,$var);
		fclose($fp);
	}
	/**
	 * 根据用户名取ID
	 *
	 * @param string $username
	 * @return int
	 */
	function getUserIdForName($username)
	{
		$result = $this->db->getValue('select user_id from '
				.$this->tableName.' where user_name=\''.$username.'\'');
		return $result;
	}
	/**
	 * 取用户名
	 * @param $id 
	 */
	static function getName($id)
	{
		$info = ModelUser::getCacheInfo($id);
		return $info['user_name'];
	}
	/**
	 * 缓存用户信息
	 * @param $id 
	 */
	function cacheUser($id)
	{
		$info = $this->getInfo($id);
		$fp = fopen(CFG_PATH_DATA.'tmp/cache/user/'.$id.'.php','w');
		fputs($fp,'<?php return '.var_export($info,true).';?>');
		fclose($fp);
		$array = $this->db->select('select user_id,user_name from '.$this->tableName, 'hashmap');
		$fp = fopen(CFG_PATH_DATA . 'dd/user.php', 'w');
		fputs($fp, '<?php return '.var_export($array, true) . '; ?>');
		fclose($fp);
	}
	/**
	 * 取用户缓存
	 * @param $id 
	 */
	static function getCacheInfo($id)
	{
		return @include(CFG_PATH_DATA.'tmp/cache/user/'.$id.'.php');
	}
	/**
	 * 删除用户缓存
	 * @param $id 
	 */
	function delCache($id)
	{
		@unlink(CFG_PATH_DATA.'tmp/cache/user/'.$id.'.php');
	}
	
	function getList($from,$to,$where=null,$sort=null)
	{
		$this->db->open('select * from '.$this->tableName.$where.' order by '.$sort.$this->primaryKey.' desc',$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$result[] = $rs;
		}
		return $result;		
	}
	function getCount($where=null)
	{
		return $this->db->getValue('select count(*) from '.$this->tableName.$where);		
	}
	/*************
	***
	* 检查用户名是否存在
	* @param string $name
	*************/
	function checkname($name)
	{
				$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, 'allpyra', CFG_DB_ADAPTER, true );
				$query = new DbQueryForMysql($db);
				$query->prefix = CFG_DB_PREFIX;
			if($query->getValue("SELECT count(*) FROM ".$this->tableName." WHERE user_name = '".$name."'")>0) {
				throw new Exception("该用户名系统已存在,请使用其他用户名");exit;
			}
	}
	function getroleright($id)
	{
		return $this->db->getValue('select action_list from ' . CFG_DB_PREFIX . 'role where role_id=' 
						. intval($id));
	}
	function getaccountlist($id)
	{
		return $this->db->getValue('select account_list from ' . CFG_DB_PREFIX . 'role where role_id=' 
						. intval($id));
	}
	/**
	 * 首页获取我的库存
	 */
	function getkucun(){
		return $this->db->getValue('select sum(ds.goods_qty) from ' . CFG_DB_PREFIX . 'goods as g left join '.CFG_DB_PREFIX.'depot_stock as ds on g.goods_id = ds.goods_id');	
	}
	/**
	 * 管理员登录普通账户
	 **/
	function AdminLogin($username)
	{
		$db = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, $username, CFG_DB_ADAPTER, true );
		$query = new DbQueryForMysql($db);
		$query->prefix = CFG_DB_PREFIX;
		$sql = 'select user_id,user_name,password,action_list,account_list,last_login,now_login,versions,company from ' .$this->tableName.' where user_name=\''.$username.'\'';
		$userInfo = $query->getValue($sql);
		if ($userInfo) {
			setcookie(CFG_COOKIE_PREFIX.'AUTH_STRING',
				authcode($userInfo['user_id'] . "\t" . $userInfo['password'], 'ENCODE', CFG_HASH_KEY)
			);
		} else {
			$errorMsg = '用户不存在';
		}
		if ($errorMsg) {
			throw new Exception($errorMsg);
		}
		return $userInfo;
	}
    /**
     * 链接主数据库
     *  
     */
    static function connectErpDb()
    {
        $maindb = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, 'ice', CFG_DB_ADAPTER, true );
        $query = new DbQueryForMysql($maindb);
        $query->prefix = CFG_DB_PREFIX;
        return $query;
    }
    static function connectSelfDb()
    {
       
        $maindb = new DataSource(CFG_DB_HOST, CFG_DB_USER, CFG_DB_PASSWORD, $_SESSION['company'], CFG_DB_ADAPTER, true );
        $query = new DbQueryForMysql($maindb);
        $query->prefix = CFG_DB_PREFIX;
        return $query;
    }
}
?>
