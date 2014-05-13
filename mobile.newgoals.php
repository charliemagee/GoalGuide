<!DOCTYPE html manifest="mobilenewgoals.appcache">
<!--[if IEMobile 7 ]>    <html class="no-js iem7"> <![endif]-->
<!--[if (gt IEMobile 7)|!(IEMobile)]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>Goal Guide</title>
    <meta name="description" content="">
    <meta http-equiv="cleartype" content="on">

    <meta name="apple-mobile-web-app-capable" content="yes" />

    <!-- Mobile viewport optimized: h5bp.com/viewport -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/touch/apple-touch-icon-144x144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/touch/apple-touch-icon-114x114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/touch/apple-touch-icon-72x72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/touch/apple-touch-icon-57x57-precomposed.png">
    <link rel="shortcut icon" href="images/touch/apple-touch-icon.png">

    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" type="text/css" href="css/fonts/fonts.css" />
    <link rel="stylesheet" type="text/css" href="css/fonts/icomoon.css" />
    <link rel="stylesheet" href="css/mobile.newmain.css">

</head>
<body>

<!--[if lt IE 7]>
<p class="chromeframe">You are using an outdated browser. <a href="http://browsehappy.com/">Upgrade your browser today</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to better experience this site.</p>
<![endif]-->

<!--[if lt IE 9]>
<script src="scripts/vendor/es5-shim.min.js"></script>
<script src="scripts/vendor/json3.min.js"></script>
<![endif]-->


<div id="nav">
    <div id="home"><h1 class="dropdown"><i class="fa-regular icon-star" ></i><br/>Add Goal</h1></div>
    <div id="school" data-category="school"><h1 class="dropdown"><i class="fa-regular icon-book" ></i><br/>School</h1></div>
    <div id="work" data-category="work"><h1 class="dropdown"><i class="fa-regular icon-boss" ></i><br/>Work</h1></div>
    <div id="personal" data-category="personal"><h1 class="dropdown"><i class="fa-regular icon-basketball" ></i><br/>Personal</h1></div>
</div>
<div id="content">

    <div id="logout">
        <button type="button" id="logoutbutton" class="btn btn-success btn-medium">Logout</button>
    </div>

    <div id="checkid">
        <h4 class="detailsLabel">Please Login</h4>
        <div id="errorlogin">Your username and password combination is incorrect. Please try again.</div>
        <form>
            <label for="theloginusername">Username:</label>
            <input type="text" id="theloginusername" class="input-small textempty" required><br>
            <label for="theloginpassword">Password:</label>
            <input type="password" id="theloginpassword" class="input-small textempty" required><br>
            <button type="button" id="loginbutton" class="btn btn-success btn-medium">Login</button>
        </form>
    </div> <!-- end checkid -->

    <div id="goalscontainer" class="move-inside">
        <ul class="goalsinprogress goalsection">

        </ul>
        <ul class="goalscompleted goalsection">

        </ul>

    </div>
    <div id="chartbox">
        <span class="goalremove closechart hidechart"><button type="button" class="btn btn-mini btn-danger" ><b>X</b> </button></span>
        <div id="thischart"></div>
    </div>
    <div class="chart-backdrop hidechart"></div>
    <div class="congratsmessageholder">
        <div class="congratsmessage"></div>
    </div>

    <div id="addgoalform">
    <h3 class="detailsLabel">Create A New Goal</h3>
<!--    <h3 class="detailsLabelupdate">Edit This Goal</h3>-->
    <form class="form-horizontal">
    <div class="control-group">
        <label class="control-label" for="thecategory">Category</label>
        <div class="controls">
            <select type="text" id="thecategory">
                <option>School</option>
                <option>Personal</option>
                <option>Work</option>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thegoal">Goal</label>
        <div class="controls">
            <input type="text" id="thegoal" class="input-small goalcomplete textempty" placeholder="What is the goal?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theicons">Icon</label>
        <div id="theicons" class="controls uncheckit">
            <ul class="icondropdown">
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="user"><i class="fa-medium icon icon-user" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="users"><i class="fa-medium icon icon-users" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="boss"><i class="fa-medium icon icon-boss" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="doctor"><i class="fa-medium icon icon-doctor" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="health"><i class="fa-medium icon icon-health" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="phone"><i class="fa-medium icon icon-phone" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="alarm"><i class="fa-medium icon icon-alarm" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="stopwatch"><i class="fa-medium icon icon-stopwatch" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bell"><i class="fa-medium icon icon-bell" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="book"><i class="fa-medium icon icon-book" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="openbook"><i class="fa-medium icon icon-openbook" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="clipboard"><i class="fa-medium icon icon-clipboard" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="suitcase"><i class="fa-medium icon icon-suitcase" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="dollar"><i class="fa-medium icon icon-dollar" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="cart"><i class="fa-medium icon icon-cart" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="coffee"><i class="fa-medium icon icon-coffee" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="silverware"><i class="fa-medium icon icon-silverware" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="car"><i class="fa-medium icon icon-car" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bus"><i class="fa-medium icon icon-bus" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bike"><i class="fa-medium icon icon-bike" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="basketball"><i class="fa-medium icon icon-basketball" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="headphones"><i class="fa-medium icon icon-headphones" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="t-shirt"><i class="fa-medium icon icon-t-shirt" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="pill"><i class="fa-medium icon icon-pill" ></i>
                    </label>
                </li>

            </ul>
        </div>
    </div>
    <div id="infotype" class="control-group uncheckit">
        <label class="control-label" for="theinfotype">Gather Data?</label>
        <div class="controls">
            <input type="checkbox" id="theinfotype" name="theinfotype" value="text"><span class="checkboxinfo">Quiz scores, body weight, etc.<br>It works with numbers only.</span>
        </div>
    </div>
    <input type="hidden" name="goalguid" value="">
    <div class="savinggoals push-right-savegoal">
        <button type="button" id="savegoal" class="btn btn-success btn-medium"><i class="fa-large icon-checkmark" ></i>&nbsp;&nbsp;Save Goal</a></button>
<!--        <button type="button" id="updategoal" data-dismiss="modal" class="btn btn-success btn-medium"><i class="fa-large icon-checkmark" ></i>&nbsp;&nbsp;Update Goal</a></button>-->
        <button type="button" id="savegoalcancel" class="btn btn-danger btn-medium"><i class="fa-large icon-remove" ></i>&nbsp;&nbsp;Cancel</a></button>
    </div>
    </form>

</div>     <!-- wrapper -->

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="js/offline.min.js"></script>
<script src="js/mobile.newmain.js"></script>

<script type="text/javascript">
    $(document).ready(function(){

        // need to run a check every 24 hours to update recurring goals; this triggers once every 30 minutes to cover the chance that they closed the browser window and reopened at a random time
        var interval = 0;
        interval = window.setTimeout(function () {
            interval = window.setInterval(function () {
                var now = (new Date()).getTime();
                var lastTime = 0;
                var lastTimeStr = localStorage['daycheck'];
                if (lastTimeStr) lastTime = parseInt(lastTimeStr, 10);
                if (now - lastTime > 24*60*60*1000) {
                    resetCompleted();
                    localStorage['daycheck'] = ""+now;
                }

            }, 60 * 60 * 1000);
        }, interval);


        $.getJSON("userlist.json", function(data) {
            return localStorage.setItem("users", JSON.stringify(data));
        });

        if (localStorage.getItem("username") === null) {
            return checkId();
        } else {
            return loadmyFiles();
        }

        var setnewtime = (new Date()).getTime();
        var daycheck = ""+setnewtime;
        if (localStorage.getItem("daycheck") === null) {
            localStorage.setItem("daycheck", daycheck);
        }

    })

</script>

    <script>
        Offline.options = {

            // Should we monitor AJAX requests to help decide if we have a connection.
            interceptRequests: true,

            // Should we automatically retest periodically when the connection is down (set to false to disable).
            reconnect: {
                // How many seconds should we wait before rechecking.
                initialDelay: 20,

                // How long should we wait between retries.
                delay: (1.5 * last delay, capped at 1 hour)
        },

        // Should we store and attempt to remake requests which fail while the connection is down.
        requests: true

        // Should we show a snake game while the connection is down to keep the user entertained?
        // It's not included in the normal build, you should bring in js/snake.js in addition to
        // offline.min.js.
        game: false
        }
    </script>

</body>
</html>