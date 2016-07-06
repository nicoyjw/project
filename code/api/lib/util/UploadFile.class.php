<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * UploadFile 上传类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Util
 * @version v0.1
 */

require_once('FileSystem.class.php');

/**
 * UploadFile 上传类
 * @package Util
 */
class UploadFile
{

    /**
     * 允许的上传文件类型
     * @var array $allowFileTypes
     * @access private
     */
    private $allowFileTypes = array('html', 'htm', 'doc', 'docx', 'zip', 'rar', 'txt', 'jpg', 'gif', 'bmp', 'png', 'xls', 'csv');

    /**
     * 允许的上传文件大小，单位字节
     * @var int $maxFileSize
     * @access public
     */
    public $maxFileSize = 8388608;

    /**
     * 构造函数
     */
    public function __construct()
    {
        // nothing
    }

    /**
     * 设置允许的文件类型
     * @param mixed $fileTypes 文件类型列表可以是数组和字符串，用“,”号隔开
     * @return void
     * @access public
     */
    public function setAllowFileType($fileTypes)
    {
        if (!is_array($fileTypes)) {
            $this->allowFileTypes = explode(',', $fileTypes);
        } else {
            $this->allowFileTypes = $fileTypes;
        }
        return;
    }

    /**
     * 上传文件
     * @param string $fileField 要上传的文件如$_FILES['file']
     * @param string $destFolder 上传的目录，会自动建立
     * @param string $fileTypes 上传后文件命名方式0使用原文件名1使用当前时间戳作为文件名
     * @return int
     * @access public
     */
    public function upload($fileField, $destFolder = './', $fileNameType = 1)
    {

        switch ($fileField['error']) {
            case UPLOAD_ERR_OK : //其值为 0，没有错误发生，文件上传成功。
                $upload_succeed = true;
                break;
            case UPLOAD_ERR_INI_SIZE : //其值为 1，上传的文件超过了 php.ini 中 upload_max_filesize 选项限制的值。
            case UPLOAD_ERR_FORM_SIZE : //其值为 2，上传文件的大小超过了 HTML 表单中 MAX_FILE_SIZE 选项指定的值。
                $errorMsg = '文件上传失败！失败原因：文件大小超出限制！';
                $errorCode = -103;
                $upload_succeed = false;
                break;
            case UPLOAD_ERR_PARTIAL : //值：3; 文件只有部分被上传。
                $errorMsg = '文件上传失败！失败原因：文件只有部分被上传！';
                $errorCode = -101;
                $upload_succeed = false;
                break;
            case UPLOAD_ERR_NO_FILE : //值：4; 没有文件被上传。
                $errorMsg = '文件上传失败！失败原因：没有文件被上传！';
                $errorCode = -102;
                $upload_succeed = false;
                break;
            case UPLOAD_ERR_NO_TMP_DIR : //其值为 6，找不到临时文件夹。PHP 4.3.10 和 PHP 5.0.3 引进。
                $errorMsg = '文件上传失败！失败原因：找不到临时文件夹！';
                $errorCode = -102;
                $upload_succeed = false;
                break;
            case UPLOAD_ERR_CANT_WRITE : //其值为 7，文件写入失败。PHP 5.1.0 引进。
                $errorMsg = '文件上传失败！失败原因：文件写入失败！';
                $errorCode = -102;
                $upload_succeed = false;
                break;
            default : //其它错误
                $errorMsg = '文件上传失败！失败原因：其它！';
                $errorCode = -100;
                $upload_succeed = false;
                break;
        }
        if ($upload_succeed) {
            if ($fileField['size'] > $this->maxFileSize) {
                $errorMsg = '文件上传失败！失败原因：文件大小超出限制！';
                $errorCode = -103;
                $upload_succeed = false;
            }
            if ($upload_succeed) {
                $fileExt = FileSystem::fileExt($fileField['name']);
                if (!in_array(strtolower($fileExt), $this->allowFileTypes)) {
                    $errorMsg = '文件上传失败！失败原因：文件类型不被允许！' . $fileField['name'];
                    $errorCode = -104;
                    $upload_succeed = false;
                }
            }
        }
        if ($upload_succeed) {
            if (!is_dir($destFolder) && $destFolder != './' && $destFolder != '../') {
                $dirname = '';
                $folders = explode('/', $destFolder);
                foreach ($folders as $folder) {
                    $dirname .= $folder . '/';
                    if ($folder != '' && $folder != '.' && $folder != '..' && !is_dir($dirname)) {
                        mkdir($dirname);
                    }
                }
                chmod($destFolder, 0777);
            }
            switch ($fileNameType) {
                case 1:
                    $fileName = date('YmdHis');
                    $dot = '.';
                    $fileFullName = $fileName . $dot . $fileExt;
                    $i = 0;
                    //判断是否有重名文件
                    while (is_file($destFolder . $fileFullName)) {
                        $fileFullName = $fileName . $i++ . $dot . $fileExt;
                    }
                    break;
                case 2:
                    $fileFullName = date('YmdHis');
                    $i = 0;
                    //判断是否有重名文件
                    while (is_file($destFolder . $fileFullName)) {
                        $fileFullName = $fileFullName . $i++;
                    }
                    break;
                default:
                    $fileFullName = $fileField['name'];
                    break;
            }
            if (@move_uploaded_file($fileField['tmp_name'], $destFolder . $fileFullName)) {
                return $fileFullName;
            } else {
                $errorMsg = '文件上传失败！失败原因：本地文件系统读写权限出错！';
                $errorCode = -105;
                $upload_succeed = false;
            }
        }
        if (!$upload_succeed) {
            throw new Exception($errorMsg, $errorCode);
        }

    }
}

?>