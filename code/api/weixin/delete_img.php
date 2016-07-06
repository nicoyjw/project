<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/3/23
 * Time: 16:13
 */

$img = $_GET['img'];
$result = @unlink ($img);
if(result==false){
    echo true;
}else{
    echo false;
}