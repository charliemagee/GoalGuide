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
dayToday = ''
currentDate = ''
setDate = ''
futureDate = ''
currentDay = ''
dateString = ''
future = ''
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

###
  this checks localStorage for data. If none, use the arrays above.
###
init = ->
#  password = prompt("What is your password?")
#  if password is "JoshBCog"
  $.getJSON ("users.json"), (data) ->
    localStorage.setItem "users", JSON.stringify(data)
    displayUserList()


# check once a day for recurring goals
resetCompleted = ->
  goals = JSON.parse(localStorage["goals"])
  dayToday = createDayToday()
  updateStatus = 'inprogress'
  $.each goals, (i, goal) ->
    dateString = '"' + (goal.goal.recurring) + '"'
    if (goal.goal.status = 'completed') && (dateString.search(dayToday) != -1)
      goal.goal.status = updateStatus
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
  displayMyGoalList()

###
 this function displays the list of users with a bit of fade for visual interest
###
displayUserList = ->
  users = JSON.parse(localStorage["users"])
  newHTML = []
  $.each users, (index, user) ->
    newHTML.push """<li data-username='#{ user.user.username }' data-userguid='#{ user.user.userguid }' data-notify='#{ user.user.notify }' data-firstname='#{ user.user.firstname }'><span class='userfullname'>#{ user.user.firstname } #{ user.user.lastname }</span><span><button type="button" class="btn btn-mini btn-danger pull-right removeuser"><b>X</b> </button></span></li>"""

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
  $('.primarycategory').hide()
  $('.category').show()
  $('#addprimarygoal').hide()
  $('#addgoal').show()

$('.primarygoal').click ->
  $('.primarycategory').show()
  $('.category').hide()
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
      username: username
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
  newgoal =
    primarygoal:
      category: $("#theprimarycategory").val().toLowerCase()
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
  primarygoals.push(newgoal)
  localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked');
  primarygoalChange()
  displayprimaryGoals()


###
this uses delegate because the lines of info are dynamically placed and won't respond to a simple click. It highlights the clicked User and displays his goals
###
$(".users").delegate "li", "click", ->
  $(".goalsection").html('')
  username = $(this).closest('li').data("username")
  $.getJSON (username + "primary.json"), (data) ->
    localStorage.setItem "primarygoals", JSON.stringify(data)
  $.getJSON (username + ".json"), (data) ->
    localStorage.setItem "goals", JSON.stringify(data)
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
  userguid = $(this).closest('li').data("userguid")
  firstname = $(this).closest('li').data('firstname')
  notify = $(this).closest('li').data('notify')
  if (goalType == 'solo')
    $("#addgoal").show()
    displayMyGoalList()
  else
    $("#addprimarygoal").show()
    displayprimaryGoals()

$(".category").click ->
  goalCategory = $(this).data("category")
  displayMyGoalList()

$(".primarycategory").click ->
  goalCategory = $(this).data("category")
  displayprimaryGoals()

displayMyGoalList = ->
  completedHTML = []
  inprogressHTML = []
  missedHTML = []
  goals = JSON.parse(localStorage["goals"])
  $.each goals, (i, goal) ->
    newinfocreated = JSON.stringify(goal.goal.infocreated)
    if (goal.goal.category is goalCategory)
      if (goal.goal.status is 'completed')
        completedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' ><input type='checkbox' checked/></span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else if (goal.goal.status is "inprogress")
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span></li>"""
      else
        if (goal.goal.infotype is 'text')
          missedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          missedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }'><input type='checkbox' /></span></li>"""

  $(".goalsinprogress").html inprogressHTML.join("")
  $(".goalscompleted").html completedHTML.join("")
  $(".goalsmissed").html missedHTML.join("")
  $(".goalsection").css(visibility: "visible").fadeIn(200)

$(".goalscompleted").delegate "input[type=checkbox]", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  emailGoal = $(this).parent().data('goal')
  $(this).closest('li').removeClass("completed").addClass("inprogress").prop("checked", false)
  updateStatus = 'inprogress'
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      goal.goal.status = updateStatus
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
  displayMyGoalList()

$(".goalsinprogress").delegate "input[type=checkbox]", "click", ->
  checkinginfotype = $(this).closest('li').data('info')
  if ( !$(this).closest('li').find('input[type="text"]').val() ) and (checkinginfotype is 'text')
    alert "You have to enter a number before this goal can be completed."
    $(this).removeAttr('checked');
  else
    goalguid = $(this).closest('li').data("goalguid")
    alertmessage = $(this).parent().data("complete")
    emailGoal = $(this).parent().data('goal')
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10)
    mygoaldate = createInfoDate()
    updateStatus = 'completed'
    $.each goals, (index, goal) ->
      if goal.goal.goalguid is goalguid
        if goal.goal.infotype is 'text'
          goal.goal.myinfo.push newinfo
          goal.goal.infocreated.push mygoaldate
        goal.goal.status = updateStatus
        goal.goal.datecompleted = mygoaldate
        alert(alertmessage)
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    logSummary()
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
    goalChange()
    displayMyGoalList()


$(".goalsmissed").delegate "input[type=checkbox]", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  emailGoal = $(this).parent().data('goal')
  $(this).closest('li').removeClass("missed").addClass("inprogress").prop("checked", false)
  updateStatus = 'inprogress'
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      goal.goal.status = updateStatus
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
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


$('#therecurring').click ->
  $('#daysoftheweek').toggle(this.checked)

$('#therecurringA').click ->
  $('#daysoftheweekA').toggle(this.checked)

$('#therecurringB').click ->
  $('#daysoftheweekB').toggle(this.checked)

$('#therecurringC').click ->
  $('#daysoftheweekC').toggle(this.checked)

$('#modalclose').click ->
  $('#adduserform').hide()
  $('#addgoalform').hide()
  $('#addprimarygoalform').hide()


###
  let's build a chart
###

$(".goalscompleted").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $("#incentivebox").show()
  $(".chart-backdrop").show()
  incentivetext = $(this).data('incentivetext')
  incentivepic = 'url("' + $(this).data('incentivepic') + '")'
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
#  key = undefined
  postThis = {}
#  i = 0
#  len = localStorage.length
#
#  while i < len
#    key = localStorage.key(i)
#    postThis[key] = "" + localStorage.getItem(key)
#    i++

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

primarygoalChange = ->
  # Copy local-storage into variable.
#  key = undefined
  postThis = {}
  #  i = 0
  #  len = localStorage.length
  #
  #  while i < len
  #    key = localStorage.key(i)
  #    postThis[key] = "" + localStorage.getItem(key)
  #    i++

  postThis.primarygoals = localStorage.getItem("primarygoals")
  # Use ajax to ask PHP to save this to a logfile
  postThis.userid = username
  $.ajax
    url: "primarygoalChange.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the save worked!");
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Didn't work so good...");