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
user = {}
goalmessage = ''


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
      $('#loginsection').hide()
      localStorage.setItem("secret", "this is a secret")
      localStorage.setItem("username", username)
      localStorage.removeItem("users")
      $('#logout').show()
      $('#checkid').hide()
      loadmyFiles()
    else
      $('#errorlogin').show()

loadmyFiles = ->
  username = localStorage.getItem("username")
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
    $('#school').show()
    $('#logout').show()
    $('#checkid').hide()
    $('#home').hide()
    $('#work').hide()
    $('#personal').hide()
    displayMyGoalList()
    displayprimaryGoals()

# menu nav stuff

$('#home').click ->
  $('#schoolwrapper').removeClass('show-menu')
  $('#schoolsolowrapper').removeClass('show-menu')
  $('#schoolprimarywrapper').removeClass('show-menu')

$('.menubar').click ->
  $('.menustuff').show()
$('#hidescreen').click ->
  $('.menustuff').hide()
$('#homemenu').click ->
  $('.menustuff').hide()
  $('#home').show()
  $('#loginsection').show()
  $('#school').hide()
  $('#work').hide()
  $('#personal').hide()
  $('#goalscontainer').hide()
  $('#primarygoalscontainer').hide()
$('#schoolmenu').click ->
  $('.menustuff').hide()
  $('#loginsection').hide()
  $('#goalscontainer').show()
  $('#primarygoalscontainer').show()
  $('#school').show()
  $('#home').hide()
  $('#work').hide()
  $('#personal').hide()
  goalCategory = "school"
  displayMyGoalList()
  displayprimaryGoals()
$('#workmenu').click ->
  $('.menustuff').hide()
  $('#loginsection').hide()
  $('#goalscontainer').show()
  $('#primarygoalscontainer').show()
  $('#work').show()
  $('#home').hide()
  $('#school').hide()
  $('#personal').hide()
  goalCategory = "work"
  displayMyGoalList()
  displayprimaryGoals()
$('#personalmenu').click ->
  $('.menustuff').hide()
  $('#loginsection').hide()
  $('#goalscontainer').show()
  $('#primarygoalscontainer').show()
  $('#personal').show()
  $('#home').hide()
  $('#school').hide()
  $('#work').hide()
  goalCategory = "personal"
  displayMyGoalList()
  displayprimaryGoals()


$('#primarymenu').click ->
  $('#goalscontainer').animate
    left: '500px'
  , 'fast'
  $('#primarygoalscontainer').animate
    left: '7px'
  , 'slow'

$('#solomenu').click ->
  $('#primarygoalscontainer').animate
    left: '500px'
  , 'fast'
  $('#goalscontainer').animate
    left: '7px'
  , 'slow'


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
                          <span class='goalicon'><i class='fa-medium icon-#{ goal.goal.icon }'></i></span>
                          <span class='goaltitle'>#{ goal.goal.goal }</span>
                          <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else if (goal.goal.status is "inprogress")
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goalicon'><i class='fa-medium icon-#{ goal.goal.icon }'></i></span>
                          <span class='goaltitle'>#{ goal.goal.goal }<br/><span class='goaldeadline'>#{ goal.goal.deadline }</span></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' data-info='#{ goal.goal.infotype }' data-goalguid='#{ goal.goal.goalguid }' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' >
                          <span class='goalicon'><i class='fa-medium icon-#{ goal.goal.icon }'></i></span>
                          <span class='goaltitle'>#{ goal.goal.goal }<br/><span class='goaldeadline'>#{ goal.goal.deadline }</span></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='clearfix'></span></li>"""

  $(".goalsinprogress").html inprogressHTML.join("")
  $(".goalscompleted").html completedHTML.join("")

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
    $.each goals, (index, goal) ->
      if goal.goal.goalguid is goalguid
        if goal.goal.infotype is 'text'
          goal.goal.myinfo.push newinfo
          goal.goal.infocreated.push mygoaldate
        goal.goal.status = updateStatus
        goal.goal.datecompleted = mygoaldate
        goalmessage = firstname + ' has completed this goal: ' + goal.goal.goal
        localStorage.setItem("goalmessage", JSON.stringify(goalmessage))
        false # break the each
    localStorage.setItem "goals", JSON.stringify(goals)
    $(this).find('.info').val('')
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true)
    showCongrats()
    emailCompletion(goalmessage)
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
            <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.icon }'></i></span>
            <span class='goaltitle'>#{ primarygoal.primarygoal.goal }</span>
            <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ primarygoal.primarygoal.goalguid }'><b>X</b> </button></span></li>"""
      if (primarygoal.primarygoal.subA.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subA.infocreated)
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub' data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subA.myinfo }]' data-goal='#{ primarygoal.primarygoal.subA.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subA.status == "inprogress")
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span class='gatherinfo'><input type='text' name='infoA' class='info'></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA' data-incentivetext='#{ primarygoal.primarygoal.subA.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subA.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subA.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subA.status } sub'  data-info='#{ primarygoal.primarygoal.subA.infotype }' data-goalguid='#{ primarygoal.primarygoal.subA.goalguid }' data-subB='subA'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subA.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subA.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subA.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subA.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subB.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subB.infocreated)
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subB.myinfo }]' data-goal='#{ primarygoal.primarygoal.subB.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subB.status == "inprogress")
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB' data-incentivetext='#{ primarygoal.primarygoal.subB.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subB.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subB.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subB.status } sub'  data-info='#{ primarygoal.primarygoal.subB.infotype }' data-goalguid='#{ primarygoal.primarygoal.subB.goalguid }' data-subB='subB'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subB.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subB.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subB.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subB.goal }'><input type='checkbox'/></span></li>"""
      if (primarygoal.primarygoal.subC.status == 'completed')
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subC.infocreated)
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }'></i></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>
                        <span><i class='fa-medium icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ primarygoal.primarygoal.subC.myinfo }]' data-goal='#{ primarygoal.primarygoal.subC.goal }'></i></span></li>"""
      else if (primarygoal.primarygoal.subC.status == "inprogress")
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push  """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>
                        <span class='gatherinfo'><input type='text' name='info' class='info'></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC' data-incentivetext='#{ primarygoal.primarygoal.subC.incentivetext }' data-incentivepic='#{ primarygoal.primarygoal.subC.incentivepic }' >
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>
                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
      else
        if (primarygoal.primarygoal.subC.infotype == 'text')
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox'/></span></li>"""
        else
          primaryGoalsHTML.push """<li class='#{ primarygoal.primarygoal.subC.status } sub'  data-info='#{ primarygoal.primarygoal.subC.infotype }' data-goalguid='#{ primarygoal.primarygoal.subC.goalguid }' data-subB='subC'>
                        <span class='goalicon'><i class='fa-medium icon-#{ primarygoal.primarygoal.subC.icon }'></i></span>
                        <span class='goaltitle'>#{ primarygoal.primarygoal.subC.goal }<br/><span class='goaldeadline'>#{ primarygoal.primarygoal.subC.deadline }</span></span>                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>
                        <span class='goalstatus' data-goal='#{ primarygoal.primarygoal.subC.goal }'><input type='checkbox'/></span></li>"""
    primaryGoalsHTML.push '<span class="clearfix"></span>'

  $(".primarygoals").html primaryGoalsHTML.join("")


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