<?
//include the header
require_once("header.php");
?>

    <div id="main" class='columnfull'>
            <h2 class="pull-left">Students</h2>
            <!-- Button to create new Student -->
            <a href="#createModal" role="button" id="adduser" class="btn btn-success btn-medium pull-right" data-toggle="modal"><i class="fa fa-plus" ></i>&nbsp;&nbsp;Add Student</a>
            <div class="clearfix"></div>


            <div id="usercontent">
                <ul id="listheader">
                    <li class="listheaderusername">Username</li>
                    <li class="listheaderuserfullname">Full Name</li>
                    <li class="listheaderpassword">Password</li>
                    <li class="listheadernotifications">Notifications</li>
                    <li class="listheaderuserremove">Remove User</li>
                </ul>
                <div class="clearfix"></div>
                <ul class="users">

                </ul>
            </div>

    </div> <!-- main content -->

        <div id="createModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="createLabel" aria-hidden="true">
            <div class="modal-header">
                <button id="modalclose" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <div id="adduserform">
                    <h3 class="detailsLabel">Add New Student</h3>
                    <form class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label" for="theusername">Username</label>
                            <div class="controls">
                                <input type="text" id="theusername" class="input-small textempty" placeholder="Pick a username...">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="thefirstname">First name</label>
                            <div class="controls">
                                <input type="text" id="thefirstname" class="input-small textempty" placeholder="First Name">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="thelastname">Last name</label>
                            <div class="controls">
                                <input type="text" id="thelastname" class="input-small textempty" placeholder="Last Name">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="thepassword">Password</label>
                            <div class="controls">
                                <input type="password" id="thepassword" class="input-small textempty" placeholder="Password">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="thepasswordconfirm">Password Confirm</label>
                            <div class="controls">
                                <input type="password" id="thepasswordconfirm" class="input-small textempty" placeholder="Confirm password">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="thenotifications">Notify</label>
                            <div class="controls">
                                <input type="text" id="thenotifications" class="input-small textempty" placeholder="jo@ex.com,ma@ot.com">
                            </div>
                        </div>
                        <div class="savinggoals push-right-savegoal">
                            <button type="button" id="saveuser" data-dismiss="modal" class="btn btn-success btn-medium"><i class="fa-large icon-checkmark" ></i>&nbsp;&nbsp;Save Student</button>
                            <button type="button" id="saveusercancel"  data-dismiss="modal" class="btn btn-danger btn-medium"><i class="fa-large icon-remove" ></i>&nbsp;&nbsp;Cancel</button>
                        </div>
                    </form>
                    <div class="clearfix"></div>
                </div>

            </div>
            <div class="modal-footer">
<!--                <p class="small">This window remains open after saving so that you can quickly create another item.</p>-->
            </div>
        </div>

<?
//include the footer
require_once("studentsfooter.php");
?>