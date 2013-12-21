###global console ###

showUserList = ''
username = ''
userguid = ''
goalTitle = ''
showThatGoalList = ''
deadline = ''
infocreated = []
myinfo = []
newcreated = ''
mygoaldate = ''
chart1 = ''
incentivepic = ''
incentivetext = ''
placeincentivetext = ''
alertmessage = ''
checkinginfotype = ''
mytitle = ''
data = []
datecreated = ''
dataDate = ''
getDate = (d) ->
  new Date(d.createdDate)
currentDate = ''
firstname = ''
notify = ''
goal = ''
emailGoal = ''
updateStatus = ''
updateGoal = ''
index = ''
goalguid = ''
goalinfo = []
newinfo = ''
goalCategory = 'school'
goalType = 'solo'
daysOfWeek = []
daysOfWeekA = []
daysOfWeekB = []
daysOfWeekC = []
goals = []
primarygoals = []
newinfocreated = ''
newgoal = {}

users =
  "0c7270bd-38e8-4db2-ae92-244de019c543":
    datecreated: "2013-10-15"
    email: "jimmy@example.com"
    firstname: "Jimmy"
    lastname: "Smith"
    username: "jimmysmith"
    password: "foobar"
    notify: "barbour@4j.lane.edu"

  "0c7270bd-38e8-4db2-ae92-244de019mju7":
    datecreated: "2013-10-16"
    email: "mary@example.com"
    firstname: "Mary"
    lastname: "Jones"
    username: "maryjones"
    password: "foobar2"
    notify: "barbour@4j.lane.edu"


###
  this checks localStorage for data. If none, use the arrays above.
###
init = ->
#  password = prompt("What is your password?")
#  if password is "JoshBCog"
  if localStorage.getItem("users") is null
    localStorage.setItem "users", JSON.stringify(users)
  if localStorage.getItem("goals") is null
    localStorage.setItem "goals", JSON.stringify(goals)
  if localStorage.getItem("primarygoals") is null
    localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  displayUserList()


# loading the json file and showing the goals
initMine = ->
  username = prompt("What is your username?")
  $.getJSON (username + "primary.json"), (data) ->
    localStorage.setItem "primarygoals", JSON.stringify(data)
  $.getJSON (username + ".json"), (data) ->
    localStorage.setItem "goals", JSON.stringify(data)
    $("#goalcontent").show()
    $("#addgoal").show()
    displayMyGoalList()

###
 this function displays the list of users with a bit of fade for visual interest
###
displayUserList = ->
  newHTML = []
  $.each users, (index, user) ->
    newHTML.push '<li data-username="' + user.username + '" data-userguid="' + index + '" data-notify="' + user.notify + '" data-firstname="' + user.firstname + '"><span class="userfullname">' + user.firstname + ' ' + user.lastname + '</span><span><button type="button" class="btn btn-mini btn-danger pull-right removeuser" data-removeguid="' + index + '"><b>X</b> </button></span></li>'

  $(".users").css(
    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)"
    "-moz-opacity": 1
    "-khtml-opacity": 1
    opacity: 1
    visibility: "hidden"
  ).fadeOut 0, ->
    $(".users").html newHTML.join("")
    $(".users").css(visibility: "visible").fadeIn(200)


$('#adduser').click ->
  $("#addgoalform").hide()
  $("#addprimarygoalform").hide()
  $("#adduserform").show()

###
  create a user guid
###
createGuid = ->
  "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = (if c is "x" then r else (r & 0x3 | 0x8))
    v.toString 16

###
  create a date for the goal info input
###
createInfoDate = ->
  currentDate = new Date()
  newcreated = currentDate.getDate() + "/" + currentDate.getMonth()
###
 this creates an array of UserGoals that is empty, adds the User to the usersArray, resaves the usersArray with the new info, then clears the form
###
$('#saveuser').click ->
  datecreated = new Date().toString()
  userguid = createGuid()
  localStorage.setItem userguid + "Goals", ""
  users[userguid] = {
    firstname: $('#thefirstname').val(),
    lastname: $('#thelastname').val(),
    email: $('#theemail').val(),
    password: $('#thepassword').val(),
    datecreated: datecreated,
    username: $('#theusername').val(),
    userguid: userguid,
    notify: $('#thenotifications').val(),
  }
  localStorage.setItem "users", JSON.stringify(users)
  $("#adduserform").hide()
  $('.textempty').val('')
  logSummary()
  displayUserList()

$('#addgoal').click ->
  $("#addgoalform").show()
  $("#adduser").show()
  $("#adduserform").hide()
  $("#addprimarygoalform").hide()

$('#addprimarygoal').click ->
  $("#addprimarygoalform").show()
  $("#addgoalform").hide()
  $("#adduser").show()
  $("#adduserform").hide()

$('.sologoal').click ->
  $('#addprimarygoal').hide()
  $('#addgoal').show()

$('.primarygoal').click ->
  $('#addprimarygoal').show()
  $('#addgoal').hide()


###
this adds a goal to the goalsArray, resaves the goalsArray with the new info, resaves the usersGoals to localstorage, then clears the form
###
$('#savegoal').click ->
  datecreated = new Date().toString()
  mygoaldate = createInfoDate()
  goalguid = createGuid()
  daysOfWeek = $("input[name=days]:checked").map(->
    $(this).val()
  ).get()
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
      recurring: daysOfWeek
      completedmessage: $("#thecomplete").val()
      deadline: $("#thedeadline").val()
      incentivepic: $("input[name=incentivepic]:checked").val()
      incentivetext: $("#theincentivetext").val()
      userguid: userguid
  goals.push(newgoal)
  localStorage.setItem "goals", JSON.stringify(goals)
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked');
  goalChange()
  displayMyGoalList()

###
this adds a goal to the goalsArray, resaves the goalsArray with the new info, resaves the usersGoals to localstorage, then clears the form
###
$('#saveprimarygoal').click ->
  datecreated = new Date().toString()
  goalguid = createGuid()
  daysOfWeekA = $("#daysoftheweekA input[name=days]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekB = $("#daysoftheweekB input[name=days]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekC = $("#daysoftheweekC input[name=days]:checked").map(->
    $(this).val()
  ).get()
  primarygoals[goalguid] =
    category: $("#thecategory").val().toLowerCase()
    datecreated: datecreated
    goal: $("#theprimarygoal").val()
    icon: $("input[name=icon]:checked").val()
    status: "inprogress"
    username: username
    userguid: userguid
    subA:
      goal: $("#thegoalA").val()
      icon: $("#theiconsA input[name=iconA]:checked").val()
      status: "inprogress"
      infotype: $("#infotypeA input[name=theinfotypeA]:checked").val()
      recurring: daysOfWeekA
      completedmessage: $("#thecompleteA").val()
      deadline: $("#thedeadlineA").val()
    subB:
      goal: $("#thegoalB").val()
      icon: $("#theiconsB input[name=iconB]:checked").val()
      status: "inprogress"
      infotype: $("#infotypeB input[name=theinfotype]:checked").val()
      recurring: daysOfWeekB
      completedmessage: $("#thecompleteB").val()
      deadline: $("#thedeadlineB").val()
    subC:
      goal: $("#thegoalC").val()
      icon: $("#theiconsC input[name=iconC]:checked").val()
      status: "inprogress"
      infotype: $("#infotypeC input[name=theinfotype]:checked").val()
      recurring: daysOfWeekC
      completedmessage: $("#thecompleteC").val()
      deadline: $("#thedeadlineC").val()
  localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  goals = JSON.parse(localStorage["goals"])
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked');
  logSummary()
  displayprimaryGoals()


###
this uses delegate because the lines of info are dynamically placed and won't respond to a simple click. It highlights the clicked User and displays his goals
###
$(".users").delegate "li", "click", ->
  goals = JSON.parse(localStorage["goals"])
  $(this).addClass("active").siblings("li").removeClass "active"
  if (goalType == 'solo')
    $("#goalcontent").show()
    $('#primarygoalcontent').hide()
  else
    $("#goalcontent").hide()
    $('#primarygoalcontent').show()
  $("#adduser").show()
  $("#addgoalform").hide()
  $("#adduserform").hide()
  $("#school").addClass('active')
  userguid = $(this).data("userguid")
  username = $(this).data("username")
  firstname = $(this).data('firstname')
  notify = $(this).data('notify')
  if (goalType == 'solo')
    $("#addgoal").show()
    displayMyGoalList()
  else
    $("#addprimarygoal").show()
    displayprimaryGoals()

$(".category").click ->
  goalCategory = $(this).data("category")
  displayMyGoalList()

displayMyGoalList = ->
  completedHTML = []
  inprogressHTML = []
  missedHTML = []
  goals = JSON.parse(localStorage["goals"])
  $.each goals, (i, goal) ->
    newinfocreated = JSON.stringify(goal.goal.infocreated)
    if (goal.goal.category is goalCategory)
      if (goal.goal.status is 'completed')
        completedHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goal.goal }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' ><input type='checkbox' checked/></span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else if (goal.goal.status is "inprogress")
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals.goal }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals.goal }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span></li>"""
      else
        if (goal.goal.infotype is 'text')
          missedHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals.goal }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          missedHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals.goal }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }'><input type='checkbox' /></span></li>"""

  $(".goalsinprogress").html inprogressHTML.join("")
  $(".goalscompleted").html completedHTML.join("")
  $(".goalsmissed").html missedHTML.join("")
  $(".goalsection").css(visibility: "visible").fadeIn(200)

$(".goalscompleted").delegate "input[type=checkbox]", "click", ->
  goalguid = $(this).parent().parent().data("goalguid")
  emailGoal = $(this).parent().data('goal')
  $(this).parent().parent().removeClass("completed").addClass("inprogress").prop("checked", false)
  updateStatus = 'inprogress'
  $.each goals, (index, goal) ->
    if index is goalguid
      goal.status = updateStatus
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  logSummary()
  displayMyGoalList()

$(".goalsinprogress").delegate "input[type=checkbox]", "click", ->
  checkinginfotype = $(this).closest('li').data('info')
  console.log(checkinginfotype)
  if ( !$(this).closest('li').find('input[type="text"]').val() ) and (checkinginfotype is 'text')
    alert "You have to enter a number before this goal can be completed."
    $(this).removeAttr('checked');
  else
    goalguid = $(this).closest('li').data("goalguid")
    alertmessage = $(this).parent().data("complete")
    console.log(goalguid)
    emailGoal = $(this).parent().data('goal')
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10)
    mygoaldate = createInfoDate()
    updateStatus = 'completed'
    $.each goals, (index, goal) ->
      if index is goalguid
        if goal.infotype is 'text'
          goal.myinfo.push newinfo
          goal.infocreated.push mygoaldate
        goal.status = updateStatus
        goal.datecompleted = mygoaldate
        alert(alertmessage)
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    logSummary()
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
    displayMyGoalList()

$(".goalsmissed").delegate "input[type=checkbox]", "click", ->
  goalguid = $(this).parent().parent().data("goalguid")
  emailGoal = $(this).parent().data('goal')
  $(this).parent().parent().removeClass("missed").addClass("inprogress").prop("checked", false)
  updateStatus = 'inprogress'
  $.each goals, (index, goal) ->
    if index is goalguid
      goal.status = updateStatus
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  logSummary()
  displayMyGoalList()

$(".primarygoal").click ->
  $('#goalcontent').hide()
  $('#primarygoalcontent').show()
  goalType = 'primary'
  displayprimaryGoals()

$(".sologoal").click ->
  $('#goalcontent').show()
  $('#primarygoalcontent').hide()
  goalType = 'solo'
  displayMyGoalList()


displayprimaryGoals = ->
  primaryGoalsHTML = []
  primarygoals = JSON.parse(localStorage["primarygoals"])
  console.log primarygoals
  $.each primarygoals, (index, primarygoal) ->
    if (primarygoal.primarygoal.category == goalCategory)
      primaryGoalsHTML.push """<li class='parent' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'">
            <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.icon }'></i>#{ primarygoal.primarygoal.goal }</span>
            <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ primarygoal.primarygoal.goalguid }'><b>X</b> </button></span></li>"""
      if (primarygoal.primarygoal.subA.status == 'completed')
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox' checked></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox' checked></span></li>"""
      else if (primarygoal.primarygoal.subA.status == "inprogress")
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoA' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subB.status == 'completed')
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox' checked></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox' checked></span></li>"""
      else if (primarygoal.primarygoal.subB.status == "inprogress")
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subC.status == 'completed')
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox' checked></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox' checked></span></li>"""
      else if (primarygoal.primarygoal.subC.status == "inprogress")
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-userguid='#{ primarygoal.primarygoal.userguid }' data-goalguid='#{ index }'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox'/></span></li>"""
      primaryGoalsHTML.push '<span class="clearfix"></span>'


  $(".primarygoals").css(
    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)"
    "-moz-opacity": 1
    "-khtml-opacity": 1
    opacity: 1
    visibility: "hidden"
  ).fadeOut 0, ->
    $(".primarygoals").html primaryGoalsHTML.join("")
    $(".primarygoals").css(visibility: "visible").fadeIn(200)


###
find and remove user function
###
$('.users').delegate "button", "click", ->
  userguid = $(this).data("removeguid")
  shouldRemove = confirm("Are you sure you want to remove this student?")
  if shouldRemove
    findAndRemove()
  else
    false

findAndRemove = ->
  delete users[userguid]
  localStorage.setItem "users", JSON.stringify(users)
  localStorage.removeItem(userguid + "Goals")
  $('.goals').empty()
  logSummary()
  displayUserList()
  findAndRemoveUserGoals(goals, 'userguid', userguid)

###
find and remove users goals when user is removed
###
findAndRemoveUserGoals = (array, property, value) ->
  $.each array, (index, result) ->
    #Remove from array
    array.splice index, 1  if result[property] is value
    localStorage.setItem "goals", JSON.stringify(goals)
    logSummary()

###
  delete a goal from the list
###
$(".goalsection").delegate "button", "click", ->
  goalguid = $(this).data("removegoal")
  shouldRemove = confirm("Are you sure you want to remove this goal?")
  if !shouldRemove
    false
  else
    delete goals[goalguid]
    localStorage.setItem "goals", JSON.stringify(goals)
    logSummary()
    displayMyGoalList()


$('#therecurring').click ->
  $('#daysoftheweek').toggle(this.checked)

$('#therecurringA').click ->
  $('#daysoftheweekA').toggle(this.checked)

$('#therecurringB').click ->
  $('#daysoftheweekB').toggle(this.checked)

$('#therecurringC').click ->
  $('#daysoftheweekC').toggle(this.checked)

$('#teethclick').click ->
  $('#teethchart').show()

$('#readingclick').click ->
  $('#readingchart').show()

$('#modalclose').click ->
  $('#adduserform').hide()
  $('#addgoalform').hide()
  $('#addprimarygoalform').hide()


$('.listheadercategory').click ->
  $('ul.goals>li').tsort('span.goalcategory',{order:'asc'})

$('.ascending').click ->
  $('ul.users>li').tsort('span.userfullname', {order:'asc'})
$('.descending').click ->
  $('ul.users>li').tsort('span.userfullname', {order:'desc'})

###
  let's build a chart
###

$(".goalscompleted").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $("#incentivebox").show()
  $(".chart-backdrop").show()
  incentivetext = $(this).data('incentivetext')
  incentivepic = 'url("' + $(this).data('incentivepic') + '")'
  console.log(incentivepic + '  supposed to be incentivepic')
  placeincentivetext =  '<p>' + incentivetext + '</p>'
  $("#incentivetext").html(placeincentivetext)
  $("#incentivepic").css('background-image', incentivepic )
  infocreated = $(this).data('infocreated')
  myinfo = $(this).data('myinfo')
  mytitle = $(this).data('goal')
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
  let's log it
###
logSummary = ->

  # Copy local-storage into variable.
  key = undefined
  postThis = {}
  i = 0
  len = localStorage.length

  while i < len
    key = localStorage.key(i)
    postThis[key] = "" + localStorage.getItem(key)
    i++

  # Use ajax to ask PHP to save this to a logfile
  $.ajax
    url: "logSummary.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Hooray, it worked!");
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Didn't work so good...");

goalChange = ->
  # Copy local-storage into variable.
  key = undefined
  postThis = {}
  i = 0
  len = localStorage.length

  while i < len
    key = localStorage.key(i)
    postThis[key] = "" + localStorage.getItem(key)
    i++

  postThis.goals = localStorage.getItem("goals")
  # Use ajax to ask PHP to save this to a logfile
  postThis.userid = username
  $.ajax
    url: "goalChange.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the save worked!");
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Didn't work so good...");