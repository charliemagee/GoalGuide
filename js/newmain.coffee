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
users = []
goals = []
primarygoals = []
newinfocreated = ''
newgoal = {}
newprimarygoal = {}
user = {}
goalmessage = ''
saywhat = ''

initStudentPage = ->
  localStorage.removeItem('firstname')
  localStorage.removeItem('goals')
  localStorage.removeItem('goalmessage')
  localStorage.removeItem('notify')
  localStorage.removeItem('primarygoals')
  localStorage.removeItem('secret')
  localStorage.removeItem('username')
  localStorage.removeItem('users')
  if localStorage.getItem('beenhere') is 'donethat'
    $.getJSON ("userlist.json"), (data) ->
      localStorage.setItem "users", JSON.stringify(data)
      localStorage.setItem "beenhere", "donethat"
      saywhat = localStorage.getItem('beenhere')
      displayUserList()
  else
    password = prompt("What is your password?")
    if password is "JoshB654#"
      $.getJSON ("userlist.json"), (data) ->
        localStorage.setItem "users", JSON.stringify(data)
        localStorage.setItem "beenhere", "donethat"
        saywhat = localStorage.getItem('beenhere')
        displayUserList()
    else
      document.location.href='index.php'


checkId = ->
  $('#checkid').show()
  setTimeout (->
    $('#theloginusername').focus()
  ), 500

$("#checkid").keydown (event) ->
  $("#loginbutton").trigger "click"  if event.keyCode is 13

$("#logoutbutton").click ->
  $('#logout').hide()
  localStorage.removeItem('firstname')
  localStorage.removeItem('goals')
  localStorage.removeItem('notify')
  localStorage.removeItem('primarygoals')
  localStorage.removeItem('secret')
  localStorage.removeItem('username')
  localStorage.removeItem('users')
  location.reload()

$('#loginbutton').click ->
  users = JSON.parse(localStorage["users"])
  username = $("#theloginusername").val()
  password = $("#theloginpassword").val()
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
  $('#logout').show()
  username = localStorage.getItem("username")
  $.getJSON username + "user.json", (data) ->
    localStorage.setItem "user", JSON.stringify(data)
    user = JSON.parse(localStorage.getItem("user"))
    notify = user.notify
    firstname = user.firstname
    localStorage.setItem "firstname", firstname
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
    newHTML.push """<li data-username='#{ user.username }' data-notify='#{ user.notify }' data-firstname='#{ user.firstname }'>
          <span class='username'>Username: #{ user.username }</span>
          <span class='userfullname'>Full name: #{ user.firstname } #{ user.lastname }</span><br>
          <span class='password'>Password: #{ user.password }</span>
          <span class='notifications'>Notify: #{ user.notify }</span>
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
  users.push(user)
  localStorage.setItem "users", JSON.stringify(users)
  localStorage.setItem 'user', JSON.stringify(user)
  makeNewUser()
  userListChange()
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
      incentivepic: ''
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
      subB:
        goalguid: createGuid()
        goal: 'This is the Second SubGoal'
        icon: 'umbrella'
        status: "inprogress"
        infotype: ''
      subC:
        goalguid: createGuid()
        goal: 'This is the Third SubGoal'
        icon: 'silverware'
        status: "inprogress"
        infotype: ''
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
  firstname = $(this).closest('li').data("firstname")
  localStorage.setItem("firstname", firstname)
  #  capfirstname = capitaliseFirstLetter(firstname)
  #  capitaliseFirstLetter(string) = ->
  #    string.charAt(0).toUpperCase() + string.slice(1)
  #  localStorage.setItem("firstname", firstname)
  document.location.href='mobile.newgoals.php'
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
  if (goalType == 'solo')
    $("#addgoal").show()
    displayMyGoalList()
  else
    $("#addprimarygoal").show()
    displayprimaryGoals()

$('#addgoal').click ->
  $("#updategoal").hide()
  $("#savegoal").show()
  $("#addgoalform").show()
  $("#addprimarygoalform").hide()

$('#addprimarygoal').click ->
  $("#addprimarygoalform").show()
  $("#addgoalform").hide()

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
      incentivepic: $("input[name=incentivepic]:checked").val()
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
  daysOfWeekA = $("#daysoftheweekA input[name=daysA]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekB = $("#daysoftheweekB input[name=daysB]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekC = $("#daysoftheweekC input[name=daysC]:checked").map(->
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
      subB:
        goalguid: createGuid()
        goal: $("#thegoalB").val()
        icon: $("#theiconsB input[name=iconB]:checked").val()
        status: "inprogress"
        infotype: $("#infotypeB input[name=theinfotype]:checked").val()
      subC:
        goalguid: createGuid()
        goal: $("#thegoalC").val()
        icon: $("#theiconsC input[name=iconC]:checked").val()
        status: "inprogress"
        infotype: $("#infotypeC input[name=theinfotype]:checked").val()
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
  goals = JSON.parse(localStorage["goals"])
  $.each goals, (i, goal) ->
    newinfocreated = JSON.stringify(goal.goal.infocreated)
    if (goal.goal.category is goalCategory)
      if (goal.goal.status is 'completed')
        completedHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i><a href="#createModal" role="button" data-toggle="modal">#{ goal.goal.goal }</a></span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' ><input type='checkbox' checked/></span>
                          <span class='gathercompletedinfo'>&nbsp;</span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i><a href="#createModal" role="button" data-toggle="modal">#{ goal.goal.goal }</a></span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-goal='#{ goal.goal.goal }'></i></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i><a href="#createModal" role="button" data-toggle="modal">#{ goal.goal.goal }</a></span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gathercompletedinfo'>&nbsp;</span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-goal='#{ goal.goal.goal }'></i></li>"""

  $(".goalsinprogress").html inprogressHTML.join("")
  $(".goalscompleted").html completedHTML.join("")
  $(".goalsection").css(visibility: "visible").fadeIn(200)

$(".goalscompleted").delegate "input[type=checkbox]", "click", ->
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

$(".goalsinprogress").delegate "input[type=checkbox]", "click", ->
  checkinginfotype = $(this).closest('li').data('info')
  if ( !$(this).closest('li').find('input[type="text"]').val() ) and (checkinginfotype is 'text')
    alert "You have to enter a number before this goal can be completed."
    $(this).removeAttr('checked');
  else
    goalguid = $(this).closest('li').data("goalguid")
    congratulations = $(this).closest('li').data("complete")
    emailGoal = $(this).closest('li').data('goal')
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10)
    mygoaldate = createInfoDate()
    updateStatus = 'completed'
    incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
    $.each goals, (index, goal) ->
      if goal.goal.goalguid is goalguid
        if goal.goal.infotype is 'text'
          goal.goal.myinfo.push newinfo
        else
          goal.goal.myinfo.push 1
        goal.goal.infocreated.push mygoaldate
        goal.goal.status = updateStatus
        goalmessage = firstname + ' has completed this goal: ' + goal.goal.goal
        localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress").addClass("completed").prop("checked", true)
    showCongrats()
    emailCompletion(goalmessage)
    goalChange()
    displayMyGoalList()

###
this brings up the goal modal filled with the data, ready for editing
###

$(".goalsection").delegate "a", "click", ->
  $("#updategoal").show()
  $("#savegoal").hide()
  $(".detailsLabelupdate").show()
  $(".detailsLabel").hide()
  $("#addgoalform").show()
  $("#addprimarygoalform").hide()
  goalguid = $(this).closest('li').data("goalguid")
  $("input[name=goalguid]").val([])
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      categoryforgoal = goal.goal.category
      categoryforgoal = categoryforgoal.toLowerCase().replace(/\b[a-z]/g, (letter) ->
        letter.toUpperCase()
      )
      $("#thecategory").val(categoryforgoal)
      $("#thegoal").val(goal.goal.goal)
      $("input[name=icon]").val([goal.goal.icon])
      if goal.goal.infotype == 'text'
        $("#theinfotype").prop('checked', true)
      else
        $("#theinfotype").prop('checked', false)
      $("input[name=incentivepic]").val([goal.goal.incentivepic])
      $("input[name=goalguid]").val([goalguid])
      false # break the each

###
this updates a goal when the user changes something like the goaltitle
###
$('#updategoal').click ->
  daysOfWeek = $("input[name=days]:checked").map(->
    $(this).val()
  ).get()
  $.each goals, (index, goal) ->
    if goal.goal.goalguid is goalguid
      goal.goal.category = $("#thecategory").val().toLowerCase()
      goal.goal.goal = $("#thegoal").val()
      goal.goal.icon = $("input[name=icon]:checked").val()
      goal.goal.infotype = $("input[name=theinfotype]:checked").val()
      goal.goal.incentivepic = $("input[name=incentivepic]:checked").val()
      false # break the each
  localStorage.setItem "goals", JSON.stringify(goals)
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".detailsLabelupdate").hide()
  $(".detailsLabel").show()
  $(".textempty").val('')
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
      primaryGoalsHTML.push """<li class='parent'  data-goalguid='#{ primarygoal.primarygoal.goalguid }'  data-removegoal='#{ primarygoal.primarygoal.goalguid }'>
            <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.icon }'></i><a href="#createModal" role="button" data-toggle="modal">#{ primarygoal.primarygoal.goal }</a></span>
            <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b> </button></span></li>"""
      if (primarygoal.primarygoal.subA.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subA.infocreated)
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]'  data-goal='#{ primarygoal.primarygoal.subA.goal }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else if (primarygoal.primarygoal.subA.status == "inprogress")
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoA' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoA' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subA.icon }'></i>#{ primarygoal.primarygoal.subA.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      if (primarygoal.primarygoal.subB.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subB.infocreated)
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else if (primarygoal.primarygoal.subB.status == "inprogress")
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoB' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='infoB' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subB.icon }'></i>#{ primarygoal.primarygoal.subB.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      if (primarygoal.primarygoal.subC.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subC.infocreated)
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox' checked></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else if (primarygoal.primarygoal.subC.status == "inprogress")
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
      else
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goaltitle'><i class='fa-large icon-#{ primarygoal.primarygoal.subC.icon }'></i>#{ primarygoal.primarygoal.subC.goal }</span>
                        <span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus'><input type='checkbox'/></span>
                        <span class='gathercompletedinfo'>&nbsp;</span>
                        <span><i class='fa-large icon-stats chartbutton'></i></span></li>"""
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
          else
            primarygoal.primarygoal.subA.myinfo.push 1
          primarygoal.primarygoal.subA.infocreated.push mygoaldate
          primarygoal.primarygoal.subA.status = updateStatus
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subA.goal
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
          false # break the each
        else if primarygoal.primarygoal.subB.goalguid is goalguid
          if primarygoal.primarygoal.subB.infotype is 'text'
            primarygoal.primarygoal.subB.myinfo.push newinfo
          else
            primarygoal.primarygoal.subB.myinfo.push newinfo
          primarygoal.primarygoal.subB.infocreated.push mygoaldate
          primarygoal.primarygoal.subB.status = updateStatus
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subB.goal
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
          false # break the each
        else if primarygoal.primarygoal.subC.goalguid is goalguid
          if primarygoal.primarygoal.subC.infotype is 'text'
            primarygoal.primarygoal.subC.myinfo.push newinfo
          else
            primarygoal.primarygoal.subC.myinfo.push newinfo
          primarygoal.primarygoal.subC.infocreated.push mygoaldate
          primarygoal.primarygoal.subC.status = updateStatus
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


###
this brings up the primarygoal modal filled with the data, ready for editing
###

$(".primarygoals").delegate "a", "click", ->
  $("#updateprimarygoal").show()
  $("#saveprimarygoal").hide()
  $(".detailsLabelupdate").show()
  $(".detailsLabel").hide()
  $("#addgoalform").hide()
  $("#addprimarygoalform").show()
  goalguid = $(this).closest('li').data("goalguid")
  $("input[name=goalguid]").val([])
  $.each primarygoals, (index, primarygoal) ->
    if primarygoal.primarygoal.goalguid is goalguid
      categoryforgoal = primarygoal.primarygoal.category
      categoryforgoal = categoryforgoal.toLowerCase().replace(/\b[a-z]/g, (letter) ->
        letter.toUpperCase()
      )
      $("#theprimarycategory").val(categoryforgoal)
      $("#theprimarygoal").val(primarygoal.primarygoal.goal)
      $("#thegoalA").val(primarygoal.primarygoal.subA.goal)
      $("input[name=iconA]").val([primarygoal.primarygoal.subA.icon])
      $("#thedeadlineA").val(primarygoal.primarygoal.subA.deadline)
      if primarygoal.primarygoal.subA.infotype == 'text'
        $("#theinfotypeA").prop('checked', true)
      else
        $("#theinfotypeA").prop('checked', false)
      if primarygoal.primarygoal.subA.recurring.length == 0
        $("#therecurringA").prop('checked', false)
      else
        $("#therecurringA").prop('checked', true)
        $('#daysoftheweekA').toggle(this.checked)
      dayAs = primarygoal.primarygoal.subA.recurring
      for dayA in dayAs
        $("input[name=daysA][value=" + dayAs[_i] + "]").prop('checked', true)
      $("#thecompleteA").val(primarygoal.primarygoal.subA.completedmessage)
      $("#thegoalB").val(primarygoal.primarygoal.subB.goal)
      $("input[name=iconB]").val([primarygoal.primarygoal.subB.icon])
      $("#thedeadlineB").val(primarygoal.primarygoal.subB.deadline)
      if primarygoal.primarygoal.subB.infotype == 'text'
        $("#theinfotypeB").prop('checked', true)
      else
        $("#theinfotypeB").prop('checked', false)
      if primarygoal.primarygoal.subB.recurring.length == 0
        $("#therecurringB").prop('checked', false)
      else
        $("#therecurringB").prop('checked', true)
        $('#daysoftheweekB').toggle(this.checked)
      dayBs = primarygoal.primarygoal.subB.recurring
      for dayB in dayBs
        $("input[name=daysB][value=" + dayBs[_j] + "]").prop('checked', true)
      $("#thecompleteB").val(primarygoal.primarygoal.subB.completedmessage)
      $("#thegoalC").val(primarygoal.primarygoal.subC.goal)
      $("input[name=iconC]").val([primarygoal.primarygoal.subC.icon])
      $("#thedeadlineC").val(primarygoal.primarygoal.subC.deadline)
      if primarygoal.primarygoal.subC.infotype == 'text'
        $("#theinfotypeC").prop('checked', true)
      else
        $("#theinfotypeC").prop('checked', false)
      if primarygoal.primarygoal.subC.recurring.length == 0
        $("#therecurringC").prop('checked', false)
      else
        $("#therecurringC").prop('checked', true)
        $('#daysoftheweekC').toggle(this.checked)
      dayCs = primarygoal.primarygoal.subC.recurring
      for dayC in dayCs
        $("input[name=daysC][value=" + dayCs[_k] + "]").prop('checked', true)
      $("#thecompleteC").val(primarygoal.primarygoal.subC.completedmessage)
      false # break the each

###
this updates a primarygoal when the user changes something like the goaltitle
###
$('#updateprimarygoal').click ->
  daysOfWeekA = $("input[name=daysA]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekB = $("input[name=daysB]:checked").map(->
    $(this).val()
  ).get()
  daysOfWeekC = $("input[name=daysC]:checked").map(->
    $(this).val()
  ).get()
  $.each primarygoals, (index, primarygoal) ->
    if primarygoal.primarygoal.goalguid is goalguid
      primarygoal.primarygoal.category = $("#theprimarycategory").val().toLowerCase()
      primarygoal.primarygoal.goal = $("#theprimarygoal").val()
      primarygoal.primarygoal.subA.goal = $("#thegoalA").val()
      primarygoal.primarygoal.subA.icon = $("input[name=iconA]:checked").val()
      primarygoal.primarygoal.subA.infotype = $("input[name=theinfotypeA]:checked").val()
      primarygoal.primarygoal.subA.recurring = daysOfWeekA
      primarygoal.primarygoal.subA.completedmessage = $("#thecompleteA").val()
      primarygoal.primarygoal.subA.deadline = $("#thedeadlineA").val()
      primarygoal.primarygoal.subB.goal = $("#thegoalB").val()
      primarygoal.primarygoal.subB.icon = $("input[name=iconB]:checked").val()
      primarygoal.primarygoal.subB.infotype = $("input[name=theinfotypeB]:checked").val()
      primarygoal.primarygoal.subB.recurring = daysOfWeekB
      primarygoal.primarygoal.subB.completedmessage = $("#thecompleteB").val()
      primarygoal.primarygoal.subB.deadline = $("#thedeadlineB").val()
      primarygoal.primarygoal.subC.goal = $("#thegoalC").val()
      primarygoal.primarygoal.subC.icon = $("input[name=iconC]:checked").val()
      primarygoal.primarygoal.subC.infotype = $("input[name=theinfotypeC]:checked").val()
      primarygoal.primarygoal.subC.recurring = daysOfWeekC
      primarygoal.primarygoal.subC.completedmessage = $("#thecompleteC").val()
      primarygoal.primarygoal.subC.deadline = $("#thedeadlineC").val()
      false # break the each
  localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
  $("#addprimarygoalform").hide()
  $("#daysoftheweekA").hide()
  $("#daysoftheweekB").hide()
  $("#daysoftheweekC").hide()
  $(".detailsLabelupdate").hide()
  $(".detailsLabel").show()
  $(".textempty").val('')
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
    userListChange()
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

###
  delete a primarygoal
###
$(".primarygoals").delegate "button", "click", ->
  goalguid = $(this).closest('li').data("goalguid")
  console.log goalguid
  shouldRemove = confirm("Are you sure you want to remove this goal?")
  if !shouldRemove
    false
  else
    i = 0

    while i < primarygoals.length
      if primarygoals[i].primarygoal.goalguid and primarygoals[i].primarygoal.goalguid is goalguid
        console.log 'found it'
        primarygoals.splice i, 1
        break
      i++
    localStorage.setItem "primarygoals", JSON.stringify(primarygoals)
    primarygoalChange()
    displayprimaryGoals()


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
$(".goalsection").on "click", "i.chartbutton", ->
  $("#chartbox").show()
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
  if $(this).closest('li').data('info') == "text"
    $ ->
    $("#thischart").highcharts
      chart: {}

      title:
        text: mytitle

      legend:
        enabled: false

      xAxis:
        categories: infocreated

      yAxis:
        minRange: 5

      series: [data: myinfo   ]
  else
    $ ->
    $("#thischart").highcharts
      chart: {
        type: 'line'
      },

      title:
        text: mytitle

      legend:
        enabled: false

      xAxis: {
        categories: infocreated,
        gridLineColor: '#000'
      }

      yAxis: {
        categories: ["No", "Yes", ""],
        gridLineColor: '#fff',
        gridLineWidth: 1,
        max: 1,
        min: 0
      }

      series: [data: myinfo   ]

# this is for primary goals
$(".primarygoals").on "click", "i.chartbutton", ->
  $("#chartbox").show()
  $("#incentivebox").show()
  $(".chart-backdrop").show()
  incentivetext = $(this).closest('li').data('incentivetext')
  incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")'
  placeincentivetext =  '<p>' + incentivetext + '</p>'
  $("#incentivetext").html(placeincentivetext)
  $("#incentivepic").css('background-image', incentivepic )
  infocreated = $(this).closest('li').data('infocreated')
  myinfo = $(this).closest('li').data('myinfo')
  mytitle = $(this).closest('li').data('goal')
  if $(this).closest('li').data('info') == "text"
    $ ->
    $("#thischart").highcharts
      chart: {}

      title:
        text: mytitle

      legend:
        enabled: false

      xAxis:
        categories: infocreated

      yAxis:
        minRange: 5

      series: [data: myinfo   ]
  else
    $ ->
    $("#thischart").highcharts
      chart: {
        type: 'line'
      },

      title:
        text: mytitle

      legend:
        enabled: false

      xAxis: {
        categories: infocreated,
        gridLineColor: '#000'
      }

      yAxis: {
        categories: ["No", "Yes", ""],
        gridLineColor: '#fff',
        gridLineWidth: 1,
        max: 1,
        min: 0
      }

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

makeNewUser = ->
  postThis = {}
  postThis.user = localStorage.getItem("user")
  username = localStorage.getItem('username');
  postThis.userid = username
  $.ajax
    url: "newUser.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, make new user worked!");
      makeSampleGoals()
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("Make new user didn't work so good...")

userListChange = ->
  postThis = {}
  postThis.users = localStorage.getItem("users")
  console.log users
  $.ajax
    url: "userList.php"
    type: "POST"
    data: postThis
    success: (response, textStatus, jqXHR) ->
      console.log("Yay, the userList save worked!")
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("UserList save didn't work so good...")

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