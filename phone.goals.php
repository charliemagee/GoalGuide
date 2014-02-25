<!DOCTYPE html manifest="phonegoals.appcache">
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
    <link rel="stylesheet" href="css/phone.main.css">

</head>
<body>

<!--[if lt IE 7]>
<p class="chromeframe">You are using an outdated browser. <a href="http://browsehappy.com/">Upgrade your browser today</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to better experience this site.</p>
<![endif]-->

<!--[if lt IE 9]>
<script src="scripts/vendor/es5-shim.min.js"></script>
<script src="scripts/vendor/json3.min.js"></script>
<![endif]-->

<div id="menuwrapper" class="menustuff">
    <div id="homemenu"><h1 class="dropdown"><i class="fa-regular icon-home" ></i><br/>Home</h1></div>
    <div id="schoolmenu" data-category="school"><h1 class="dropdown"><i class="fa-regular icon-book" ></i><br/>School</h1></div>
    <div id="workmenu" data-category="work"><h1 class="dropdown"><i class="fa-regular icon-boss" ></i><br/>Work</h1></div>
    <div id="personalmenu" data-category="personal"><h1 class="dropdown"><i class="fa-regular icon-basketball" ></i><br/>Personal</h1></div>
</div>
<div id="nav">
    <div id="home" class="menubar"><h1 class="dropdown"><i class="fa-regular icon-home" ></i><br/>Home</h1></div>
    <div id="school" class="menubar" data-category="school"><h1 class="dropdown"><i class="fa-regular icon-book" ></i><br/>School</h1></div>
    <div id="work" class="menubar" data-category="work"><h1 class="dropdown"><i class="fa-regular icon-boss" ></i><br/>Work</h1></div>
    <div id="personal" class="menubar" data-category="personal"><h1 class="dropdown"><i class="fa-regular icon-basketball" ></i><br/>Personal</h1></div>
    <div id="solomenu">
        <div class="solobartop"></div>
        <div class="solobarsecond"></div>
        <div class="solobarthird"></div>
        <div class="solobarthird"></div>
    </div>
    <div id="primarymenu">
        <div class="primarybartop"></div>
        <div class="primarybarsecond"></div>
        <div class="primarybarsecond"></div>
        <div class="primarybarthird"></div>
    </div>
</div>
<div id="hidescreen" class="menustuff"></div>
<div id="content">

        <div id="logout">
            <button type="button" id="logoutbutton" class="btn btn-success btn-medium">Logout</button>
        </div>

        <div id="checkid">
            <h4 class="detailsLabel">Please Login</h4>
            <div id="errorlogin">Your username and password combination is incorrect. Please try again.</div>
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="theloginusername">Username:</label>
                    <div class="controls">
                        <input type="text" id="theloginusername" class="input-small textempty" required>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="theloginpassword">Password:</label>
                    <div class="controls">
                        <input type="password" id="theloginpassword" class="input-small textempty" required>
                    </div>
                </div>
                <div class="savinggoals push-right-savegoal">
                    <button type="button" id="loginbutton" class="btn btn-success btn-medium">Login</button>
                </div>
            </form>
        </div> <!-- end checkid -->

        <div id="goalscontainer" class="move-inside">
            <ul class="goalsinprogress goalsection">

            </ul>
            <ul class="goalscompleted goalsection">

            </ul>
        </div>
        <div id="primarygoalscontainer">
            <ul class="primarygoals">

            </ul>

        </div>
        <div id="chartbox">
            <span class="goalremove closechart hidechart"><button type="button" class="btn btn-mini btn-danger" ><b>X</b> </button></span>
            <div id="thischart"></div>
        </div>
<!--        <div id="incentivebox">-->
<!--            <div id="incentivepic"></div>-->
<!--            <div id="incentivetext"></div>-->
<!--        </div>-->
        <div class="chart-backdrop hidechart"></div>
        <div class="congratsmessageholder">
            <div class="congratsmessage"></div>
        </div>
    <footer>
        <span>&copy;2013 Cognitopia Software, LLC</span>
        <!--  <ul>
           <li><a href="index.html">Desktop</a></li>
           <li><a href="tablet.index.html">Tablet</a></li>
           <li><a href="m.index.html">Phone</a></li>
         </ul> -->

    </footer>
</div>     <!-- wrapper -->

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="js/offline.min.js"></script>
    <script src="js/phone.main.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            var str=location.href.toLowerCase();
            $(".nav li a").each(function() {
                if (str.indexOf(this.href.toLowerCase()) > -1) {
                    $("li.active").removeClass("active");
                    $(this).parent().addClass("active");
                }
            });


            $(window).focus(function() {
                var now = (new Date()).getTime();
                var lastTime = 0;
                var lastTimeStr = localStorage['daycheck'];
                if (lastTimeStr) lastTime = parseInt(lastTimeStr, 10);
                if (now - lastTime > 60*1000) {
                    resetCompleted();
                    localStorage['daycheck'] = ""+now;
                }
            })

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
