<?php

header("Content-Type: text/plain");

echo get_value_test();

function get_value_test(){
    global $_GET;

    $value = isset($_GET['test']) ? $_GET['test'] : 'error';
    $value = empty($value) ? 'error' : $value;

    return $value . 'hoge';
}
