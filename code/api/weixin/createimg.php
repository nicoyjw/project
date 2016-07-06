<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/3/23
 * Time: 16:03
 */

require_once('recode.php');

$randStr = str_shuffle('abcdefghijklmnopqrstuvwxyz1234567890');
$rand = substr($randStr,0,8).rand(1000,9999);

$codeObj = new recode($rand.'.png');


$img = $codeObj->code('http://www.93myb.com/api/tx/weixin/a/oauth.php?state='.$rand);

echo $rand;