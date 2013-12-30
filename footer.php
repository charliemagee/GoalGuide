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
<script src="js/jquery-ui-1.10.0.custom.min.js"></script>
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

        var interval = 0;
        var now = new Date();
        var night = now.getHours();
        if (night > 2 && night < 3)
           resetCompleted();
           localStorage["daycheck"] = "" + now;
//        interval = window.setTimeout(function () {
//            interval = window.setInterval(function () {
//                resetCompleted();
//                localStorage["daycheck"] = "" + now;
//            }, 1 * 60 * 1000);
//        }, interval);

        var username;

        if (localStorage.getItem("username") === null) {
            username = prompt("What is your username?");
            localStorage.setItem("username", username);
        }

        if (localStorage.getItem("daycheck") === null) {
            localStorage.setItem("daycheck", new Date());
        }

        username = localStorage.getItem('username');

        $.getJSON(username + "primary.json", function(data) {
            return localStorage.setItem("primarygoals", JSON.stringify(data));
        });

        $.getJSON(username + ".json", function(data) {
            localStorage.setItem("goals", JSON.stringify(data));
            $("#goalcontent").show();
            $("#addgoal").show();
            $("#studentname").html(username + " Goals");
            return displayMyGoalList();
        });



    })
//    $(window).load(function(){
//
//        initMine();
//
//
//    })
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
