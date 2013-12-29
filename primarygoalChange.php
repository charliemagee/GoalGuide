<?
if ($_POST) {
    $user = $_POST['userid'];  // ADDED THIS LINE AND CHANGED NEXT TO GET STUFF INTO THE USERS OWN FILE
    $logFile = dirname($_SERVER['SCRIPT_FILENAME']) . "/" . $user . "primary.json";
    if (!file_exists($logFile)) {
        touch($logFile);
        chmod($logFile, 0777);
    }
    $newStr = ($_POST);
    $toPost = str_replace('\\', '', $newStr);
    $bunchgoals = array_pop($toPost);
    file_put_contents($logFile, $toPost);
    echo "OK";
    return;
}
