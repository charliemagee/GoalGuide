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
congratulations = ''
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
users = []
goals = []
primarygoals = []
newinfocreated = ''
newgoal = {}
newprimarygoal = {}
goalmessage = ''

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
  updateStatus = "inprogress"
  $.each goals, (i, goal) ->
    dateString = "\"" + goal.goal.recurring + "\""
    goal.goal.status = updateStatus  if (goal.goal.status = "completed") and (dateString.search(dayToday) isnt -1)
  localStorage.setItem "goals", JSON.stringify(goals)
  goalChange()
  displayMyGoalList()


###
  create a guid
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
 this function displays the list of users with a bit of fade for visual interest
###
displayUserList = ->
  users = JSON.parse(localStorage["users"])
  newHTML = []
  $.each users, (index, user) ->
    newHTML.push """<li data-username='#{ user.username }' data-notify='#{ user.notify }'>
          <span class='username'>#{ user.username }</span>
          <span class='userfullname'>#{ user.firstname } #{ user.lastname }</span>
          <span class='password'>#{ user.password }</span>
          <span class='notifications'>#{ user.notify }</span>
          <span><button type="button" class="btn btn-mini btn-danger pull-right removeuser"><b>X</b> </button></span></li>"""
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
 this creates an array of UserGoals that is empty, adds the User to the usersArray, resaves the usersArray with the new info, then clears the form
###
$('#saveuser').click ->
  datecreated = new Date().toString()
  username = $('#theusername').val()
  localStorage.setItem("username", username)
  user = {
    username: $('#theusername').val(),
    firstname: $('#thefirstname').val(),
    lastname: $('#thelastname').val(),
    password: $('#thepassword').val(),
    notify: $('#thenotifications').val()
  }
  users = JSON.parse(localStorage["users"])
  users.push(user)
  localStorage.setItem "users", JSON.stringify(users)
  makeNewUser()
  displayUserList()

makeSampleGoals = ->
  mygoaldate = createInfoDate()
  newgoal =
    goal:
      goalguid: createGuid()
      category: 'school'
      datecreated: datecreated
      goal: 'This is a Blank Goal.'
      icon: 'gift'
      status: "inprogress"
      infotype: ''
      infocreated: []
      myinfo: []
      recurring: ''
      completedmessage: 'Yay! You completed the Blank Goal.'
      deadline: ''
      incentivepic: ''
      incentivetext: ''
      username: username
  goals.push(newgoal)
  localStorage.setItem "goals", JSON.stringify(goals)
  newprimarygoal =
    primarygoal:
      goalguid: createGuid()
      category: 'school'
      datecreated: datecreated
      goal: 'This is a blank Primary Goal.'
      icon: 'gift'
      status: "inprogress"
      username: username
      subA:
        goalguid: createGuid()
        goal: 'This is the First SubGoal'
        icon: 'alarm'
        status: "inprogress"
        infotype: ''
        recurring: ''
        completedmessage: 'Yay! You completed the blank First Sub Goal.'
        deadline: ''
      subB:
        goalguid: createGuid()
        goal: 'This is the Second SubGoal'
        icon: 'umbrella'
        status: "inprogress"
        infotype: ''
        recurring: ''
        completedmessage: 'Yay! You completed the blank Second Sub Goal.'
        deadline: ''
      subC:
        goalguid: createGuid()
        goal: 'This is the Third SubGoal'
        icon: 'silverware'
        status: "inprogress"
        infotype: ''
        recurring: ''
        completedmessage: 'Yay! You completed the blank Third Sub Goal.'
        deadline: ''
  primarygoals.push(newprimarygoal)
  localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  $("#adduserform").hide()
  $('.textempty').val('')
  goalChange()
  primarygoalChange()

###
this uses delegate because the lines of info are dynamically placed and won't respond to a simple click. It highlights the clicked User and displays his goals
###
$(".users").delegate "li > span.username", "click", ->
  username = $(this).closest('li').data("username")
  localStorage.setItem("username", username)
  document.location.href='goals.php'
  $(".goalsection").html('')
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
  newprimarygoal =
    primarygoal:
      goalguid: createGuid()
      category: $("#theprimarycategory").val().toLowerCase()
      datecreated: datecreated
      goal: $("#theprimarygoal").val()
      icon: $("input[name=icon]:checked").val()
      status: "inprogress"
      username: username
      subA:
        goalguid: createGuid()
        goal: $("#thegoalA").val()
        icon: $("#theiconsA input[name=iconA]:checked").val()
        status: "inprogress"
        infotype: $("#infotypeA input[name=theinfotypeA]:checked").val()
        recurring: daysOfWeekA
        completedmessage: $("#thecompleteA").val()
        deadline: $("#thedeadlineA").val()
      subB:
        goalguid: createGuid()
        goal: $("#thegoalB").val()
        icon: $("#theiconsB input[name=iconB]:checked").val()
        status: "inprogress"
        infotype: $("#infotypeB input[name=theinfotype]:checked").val()
        recurring: daysOfWeekB
        completedmessage: $("#thecompleteB").val()
        deadline: $("#thedeadlineB").val()
      subC:
        goalguid: createGuid()
        goal: $("#thegoalC").val()
        icon: $("#theiconsC input[name=iconC]:checked").val()
        status: "inprogress"
        infotype: $("#infotypeC input[name=theinfotype]:checked").val()
        recurring: daysOfWeekC
        completedmessage: $("#thecompleteC").val()
        deadline: $("#thedeadlineC").val()
  primarygoals.push(newprimarygoal)
  localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked')
  primarygoalChange()
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
#    this next chunk of lines is to convert a js Date to match the html5 datepicker date, then compare to see if deadline is missed
    now = new Date()
    year = now.getFullYear()
    month = now.getMonth()+1
    if month <= 9 then month = '0' + month
    day = now.getDate()
    if day <= 9 then day = '0' + day
    compareDate = year + '-' + month + '-' + day
    if (goal.goal.category is goalCategory)
      if (goal.goal.deadline) and (goal.goal.status is 'inprogress') and (goal.goal.deadline < compareDate)
        goal.goal.status = 'missed'
      if (goal.goal.status is 'completed')
        completedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' ><input type='checkbox' checked/></span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else if (goal.goal.status is "inprogress")
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' >
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
    congratulations = $(this).parent().data("complete")
    emailGoal = $(this).parent().data('goal')
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10)
    mygoaldate = createInfoDate()
    updateStatus = 'completed'
    incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
    console.log incentivepic
    $.each goals, (index, goal) ->
      if goal.goal.goalguid is goalguid
        if goal.goal.infotype is 'text'
          goal.goal.myinfo.push newinfo
          goal.goal.infocreated.push mygoaldate
        goal.goal.status = updateStatus
        goal.goal.datecompleted = mygoaldate
        goalmessage = ' has completed this goal: ' + goal.goal.goal
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
    showCongrats()
    emailCompletion(goalmessage)
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
      primaryGoalsHTML.push """<li class='parent'  data-goalguid='#{ primarygoal.primarygoal.goalguid }' >
            <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.icon }'></i>#{ primarygoal.primarygoal.goal }</span>
            <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ primarygoal.primarygoal.goalguid }'><b>X</b> </button></span></li>"""
      if (primarygoal.primarygoal.subA.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subA.infocreated)
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subA.status == "inprogress")
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoA' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subB.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subB.infocreated)
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subB.status == "inprogress")
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subC.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subC.infocreated)
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox' checked></span>
                        <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subC.status == "inprogress")
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
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


# change the class of the li and save the data
$(".primarygoals").delegate "input[type=checkbox]", "click", ->
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
    if ( !$(this).closest('li').find('input[type="text"]').val() ) and (checkinginfotype is 'text')
      alert "You have to enter a number before this goal can be completed."
      $(this).removeAttr('checked');
    else
      newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10)
      mygoaldate = createInfoDate()
      updateStatus = 'completed'
      $.each primarygoals, (index, primarygoal) ->
        if primarygoal.primarygoal.subA.goalguid is goalguid
          if primarygoal.primarygoal.subA.infotype is 'text'
            primarygoal.primarygoal.subA.myinfo.push newinfo
            primarygoal.primarygoal.subA.infocreated.push mygoaldate
          primarygoal.primarygoal.subA.status = updateStatus
          primarygoal.primarygoal.subA.datecompleted = mygoaldate
          goalmessage = ' has completed this goal: ' + primarygoal.primarygoal.subA.goal
          false # break the each
        else if primarygoal.primarygoal.subB.goalguid is goalguid
          if primarygoal.primarygoal.subB.infotype is 'text'
            primarygoal.primarygoal.subB.myinfo.push newinfo
            primarygoal.primarygoal.subB.infocreated.push mygoaldate
          primarygoal.primarygoal.subB.status = updateStatus
          primarygoal.primarygoal.subB.datecompleted = mygoaldate
          goalmessage = ' has completed this goal: ' + primarygoal.primarygoal.subB.goal
          false # break the each
        else if primarygoal.primarygoal.subC.goalguid is goalguid
          if primarygoal.primarygoal.subC.infotype is 'text'
            primarygoal.primarygoal.subC.myinfo.push newinfo
            primarygoal.primarygoal.subC.infocreated.push mygoaldate
          primarygoal.primarygoal.subC.status = updateStatus
          primarygoal.primarygoal.subC.datecompleted = mygoaldate
          goalmessage = ' has completed this goal: ' + primarygoal.primarygoal.subC.goal
          false # break the each
      localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
      emailCompletion()
      $(this).find('.info').val('')
      $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
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

###
find and remove user function
###
$('.users').delegate "button.removeuser", "click", ->
  username = $(this).closest('li').data("username")
  shouldRemove = confirm("Are you sure you want to remove this student?")
  if !shouldRemove
    false
  else
    i = 0

    while i < users.length
      if users[i].username is username
        users.splice i, 1
        break
      i++
    localStorage.setItem "users", JSON.stringify(users)
    localStorage.removeItem("user")
    localStorage.removeItem("goals")
    localStorage.removeItem("primarygoals")
    displayUserList()

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
# this is for regular goals
$(".goalscompleted").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $("#incentivebox").css('top', -10)
  $("#incentivebox").css('right', 25)
  $("#incentivebox").show()
  $(".chart-backdrop").show()
  incentivetext = $(this).closest('li').data('incentivetext')
  incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
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

# this is for primary goals
$(".primarygoals").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $("#incentivebox").css('top', -10)
  $("#incentivebox").css('right', 25)
  $("#incentivebox").show()
  $(".chart-backdrop").show()
  incentivetext = $(this).closest('li').data('incentivetext')
  incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
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


# show the congrats message
showCongrats = ->
  $("#incentivebox").css('top', -90)
  $("#incentivebox").css('right', 430)
  placeincentivetext =  '<p>' + congratulations + '</p>'
  $("#incentivetext").html(placeincentivetext)
  $("#incentivepic").css('background-image', incentivepic )
  $("#incentivebox").fadeIn "slow"
  setTimeout "$('#incentivebox').hide();", 5000

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

emailCompletion = ->
  username = localStorage.getItem('username')
  notify = localStorage.getItem('notify')
  console.log username + goalmessage + ' has been sent to ' + notify

makeNewUser = ->
  postThis = {}

  # Use ajax to ask PHP to save this to a logfile
  postThis.username = localStorage.getItem("username")
  username = localStorage.getItem('username');
  postThis.userid = username
  $.ajax
    url: "newUser.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the save worked!");
      makeSampleGoals()
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Didn't work so good...");

goalChange = ->
  postThis = {}

  # Use ajax to ask PHP to save this to a logfile
  postThis.goals = localStorage.getItem("goals")
  username = localStorage.getItem('username');
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
  postThis = {}

  # Use ajax to ask PHP to save this to a logfile
  postThis.primarygoals = localStorage.getItem("primarygoals")
  username = localStorage.getItem('username');
  postThis.userid = username
  $.ajax
    url: "primarygoalChange.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the save worked!");
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Didn't work so good...");