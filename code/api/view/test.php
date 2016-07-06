<?php

var_dump($_FILES);
exit();
if (empty($path)) return false;
$inputname = $_POST["inputname"];

//获取文件对象
$files = $_FILES[$inputname];

//判断是否存在文件
if (empty($files)) {
    return false;
}

//获取文件名
$filenames = $files['name'];

$ext = explode('.', basename($filenames));
$newName = md5(uniqid()) . "." . array_pop($ext);
$target = $_SERVER['DOCUMENT_ROOT'] . $path . "/" . $newName;

if (move_uploaded_file($files['tmp_name'], $target)) {
    return $newName;
} else {
    return false;
}


