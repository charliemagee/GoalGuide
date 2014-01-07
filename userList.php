<?
if ($_POST) {
    $logFile = dirname($_SERVER['SCRIPT_FILENAME']) . "/userlist.json";
    if (!file_exists($logFile)) {
        touch($logFile);
        chmod($logFile, 0777);
    }
    $newStr = ($_POST);
    $toPost = str_replace('\\', '', $newStr);
    file_put_contents($logFile, $toPost);
    echo "OK";
    return;
}
