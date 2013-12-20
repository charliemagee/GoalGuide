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

#
#goals =
#  "691473a7-acad-458e-bb27-96bac22467jj":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "Weigh Yourself"
#    icon: "health"
#    status: "completed"
#    infotype: "text"
#    infocreated: ['11/30', '12/01', '12/02', '12/03', '12/04', '12/05', '12/06', '12/07']
#    myinfo: [165,168,170,171,172,170,168,164]
#    recurring: ""
#    completedmessage: "Great Job!"
#    incentivepic: "images/fireworks.jpg"
#    incentivetext: "Losing weight is great!"
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "9e693231-e6d8-4ca9-b5c8-81ea7a8056hh":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "track spending money"
#    icon: "dollar"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Awesome!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "8d23005d-f6f3-4589-bb85-a90510bc45gg":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "Brush teeth--night"
#    icon: "health"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Way to Go."
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d845534cd":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "Shower--morning"
#    icon: "health"
#    status: "missed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Great Job!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "9e693231-e6d8-4ca9-b5c8-81ea7a8012ed":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "study tonight"
#    icon: "book"
#    status: "completed"
#    infotype: ""
#    infocreated: ['12/01', '12/03', '12/04', '12/06', '12/07', '12/08']
#    myinfo: [108,138,168,156,144,160]
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete5"
#    incentivepic: "images/moneybag.jpg"
#    incentivetext: "Study hard and get a good job!"
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "8d23005d-f6f3-4589-bb85-a90510bckk88":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "arrive on time"
#    icon: "bell"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete6!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d8455nn78":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "arrive prepared"
#    icon: "clipboard"
#    status: "missed"
#    infotype: "text"
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete7!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "9e693231-e6d8-4ca9-b5c8-81ea7a80mm75":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "pass LCC Class"
#    icon: "book"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete8!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "8d23005d-f6f3-4589-bb85-a90510bcbb76":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "track time to complete homework"
#    icon: "stopwatch"
#    status: "missed"
#    infotype: ""
#    infocreated: ['12/01', '12/03', '12/04', '12/06', '12/07', '12/08']
#    myinfo: [64,122,114,181,78,104]
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete9!"
#    incentivepic: "images/ps4.jpg"
#    incentivetext: "Finish homework and then play games."
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d845578iu":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "Get good quiz grades"
#    icon: "book"
#    status: "completed"
#    infotype: "text"
#    infocreated: ['12/01', '12/03', '12/04', '12/06', '12/07', '12/08']
#    myinfo: [81,84,81,86,90,92]
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete11!"
#    incentivepic: "images/pizza.jpg"
#    incentivetext: "Good grades = a pizza dinner."
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d845512fg":
#    category: "work"
#    datecreated: "2013-10-20"
#    goal: "arrive on time"
#    icon: "alarm"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete12!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d845556ty":
#    category: "work"
#    datecreated: "2013-10-20"
#    goal: "check in with boss"
#    icon: "boss"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete13!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "ac879673-19eb-43f6-8b95-078d8455ew44":
#    category: "work"
#    datecreated: "2013-10-20"
#    goal: "finish task"
#    icon: "clipboard"
#    status: "completed"
#    infotype: ""
#    infocreated: ['11/01', '11/03', '11/04', '11/06', '11/07', '11/08', '11/12', '11/18', '12/01', '12/03', '12/04', '12/06', '12/07', '12/08']
#    myinfo: [0,1,1,0,1,1,1,1,0,0,1,1,1,1]
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete14!"
#    incentivepic: "images/goldstar.jpg"
#    incentivetext: "You finished!"
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "jimmysmith"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
#
#  "691473a7-acad-458e-bb27-96bac224bvc5":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "brush my hair"
#    icon: "health"
#    status: "completed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete15!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "691473a7-acad-458e-bb27-96bac2241423":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "brush teeth--morning"
#    icon: "health"
#    status: "completed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete16!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "9e693231-e6d8-4ca9-b5c8-81ea7a80tth7":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "take morning medication"
#    icon: "pill"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete17!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "8d23005d-f6f3-4589-bb85-a90510bcyyk9":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "Shower--evening"
#    icon: "health"
#    status: "inprogress"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete18!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "ac879673-19eb-43f6-8b95-078d8455uul8":
#    category: "personal"
#    datecreated: "2013-10-20"
#    goal: "Brush Teeth--evening"
#    icon: "health"
#    status: "missed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete19!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "8d23005d-f6f3-4589-bb85-a90510bcooj5":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "pass self-quizzes in homework"
#    icon: "book"
#    status: "inprogress"
#    infotype: "text"
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete20!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "ac879673-19eb-43f6-8b95-078d8455ffh6":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "meet with Josh on Friday"
#    icon: "boss"
#    status: "missed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete21!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "9e693231-e6d8-4ca9-b5c8-81ea7a8dd54":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "keep locker tidy"
#    icon: "clipboard"
#    status: "inprogress"
#    infotype: "text"
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete22!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "8d23005d-f6f3-4589-bb85-a90510bcwer3":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "improve reading scores"
#    icon: "book"
#    status: "completed"
#    infotype: "text"
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete23!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "ac879673-19eb-43f6-8b95-078d8455gt65":
#    category: "school"
#    datecreated: "2013-10-20"
#    goal: "finish assignments"
#    icon: "book"
#    status: "missed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete24!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "ac879673-19eb-43f6-8b95-078d8455ku88":
#    category: "work"
#    datecreated: "2013-10-20"
#    goal: "wear clean clothes"
#    icon: "health"
#    status: "inprogress"
#    infotype: "text"
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete25!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#
#  "ac879673-19eb-43f6-8b95-078d8455zx43":
#    category: "work"
#    datecreated: "2013-10-20"
#    goal: "be on time"
#    icon: "alarm"
#    status: "completed"
#    infotype: ""
#    infocreated: []
#    myinfo: []
#    recurring: "mon,wed,fri"
#    completedmessage: "Complete26!"
#    incentivepic: ""
#    incentivetext: ""
#    datecompleted: ""
#    deadline: "2014-1-20"
#    username: "maryjones"
#    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
#

primegoals =
  "691473a7-acad-458e-bb27-96bac2212345":
    category: "school"
    datecreated: "2013-10-20"
    goal: "pass science class"
    icon: "eyedropper"
    status: "completed"
    username: "jimmysmith"
    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
    subA:
      goal: "finish all experiments"
      icon: "alarm"
      status: "completed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice1!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subB:
      goal: "pass all quizzes"
      icon: "alarm"
      status: "inprogress"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice2!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subC:
      goal: "be on time"
      icon: "alarm"
      status: "missed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice3!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"

  "9e693231-e6d8-4ca9-b5c8-81ea7a823456":
    category: "school"
    datecreated: "2013-10-20"
    goal: "lead basketball team"
    icon: "basketball"
    status: "inprogress"
    username: "jimmysmith"
    userguid: "0c7270bd-38e8-4db2-ae92-244de019c543"
    subA:
      goal: "pass the ball"
      icon: "alarm"
      status: "completed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice4!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subB:
      goal: "score baskets"
      icon: "alarm"
      status: "inprogress"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Awesome4!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subC:
      goal: "high fives"
      icon: "alarm"
      status: "inprogress"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Congrats4!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"

  "691473a7-acad-458e-bb27-96bac2234567":
    category: "school"
    datecreated: "2013-10-20"
    goal: "pass math class"
    icon: "book"
    status: "missed"
    username: "maryjones"
    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
    subA:
      goal: "finish all assignments"
      icon: "alarm"
      status: "completed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice5!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subB:
      goal: "pass all quizzes"
      icon: "alarm"
      status: "inprogress"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Awesome5!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subC:
      goal: "be on time"
      icon: "alarm"
      status: "missed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Congrats5!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"

  "9e693231-e6d8-4ca9-b5c8-81ea7a845678":
    category: "school"
    datecreated: "2013-10-20"
    goal: "pass reading class"
    icon: "book"
    status: "completed"
    username: "maryjones"
    userguid: "0c7270bd-38e8-4db2-ae92-244de019mju7"
    subA:
      goal: "read all assignments"
      icon: "alarm"
      status: "completed"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Nice6!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subB:
      goal: "pass all quizzes"
      icon: "alarm"
      status: "inprogress"
      infotype: "text"
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Awesome6!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"
    subC:
      goal: "be on time"
      icon: "alarm"
      status: "missed"
      infotype: ""
      infocreated: []
      myinfo: []
      recurring: "mon,wed,fri"
      completedmessage: "Congrats6!"
      incentivepic: ""
      incentivetext: ""
      datecompleted: ""
      deadline: "2014-1-20"


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
  if localStorage.getItem("primegoals") is null
    localStorage.setItem "primegoals", JSON.stringify(primegoals)
  displayUserList()


# loading the json file and showing the goals
initMine = ->
  username = prompt("What is your username?")
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
  $("#addprimegoalform").hide()
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
  $("#addprimegoalform").hide()

$('#addprimegoal').click ->
  $("#addprimegoalform").show()
  $("#addgoalform").hide()
  $("#adduser").show()
  $("#adduserform").hide()

$('.sologoal').click ->
  $('#addprimegoal').hide()
  $('#addgoal').show()

$('.primegoal').click ->
  $('#addprimegoal').show()
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
$('#saveprimegoal').click ->
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
  primegoals[goalguid] =
    category: $("#thecategory").val().toLowerCase()
    datecreated: datecreated
    goal: $("#theprimegoal").val()
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
  localStorage.setItem "primegoals", JSON.stringify(primegoals)
  goals = JSON.parse(localStorage["goals"])
  $("#addgoalform").hide()
  $("#daysoftheweek").hide()
  $(".textempty").val('')
  $('.uncheckit input').removeAttr('checked');
  logSummary()
  displayPrimeGoals()


###
this uses delegate because the lines of info are dynamically placed and won't respond to a simple click. It highlights the clicked User and displays his goals
###
$(".users").delegate "li", "click", ->
  goals = JSON.parse(localStorage["goals"])
  $(this).addClass("active").siblings("li").removeClass "active"
  if (goalType == 'solo')
    $("#goalcontent").show()
    $('#primegoalcontent').hide()
  else
    $("#goalcontent").hide()
    $('#primegoalcontent').show()
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
    $("#addprimegoal").show()
    displayPrimeGoals()

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
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' ><input type='checkbox' checked/></span>
                          <span><i class='fa-large icon-stats chartbutton' data-infocreated='#{ newinfocreated }' data-myinfo='[#{ goal.goal.myinfo }]' data-incentivetext='#{ goal.goal.incentivetext }' data-incentivepic='#{ goal.goal.incentivepic }' data-goal='#{ goal.goal.goal }'></i></span></li>"""

      else if (goal.goal.status is "inprogress")
        if (goal.goal.infotype is 'text')
          inprogressHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals[i] }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          inprogressHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals[i] }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }' data-complete='#{ goal.goal.completedmessage }'><input type='checkbox' /></span></li>"""
      else
        if (goal.goal.infotype is 'text')
          missedHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals[i] }'><b>X</b></button></span>
                          <span class='goalstatus' data-goal='#{ goal.goal.goal }'><input type='checkbox' /></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"""
        else
          missedHTML.push """<li class='#{ goal.goal.status }' >
                          <span class='goaltitle'><i class='fa-large icon-#{ goal.goal.icon }'></i>#{ goal.goal.goal }</span>
                          <span class='goaldeadline'>#{ goal.goal.deadline }</span>
                          <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ goals[i] }'><b>X</b></button></span>
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

$(".primegoal").click ->
  $('#goalcontent').hide()
  $('#primegoalcontent').show()
  goalType = 'prime'
  displayPrimeGoals()

$(".sologoal").click ->
  $('#goalcontent').show()
  $('#primegoalcontent').hide()
  goalType = 'solo'
  displayMyGoalList()

displayPrimeGoals = ->
  primeGoalsHTML = []
  $.each primegoals, (index, primegoal) ->
    if (primegoal.userguid == userguid)
      if (primegoal.category == goalCategory)
        primeGoalsHTML.push """<li class='parent' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'">
              <span class='goaltitle'><i class='fa-large icon-#{ primegoal.icon }'></i>#{ primegoal.goal }</span>
              <span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='#{ primegoal.goalguid }'><b>X</b> </button></span></li>"""
        if (primegoal.subA.status == 'completed')
          if (primegoal.subA.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }'><input type='checkbox' checked></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }'><input type='checkbox' checked></span></li>"""
        else if (primegoal.subA.status == "inprogress")
          if (primegoal.subA.infotype == 'text')
            primeGoalsHTML.push  """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                          <span class='gatherinfo'><input type='text' name='infoA' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          if (primegoal.subA.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }'><input type='checkbox'/></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subA.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subA.icon }'></i>#{ primegoal.subA.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subA.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subA.goal }'><input type='checkbox'/></span></li>"""
        if (primegoal.subB.status == 'completed')
          if (primegoal.subB.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }'><input type='checkbox' checked></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }'><input type='checkbox' checked></span></li>"""
        else if (primegoal.subB.status == "inprogress")
          if (primegoal.subB.infotype == 'text')
            primeGoalsHTML.push  """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          if (primegoal.subB.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }'><input type='checkbox'/></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subB.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subB.icon }'></i>#{ primegoal.subB.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subB.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subB.goal }'><input type='checkbox'/></span></li>"""
        if (primegoal.subC.status == 'completed')
          if (primegoal.subC.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }'><input type='checkbox' checked></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }'><input type='checkbox' checked></span></li>"""
        else if (primegoal.subC.status == "inprogress")
          if (primegoal.subC.infotype == 'text')
            primeGoalsHTML.push  """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span>
                          <span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }' data-complete='#{ goal.completedmessage }'><input type='checkbox'/></span></li>"""
        else
          if (primegoal.subC.infotype == 'text')
            primeGoalsHTML.push """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }'><input type='checkbox'/></span></li>"""
          else
            primeGoalsHTML.push """<li class='#{ primegoal.subC.status } sub' data-userguid='#{ primegoal.userguid }' data-goalguid='#{ index }'>
                          <span class='goaltitle'><i class='fa-large icon-#{ primegoal.subC.icon }'></i>#{ primegoal.subC.goal }</span>
                          <span class='goaldeadline'>#{ primegoal.subC.deadline }</span>
                          <span class='chartbutton'><i class='fa-large icon-stats'></i></span>
                          <span class='goalstatus' data-goal='#{ primegoal.subC.goal }'><input type='checkbox'/></span></li>"""
        primeGoalsHTML.push '<span class="clearfix"></span>'


  $(".primegoals").css(
    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)"
    "-moz-opacity": 1
    "-khtml-opacity": 1
    opacity: 1
    visibility: "hidden"
  ).fadeOut 0, ->
    $(".primegoals").html primeGoalsHTML.join("")
    $(".primegoals").css(visibility: "visible").fadeIn(200)


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
  $('#addprimegoalform').hide()


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