<?
if ($_POST) {
    //$logFile = "/Users/mcstafford/_CURRENT_WORK/ERI/www/cognitopia.com/public_html/HealthCheckerDev/log/log.txt";
    $logFile = dirname($_SERVER['SCRIPT_FILENAME']) . "/goalsave.txt";
    if (!file_exists($logFile)) {
        touch($logFile);
        chmod($logFile, 0777);
    }
    $toPost = date('m/d/Y h:i:s a') . '->' . serialize($_POST) . "\n";
    file_put_contents($logFile, $toPost, FILE_APPEND);
    echo "OK";
    return;
}
