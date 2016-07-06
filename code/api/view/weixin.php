<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2016/4/5
 * Time: 11:15
 */

session_start();
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Request-With');
header('Access-Control-Allow-Credentials: true');

if( empty($_COOKIE['PHPSESSID']) ){
    setCookie('PHPSESSID', session_id(), time() + 3600, '/');
    echo true;
}