<footer>
    <span class="copyright">&copy;2013 Cognitopia Software, LLC</span>
    <!--  <ul>
       <li><a href="index.html">Desktop</a></li>
       <li><a href="tablet.index.html">Tablet</a></li>
       <li><a href="m.index.html">Phone</a></li>
     </ul> -->

</footer>

</div>     <!-- wrapper -->

<script src="js/jquery-1.8.3.min.js"></script>
<!--<script src="js/jquery-ui-1.10.0.custom.min.js"></script>-->
<script src="js/main.js"></script>
<script src="js/bootstrap/bootstrap-alert.js"></script>
<script src="js/bootstrap/bootstrap-transition.js"></script>
<script src="js/bootstrap/bootstrap-collapse.js"></script>
<script src="js/bootstrap/bootstrap-button.js"></script>
<script src="js/bootstrap/bootstrap-modal.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<!--<script src="js/jquery.tinysort.min.js"></script>-->
<!--<script src="js/offline.min.js"></script>-->

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
            if (now - lastTime > 24*60*60*1000) {
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

        var username;

        if (localStorage.getItem("username") === null) {
            var username = prompt("What is your username?");
            localStorage.setItem("username", username);
        }

        var setnewtime = (new Date()).getTime();
        var daycheck = ""+setnewtime;
        if (localStorage.getItem("daycheck") === null) {
            localStorage.setItem("daycheck", daycheck);
        }

        username = localStorage.getItem('username');

        $.getJSON(username + "user.json", function(data) {
            localStorage.setItem("user", JSON.stringify(data));
            var user = JSON.parse(localStorage.getItem('user'));
            var notify = user.notify;
            var firstname = user.firstname;
//            var capfirstname = capitaliseFirstLetter(firstname)
//            function capitaliseFirstLetter(string) {
//                return string.charAt(0).toUpperCase() + string.slice(1);
//            };
            localStorage.setItem("firstname", firstname)
            return localStorage.setItem("notify", notify)
        });

        firstname = localStorage.getItem('firstname');

        $.getJSON(username + "primary.json", function(data) {
            return localStorage.setItem("primarygoals", JSON.stringify(data));
        });

        $.getJSON(username + ".json", function(data) {
            localStorage.setItem("goals", JSON.stringify(data));
            $("#goalcontent").show();
            $("#addgoal").show();
            $("#studentname").html(firstname + "\'s" + " Goals");
            return displayMyGoalList();
        });



    })

</script>
<!--<script>-->
<!--    Offline.options = {-->
<!---->
<!--        // Should we monitor AJAX requests to help decide if we have a connection.-->
<!--        interceptRequests: true,-->
<!---->
<!--        // Should we automatically retest periodically when the connection is down (set to false to disable).-->
<!--        reconnect: {-->
<!--            // How many seconds should we wait before rechecking.-->
<!--            initialDelay: 20,-->
<!---->
<!--            // How long should we wait between retries.-->
<!--            delay: (1.5 * last delay, capped at 1 hour)-->
<!--    },-->
<!---->
<!--    // Should we store and attempt to remake requests which fail while the connection is down.-->
<!--    requests: true-->
<!---->
<!--    // Should we show a snake game while the connection is down to keep the user entertained?-->
<!--    // It's not included in the normal build, you should bring in js/snake.js in addition to-->
<!--    // offline.min.js.-->
<!--    game: false-->
<!--    }-->
<!--</script>-->
</body>
</html>
