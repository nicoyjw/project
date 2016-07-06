<?php  
 /* 
 这是一个在服务器端备份和恢复数据库的类
 */  
 class DBBack{  
	private $back_dir='./';//备份的路径  
	private $back_file=array();//当前已存在的备份  
	private $host='localhost';  
	private $user='root';  
	private $pwd='123456';  
	private $conn;  
	private $dbname='navgoods';  
	private $charset='utf8';  
	private $sql='';  
	private $limit=";\r\n[*_*]";  
	public $tips='';//执行得到的提示信息  
	private $cg_line=0;//操作成功的记录总条数  
	private $cg_tb=0;//操作成功的表的个数  
	private $sb_line=0;//操作失败的记录总条数  
	private $sb_tb=0;//操作失败的表的个数  
	private static $instance;  
	public static function getInstance(){  
		if(!self::$instance instanceof self){  
			self::$instance=new self();  
		}  
		return self::$instance;  
	}  
	private function __construct(){  
		date_default_timezone_set('Asia/Shanghai');  
		$this->conn=@mysql_connect($this->host,$this->user,$this->pwd);  
		if(!$this->conn){  
			$this->tips='数据库连接失败!'.mysql_error();  
			return false;  
		}  
		mysql_query("SET NAMES '".$this->charset."'");  
		mysql_query("SET CHARACTER_SET_CLIENT='".$this->charset."'");  
		mysql_query("SET CHARACTER_SET_RESULTS='".$this->charset."'");  
		if(!mysql_select_db($this->dbname,$this->conn)){  
			$this->tips='不存在数据库:'.$this->dbname.',请核对后再试!'.mysql_error();  
			return false;  
		}  
	}  
	//以库为单位备份  
	public function dbBack(){  
		mysql_query("set names '{$this->charset}'");  
		$this->sql='';  
		$this->sql= "CREATE DATABASE IF NOT EXISTS `$this->dbname` DEFAULT CHARACTER SET {$this->charset}{$this->limit}";  
		$this->sql.= "USE `$this->dbname`{$this->limit}";  
		$tb_result=mysql_query("show tables");  
		while($t=mysql_fetch_array($tb_result)){  
			$tb_name[]=$t[0];  
		}  
		$this->sql.=$this->tbBack($tb_name);  
		return $this->saveFile();  
	}  
   
	//以表为单位备份，传入一个数组  
	public function tbBack($arr_tb_name){  
		$mysql=array();  
		$i=0;  
		$this->cg_line=0;  
		foreach($arr_tb_name as $tb_name){  
			$mysql[$i]= "set charset {$this->charset}{$this->limit}";  
			$mysql[$i].= "DROP TABLE IF EXISTS `$tb_name`{$this->limit}";  
			$tb_create=mysql_query("show create table `$tb_name`");  
			$row=mysql_fetch_assoc($tb_create);  
			$mysql[$i].=$row['Create Table'].$this->limit;  
			$mysql[$i].= "LOCK TABLES `$tb_name` WRITE{$this->limit}";  
			$result=mysql_query("select * from `$tb_name`");  
			while($data=mysql_fetch_assoc($result)){  
				foreach ($data as $k=>$v){  
					if($v==''){  
						unset($data[$k]);  
					}  
				}  
				$keys=array_keys($data);  
				$keys=array_map(addslashes,$keys);  
				$keys=join('`,`',$keys);  
				$keys="`".$keys."`";  
				$vals=array_values($data);  
				$vals=array_map(addslashes,$vals);  
				$vals=join("','",$vals);  
				$vals="'".$vals."'";  
				$mysql[$i].="insert into `$tb_name`($keys) values($vals){$this->limit}";  
				$this->cg_line++;  
			}  
			$mysql[$i].= "UNLOCK TABLES{$this->limit}";  
			$i++;  
		}  
		$this->cg_tb=$i;  
		$mysql=implode('',$mysql);  
		return $mysql;  
	}  
   
   
	//恢复数据库  
	function restore($fname){  
		if (file_exists($fname)) {  
			$cg=0;  
			$sb=0;  
			$this->cg_line=0;  
			$this->sb_line=0;  
			$this->cg_tb=0;  
			$this->sb_tb=0;  
			$handle = @fopen($fname, "r");  
			$buffer='';  
			$this->tips='';  
			if ($handle){  
				while (!feof($handle)){  
					$buffer .= fgets($handle, 4096);  
				}  
				fclose($handle);  
			}else{  
				$this->tips.="备份文件读取失败！";  
			}  
			$a=explode($this->limit, $buffer);  
			unset($buffer);  
			$total=count($a)-1;  
			for ($i=0;$i<$total;$i++){  
				if(mysql_query($a[$i])){  
					if(strpos($a[$i],'insert into')!==false||strpos($a[$i],'INSERT INTO')!==false)$this->cg_line++;  
					if(strpos($a[$i],'create table')!==false||strpos($a[$i],'CREATE TABLE')!==false)$this->cg_tb++;  
					$cg+=1;  
				}else{  
					if(strpos($a[$i],'insert into')!==false||strpos($a[$i],'INSERT INTO')!==false)$this->sb_line++;  
					if(strpos($a[$i],'create table')!==false||strpos($a[$i],'CREATE TABLE')!==false)$this->sb_tb++;  
					$sb+=1;  
					$sb_command[$sb]=$a[$i].'---'.mysql_error();  
				}  
			}  
			$this->tips.="操作完毕，<br/>共处理 $total 条命令，<br/>成功 $cg 条，<br/>失败 $sb 条.<br/>成功恢复{$this->cg_tb}张表，{$this->cg_line}条记录。<br/>恢复失败{$this->sb_tb}张表，{$this->sb_line}条记录.";  
			if ($sb>0){  
				$this->tips.="<hr><br><br>失败命令如下：<br>";  
				for ($ii=1;$ii<=$sb;$ii++){  
					$this->tips.="<p><b>第 ".$ii." 条命令（内容如下）：</b><br>".$sb_command[$ii]."</p><br>";  
				}  
			}  
		}else{  
			$this->tips.="MySQL备份文件不存在，请检查文件路径是否正确！";  
		}  
	}  
   
	private function saveFile(){  
		$this->tips='';  
		$this->back_dir=rtrim($this->back_dir,'/').'/';  
		$filename=$this->back_dir.$this->dbname.date('YmdHis').".sql";  
		$fsize=file_put_contents($filename,$this->sql,FILE_USE_INCLUDE_PATH);  
		$this->sql='';  
		if($result===false){  
			$this->tips='文件备份失败！';  
			return false;  
		}else{  
			$this->tips='文件保存成功^_^<br/>文件名：'.$filename.'<br/>大小：'.round($fsize/1024/1024,2).'兆.<br/>';  
			$this->tips.="共备份了{$this->cg_tb}张表，{$this->cg_line}条记录。";  
			return true;  
		}  
	}  
   
   
	//检测已存在的备份  
	public function check(){  
		$this->back_dir=rtrim($this->back_dir,'/').'/';  
		if(!is_dir($this->back_dir)){  
			if(!mkdir($this->back_dir)){  
				$this->tips='存放备份文件的文件夹不存在，并且创建失败，请确保您在服务器有创建该目录的权限!';  
				return false;  
			}  
		}  
		$arrFile=scandir($this->back_dir);  
		foreach($arrFile as $key=>$value){  
			if(is_dir($this->back_dir.$value)){unset($arrFile[$key]);continue;}  
			if(substr($value,-4,4)!='.sql')unset($arrFile[$key]);  
		}  
		if(empty($arrFile)){  
			$this->back_file=array();  
			$this->tips='数据库目前还没有备份！';  
			return false;  
		}else{  
			$i=0;  
			foreach($arrFile as $k=>$v){  
				$url=$this->back_dir.$v;  
				$this->back_file[$i]['name']=iconv('GBK','UTF-8',$v);//转码文件名  
				$this->back_file[$i]['url']=$url;  
				$this->back_file[$i]['time']=filectime($url);  
				$this->back_file[$i]['size']=round(filesize($url)/1024/1024,2).'Mb';  
				$i++;  
			}  
			return $this->back_file;  
		}  
	}
 }  
 ?>  