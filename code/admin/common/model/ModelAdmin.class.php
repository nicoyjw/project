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
 * 用户操作类
 *
 * @copyright Copyright (c) 2012 - 2015
 * @author 吴小勇 <nicoyjw041114@163.com>
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
		$this->tableName = CFG_DB_PREFIX . 'user';
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
	
	/**
	 * 检查用户信息
	 *
	 * @param string $username
	 * @param string $passwd
	 * @return bool
	 */
	function checkUser($username,$passwd)
	{
		$sql = 'select user_id,username,passwd from ' . CFG_DB_PREFIX . 'user where username=\''.$username.'\'';
		$userInfo = $this->db->getValue($sql);
		if ($userInfo) {
			if ($userInfo['passwd']==md5($passwd)) {
				$this->login($userInfo['user_id'],$passwd);
			} else {
				$errorMsg = '密码错误';
			}
		} else {
			$errorMsg = '用户不存在';
		}
		if ($errorMsg) {
			throw new Exception($errorMsg);
		}
		return $userInfo['user_id'];
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
		$result['passwd'] = $authInfo[1];
		if ($field) {
			if ($result[$field]) {
				return $result[$field];
			} else {
				$info = $this->db->getValue('select * from ' . CFG_DB_PREFIX . 'user where user_id=' 
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
					 . CFG_DB_PREFIX . 'user where user_id=\''
					 . $authInfo['user_id'] . '\' and  passwd=\''.$authInfo['passwd'].'\'');

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
		specConvert($info,array('username','real_name','id_card','school','telephone','mobile',
				'email','address','note'));
		$user = new ModelUser();
		$user_id = $user->getAuthInfo('user_id');
		if (!$info['user_id']) {
			$this->db->insert(CFG_DB_PREFIX.'user',array(
				'username' => $info['username'],
				'real_name' => $info['real_name'],
				'sex' => $info['sex'],
				'native_place' => $info['native_place'],
				'birthday' => MyDate::transform('timestamp',$info['birthday']),
				'id_card' => $info['id_card'],
				'nation' => $info['nation'],
				'is_married' => $info['is_married'],
				'polity' => $info['polity'],
				'education' => $info['education'],
				'specialty' => $info['specialty'],
				'school' => $info['school'],
				'telephone' => $info['telephone'],
				'mobile' => $info['mobile'],
				'email' => $info['email'],
				'address' => $info['address'],
				'station_status' => $info['station_status'],
				'headship' => $info['headship'],
				'join_time' => MyDate::transform('timestamp',$info['join_time']),
				'leave_time' => MyDate::transform('timestamp',$info['leave_time']),
				'rehab_time' => MyDate::transform('timestamp',$info['rehab_time']),
				'dept_id' => $info['dept_id'],
				'note' => $info['note'],
				'passwd' => md5(CFG_DEFAULT_PASSWD),
				'create_user_id' => $user_id,
				'create_time' => time(),
				'status' => 1,
				));
			$info['user_id'] = $this->db->getInsertId();
		} else {
			$this->db->update(CFG_DB_PREFIX.'user',array(
				'username' => $info['username'],
				'real_name' => $info['real_name'],
				'sex' => $info['sex'],
				'native_place' => $info['native_place'],
				'birthday' => MyDate::transform('timestamp',$info['birthday']),
				'id_card' => $info['id_card'],
				'nation' => $info['nation'],
				'is_married' => $info['is_married'],
				'polity' => $info['polity'],
				'education' => $info['education'],
				'specialty' => $info['specialty'],
				'school' => $info['school'],
				'telephone' => $info['telephone'],
				'mobile' => $info['mobile'],
				'email' => $info['email'],
				'address' => $info['address'],
				'station_status' => $info['station_status'],
				'headship' => $info['headship'],
				'join_time' => MyDate::transform('timestamp',$info['join_time']),
				'leave_time' => MyDate::transform('timestamp',$info['leave_time']),
				'rehab_time' => MyDate::transform('timestamp',$info['rehab_time']),
				'dept_id' => $info['dept_id'],
				'note' => $info['note'],
				'modify_user_id' => $user_id,
				'modify_time' => time(),
				),'user_id='.intval($info['user_id']));
			
		}
		$this->cacheUser($info['user_id']);
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
	 * 保存个人密码
	 *
	 * @param array $info
	 */
	function savePass($info)
	{
		$passwd = $this->getAuthInfo('passwd');
		$user_id = $this->getAuthInfo('user_id');
		if (md5($info['oldpasswd'])!=$passwd) {
			throw new Exception('原密码错误！');
		}
		if ($info['passwd']!=$info['passwd2']) {
			throw new Exception('两次密码不同！');
		}
		$this->db->update($this->tableName,array(
				'passwd' => md5($info['passwd']),
				),'user_id='.$user_id);
		$this->cacheUser($user_id);
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
	 * 取列表
	 *
	 * @param int $from
	 * @param int $to
	 * @param string $where
	 * @return array
	 */
	function getList($from,$to,$where=null)
	{
		$this->db->open('select * from '.$this->tableName.$where,$from,$to);
		$result = array();
		while ($rs = $this->db->next()) {
			$rs['station_status'] = ModelDd::getCaption('station_status',$rs['station_status']);
			$rs['headship'] = ModelDd::getCaption('headship',$rs['headship']);
			$result[] = $rs;
		}
		return $result;
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
				.$this->tableName.' where username=\''.$username.'\'');
		return $result;
	}
	/**
	 * 取用户名
	 * @param $id 
	 */
	static function getName($id)
	{
		$info = ModelUser::getCacheInfo($id);
		return $info['username'];
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
}
?>