<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/4/19
 * Time: 20:58
 */

$file = $_FILES['upload'];//得到传输的数据
//得到文件名称
$name = $file['name'];

$type = strtolower(substr($name,strrpos($name,'.')+1)); //得到文件类型，并且都转化成小写
$allow_type = array('jpg','jpeg','gif','png'); //定义允许上传的类型
//判断文件类型是否被允许上传

if(!in_array($type, $allow_type)){
    //如果不被允许，则直接停止程序运行
    return ;
}
if($file["size"] > 2000000){
    return ;
}

//判断是否是通过HTTP POST上传的
if(!is_uploaded_file($file['tmp_name'])){
    //如果不是通过HTTP POST上传的
    return ;
}
$upload_path = "./img/".date ('ymd' , time ()) .mt_rand(1000,9999).".jpg"; //上传文件的存放路径
$whole_path = str_replace("./img","/api/upload_img/img",$upload_path);
//开始移动文件到相应的文件夹
if(move_uploaded_file($file['tmp_name'],$upload_path)){
    echo $whole_path;
}else{
    echo "上传失败!";
}


