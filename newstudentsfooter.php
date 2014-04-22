<footer>
    <span class="copyright">&copy;2014 Cognitopia Software, LLC</span>

</footer>

</div>     <!-- wrapper -->

<script src="js/jquery-1.8.3.min.js"></script>
<script src="js/jquery-ui-1.10.0.custom.min.js"></script>
<script src="js/newmain.js"></script>
<script src="js/bootstrap/bootstrap-alert.js"></script>
<script src="js/bootstrap/bootstrap-transition.js"></script>
<script src="js/bootstrap/bootstrap-collapse.js"></script>
<script src="js/bootstrap/bootstrap-button.js"></script>
<script src="js/bootstrap/bootstrap-modal.js"></script>
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

        initStudentPage();

    })

</script>
</body>
</html>
