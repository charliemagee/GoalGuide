<?
//include the header
require_once("mobile.header.php");
?>

    <div id="content">

        <div id="checkid">
            <h3 class="detailsLabel">Please Login</h3>
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

        <div id="main">
            <ul class="goalsinprogress goalsection">

            </ul>
            <ul class="goalscompleted goalsection">

            </ul>
            <ul class="primarygoals">

            </ul>
            <div id="chartbox">
                <span class="goalremove closechart hidechart"><button type="button" class="btn btn-mini btn-danger" ><b>X</b> </button></span>
                <div id="thischart"></div>
            </div>
            <div id="incentivebox">
                <div id="incentivepic"></div>
                <div id="incentivetext"></div>
            </div>
            <div class="chart-backdrop hidechart"></div>
            <div class="congratsmessageholder">
                <div class="congratsmessage"></div>
            </div>
        </div> <!-- end main -->

    </div> <!-- end content -->
<?
//include the footer
require_once("mobile.footer.php");
?>