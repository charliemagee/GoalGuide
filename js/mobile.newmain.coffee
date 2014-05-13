###global console ###

username = ''
password = ''
deadline = ''
infocreated = []
myinfo = []
newcreated = ''
mygoaldate = ''
chart1 = ''
incentivepic = ''
incentivetext = ''
placeincentivetext = ''
congratulations = ''
checkinginfotype = ''
mytitle = ''
data = []
datecreated = ''
getDate = (d) ->
  new Date(d.createdDate)
dayToday = ''
currentDay = ''
dateString = ''
firstname = ''
capfirstname = ''
notify = ''
goal = ''
emailGoal = ''
updateStatus = ''
index = ''
goalguid = ''
goalinfo = []
newinfo = ''
goalCategory = 'school'
goalType = 'solo'
thecategorysaved = ''
users = []
goals = []
primarygoals = []
newinfocreated = ''
newgoal = {}
newprimarygoal = {}
user = {}
goalmessage = ''


# check once a day for goals that didn't get completed
resetCompleted = ->
  console.log 'reset triggered'
  goals = JSON.parse(localStorage["goals"])
  mygoaldate = createInfoDate()
  newinfo = 0
  if (goal.goal.status is 'inprogress') and (goal.goal.infotype isnt 'text')
    $.each goals, (i, goal) ->
      goal.goal.myinfo.push newinfo
      goal.goal.infocreated.push mygoaldate
      goal.goal.datecompleted = mygoaldate
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
  displayMyGoalList()

checkId = ->
  if localStorage.getItem('username') isnt null
    loadmyFiles()
  else
    $('#checkid').show()
    setTimeout (->
      $('#theloginusername').focus()
    ), 500

###
  create a date for the goal info input
###
createInfoDate = ->
  d = new Date()
  month = new Array()
  month[0] = "Jan"
  month[1] = "Feb"
  month[2] = "Mar"
  month[3] = "April"
  month[4] = "May"
  month[5] = "June"
  month[6] = "July"
  month[7] = "Aug"
  month[8] = "Sept"
  month[9] = "Oct"
  month[10] = "Nov"
  month[11] = "Dec"
  n = month[d.getMonth()]
  newcreated = n + ' ' + d.getDate()

###
  create a date for recurring goal check
###
createDayToday = ->
  currentDay = new Date().getDay()

###
  create a guid
###
createGuid = ->
  "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = (if c is "x" then r else (r & 0x3 | 0x8))
    v.toString 16

$("#checkid").keydown (event) ->
  $("#loginbutton").trigger "click"  if event.keyCode is 13

$("#logoutbutton").click ->
  $('#logout').hide()
  console.log 'logged out'
  localStorage.removeItem('firstname')
  localStorage.removeItem('goals')
  localStorage.removeItem('notify')
  localStorage.removeItem('primarygoals')
  localStorage.removeItem('secret')
  localStorage.removeItem('username')
  localStorage.removeItem('users')
  location.reload()

$('#loginbutton').click ->
  console.log 'logged in'
  users = JSON.parse(localStorage["users"])
  username = $("#theloginusername").val()
  password = $("#theloginpassword").val()
  console.log username + '  ' + password
  $.each users, (i, user) ->
    if user.username is username and user.password is password
      $('#checkid').hide()
      localStorage.setItem("secret", "this is a secret")
      localStorage.setItem("username", username)
      localStorage.removeItem("users")
      loadmyFiles()
    else
      $('#errorlogin').show()

loadmyFiles = ->
  username = localStorage.getItem("username")
  $('#checkid').hide()
  $('#logout').hide()
  $('#home').removeClass('currentmenu')
  $('#school').addClass('currentmenu')
  $('#work').removeClass('currentmenu')
  $('#personal').removeClass('currentmenu')
  $('#goalscontainer').show()
  $.getJSON username + "user.json", (data) ->
    capitaliseFirstLetter = (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)
    localStorage.setItem "user", JSON.stringify(data)
    user = JSON.parse(localStorage.getItem("user"))
    notify = user.notify
    firstname = user.firstname
    capfirstname = capitaliseFirstLetter(firstname)
    localStorage.setItem "firstname", capfirstname
    localStorage.setItem "notify", notify
    localStorage.removeItem("user")
    localStorage.removeItem("users")

  $.getJSON username + "primary.json", (data) ->
    localStorage.setItem "primarygoals", JSON.stringify(data)

  $.getJSON username + ".json", (data) ->
    localStorage.setItem "goals", JSON.stringify(data)
    $("#goalcontent").show()
    $("#addgoal").show()
    firstname = localStorage.getItem("firstname")
    $("#studentname").html firstname + "'s" + " Goals"
    $('#goalscontainer').show()
    $('#primarygoalscontainer').show()
    $('#logout').hide()
    $('#checkid').hide()
    displayMyGoalList()
    displayprimaryGoals()

# menu nav stuff

#$('#home').click ->
#  $('#home').addClass('currentmenu')
#  $('#school').removeClass('currentmenu')
#  $('#work').removeClass('currentmenu')
#  $('#personal').removeClass('currentmenu')
#  $('#goalscontainer').hide()
#  if localStorage.getItem('username') != null
#    $('#logout').show()
#  else
#    $('#checkid').show()


$('#home').click ->
  $('#home').addClass('currentmenu')
  $('#school').removeClass('currentmenu')
  $('#work').removeClass('currentmenu')
  $('#personal').removeClass('currentmenu')
  $('#addgoalform').show()
  $('#goalscontainer').hide()
  if localStorage.getItem('username') != null
    $('#logout').show()
  else
    $('#checkid').show()

$('#school').click ->
  $('#home').removeClass('currentmenu')
  $('#school').addClass('currentmenu')
  $('#work').removeClass('currentmenu')
  $('#personal').removeClass('currentmenu')
  $('#checkid').hide()
  $('#logout').hide()
  $('#goalscontainer').show()
  $('#addgoalform').hide()
  goalCategory = "school"
  displayMyGoalList()
  displayprimaryGoals()

$('#work').click ->
  $('#home').removeClass('currentmenu')
  $('#school').removeClass('currentmenu')
  $('#work').addClass('currentmenu')
  $('#personal').removeClass('currentmenu')
  $('#checkid').hide()
  $('#logout').hide()
  $('#goalscontainer').show()
  $('#addgoalform').hide()
  goalCategory = "work"
  displayMyGoalList()
  displayprimaryGoals()

$('#personal').click ->
  $('#home').removeClass('currentmenu')
  $('#school').removeClass('currentmenu')
  $('#work').removeClass('currentmenu')
  $('#personal').addClass('currentmenu')
  $('#checkid').hide()
  $('#logout').hide()
  $('#goalscontainer').show()
  $('#addgoalform').hide()
  goalCategory = "personal"
  displayMyGoalList()
  displayprimaryGoals()

###
this adds a goal to the goalsArray, resaves the goalsArray with the new info, resaves the usersGoals to localstorage, then clears the form
###
$('#savegoal').click ->
  datecreated = new Date().toString()
  mygoaldate = createInfoDate()
  goalguid = createGuid()
  thecategorysaved = $("#thecategory").val().toLowerCase()
  newgoal =
    goal:
      goalguid: goalguid
      category: $("#thecategory").val().toLowerCase()
      datecreated: datecreated
      goal: $("#thegoal").val()
      icon: $("input[name=icon]:checked").val()
      status: "inprogress"
      infotype: $("input[name=theinfotype]:checked").val()
      infocreated: []
      myinfo: []
      username: username
  goals.push(newgoal)
  localStorage.setItem "goals", JSON.stringify(goals)
  $("#addgoalform").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked');
  jumpToCategory(thecategorysaved)
  goalChange()

jumpToCategory = ->
  if thecategorysaved is 'school'
    $('#home').removeClass('currentmenu')
    $('#school').addClass('currentmenu')
    $('#work').removeClass('currentmenu')
    $('#personal').removeClass('currentmenu')
    $('#checkid').hide()
    $('#logout').hide()
    $('#goalscontainer').show()
    $('#addgoalform').hide()
    goalCategory = "school"
    displayMyGoalList()
  else if thecategorysaved is 'work'
    $('#home').removeClass('currentmenu')
    $('#school').removeClass('currentmenu')
    $('#work').addClass('currentmenu')
    $('#personal').removeClass('currentmenu')
    $('#checkid').hide()
    $('#logout').hide()
    $('#goalscontainer').show()
    $('#addgoalform').hide()
    goalCategory = "work"
    displayMyGoalList()
  else
    $('#home').removeClass('currentmenu')
    $('#school').removeClass('currentmenu')
    $('#work').removeClass('currentmenu')
    $('#personal').addClass('currentmenu')
    $('#checkid').hide()
    $('#logout').hide()
    $('#goalscontainer').show()
    $('#addgoalform').hide()
    goalCategory = "personal"
    displayMyGoalList()


$('#savegoalcancel').click ->
  $("#addgoalform").hide()


displayMyGoalList = ->
  completedHTML = []
  inprogressHTML = []
  goals = JSON.parse(localStorage["goals"])
  $.each goals, (i, goal) ->
    newinfocreated = JSON.stringify(goal.goal.infocreated)
    if (goal.goal.category is goalCategory)
      if (goal.goal.status is 'completed')
        completedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ goal.goal.icon }'></i></span>
                            <span class='goaltitle'>#{ goal.goal.goal }</span>
                            <span><i class='fa-large icon-checkmark checkmark' ></i></span>
                            <span><i class='fa-medium icon-stats chartbutton chartcompleted' ></i></span>
                          </div>
                          <div class='goallower'>
                              <div class='lowerleft'>
                                Use this goal again?<br>
                                <button type="button" class="btn btn-success btn-medium useagainbutton"><i class="fa-medium icon-checkmark" ></i>&nbsp;&nbsp;Yes</button>
                              </div>
                              <div class='lowerright'>
                                Delete this goal?<br>
                                <button type='button' class='btn btn-small btn-danger removegoal'><b>X&nbsp;&nbsp;Delete</b></button>
                              </div>
                          </div></li>"""
      else
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ goal.goal.icon }'></i></span>
                            <span class='goaltitle'>#{ goal.goal.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                              <div class='lowerleft'>
                                  Enter a number:<br>
                               <input type='number' name='info' class='info gatherinfo' />
                               <button type="button" class="btn btn-success btn-medium diditbutton"><i class="fa-medium icon-checkmark" ></i>&nbsp;&nbsp;I did it!</button>
                              </div>
                              <div class='lowerright'>
                                Delete this goal?<br>
                                <button type='button' class='btn btn-small btn-danger removegoal'><b>X&nbsp;&nbsp;Delete</b></button>
                              </div>
                          </div></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ goal.goal.icon }'></i></span>
                            <span class='goaltitle'>#{ goal.goal.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                              <div class='lowerleft'>
                               Completed?<br>
                               <button type="button" class="btn btn-success btn-medium diditbutton"><i class="fa-medium icon-checkmark" ></i>&nbsp;&nbsp;I did it!</button>
                              </div>
                              <div class='lowerright'>
                                Delete this goal?<br>
                                <button type='button' class='btn btn-small btn-danger removegoal'><b>X&nbsp;&nbsp;Delete</b></button>
                              </div>
                          </div></li>"""

  $(".goalsinprogress").html inprogressHTML.join("")
  $(".goalscompleted").html completedHTML.join("")


$(".goalscompleted").delegate ".useagainbutton", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  emailGoal = $(this).closest('li').data('goal')
  $(this).closest('li').removeClass("completed").addClass("inprogress").prop("checked", false)
  updateStatus = 'inprogress'
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      goal.goal.status = updateStatus
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
  displayMyGoalList()


$(".goalsinprogress").delegate ".diditbutton", "click", ->
  checkinginfotype = $(this).closest('li').data('info')
  if ( !$(this).closest('li').find('input[name="info"]').val() ) and (checkinginfotype is 'text')
    alert "You have to enter a number before this goal can be completed."
    $(this).removeAttr('checked');
  else
    goalguid = $(this).closest('li').data("goalguid")
    congratulations = $(this).closest('li').data("complete")
    emailGoal = $(this).closest('li').data('goal')
    mygoaldate = createInfoDate()
    newinfo = parseInt($(this).closest('li').find('input[type="number"]').val(), 10)
    nontextinfo = 1
    updateStatus = 'completed'
    incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
    $.each goals, (index, goal) ->
      if goal.goal.goalguid is goalguid
        if goal.goal.infotype is 'text'
          goal.goal.myinfo.push newinfo
          goal.goal.infocreated.push mygoaldate
        else
          goal.goal.myinfo.push nontextinfo
          goal.goal.infocreated.push mygoaldate
        goal.goal.status = updateStatus
        goal.goal.datecompleted = mygoaldate
        goalmessage = firstname + ' has completed this goal: ' + goal.goal.goal
        localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress").addClass("completed")
    emailCompletion(goalmessage)
    goalChange()
    displayMyGoalList()

$(".goalsinprogress").delegate "input[name=completedno]", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  emailGoal = $(this).closest('li').data('goal')
  mygoaldate = createInfoDate()
  newinfo = 0
  updateStatus = 'missed'
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      goal.goal.myinfo.push newinfo
      goal.goal.infocreated.push mygoaldate
      goal.goal.status = updateStatus
      goal.goal.datecompleted = mygoaldate
      goalmessage = firstname + ' has not completed this goal: ' + goal.goal.goal
      localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  $(this).find('.info').val('')
  $(this).closest('li').removeClass("inprogress completed").addClass("missed").prop("checked", false)
  emailCompletion(goalmessage)
  goalChange()
  displayMyGoalList()

###
  delete a goal
###
$(".goalsection").delegate "button", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  shouldRemove = confirm("Are you sure you want to remove this goal?")
  if !shouldRemove
    false
  else
    i = 0

    while i < goals.length
      if goals[i].goal.goalguid and goals[i].goal.goalguid is goalguid
        goals.splice i, 1
        break
      i++
    localStorage.setItem "goals", JSON.stringify(goals)
    goalChange()
    displayMyGoalList()


displayprimaryGoals = ->
  primaryGoalsHTML = []
  primarygoals = JSON.parse(localStorage["primarygoals"])
  $.each primarygoals, (index, primarygoal) ->
    if (primarygoal.primarygoal.category == goalCategory)
      primaryGoalsHTML.push """<li class='parent'  data-goalguid='#{ primarygoal.primarygoal.goalguid }' >
            <div class='goalupper'>
               <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.icon }'></i></span>
               <span class='goaltitle'>#{ primarygoal.primarygoal.goal }</span>
            </div></li>"""
      if (primarygoal.primarygoal.subA.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subA.infocreated)
        (primarygoal.primarygoal.subA.infotype == 'text')
        primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ primarygoal.primarygoal.subA.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' checked /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                          </div></li>"""
      else if (primarygoal.primarygoal.subA.status == "inprogress")
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ primarygoal.primarygoal.subA.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                               <label class='gatherinfo'>
                                 <input type='number' name='info' class='info' />&nbsp; Enter a number.
                               </label>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subA.deadline }</span>
                          </div></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ primarygoal.primarygoal.subA.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subA.deadline }</span>
                          </div></li>"""
      if (primarygoal.primarygoal.subB.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subB.infocreated)
        (primarygoal.primarygoal.subB.infotype == 'text')
        primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ primarygoal.primarygoal.subB.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' checked /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                          </div></li>"""
      else if (primarygoal.primarygoal.subB.status == "inprogress")
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ primarygoal.primarygoal.subB.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                               <label class='gatherinfo'>
                                 <input type='number' name='info' class='info' />&nbsp; Enter a number.
                               </label>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subB.deadline }</span>
                          </div></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ primarygoal.primarygoal.subB.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subB.deadline }</span>
                          </div></li>"""
      if (primarygoal.primarygoal.subC.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subC.infocreated)
        (primarygoal.primarygoal.subC.infotype == 'text')
        primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ primarygoal.primarygoal.subC.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' checked /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                          </div></li>"""
      else if (primarygoal.primarygoal.subC.status == "inprogress")
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ primarygoal.primarygoal.subC.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                               <label class='gatherinfo'>
                                 <input type='number' name='info' class='info' />&nbsp; Enter a number.
                               </label>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subC.deadline }</span>
                          </div></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ primarygoal.primarygoal.subC.completedmessage }'>
                          <div class='goalupper'>
                            <span class='goalicon'><i class='fa-medium details icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                            <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }</span>
                            <span class='thechartbutton'><i class='fa-medium icon-stats chartbutton' ></i></span>
                          </div>
                          <div class='goallower'>
                            <div class='control-group uncheckit' >
                              <label class='control-label thequestion' for='completedquestion'>Did you complete this goal?</label>
                              <div class='controls theanswer'>
                                <label class='radio'>
                                 <input type='radio' name='completedyes' value='true' /> Yes
                                </label>
                                <label class='radio'>
                                 <input type='radio' name='completedno' value='false' /> No
                                </label>
                              </div>
                            </div>
                            <span class='goaldeadline'>Deadline: #{ primarygoal.primarygoal.subC.deadline }</span>
                          </div></li>"""
    primaryGoalsHTML.push '<span class="clearfix"></span>'

  $(".primarygoals").html primaryGoalsHTML.join("")


# change the class of the li and save the data
$(".primarygoals").delegate "input[name='completedyes']", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  if ( $(this).closest('li').hasClass('completed'))
    $(this).closest('li').removeClass("completed").addClass("inprogress").prop("checked", false)
    updateStatus = 'inprogress'
    $.each primarygoals, (index, primarygoal) ->
      if primarygoal.primarygoal.subA.goalguid is goalguid
        primarygoal.primarygoal.subA.status = updateStatus
        false # break the each
      else if primarygoal.primarygoal.subB.goalguid is goalguid
        primarygoal.primarygoal.subB.status = updateStatus
        false # break the each
      else if primarygoal.primarygoal.subC.goalguid is goalguid
        primarygoal.primarygoal.subC.status = updateStatus
        false # break the each
    localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
    primarygoalChange()
    displayprimaryGoals()
  else if ( $(this).closest('li').hasClass('inprogress'))
    checkinginfotype = $(this).closest('li').data('info')
    if ( !$(this).closest('li').find('input[type="number"]').val() ) and (checkinginfotype is 'text')
      alert "You have to enter a number before this goal can be completed."
      $(this).removeAttr('checked');
    else
      newinfo = parseInt($(this).closest('li').find('input[type="number"]').val(), 10)
      mygoaldate = createInfoDate()
      updateStatus = 'completed'
      $.each primarygoals, (index, primarygoal) ->
        if primarygoal.primarygoal.subA.goalguid is goalguid
          if primarygoal.primarygoal.subA.infotype is 'text'
            primarygoal.primarygoal.subA.myinfo.push newinfo
            primarygoal.primarygoal.subA.infocreated.push mygoaldate
          primarygoal.primarygoal.subA.status = updateStatus
          primarygoal.primarygoal.subA.datecompleted = mygoaldate
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subA.goal
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
          false # break the each
        else if primarygoal.primarygoal.subB.goalguid is goalguid
          if primarygoal.primarygoal.subB.infotype is 'text'
            primarygoal.primarygoal.subB.myinfo.push newinfo
            primarygoal.primarygoal.subB.infocreated.push mygoaldate
          primarygoal.primarygoal.subB.status = updateStatus
          primarygoal.primarygoal.subB.datecompleted = mygoaldate
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subB.goal
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
          false # break the each
        else if primarygoal.primarygoal.subC.goalguid is goalguid
          if primarygoal.primarygoal.subC.infotype is 'text'
            primarygoal.primarygoal.subC.myinfo.push newinfo
            primarygoal.primarygoal.subC.infocreated.push mygoaldate
          primarygoal.primarygoal.subC.status = updateStatus
          primarygoal.primarygoal.subC.datecompleted = mygoaldate
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subC.goal
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
          false # break the each
      localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
      emailCompletion()
      $(this).find('.info').val('')
      $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
      emailCompletion(goalmessage)
      primarygoalChange()
      displayprimaryGoals()
  else
    $(this).closest('li').removeClass("missed").addClass("inprogress").prop("checked", false)
    updateStatus = 'inprogress'
    $.each primarygoals, (index, primarygoal) ->
      if primarygoal.primarygoal.subA.goalguid is goalguid
        primarygoal.primarygoal.subA.status = updateStatus
        false # break the each
      else if primarygoal.primarygoal.subB.goalguid is goalguid
        primarygoal.primarygoal.subB.status = updateStatus
        false # break the each
      else if primarygoal.primarygoal.subC.goalguid is goalguid
        primarygoal.primarygoal.subC.status = updateStatus
        false # break the each
    localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
    primarygoalChange()
    displayprimaryGoals()


$('#modalclose').click ->
  $('#adduserform').hide()
  $('#addgoalform').hide()
  $('#addprimarygoalform').hide()


###
  open and close the details div of a goal
###

$(".goalsection").on "click", "span.goaltitle", ->
  if $(this).parent().siblings('.goallower').hasClass('showdetails')
    $(this).parent().siblings('.goallower').removeClass('showdetails')
  else
    $(".goallower").removeClass('showdetails')
    $(this).parent().siblings('.goallower').addClass('showdetails')
  return false

$(".primarygoals").on "click", "span.goaltitle", ->
  if $(this).parent().siblings('.goallower').hasClass('showdetails')
    $(this).parent().siblings('.goallower').removeClass('showdetails')
  else
    $(".goallower").removeClass('showdetails')
    $(this).parent().siblings('.goallower').addClass('showdetails')
  return false


###
  let's build a chart
###

# this is for regular goals
$(".goalsection").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $(".chart-backdrop").show()
  infocreated = $(this).closest('li').data('infocreated')
  myinfo = $(this).closest('li').data('myinfo')
  mytitle = $(this).closest('li').data('goal')
  $ ->
  $("#thischart").highcharts
    chart: {}

    title:
      text: mytitle

    legend:
      enabled: false

    xAxis:
      categories: infocreated

    series: [data: myinfo   ]

# this is for primary goals
$(".primarygoals").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $(".chart-backdrop").show()
  infocreated = $(this).closest('li').data('infocreated')
  myinfo = $(this).closest('li').data('myinfo')
  mytitle = $(this).closest('li').data('goal')
  $ ->
  $("#thischart").highcharts
    chart: {}

    title:
      text: mytitle

    legend:
      enabled: false

    xAxis:
      categories: infocreated

    series: [data: myinfo   ]


$('.hidechart').click ->
  $("#chartbox").hide()
  $("#incentivebox").hide()
  $(".chart-backdrop").hide()


###
  after a goal is completed, or changed in any way, then update it and email the teacher
###

# show the congrats message
showCongrats = ->
  $("#incentivebox").css('top', -90)
  $("#incentivebox").css('right', 430)
  placeincentivetext =  '<p>' + congratulations + '</p>'
  $("#incentivetext").html(placeincentivetext)
  $("#incentivepic").css('background-image', incentivepic )
  $("#incentivebox").fadeIn "slow"
  setTimeout "$('#incentivebox').hide();", 5000

# show the email about a goal completion
emailCompletion = ->
  postThis = {}
  postThis.notify = localStorage.getItem("notify")
  postThis.goalmessage = localStorage.getItem("goalmessage")
  console.log goalmessage
  $.ajax
    url: "goalNotify.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log "Yay, the email notify worked!"
    error: (jqXHR, textStatus, errorThrown) ->
      console.log "Didn't work so good..."

goalChange = ->
  postThis = {}
  postThis.goals = localStorage.getItem("goals")
  username = localStorage.getItem('username');
  postThis.userid = username
  $.ajax
    url: "goalChange.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the goalChange save worked!")
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("GoalChange save didn't work so good...")

primarygoalChange = ->
  postThis = {}
  postThis.primarygoals = localStorage.getItem("primarygoals")
  username = localStorage.getItem('username');
  postThis.userid = username
  $.ajax
    url: "primarygoalChange.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the primaryGoal save worked!")
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("PrimaryGoal save didn't work so good...")