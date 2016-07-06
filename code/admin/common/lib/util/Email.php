<?php
/**
 *
 * @author      smllbo 
 * @version     $$Id: Email.PHP 175 2012-04-07 10:52:16Z smllbo $$
 */

/**
 * Email class
 *
 * get mail total count,get mail list,get mail content,get mail attach
 *
 * For a example, if you want to get some specified email list.
 * 
 * $mail = new Evebit_Mail();
 * $mail->mailConnect($host,$port,$user,$pass,'INBOX',$ssl);
 * $mail->mailList('5,9:20');
 * 
 *
 * show the five,and nine to twenty mail.
 * 
 * $mail->mailList('5,9:20');
 * 
 *
 * @docinfo
 *
 * @author      smllbo 
 * @version     $$Id: Email.PHP 175 2012-04-07 10:52:16Z smllbo $$
 */
class Smllbo_Email{
    
    /**
     * @var resource $_connect
     */
    private $_connect;
    /**
     * @var object $_mailInfo
     */
    private $_mailInfo;
    /**
     * @var int $_totalCount
     */
    private $_totalCount;
    /**
     * @var array $_totalCount
     */
    private $_contentType;

    
    /**
     * __construct of the class
     */
    public function __construct() {
        $this->_contentType = array(
            'ez' => 'application/andrew-inset','hqx' => 'application/mac-binhex40',
            'cpt' => 'application/mac-compactpro','doc' => 'application/msword',
            'bin' => 'application/octet-stream','dms' => 'application/octet-stream',
            'lha' => 'application/octet-stream','lzh' => 'application/octet-stream',
            'exe' => 'application/octet-stream','class' => 'application/octet-stream',
            'so' => 'application/octet-stream','dll' => 'application/octet-stream',
            'oda' => 'application/oda','pdf' => 'application/pdf',
            'ai' => 'application/postscript','eps' => 'application/postscript',
            'ps' => 'application/postscript','smi' => 'application/smil',
            'smil' => 'application/smil','mif' => 'application/vnd.mif',
            'xls' => 'application/vnd.ms-excel','ppt' => 'application/vnd.ms-powerpoint',
            'wbxml' => 'application/vnd.wap.wbxml','wmlc' => 'application/vnd.wap.wmlc',
            'wmlsc' => 'application/vnd.wap.wmlscriptc','bcpio' => 'application/x-bcpio',
            'vcd' => 'application/x-cdlink','pgn' => 'application/x-chess-pgn',
            'cpio' => 'application/x-cpio','csh' => 'application/x-csh',
            'dcr' => 'application/x-director','dir' => 'application/x-director',
            'dxr' => 'application/x-director','dvi' => 'application/x-dvi',
            'spl' => 'application/x-futuresplash','gtar' => 'application/x-gtar',
            'hdf' => 'application/x-hdf','JS' => 'application/x-javascript',
            'skp' => 'application/x-koan','skd' => 'application/x-koan',
            'skt' => 'application/x-koan','skm' => 'application/x-koan',
            'latex' => 'application/x-latex','nc' => 'application/x-netcdf',
            'cdf' => 'application/x-netcdf','sh' => 'application/x-sh',
            'shar' => 'application/x-shar','swf' => 'application/x-shockwave-flash',
            'sit' => 'application/x-stuffit','sv4cpio' => 'application/x-sv4cpio',
            'sv4crc' => 'application/x-sv4crc','tar' => 'application/x-tar',
            'tcl' => 'application/x-tcl','tex' => 'application/x-tex',
            'texinfo' => 'application/x-texinfo','texi' => 'application/x-texinfo',
            't' => 'application/x-troff','tr' => 'application/x-troff',
            'roff' => 'application/x-troff','man' => 'application/x-troff-man',
            'me' => 'application/x-troff-me','ms' => 'application/x-troff-ms',
            'ustar' => 'application/x-ustar','src' => 'application/x-wais-source',
            'xHTML' => 'application/xHTML+xml','xht' => 'application/xHTML+xml',
            'zip' => 'application/zip','au' => 'audio/basic','snd' => 'audio/basic',
            'mid' => 'audio/midi','midi' => 'audio/midi','kar' => 'audio/midi',
            'mpga' => 'audio/mpeg','mp2' => 'audio/mpeg','mp3' => 'audio/mpeg',
            'aif' => 'audio/x-aiff','aiff' => 'audio/x-aiff','aifc' => 'audio/x-aiff',
            'm3u' => 'audio/x-mpegurl','ram' => 'audio/x-pn-realaudio','rm' => 'audio/x-pn-realaudio',
            'rpm' => 'audio/x-pn-realaudio-plugin','ra' => 'audio/x-realaudio',
            'wav' => 'audio/x-wav','pdb' => 'chemical/x-pdb','xyz' => 'chemical/x-xyz',
            'bmp' => 'image/bmp','gif' => 'image/gif','ief' => 'image/ief',
            'jpeg' => 'image/jpeg','jpg' => 'image/jpeg','jpe' => 'image/jpeg',
            'png' => 'image/png','tiff' => 'image/tiff','tif' => 'image/tiff',
            'djvu' => 'image/vnd.djvu','djv' => 'image/vnd.djvu','wbmp' => 'image/vnd.wap.wbmp',
            'ras' => 'image/x-cmu-raster','pnm' => 'image/x-portable-anymap',
            'pbm' => 'image/x-portable-bitmap','pgm' => 'image/x-portable-graymap',
            'ppm' => 'image/x-portable-pixmap','rgb' => 'image/x-rgb','xbm' => 'image/x-xbitmap',
            'xpm' => 'image/x-xpixmap','xwd' => 'image/x-xwindowdump','igs' => 'model/iges',
            'iges' => 'model/iges','msh' => 'model/mesh','mesh' => 'model/mesh',
            'silo' => 'model/mesh','wrl' => 'model/vrml','vrml' => 'model/vrml',
            'css' => 'text/css','HTML' => 'text/HTML','htm' => 'text/HTML',
            'asc' => 'text/plain','txt' => 'text/plain','rtx' => 'text/richtext',
            'rtf' => 'text/rtf','sgml' => 'text/sgml','sgm' => 'text/sgml',
            'tsv' => 'text/tab-separated-values','wml' => 'text/vnd.wap.wml',
            'wmls' => 'text/vnd.wap.wmlscript','etx' => 'text/x-setext',
            'xsl' => 'text/xml','xml' => 'text/xml','mpeg' => 'video/mpeg',
            'mpg' => 'video/mpeg','mpe' => 'video/mpeg','qt' => 'video/quicktime',
            'mov' => 'video/quicktime','mxu' => 'video/vnd.mpegurl','avi' => 'video/x-msvideo',
            'movie' => 'video/x-sgi-movie','ice' => 'x-conference/x-cooltalk',
            'rar' => 'application/x-rar-compressed','zip' => 'application/x-zip-compressed',
            '*'=> 'application/octet-stream','docx' => 'application/msword'
        );
    }
    
    /**
     * Open an IMAP stream to a mailbox
     *
     * @param string $host
     * @param string $port
     * @param string $user
     * @param string $pass
     * @param string $folder
     * @param string $ssl
     * @param string $pop
     * @return resource|bool
     */
    public function mailConnect($host,$port,$user,$pass,$folder="INBOX",$ssl,$pop=false) {
        if($pop){
            $ssl = $pop.'/'.$ssl.'/novalidate-cert/notls';
        }
        $this->_connect = imap_open("{"."$host:$port/$ssl"."}$folder",$user,$pass);
        if(!$this->_connect) {
           echo 'cannot connect: ' . imap_last_error();
            return false;   
        }
        return $this->_connect;
    }
    
    /**
     * Get information about the current mailbox
     *
     * @return object|bool
     */
    public function mailInfo(){
        $this->_mailInfo = imap_mailboxmsginfo($this->_connection);
        if(!$this->_mailInfo) {
            echo "get mailInfo failed: " . imap_last_error();
            return false;
        }
        return $this->_mailInfo;
    }
    
    /**
     * Read an overview of the information in the headers of the given message
     *
     * @param string $msgRange
	 * @param string $order
     * @return array
     */
    public function mailList($msgRange='',$order='ASC')
    {
        if ($msgRange) {
            $range=$msgRange;
        } else {
            $this->mailTotalCount();
            $range = "1:".$this->_totalCount;
        }
        $overview  = imap_fetch_overview($this->_connect,$range);
        foreach ($overview  as $val) {
            $mailList[$val->msgno]=(array)$val;
        }
		if(strtolower($order)=='desc')
			krsort($mailList);
        return $mailList;
    }
    
    /**
     * get the total count of the current mailbox
     *
     * @return int
     */
    public function mailTotalCount(){
		if($this->_connect){
			$check = imap_check($this->_connect);
			   $this->_totalCount = $check->Nmsgs;
			   return $this->_totalCount;
		   }else{
			   return -1;
		   }
    }
    
    /**
     * Read the header of the message
     *
     * @param string $msgCount
     * @return array
     */
    public function mailHeader($msgCount) {
        $mailHeader = array();
        $header=imap_header($this->_connect,$msgCount);
        $sender=$header->from[0];
        $replyTo=$header->reply_to[0];
        if(strtolower($sender->mailbox)!='mailer-daemon' && strtolower($sender->mailbox)!='postmaster') {
            $mailHeader = array(
                'from'=>strtolower($sender->mailbox).'@'.$sender->host,
                'fromName'=>$this->decode_str($sender->personal),
                'toOther'=>strtolower($replyTo->mailbox).'@'.$replyTo->host,
                'toOtherName'=>$this->decode_str($replyTo->personal),
                'subject'=>$this->decode_str($header->subject),
                'to'=>$this->decodeEmailTo($header->toaddress),
                'date'=>$header->date,
                'id'=>$header->Msgno,
                'seen'=>$header->Unseen
            );
        }
        return $mailHeader;
    }
	function decodeEmailTo($str){
		$str_arr=explode('?=',$str);
		if(is_array($str_arr)&&count($str_arr)>1)
			return	$this->decode_str($str_arr[0].'?=').$str_arr[1];
		else
			return $str;
	}
    /**
     * get the header list of the message
     *
     * @param string $range
     * @return array
     */
    public function getMailHeaderList($range) {
	
    }	
  	/**
     * decode the subject of chinese
     *
     * @param string $subject
     * @return sting
     */
    public function subjectDecode($subject) {
        $beginStr = substr($subject, 0, 5);
        if($beginStr == '=?ISO') {
            $separator = '=?ISO-2022-JP';
            $toEncoding = 'ISO-2022-JP';
        } else  {
            $separator = '=?GB2312';
            $toEncoding = 'GB2312';
        }
        $encode = strstr($subject, $separator);
        if ($encode) {
            $explodeArr = explode($separator, $subject);
            $length = count($explodeArr);
            $subjectArr = array();
            for($i = 0; $i < $length / 2; $i++) {
                $subjectArr[$i][] = $explodeArr[$i * 2];
                if (@$explodeArr[$i * 2 + 1]) {
                    $subjectArr[$i][] = $explodeArr[$i * 2 + 1];
                }
            }
            foreach ($subjectArr as $arr) {
                $subSubject = implode($separator, $arr);
                if (count($arr) == 1) {
                    $subSubject = $separator . $subSubject;
                }
                $begin = strpos($subSubject, "=?");
                $end = strpos($subSubject, "?=");
                $beginStr = '';
                $endStr = '';
                if ($end > 0) {
                    if ($begin > 0) {
                        $beginStr = substr($subSubject, 0, $begin);
                    }
                    if ((strlen($subSubject) - $end) > 2) {
                        $endStr = substr($subSubject, $end + 2, strlen($subSubject) - $end - 2);
                    }
                    $str = substr($subSubject, 0, $end - strlen($subSubject));
                    $pos = strrpos($str, "?");
                    $str = substr($str, $pos + 1, strlen($str) - $pos);
                    $subSubject = $beginStr . imap_base64($str) . $endStr;
                    $subSubjectArr[] = iconv ( $toEncoding, 'utf-8', $subSubject );
//                    mb_convert_encoding($subSubject, 'utf-8' ,'gb2312,ISO-2022-JP');
                }
            }
            $subject = implode('', $subSubjectArr);
        }
        return $subject;
    }
	function decode_str($input,$des_charset='utf-8'){
		$out='';
		if(empty($input)) return $out;
		$input = preg_replace("/\?=\s+=\?/", '?==?', $input);
		$pattern = '/=\?([^?]+)\?([BbQq])\?([^\n]*?)\?=/';
		if (preg_match_all($pattern, $input, $matches,PREG_SET_ORDER)){
			$charset  = strtolower($matches[0][1]);
			$encoding = strtolower($matches[0][2]);
			$text     = $matches[0][3];
			if(empty($text)) return $out;
			switch ($encoding)
			{
				case 'b':
					$text = base64_decode($text);
					break;
				
				case 'q':
					$text = str_replace('_', ' ', $text);
					$text = ereg_replace("=\r", "\r", $text);
					$text = quoted_printable_decode($text);
					break;
				default:
					$text = str_replace('_', ' ', $text);
					$text = ereg_replace("=\r", "\r", $text);
					$text = quoted_printable_decode($text);
					
			}
			if($charset!=''){
				if($charset!=strtolower($des_charset)){
					//$out= iconv($charset, $des_charset."//IGNORE",$text);
					$out= mb_convert_encoding($text, $des_charset ,$charset);
				}else
					$out=$text;
					
			}
		}elseif(strrchr($input,'?')=='?='){
			$input=substr($input,0,strrpos($input,'?'));
			$input = str_replace('_', ' ', $input);
			$input = ereg_replace("=\r", "\r", $input);
			$input   = quoted_printable_decode($input);
			$encode = mb_detect_encoding($input,array('ASCII','GB2312','GBK','ISO-8859-1','UTF-8'));
			$encodeArr=array('ASCII','GB2312','GBK','ISO-8859-1');
			$out=$input;
			if(in_array($encode,$encodeArr))
			$out    =  mb_convert_encoding($out, $des_charset,$encode);
		}else{
			$out=$input;
		}
		 return $out;		
	}	
    /**
     * Mark a message for deletion from current mailbox
     *
     * @param string $msgCount
     */
    public function mailDelete($msgCount) {
        imap_delete($this->_connect,$msgCount);
    }
    
    /**
     * get attach of the message
     *
     * @param string $msgCount
     * @param string $path
     * @return array
     */
    public function getAttach($msgCount,$path) {
        $struckture = imap_fetchstructure($this->_connect,$msgCount);
        $attach = array();
        if($struckture->parts) {
            foreach($struckture->parts as $key => $value) {
                $encoding=$struckture->parts[$key]->encoding;
                if(!(strtolower($struckture->parts[$key]->subtype)=='alternative')) {
                    $name=$this->decode_str($struckture->parts[$key]->parameters[1]->value);
                    $message = imap_fetchbody($this->_connect,$msgCount,$key+1);
                    if ($encoding == 0) {
                        $message = imap_8bit($message);    
                    } else if ($encoding == 1){
                        $message = imap_8bit ($message);
                    } else if ($encoding == 2) {
                        $message = imap_binary ($message);
                    } else if ($encoding == 3) {
                        $message = imap_base64 ($message);
                    } else if ($encoding == 4) {
                        $message = quoted_printable_decode($message);
                    }
                    $this->downAttach($path,$name,$message);;
                    $attach[] = $name;
					}
            }
        }
        return $attach;
    }
    
    /**
     * download the attach of the mail to localhost
     *
     * @param string $filePath
     * @param string $message
     * @param string $name
     */
    public function downAttach($filePath,$name,$message) {
		if(empty($name))
		return false;
		@mkdir($filePath);
        if(is_dir($filePath)) {
            $fileOpen = fopen($filePath.$name,"w");
        } else {
            mkdir($filePath);
        }
        fwrite($fileOpen,$message);
        fclose($fileOpen);
    }
    
    /**
     * click the attach link to download the attach
     *
     * @param string $id
     */
    public function getAttachData($id,$filePath,$fileName) {
        $nameArr = explode('.',$fileName);
        $length = count($nameArr);
        $contentType = $this->_contentType[$nameArr[$length-1]];
        if(!$contentType) {
            $contentType = $this->_contentType['*'];
        }
          $filePath = chop($filePath);
         if($filePath != ''){
            if(substr($filePath,strlen($filePath)-1,strlen($filePath)) != '/') {
                $filePath .= '/';
            }
               $filePath .= $fileName;
        } else {
            $filePath = $fileName;
          }
           //print_r($filePath);exit;
           //print_r(str_replace('\\', '/', dirname(__FILE__)).'/attachpath/新建文本文档.txt');exit;
          if(!file_exists($fileName)){
            echo 'the file is not exsit';
            return false;
          }
        $fileSize = filesize($filePath);
          header("Content-type: ".$contentType);
          header("Accept-Range : byte ");
          header("Accept-Length: $fileSize");
          header("Content-Disposition: attachment; filename=".$fileName);
          $fileOpen= fopen($filePath,"r");
          $bufferSize = 1024;
          $curPos = 0;
          while(!feof($fileOpen)&&$fileSize-$curPos>$bufferSize) {
                $buffer = fread($fileOpen,$bufferSize);
                echo $buffer;
            $curPos += $bufferSize;
        }
          $buffer = fread($fileOpen,$fileSize-$curPos);
         echo $buffer;
          fclose($fileOpen);
          return true;
    }
    
    /**
     * get the body of the message
     *
     * @param string $msgCount
     * @return string
     */
    public function getBody($msgCount) {
        $body = $this->getPart($msgCount, "TEXT/HTML");
        if ($body == '') {
            $body = $this->getPart($msgCount, "TEXT/PLAIN");
        }
        if ($body == '') {
            return '';
        }
        return $body;
    }
    
    /**
     * Read the structure of a particular message and fetch a particular
     * section of the body of the message
     *
     * @param string $msgCount
     * @param string $mimeType
     * @param object $structure
     * @param string $partNumber
     * @return string|bool
     */
    private function getPart($msgCount, $mimeType, $structure = false, $partNumber = false) {
        if(!$structure) {
            $structure = imap_fetchstructure($this->_connect, $msgCount);
        }
        if($structure) {
            if($mimeType == $this->getMimeType($structure)) {
                if(!$partNumber) {
                    $partNumber = "1";
                }
                $fromEncoding = $structure->parameters[0]->value;
                $text = imap_fetchbody($this->_connect, $msgCount, $partNumber);
                if($structure->encoding == 3) {
                    $text =  imap_base64($text);
                } else if($structure->encoding == 4) {
                    $text =  imap_qprint($text);
                }
                $text = mb_convert_encoding($text,'utf-8',$fromEncoding);
                return $text;
            }
            if($structure->type == 1) {
                while(list($index, $subStructure) = each($structure->parts)) {
                    if($partNumber) {
                        $prefix = $partNumber . '.';
                    }
                    $data = $this->getPart($msgCount, $mimeType, $subStructure, $prefix . ($index + 1));
                    if($data){
                        return $data;
                    }
                }
            }
        }
        return false;
    }
    
    /**
     * get the subtype and type of the message structure
     *
     * @param object $structure
     */
    private function getMimeType($structure) {
        $mimeType = array("TEXT", "MULTIPART", "MESSAGE", "APPLICATION", "AUDIO", "IMAGE", "VIDEO", "OTHER");
        if($structure->subtype) {
            return $mimeType[(int) $structure->type] . '/' . $structure->subtype;
        }
        return "TEXT/PLAIN";
    }
    
    /**
     * put the message from unread to read
     *
     * @param string $msgCount
     * @return bool
     */
    public function mailRead($msgCount) {
        $status = imap_setflag_full($this->_connect, $msgCount , "\\Seen");
        return $status;
    }
    
    /**
     * Close an IMAP stream
     */
    public    function closeMail() {
        imap_close($this->_connect,CL_EXPUNGE);
    }
    
}