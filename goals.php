<?
//include the header
require_once("header.php");
?>

    <div id="content">

    <div id="main" class='columnfull'>
        <h2 id="studentname" class="pull-left">Goals</h2>
        <div class="btn-group pull-left push-right" data-toggle="buttons-radio">
            <!--                <button type="button" id="all" class="btn btn-medium btn-primary"><i class="fa-large icon-stack" ></i> All</button>-->
            <button type="button" id="school" class="btn btn-large btn-primary category active" data-category="school"><i class="fa-large icon-book" ></i> School</button>
            <button type="button" id="work" class="btn btn-large btn-primary category" data-category="work"><i class="fa-large icon-boss" ></i> Work</button>
            <button type="button" id="personal" class="btn btn-large btn-primary category" data-category="personal"><i class="fa-large icon-basketball" ></i> Personal</button>
            <button type="button" id="primaryschool" class="btn btn-large btn-primary primarycategory active" data-category="school"><i class="fa-large icon-book" ></i> School</button>
            <button type="button" id="primarywork" class="btn btn-large btn-primary primarycategory" data-category="work"><i class="fa-large icon-boss" ></i> Work</button>
            <button type="button" id="primarypersonal" class="btn btn-large btn-primary primarycategory" data-category="personal"><i class="fa-large icon-basketball" ></i> Personal</button>
        </div>

        <div class="btn-group pull-right" data-toggle="buttons-radio">
            <button type="button" class="btn btn-small btn-primary primarygoal"><i class="fa-large icon-stack" ></i> Primary</button>
            <button type="button" class="btn btn-small btn-primary sologoal active"><i class="fa-large icon-bell" ></i> Solo</button>
        </div>

        <!-- Button to create new Goal -->
        <a href="#createModal" role="button" id="addgoal" class="btn btn-success btn-medium pull-right" data-toggle="modal"><i class="fa icon-checkmark" ></i>&nbsp;&nbsp;Add Goal</a>
        <a href="#createModal" role="button" id="addprimarygoal" class="btn btn-success btn-medium pull-right" data-toggle="modal"><i class="fa icon-checkmark" ></i>&nbsp;&nbsp;Add Primary Goal</a>
        <div class="clearfix"></div>

        <div id="goalcontent">
            <ul id="listheader">
                <!--                    <li class="listheadercategory">Category</li>-->
                <li class="listheadertitle">Goal</li>
                <li class="listheaderdeadline">Deadline</li>
                <li class="listheaderstatus">Completed?</li>
            </ul>
            <ul class="goalsinprogress goalsection">

            </ul>
            <ul class="goalscompleted goalsection">

            </ul>
            <ul class="goalsmissed goalsection">

            </ul>
        </div>
        <div id="primarygoalcontent">
            <ul id="primarylistheader">
                <!--                    <li class="listheadercategory">Category</li>-->
                <li class="listheadertitle">Goal</li>
                <li class="listheaderstatus">Completed?</li>
            </ul>
            <ul class="primarygoals">

            </ul>
        </div>
        <div id="chartbox">
            <span class="goalremove closechart hidechart"><button type="button" class="btn btn-mini btn-danger" ><b>X</b> </button></span>
            <div id="thischart"></div>
        </div>
        <div id="incentivebox">
            <div id="incentivepic"></div>
            <div id="incentivetext"></div>
        </div>
        <div class="chart-backdrop hidechart"></div>
    </div> <!-- end sidebar -->

    <div id="createModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="createLabel" aria-hidden="true">
    <div class="modal-header">
        <button id="modalclose" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    </div>
    <div class="modal-body">

    <div id="addgoalform">
    <h3 class="detailsLabel">Create New Goal</h3>
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
            <input type="text" id="thegoal" class="input-small goalcomplete textempty" placeholder="What's the goal?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theicons">Icon</label>
        <div id="theicons" class="controls uncheckit">
            <ul class="icondropdown">
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="user"><i class="fa-large icon-user" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="users"><i class="fa-large icon-users" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="boss"><i class="fa-large icon-boss" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="doctor"><i class="fa-large icon-doctor" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="health"><i class="fa-large icon-health" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="phone"><i class="fa-large icon-phone" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="alarm"><i class="fa-large icon-alarm" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="stopwatch"><i class="fa-large icon-stopwatch" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bell"><i class="fa-large icon-bell" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="book"><i class="fa-large icon-book" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="openbook"><i class="fa-large icon-openbook" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="clipboard"><i class="fa-large icon-clipboard" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="suitcase"><i class="fa-large icon-suitcase" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="dollar"><i class="fa-large icon-dollar" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="cart"><i class="fa-large icon-cart" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="coffee"><i class="fa-large icon-coffee" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="silverware"><i class="fa-large icon-silverware" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="gift"><i class="fa-large icon-gift" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="car"><i class="fa-large icon-car" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bus"><i class="fa-large icon-bus" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="bike"><i class="fa-large icon-bike" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="basketball"><i class="fa-large icon-basketball" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="umbrella"><i class="fa-large icon-umbrella" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="headphones"><i class="fa-large icon-headphones" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="t-shirt"><i class="fa-large icon-t-shirt" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="pill"><i class="fa-large icon-pill" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="icon" value="eyedropper"><i class="fa-large icon-eyedropper" ></i>
                    </label>
                </li>

            </ul>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thedeadline">Deadline?</label>
        <div class="controls">
            <input type="date" id="thedeadline" class="input-large textempty">
        </div>
    </div>
    <div id="infotype" class="control-group uncheckit">
        <label class="control-label" for="theinfotype">Gather Data?</label>
        <div class="controls">
            <input type="checkbox" id="theinfotype" name="theinfotype" value="text"><span class="checkboxinfo">Quiz scores, body weight, etc. Used for charts, so numbers only.</span>
        </div>
    </div>
    <div id="recurring" class="control-group uncheckit">
        <label class="control-label" for="therecurring">Recurring Goal?</label>
        <div class="controls">
            <input type="checkbox" id="therecurring" name="therecurring" value="1">
        </div>
    </div>
    <div id="daysoftheweek" class="control-group uncheckit">
        <label class="control-label" for="thedaysoftheweek">Which Days:</label>
        <div class="controls" name="thedaysoftheweek">
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox1" value="mon"> Mon
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox2" value="tue"> Tue
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox3" value="wed"> Wed
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox1" value="thu"> Thu
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox2" value="fri"> Fri
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox3" value="sat"> Sat
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" id="inlineCheckbox3" value="sun"> Sun
            </label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thecomplete">Completion Message</label>
        <div class="controls">
            <input type="text" id="thecomplete" class="input-large goalcomplete textempty" placeholder="Congratulations message? A reminder, perhaps?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theincentivetext">Incentive Message</label>
        <div class="controls">
            <input type="text" id="theincentivetext" class="input-large goalcomplete textempty" placeholder="What is the student's incentive?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theincentivepic">Incentive Picture</label>
        <div id="theincentivepic" class="controls uncheckit">
            <ul class="incentive">
                <li>
                    <label class="radio">
                        <input type="radio" name="incentivepic" value="images/moneybag.jpg"><img src="images/moneybag-sm.jpg" class="thumbnail">
                    </label>
                </li>
                <li>
                    <label class="radio">
                        <input type="radio" name="incentivepic" value="images/fireworks.jpg"><img src="images/fireworks-sm.jpg" class="thumbnail">
                    </label>
                </li>
                <li>
                    <label class="radio">
                        <input type="radio" name="incentivepic" value="images/goldstar.jpg"><img src="images/goldstar-sm.jpg" class="thumbnail">
                    </label>
                </li>
                <li>
                    <label class="radio">
                        <input type="radio" name="incentivepic" value="images/ps4-sm.jpg"><img src="images/ps4-sm.jpg" class="thumbnail">
                    </label>
                </li>
                <li>
                    <label class="radio">
                        <input type="radio" name="incentivepic" value="images/pizza-sm.jpg"><img src="images/pizza-sm.jpg" class="thumbnail">
                    </label>
                </li>
            </ul>
        </div>
    </div>
    <div class="savinggoals push-right-savegoal">
        <button type="button" id="savegoal" data-dismiss="modal" class="btn btn-success btn-medium"><i class="fa-large icon-checkmark" ></i>&nbsp;&nbsp;Save Goal</a></button>
        <button type="button" id="savegoalcancel"  data-dismiss="modal" class="btn btn-danger btn-medium"><i class="fa-large icon-remove" ></i>&nbsp;&nbsp;Cancel</a></button>
    </div>
    </form>
    <div class="clearfix"></div>
    </div>
    <div id="addprimarygoalform">
    <h3 class="detailsLabel">Create New Primary Goal</h3>
    <form class="form-horizontal">
    <div class="control-group">
        <label class="control-label" for="theprimarycategory">Category</label>
        <div class="controls">
            <select type="text" id="theprimarycategory">
                <option>School</option>
                <option>Personal</option>
                <option>Work</option>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theprimarygoal">Primary Goal</label>
        <div class="controls">
            <input type="text" id="theprimarygoal" class="input-large goalcomplete textempty" placeholder="What's the primary goal?">
        </div>
    </div>
    <hr/>
    <div class="control-group">
        <label class="control-label" for="thegoalA">Enabling A</label>
        <div class="controls">
            <input type="text" id="thegoalA" class="input-large goalcomplete textempty" placeholder="What's the goal?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theiconsA">Icon</label>
        <div id="theiconsA" class="controls uncheckit">
            <ul class="icondropdownsub">
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="user"><i class="fa-large icon-user" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="users"><i class="fa-large icon-users" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="boss"><i class="fa-large icon-boss" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="doctor"><i class="fa-large icon-doctor" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="health"><i class="fa-large icon-health" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="phone"><i class="fa-large icon-phone" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="alarm"><i class="fa-large icon-alarm" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="stopwatch"><i class="fa-large icon-stopwatch" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="bell"><i class="fa-large icon-bell" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="book"><i class="fa-large icon-book" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="openbook"><i class="fa-large icon-openbook" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="clipboard"><i class="fa-large icon-clipboard" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="suitcase"><i class="fa-large icon-suitcase" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="dollar"><i class="fa-large icon-dollar" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="cart"><i class="fa-large icon-cart" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="coffee"><i class="fa-large icon-coffee" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="silverware"><i class="fa-large icon-silverware" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="gift"><i class="fa-large icon-gift" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="car"><i class="fa-large icon-car" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="bus"><i class="fa-large icon-bus" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="bike"><i class="fa-large icon-bike" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="basketball"><i class="fa-large icon-basketball" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="umbrella"><i class="fa-large icon-umbrella" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="headphones"><i class="fa-large icon-headphones" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="t-shirt"><i class="fa-large icon-t-shirt" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="pill"><i class="fa-large icon-pill" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconA" value="eyedropper"><i class="fa-large icon-eyedropper" ></i>
                    </label>
                </li>
            </ul>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thedeadlineA">Deadline?</label>
        <div class="controls">
            <input type="date" id="thedeadlineA" class="input-large textempty">
        </div>
    </div>
    <div id="infotypeA" class="control-group uncheckit">
        <label class="control-label" for="theinfotypeA">Gather Data?</label>
        <div class="controls">
            <input type="checkbox" id="theinfotypeA" name="theinfotypeA" value="text"><span class="checkboxinfo">Quiz scores, body weight, etc. Used for charts, so numbers only.</span>
        </div>
    </div>
    <div id="recurringA" class="control-group uncheckit">
        <label class="control-label" for="therecurringA">Recurring Goal?</label>
        <div class="controls">
            <input type="checkbox" id="therecurringA" name="therecurringA" value="1">
        </div>
    </div>
    <div id="daysoftheweekA" class="control-group uncheckit">
        <label class="control-label" for="thedaysoftheweekA">Which Days:</label>
        <div class="controls" name="thedaysoftheweekA">
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="mon"> Mon
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="tue"> Tue
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="wed"> Wed
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="thu"> Thu
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="fri"> Fri
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sat"> Sat
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sun"> Sun
            </label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thecompleteA">Completion Message</label>
        <div class="controls">
            <input type="text" id="thecompleteA" class="input-large goalcomplete textempty" placeholder="Congratulations message? A reminder, perhaps?">
        </div>
    </div>
    <hr/>
    <div class="control-group">
        <label class="control-label" for="thegoalB">Enabling B</label>
        <div class="controls">
            <input type="text" id="thegoalB" class="input-large goalcomplete textempty" placeholder="What's the goal?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theiconsB">Icon</label>
        <div id="theiconsB" class="controls uncheckit">
            <ul class="icondropdownsub">
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="user"><i class="fa-large icon-user" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="users"><i class="fa-large icon-users" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="boss"><i class="fa-large icon-boss" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="doctor"><i class="fa-large icon-doctor" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="health"><i class="fa-large icon-health" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="phone"><i class="fa-large icon-phone" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="alarm"><i class="fa-large icon-alarm" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="stopwatch"><i class="fa-large icon-stopwatch" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="bell"><i class="fa-large icon-bell" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="book"><i class="fa-large icon-book" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="openbook"><i class="fa-large icon-openbook" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="clipboard"><i class="fa-large icon-clipboard" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="suitcase"><i class="fa-large icon-suitcase" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="dollar"><i class="fa-large icon-dollar" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="cart"><i class="fa-large icon-cart" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="coffee"><i class="fa-large icon-coffee" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="silverware"><i class="fa-large icon-silverware" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="gift"><i class="fa-large icon-gift" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="car"><i class="fa-large icon-car" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="bus"><i class="fa-large icon-bus" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="bike"><i class="fa-large icon-bike" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="basketball"><i class="fa-large icon-basketball" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="umbrella"><i class="fa-large icon-umbrella" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="headphones"><i class="fa-large icon-headphones" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="t-shirt"><i class="fa-large icon-t-shirt" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="pill"><i class="fa-large icon-pill" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconB" value="eyedropper"><i class="fa-large icon-eyedropper" ></i>
                    </label>
                </li>

            </ul>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thedeadlineB">Deadline?</label>
        <div class="controls">
            <input type="date" id="thedeadlineB" class="input-large textempty">
        </div>
    </div>
    <div id="infotypeB" class="control-group uncheckit">
        <label class="control-label" for="theinfotypeB">Gather Data?</label>
        <div class="controls">
            <input type="checkbox" id="theinfotypeB" name="theinfotypeB" value="text"><span class="checkboxinfo">Quiz scores, body weight, etc. Used for charts, so numbers only.</span>
        </div>
    </div>
    <div id="recurringB" class="control-group uncheckit">
        <label class="control-label" for="therecurringB">Recurring Goal?</label>
        <div class="controls">
            <input type="checkbox" id="therecurringB" name="therecurringB" value="1">
        </div>
    </div>
    <div id="daysoftheweekB" class="control-group uncheckit">
        <label class="control-label" for="thedaysoftheweekB">Which Days:</label>
        <div class="controls" name="thedaysoftheweekB">
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="mon"> Mon
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="tue"> Tue
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="wed"> Wed
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="thu"> Thu
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="fri"> Fri
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sat"> Sat
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sun"> Sun
            </label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thecompleteB">Completion Message</label>
        <div class="controls">
            <input type="text" id="thecompleteB" class="input-large goalcomplete textempty" placeholder="Congratulations message? A reminder, perhaps?">
        </div>
    </div>
    <hr/>
    <div class="control-group">
        <label class="control-label" for="thegoalC">Enabling C</label>
        <div class="controls">
            <input type="text" id="thegoalC" class="input-large goalcomplete textempty" placeholder="What's the goal?">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="theiconsC">Icon</label>
        <div id="theiconsC" class="controls uncheckit">
            <ul class="icondropdownsub">
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="user"><i class="fa-large icon-user" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="users"><i class="fa-large icon-users" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="boss"><i class="fa-large icon-boss" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="doctor"><i class="fa-large icon-doctor" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="health"><i class="fa-large icon-health" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="phone"><i class="fa-large icon-phone" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="alarm"><i class="fa-large icon-alarm" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="stopwatch"><i class="fa-large icon-stopwatch" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="bell"><i class="fa-large icon-bell" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="book"><i class="fa-large icon-book" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="openbook"><i class="fa-large icon-openbook" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="clipboard"><i class="fa-large icon-clipboard" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="suitcase"><i class="fa-large icon-suitcase" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="dollar"><i class="fa-large icon-dollar" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="cart"><i class="fa-large icon-cart" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="coffee"><i class="fa-large icon-coffee" ></i><br/>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="silverware"><i class="fa-large icon-silverware" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="gift"><i class="fa-large icon-gift" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="car"><i class="fa-large icon-car" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="bus"><i class="fa-large icon-bus" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="bike"><i class="fa-large icon-bike" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="basketball"><i class="fa-large icon-basketball" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="umbrella"><i class="fa-large icon-umbrella" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="headphones"><i class="fa-large icon-headphones" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="t-shirt"><i class="fa-large icon-t-shirt" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="pill"><i class="fa-large icon-pill" ></i>
                    </label>
                </li>
                <li class="icomoonli">
                    <label class="radio">
                        <input type="radio" name="iconC" value="eyedropper"><i class="fa-large icon-eyedropper" ></i>
                    </label>
                </li>

            </ul>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thedeadlineC">Deadline?</label>
        <div class="controls">
            <input type="date" id="thedeadlineC" class="input-large textempty">
        </div>
    </div>
    <div id="infotypeC" class="control-group uncheckit">
        <label class="control-label" for="theinfotypeC">Gather Data?</label>
        <div class="controls">
            <input type="checkbox" id="theinfotypeC" name="theinfotypeC" value="text"><span class="checkboxinfo">Quiz scores, body weight, etc. Used for charts, so numbers only.</span>
        </div>
    </div>
    <div id="recurringC" class="control-group uncheckit">
        <label class="control-label" for="therecurringC">Recurring Goal?</label>
        <div class="controls">
            <input type="checkbox" id="therecurringC" name="therecurringC" value="1">
        </div>
    </div>
    <div id="daysoftheweekC" class="control-group uncheckit">
        <label class="control-label" for="thedaysoftheweekC">Which Days:</label>
        <div class="controls" name="thedaysoftheweekC">
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="mon"> Mon
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="tue"> Tue
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="wed"> Wed
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="thu"> Thu
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="fri"> Fri
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sat"> Sat
            </label>
            <label class="checkbox inline">
                <input type="checkbox" name="days" value="sun"> Sun
            </label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="thecompleteC">Completion Message</label>
        <div class="controls">
            <input type="text" id="thecompleteC" class="input-large goalcomplete textempty" placeholder="Congratulations message? A reminder, perhaps?">
        </div>
    </div>
    <div class="savinggoals push-right-savegoal">
        <button type="button" id="saveprimarygoal" data-dismiss="modal" class="btn btn-success btn-medium"><i class="fa-large icon-checkmark" ></i>&nbsp;&nbsp;Save These Goals</a></button>
        <button type="button" id="savegoalcancel"  data-dismiss="modal" class="btn btn-danger btn-medium"><i class="fa-large icon-remove" ></i>&nbsp;&nbsp;Cancel</a></button>
    </div>
    </form>
    <div class="clearfix"></div>
    </div>

    <!--                <div id="teethchart"></div>-->
    <!--                <div id="readingchart"></div>-->
    </div>
    <div class="modal-footer">
        <!--                <p class="small">This window remains open after saving so that you can quickly create another item.</p>-->
    </div>
    </div>

    </div>
<?
//include the footer
require_once("footer.php");
?>