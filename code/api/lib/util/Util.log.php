<?php

/**
 * User: fengxiaofei
 * Date: 2016/3/25
 * Time: 10:35
 */

function log_trace($content)
{
    set_log (6 , $content);
}

function log_log($content)
{
    set_log (5 , $content);
}

function log_debug($content)
{
    set_log (4 , $content);
}

function log_warn($content)
{
    set_log (3 , $content);
}

function log_error($content)
{
    set_log (2 , $content);
}


function log_fatal($content)
{
    set_log (1 , $content);
}

function set_log($level , $content)
{
    if (CFG_LOG_LEVEL < $level) {
        return false;
    }
    $levelStr = "";
    switch ($level) {
        case 1:
            $levelStr = "fatal";
            break;
        case 2:
            $levelStr = "error";
            break;
        case 3:
            $levelStr = "warn";
            break;
        case 4:
            $levelStr = "debug";
            break;
        case 5:
            $levelStr = "log";
            break;
        case 6:
            $levelStr = "trace";
            break;
    }
    $file = CFG_PATH_ROOT . 'log/' . date ('ymd' , time ()) . "/$levelStr.txt";
    log_getPath ($file);


    list($tmp1 , $tmp2) = explode (' ' , microtime ());
    $date = date ("Y-m-d H:i:s ms") . (float)sprintf ('%.0f' , (floatval ($tmp1) * 1000));

    if (!is_string ($content)) {
        $content = var_export ($content , TRUE);
    }

    $content = $date . "\r\n" . log_get_stack_trace () . $content . "\r\n\r\n";
    file_put_contents ($file , $content , FILE_APPEND);
}

function log_get_stack_trace()
{
    $array = debug_backtrace ();
    $trace = "";
    for ($i = count ($array) - 1; $i >= 0; $i--) {
        $row = $array[$i];
        $fileName = substr ($row['file'] , strpos ($row['file'] , 'api') + 4);
        if (strpos ($fileName , 'Util.log')) break;

        $trace .= $fileName . '->line:' . $row['line'] . '->call :' . $row['function'] . "\r\n";
    }
    return $trace;
}

function log_getPath($path)
{
    if (!is_dir ($path) && $path != './' && $path != '../') {
        $dirname = '';
        $folders = explode ('/' , $path);
        foreach ($folders as $folder) {
            $dirname .= $folder . '/';
            if ($folder != '' && $folder != '.' && $folder != '..' && !strpos ($folder , ".txt") && !is_dir ($dirname)) {
                mkdir ($dirname);
            }
        }
        chmod ($path , 0777);
    }
}
