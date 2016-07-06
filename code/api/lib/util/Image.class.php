<?php
// +--------------------------------------------------------------+
// | 这个文件是 EPR 项目的一部分                                   |
// +--------------------------------------------------------------+
// | Copyright (c) 2012 - 2015  
// |                                                              |
// | 要查看完整的版权信息和许可信息，请查看源代码中附带的 COPYRIGHT 文件  |
// +--------------------------------------------------------------+


/**
 * Image 图片处理类
 *
 * @copyright Copyright (c) 2010 - 2015
 * @package Util
 * @version v0.1
 */

/**
 * Image 图片处理类
 * @package Util
 */
class Image
{

    /**
     * @var string $fileName 文件名
     * @access private
     */
    private $fileName = '';

    /**
     * @var gd resource $imageResource 原图像
     * @access private
     */
    private $imageResource = NULL;

    /**
     * @var int $imageWidth 原图像宽
     * @access private
     */
    private $imageWidth = NULL;

    /**
     * @var int $imageHeight 原图像高
     * @access private
     */
    private $imageHeight = NULL;

    /**
     * @var int $imageType 原图像类型
     * @access private
     */
    private $imageType = NULL;

    /**
     * @var int $newResource 新图像
     * @access private
     */
    private $newResource = NULL;

    /**
     * @var int $newResType 新图像类型
     * @access private
     */
    private $newResType = NULL;

    /**
     * 构造函数
     * @param string $fileName 文件名
     */
    public function __construct($fileName = NULL)
    {
        $this->fileName = $fileName;
        if ($this->fileName) {
            $this->getSrcImageInfo();
        }
    }

    /**
     * 取源图像信息
     * @access private
     * @return void
     */
    private function getSrcImageInfo()
    {
        $info = $this->getImageInfo();
        $this->imageWidth = $info[0];
        $this->imageHeight = $info[1];
        $this->imageType = $info[2];
    }

    /**
     * 取图像信息
     * @param string $fileName 文件名
     * @access private
     * @return array
     */
    private function getImageInfo($fileName = NULL)
    {
        if ($fileName == NULL) {
            $fileName = $this->fileName;
        }
        $info = getimagesize($fileName);
        return $info;
    }

    /**
     * 创建源图像GD 资源
     * @access private
     * @return void
     */
    private function createSrcImage()
    {
        $this->imageResource = $this->createImageFromFile();
    }

    /**
     * 跟据文件创建图像GD 资源
     * @param string $fileName 文件名
     * @return gd resource
     */
    public function createImageFromFile($fileName = NULL)
    {
        if (!$fileName) {
            $fileName = $this->fileName;
            $imgType = $this->imageType;
        }
        if (!is_readable($fileName) || !file_exists($fileName)) {
            throw new Exception('Unable to open file "' . $fileName . '"');
        }

        if (!$imgType) {
            $imageInfo = $this->getImageInfo($fileName);
            $imgType = $imageInfo[2];
        }

        switch ($imgType) {
            case IMAGETYPE_GIF:
                $tempResource = imagecreatefromgif($fileName);
                break;
            case IMAGETYPE_JPEG:
                $tempResource = imagecreatefromjpeg($fileName);
                break;
            case IMAGETYPE_PNG:
                $tempResource = imagecreatefrompng($fileName);
                break;
            case IMAGETYPE_WBMP:
                $tempResource = imagecreatefromwbmp($fileName);
                break;
            case IMAGETYPE_XBM:
                $tempResource = imagecreatefromxbm($fileName);
                break;
            default:
                throw new Exception('错误的图片格式，或图片有问题！');
        }
        return $tempResource;
    }

    /**
     * 改变图像大小
     * @param int $width 宽
     * @param int $height 高
     * @param string $flag 按什么方式改变 0=长宽转换成参数指定的 1=按比例缩放，长宽约束在参数指定内，2=以宽为约束缩放，3=以高为约束缩放,4按比例缩小后截取长宽部份
     * @return string
     */
    public function resizeImage($width, $height, $flag = 1)
    {
        $widthRatio = $width / $this->imageWidth;
        $heightRatio = $height / $this->imageHeight;
        switch ($flag) {
            case 1:
                if ($this->imageHeight < $height && $this->imageWidth < $width) {
                    $endWidth = $this->imageWidth;
                    $endHeight = $this->imageHeight;
                    //return;
                } elseif (($this->imageHeight * $widthRatio) > $height) {
                    $endWidth = ceil($this->imageWidth * $heightRatio);
                    $endHeight = $height;
                } else {
                    $endWidth = $width;
                    $endHeight = ceil($this->imageHeight * $widthRatio);
                }
                break;
            case 2:
                $endWidth = $width;
                $endHeight = ceil($this->imageHeight * $widthRatio);
                break;
            case 3:
                $endWidth = ceil($this->imageWidth * $heightRatio);
                $endHeight = $height;
                break;
            case 4:
                $endWidth2 = $width;
                $endHeight2 = $height;
                if ($this->imageHeight < $height && $this->imageWidth < $width) {
                    $endWidth = $this->imageWidth;
                    $endHeight = $this->imageHeight;
                    //return;
                } elseif (($this->imageHeight * $widthRatio) < $height) {
                    $endWidth = ceil($this->imageWidth * $heightRatio);
                    $endHeight = $height;
                } else {
                    $endWidth = $width;
                    $endHeight = ceil($this->imageHeight * $widthRatio);
                }
                break;
            default:
                $endWidth = $width;
                $endHeight = $height;
                break;
        }
        if ($this->imageResource == NULL) {
            $this->createSrcImage();
        }
        if ($flag == 4) {
            $this->newResource = imagecreatetruecolor($endWidth2, $endHeight2);
        } else {
            $this->newResource = imagecreatetruecolor($endWidth, $endHeight);
        }
        $this->newResType = $this->imageType;
        imagecopyresampled($this->newResource, $this->imageResource, 0, 0, 0, 0, $endWidth, $endHeight, $this->imageWidth, $this->imageHeight);

    }

    /**
     * 给图像加水印
     * @param string $waterContent 水印内容可以是图像文件名，也可以是文字
     * @param int $pos 位置0-9可以是数组
     * @param int $textFont 字体大字，当水印内容是文字时有效
     * @param string $textColor 文字颜色，当水印内容是文字时有效
     * @return string
     */
    public function waterMark($waterContent, $pos = 0, $textFont = 5, $textColor = "#ffffff")
    {
        $isWaterImage = file_exists($waterContent);
        if ($isWaterImage) {
            $waterImgRes = $this->createImageFromFile($waterContent);
            $waterImgInfo = $this->getImageInfo($waterContent);
            $waterWidth = $waterImgInfo[0];
            $waterHeight = $waterImgInfo[1];
        } else {
            $waterText = $waterContent;
            //$temp = @imagettfbbox(ceil($textFont*2.5),0,"./cour.ttf",$waterContent);
            if ($temp) {
                $waterWidth = $temp[2] - $temp[6];
                $waterHeight = $temp[3] - $temp[7];
            } else {
                $waterWidth = 100;
                $waterHeight = 12;
            }
        }
        if ($this->imageResource == NULL) {
            $this->createSrcImage();
        }
        switch ($pos) {
            case 0://随机
                $posX = rand(0, ($this->imageWidth - $waterWidth));
                $posY = rand(0, ($this->imageHeight - $waterHeight));
                break;
            case 1://1为顶端居左
                $posX = 0;
                $posY = 0;
                break;
            case 2://2为顶端居中
                $posX = ($this->imageWidth - $waterWidth) / 2;
                $posY = 0;
                break;
            case 3://3为顶端居右
                $posX = $this->imageWidth - $waterWidth;
                $posY = 0;
                break;
            case 4://4为中部居左
                $posX = 0;
                $posY = ($this->imageHeight - $waterHeight) / 2;
                break;
            case 5://5为中部居中
                $posX = ($this->imageWidth - $waterWidth) / 2;
                $posY = ($this->imageHeight - $waterHeight) / 2;
                break;
            case 6://6为中部居右
                $posX = $this->imageWidth - $waterWidth;
                $posY = ($this->imageHeight - $waterHeight) / 2;
                break;
            case 7://7为底端居左
                $posX = 0;
                $posY = $this->imageHeight - $waterHeight;
                break;
            case 8://8为底端居中
                $posX = ($this->imageWidth - $waterWidth) / 2;
                $posY = $this->imageHeight - $waterHeight;
                break;
            case 9://9为底端居右
                $posX = $this->imageWidth - $waterWidth - 20;
                $posY = $this->imageHeight - $waterHeight - 10;
                break;
            default://随机
                $posX = rand(0, ($this->imageWidth - $waterWidth));
                $posY = rand(0, ($this->imageHeight - $waterHeight));
                break;
        }
        imagealphablending($this->imageResource, true);
        if ($isWaterImage) {
            imagecopy($this->imageResource, $waterImgRes, $posX, $posY, 0, 0, $waterWidth, $waterHeight);
        } else {
            $R = hexdec(substr($textColor, 1, 2));
            $G = hexdec(substr($textColor, 3, 2));
            $B = hexdec(substr($textColor, 5));

            $textColor = imagecolorallocate($this->imageResource, $R, $G, $B);
            imagestring($this->imageResource, $textFont, $posX, $posY, $waterText, $textColor);
        }
        $this->newResource = $this->imageResource;
        $this->newResType = $this->imageType;
    }

    /**
     * 生成验证码图片
     * @param int $width 宽
     * @param string $height 高
     * @param int $length 长度
     * @param int $validType 0=数字,1=字母,2=数字加字母
     * @param string $textColor 文字颜色
     * @param string $backgroundColor 背景颜色
     * @return void
     */
    public function imageValidate($width, $height, $length = 4, $validType = 1, $textColor = '#000000', $backgroundColor = '#ffffff')
    {
        if ($validType == 1) {
            $validString = 'abcdefghjkmnopqrstuvwxyzABCDEFGHJKMNOPQRSTUVWXYZ';
            $validLength = 52;
        } elseif ($validType == 2) {
            $validString = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
            $validLength = 62;
        } else {
            $validString = '0123456789';
            $validLength = 10;
        }

        srand((int)time());
        $valid = '';
        for ($i = 0; $i < $length; $i++) {
            $valid .= $validString{rand(0, $validLength - 1)};
        }
        $this->newResource = imagecreate($width, $height);
        $bgR = hexdec(substr($backgroundColor, 1, 2));
        $bgG = hexdec(substr($backgroundColor, 3, 2));
        $bgB = hexdec(substr($backgroundColor, 5, 2));
        $backgroundColor = imagecolorallocate($this->newResource, $bgR, $bgG, $bgB);
        $tR = hexdec(substr($textColor, 1, 2));
        $tG = hexdec(substr($textColor, 3, 2));
        $tB = hexdec(substr($textColor, 5, 2));
        $textColor = imagecolorallocate($this->newResource, $tR, $tG, $tB);
        for ($i = 0; $i < strlen($valid); $i++) {
            imagestring($this->newResource, 5, $i * $width / $length + 3, 2, $valid[$i], $textColor);
        }
        $this->newResType = IMAGETYPE_JPEG;
        return $valid;

    }

    function _c128Encode($barnumber, $useKeys)
    {
        $encTable = array("11011001100", "11001101100", "11001100110", "10010011000", "10010001100", "10001001100", "10011001000", "10011000100", "10001100100", "11001001000", "11001000100", "11000100100", "10110011100", "10011011100", "10011001110", "10111001100", "10011101100", "10011100110", "11001110010", "11001011100", "11001001110", "11011100100", "11001110100", "11101101110", "11101001100", "11100101100", "11100100110", "11101100100", "11100110100", "11100110010", "11011011000", "11011000110", "11000110110", "10100011000", "10001011000", "10001000110", "10110001000", "10001101000", "10001100010", "11010001000", "11000101000", "11000100010", "10110111000", "10110001110", "10001101110", "10111011000", "10111000110", "10001110110", "11101110110", "11010001110", "11000101110", "11011101000", "11011100010", "11011101110", "11101011000", "11101000110", "11100010110", "11101101000", "11101100010", "11100011010", "11101111010", "11001000010", "11110001010", "10100110000", "10100001100", "10010110000", "10010000110", "10000101100", "10000100110", "10110010000", "10110000100", "10011010000", "10011000010", "10000110100", "10000110010", "11000010010", "11001010000", "11110111010", "11000010100", "10001111010", "10100111100", "10010111100", "10010011110", "10111100100", "10011110100", "10011110010", "11110100100", "11110010100", "11110010010", "11011011110", "11011110110", "11110110110", "10101111000", "10100011110", "10001011110", "10111101000", "10111100010", "11110101000", "11110100010", "10111011110", "10111101110", "11101011110", "11110101110", "11010000100", "11010010000", "11010011100", "11000111010");

        $start = array("A" => "11010000100", "B" => "11010010000", "C" => "11010011100");
        $stop = "11000111010";

        $sum = 0;
        $mfcStr = "";
        if ($useKeys == 'C') {
            for ($i = 0; $i < strlen($barnumber); $i += 2) {
                $val = substr($barnumber, $i, 2);
                if (is_int($val))
                    $sum += ($i + 1) * (int)($val);
                elseif ($barnumber == chr(129))
                    $sum += ($i + 1) * 100;
                elseif ($barnumber == chr(130))
                    $sum += ($i + 1) * 101;
                $mfcStr .= $encTable[$val];
            }
        } else {
            for ($i = 0; $i < strlen($barnumber); $i++) {
                $num = ord($barnumber[$i]);
                if ($num >= 32 && $num <= 126)
                    $num = ord($barnumber[$i]) - 32;
                elseif ($num == 128)
                    $num = 99;
                elseif ($num == 129)
                    $num = 100;
                elseif ($num == 130)
                    $num = 101;
                elseif ($num < 32 && $useKeys == 'A')
                    $num = $num + 64;
                $sum += ($i + 1) * $num;
                $mfcStr .= $encTable[$num];
            }
        }

        if ($useKeys == 'A')
            $check = ($sum + 103) % 103;
        if ($useKeys == 'B')
            $check = ($sum + 104) % 103;
        if ($useKeys == 'C')
            $check = ($sum + 105) % 103;

        return $start[$useKeys] . $mfcStr . $encTable[$check] . $stop . "11";
    }

    /**
     * 生成条形码图片
     * @param int $width 宽
     * @param string $height 高
     * @param int $length 长度
     * @param int $validType 0=数字,1=字母,2=数字加字母
     * @param string $textColor 文字颜色
     * @param string $backgroundColor 背景颜色
     * @return void
     */
    public function imageBarcode($barnumber, $height, $hasno = 0, $scale = 2, $textColor = '#000000', $backgroundColor = '#ffffff')
    {
        $barnumber = html_entity_decode($barnumber);
        $useKeys = "B";
        if (preg_match("/^[0-9" . chr(128) . chr(129) . chr(130) . "]+$/", $barnumber)) {
            $useKeys = 'C';
            if (strlen($barnumber) % 2 != 0)
                $barnumber = '0' . $barnumber;
        }
        for ($i = 0; $i < 32; $i++)
            $chr = chr($i);
        if (preg_match("/[" . $chr . "]+/", $barnumber))
            $useKeys = 'A';
        $bars = $this->_c128Encode($barnumber, $useKeys);
        if ($scale < 1) $scale = 2;
        $total_y = (double)$scale * $height + 12 * $scale;
        if (!$space)
            $space = array('top' => 2 * $scale, 'bottom' => 2 * $scale, 'left' => 2 * $scale, 'right' => 2 * $scale);
        $xpos = 0;

        $xpos = $scale * strlen($bars) + 2 * $scale * 10;

        /* allocate the image */
        $total_x = $xpos + $space['left'] + $space['right'];
        $xpos = $space['left'] + $scale * 10;

        $height = floor($total_y - ($scale * 20));
        $height2 = floor($total_y - $space['bottom'] - $scale * 8);
        $this->newResource = @imagecreatetruecolor($total_x, $total_y);
        $bgcolor = array(hexdec(substr($backgroundColor, 1, 2)), hexdec(substr($backgroundColor, 3, 2)), hexdec(substr($backgroundColor, 5, 2)));
        $color = array(hexdec(substr($textColor, 1, 2)), hexdec(substr($textColor, 3, 2)), hexdec(substr($textColor, 5, 2)));
        $bg_color = @imagecolorallocate($this->newResource, $bgcolor[0], $bgcolor[1], $bgcolor[2]);
        @imagefilledrectangle($this->newResource, 0, 0, $total_x, $total_y, $bg_color);
        $bar_color = @imagecolorallocate($this->newResource, $color[0], $color[1], $color[2]);
        for ($i = 0; $i < strlen($bars); $i++) {
            $h = $height;
            $val = strtoupper($bars[$i]);

            if ($val == 1)
                @imagefilledrectangle($this->newResource, $xpos, $space['top'], $xpos + $scale - 1, $h, $bar_color);
            $xpos += $scale;
        }
        $font = "/var/www/html/erp/common/lib/arial.ttf";
        //if (isset($_SERVER['WINDIR']) && file_exists($_SERVER['WINDIR']))
        //$font=$_SERVER['WINDIR']."\Fonts\arial.ttf";
        $font_arr = @imagettfbbox($scale * 10, 0, $font, $barnumber);
        $x = floor($total_x - (int)$font_arr[0] - (int)$font_arr[2] + $scale * 10) / 2;
        if ($hasno) @imagettftext($this->newResource, $scale * 8, 0, $x, $height2, $bar_color, $font, $barnumber);
        $this->newResType = IMAGETYPE_JPEG;
    }

    public function imageEUB($str)
    {
        $this->newResource = @imagecreate(350, 50);
        $this->newResType = IMAGETYPE_JPEG;
        $bg_color = imagecolorallocate($this->newResource, 255, 255, 255);
        imagefilledrectangle($this->newResource, 0, 0, 350, 50, $bg_color);
        $black = imagecolorallocate($this->newResource, 0, 0, 0);
        $font = "/var/www/html/erp/common/lib/IDAutomationC128S.ttf";
        //if (isset($_SERVER['WINDIR']) && file_exists($_SERVER['WINDIR']))
        //$font=$_SERVER['WINDIR']."\Fonts\IDAutomationC128S.ttf";
        imagettftext($this->newResource, 40, 0, 0, 50, $black, $font, $str);
    }

    /**
     * 显示输出图像
     * @param string $fileName 文件名
     * @param int $quality 图片质量(100最好)
     * @return void
     */
    public function display($fileName = '', $quality = 60)
    {

        $imgType = $this->newResType;
        $imageSrc = $this->newResource;
        switch ($imgType) {
            case IMAGETYPE_GIF:
                if ($fileName == '') {
                    header('Content-type: image/gif');
                }
                imagegif($imageSrc, $fileName, $quality);
                break;
            case IMAGETYPE_JPEG:
                if ($fileName == '') {
                    header('Content-type: image/jpeg');
                }
                imagejpeg($imageSrc, $fileName, $quality);
                break;
            case IMAGETYPE_PNG:
                if ($fileName == '') {
                    header('Content-type: image/png');
                    imagepng($imageSrc);
                } else {
                    imagepng($imageSrc, $fileName);
                }
                break;
            case IMAGETYPE_WBMP:
                if ($fileName == '') {
                    header('Content-type: image/wbmp');
                }
                imagewbmp($imageSrc, $fileName, $quality);
                break;
            case IMAGETYPE_XBM:
                if ($fileName == '') {
                    header('Content-type: image/xbm');
                }
                imagexbm($imageSrc, $fileName, $quality);
                break;
            default:
                throw new Exception('Unsupport image type');
        }
        imagedestroy($imageSrc);
    }

    /**
     * 保存图像
     * @param int $fileNameType 文件名类型 0使用原文件名，1使用指定的文件名，2在原文件名加上后缀，3产生随机文件名
     * @param string $folder 文件夹路径 为空为与原文件相同
     * @param string $param 参数$fileNameType为1时为文件名2时为后缀
     * @return void
     */
    public function save($fileNameType = 0, $folder = NULL, $param = '_miniature')
    {
        if ($folder == NULL) {
            $folder = dirname($this->fileName) . DIRECTORY_SEPARATOR;

        }
        $fileExtName = FileSystem::fileExt($this->fileName, true);
        $fileBesicName = FileSystem::getBasicName($this->fileName, false);
        switch ($fileNameType) {
            case 1:
                $newFileName = $folder . $param;
                var_dump($newFileName);
                break;
            case 2:
                $newFileName = $folder . $fileBesicName . $param . $fileExtName;
                break;
            case 3:
                $tmp = date('YmdHis');
                $fileBesicName = $tmp;
                $i = 0;
                while (file_exists($folder . $fileBesicName . $fileExtName)) {
                    $fileBesicName = $tmp . $i;
                    $i++;
                }
                $newFileName = $folder . $fileBesicName . $fileExtName;
                break;
            default:
                $newFileName = $this->fileName;
                break;
        }
        $this->display($newFileName);
        return $newFileName;
    }

    //等比缩放图片 限制最大宽度和最大高度
    public function scale($source_path, $target_path, $max_px)
    {
        $source_info = getimagesize($source_path);
        $w = $source_info[0];//sourceWidth
        $h = $source_info[1];//sourceHeight

        $source_mime = $source_info['mime'];

        switch ($source_mime) {
            case 'image/gif':
                $source_image = imagecreatefromgif($source_path);
                break;

            case 'image/jpeg':
                $source_image = imagecreatefromjpeg($source_path);
                break;

            case 'image/png':
                $source_image = imagecreatefrompng($source_path);
                break;

            default:
                return false;
                break;
        }


        if (is_null($source_image)) {
            return false;
        }

        if ($w > $max_px) {
            $h = $h * ($max_px / $w);
            $w = $max_px;
        }

        if ($h > $max_px) {
            $w = $w * ($max_px / $h);
            $h = $max_px;
        }
        $w = (int)$w;
        $h = (int)$h;

        //声明一个$w宽，$h高的真彩图片资源
        $image = imagecreatetruecolor($w, $h);

        //关键函数，参数（目标资源，源，目标资源的开始坐标x,y, 源资源的开始坐标x,y,目标资源的宽高w,h,源资源的宽高w,h）
        imagecopyresampled($image, $source_image, 0, 0, 0, 0, $w, $h, $source_info[0], $source_info[1]);

        $dirs = dirname($target_path);
        if (!is_dir($dirs) && $dirs != './' && $dirs != '../') {
            mkdir($dirs, 0777);
        }

        $flag = false;
        switch ($source_mime) {
            case 'image/gif':
                $flag = imagegif($image, $target_path, 100);
                break;

            case 'image/jpeg':
                $flag = imagejpeg($image, $target_path, 100);
                break;

            case 'image/png':
                $flag = imagepng($image, $target_path, 100);
                break;

            default:
                $flag = false;
                break;
        }

        //销毁资源
        imagedestroy($source_image);
        imagedestroy($image);

        return $flag;
    }
}

?>