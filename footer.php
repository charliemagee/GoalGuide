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


        $.getJSON("userlist.json", function(data) {
            localStorage.setItem("users", JSON.stringify(data));
            return displayUserList();
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

</body>
</html>
