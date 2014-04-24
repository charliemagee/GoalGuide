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
<script src="js/newmain.js"></script>
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


        $.getJSON("newuserlist.json", function(data) {
            localStorage.setItem("users", JSON.stringify(data));
            return displayUserList();
        });

        if (localStorage.getItem("username") === null) {
            return checkId();
        } else {
            return loadmyFiles();
        }


    })

</script>

</body>
</html>
