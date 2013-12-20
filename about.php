<?
//include the header
require_once("header.php");
?>

<div id="content">
        <div id="main" class="columnonethird" role="main">
                <h2>Cheerio!</h2>
                <p>This is all about us, not you.</p>
        </div> <!-- main content -->
        <aside id="sidebar" class='columntwothirds'>
            <h2>Coming Up!</h2>
            <div id="sooncontent">
                <ul id="soon">
                    <li>
                        <div class="whowhat">
                            <div><img class="img-rounded what" src='images/locations/ducksbball.jpg' alt="face one"></div>
                            <div><img class="img-rounded who" src='images/people/face4.jpg' alt="face one"></div>
                        </div>
                        <div class="title"><p>Ducks bball with JT!</p></div>
                        <div>
                            <!-- Button to trigger modal -->
                            <a href="#detailsModal" role="button" class="btn showbtn" data-toggle="modal"><i class="icon-eye-open" ></i> Show</a>
                        </div>
                    </li>
                    <li>
                        <div class="whowhat">
                            <div><img class="img-rounded what" src='images/locations/oakwaygolf.jpg' alt="face one"></div>
                            <div><img class="img-rounded who" src='images/people/face5.jpg' alt="face one"></div>
                        </div>
                        <div class="title"><p>Golfing with Lucy!</p></div>
                        <div>
                            <!-- Button to trigger modal -->
                            <a href="#detailsModal" role="button" class="btn showbtn" data-toggle="modal"><i class="icon-eye-open" ></i> Show</a>
                        </div>
                    </li>
                    <li>
                        <div class="whowhat">
                            <div><img class="img-rounded what" src='images/locations/bellylarge.jpg' alt="face one"></div>
                            <div><img class="img-rounded who" src='images/people/face7.jpg' alt="face one"></div>
                        </div>
                        <div class="title"><p>Dinner with Casey Jo!</p></div>
                        <div>
                            <!-- Button to trigger modal -->
                            <a href="#detailsModal" role="button" class="btn showbtn" data-toggle="modal"><i class="icon-eye-open" ></i> Show</a>
                        </div>
                    </li>
                    <li>
                        <div class="whowhat">
                            <div><img class="img-rounded what" src='images/locations/strikecitylanes.jpg' alt="face one"></div>
                            <div><img class="img-rounded who" src='images/people/face11.jpg' alt="face one"></div>
                        </div>
                        <div class="title"><p>Bowling with Geni!</p></div>
                        <div>
                            <!-- Button to trigger modal -->
                            <a href="#detailsModal" role="button" class="btn showbtn" data-toggle="modal"><i class="icon-eye-open" ></i> Show</a>
                        </div>
                    </li>
                </ul> <!-- end yes ul -->
            </div>
        </aside> <!-- end sidebar -->

        
<!-- Modal -->
<div id="detailsModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="detailsLabel" aria-hidden="true">
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="detailsLabel">Golfing at Oakway with Lucy</h3>
</div>
<div class="modal-body">
    <div class="whowhat">
        <div><img class="img-rounded what" src='images/locations/oakwaygolf.jpg' alt="face one"></div>
        <div><img class="img-rounded who" src='images/people/face5.jpg' alt="face one"></div>
    </div>
    <div class="titleclock">
        <div class="clock">March 14 &mdash; <div id="clock16">[clock16]</div></div>
    </div>
    <div class="guests">
        <div class="hidden"><img class="img-rounded sizec user" src='images/people/face1.jpg' alt="face one">
            <img class="guestcancel"src="images/closebox.png" /></div>
        <div><img class="img-rounded guest" src='images/people/face11.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face2.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face12.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face10.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face7.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face9.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face4.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face6.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face3.jpg' alt="face one"></div>
        <div><img class="img-rounded guest" src='images/people/face8.jpg' alt="face one"></div>
    </div>
    <div class="comments">
        <p>Add a comment:</p>
        <textarea rows="2" columns="30"></textarea>
        <p><span class="author">J.T.</span>: Wow, this is enough people for a tournament!</p>
        <p><span class="author">Bella</span>: I don't want to use a cart.</p>
        <p><span class="author">Patsy</span>: Can I borrow some golf clubs?</p>
        <p><span class="author">Trent</span>: Are we using carts?</p>
        <p><span class="author">Ali</span>: The green fee (how much a round of golf costs) is $30.</p>
        <p><span class="author">J.T.</span>: How much will it cost?</p>
    </div>
</div>
<div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">Save</button>
</div>
</div>
</div><!-- content -->
        
        
<!-- Modal -->
<div id="createModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="createLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="detailsLabel">Create New Event</h3>
    </div>
    <div class="modal-body">
        <div id="activityholder">
            <div id="selectedactivity"><img class="img-rounded what" src='images/locations/blankactivity.jpg'></div>
            <button id="changeactivitybtn" type="button" class="btn btn-mini"><i class="icon-pencil" ></i>  Change</button>
        </div>
        <div id="dateholder">
            <input type="text" id="datepicker" placeholder="Pick a Date" />
        </div>
        <button id="sendinvitationsbtn" class="btn btn-large btn-success"><i class="icon-share" ></i>&nbsp;&nbsp;Send Invitations</button>
        <div id="thanks">
            <h4 class="thanksmessage">Your invitations have been sent!</h4>
            <button id="thanksbtn" class="btn btn-large btn-info" data-dismiss="modal" aria-hidden="true"><i class="icon-thumbs-up" ></i>&nbsp;&nbsp;Thanks</button>
        </div>
        <div id="activitylist">
            <h4>Pick an Activity</h4>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/ducksfball.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/ducksbball.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/ems.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/amazonpool.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/strikecitylanes.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/oakwaygolf.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/bellylarge.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/taylors.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/wetlands.jpg' /></div>
            <div class="activitychoice"><img class="img-rounded what" src='images/locations/soriah.jpg' /></div>
        </div>
    </div>
    <div class="modal-footer">

    </div>
</div>

<?
//include the footer
require_once("footer.php");
?>