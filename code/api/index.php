<?php

require ('common.inc.php');

try {

    //跨域请求会发送Options请求，阻止继续执行，防止空数据提交
    if ($_SERVER['REQUEST_METHOD'] == "OPTIONS") {
        exit;
    }

    $app = new App();

    $app->run ();

} catch (Exception $e) {
    log_error ($e->getMessage ());
    echo $e->getMessage ();
}

