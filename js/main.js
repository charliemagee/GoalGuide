// Generated by CoffeeScript 1.6.3
/*global console*/

var alertmessage, chart1, checkinginfotype, createDayToday, createGuid, createInfoDate, currentDate, currentDay, data, dataDate, dateString, datecreated, dayToday, daysOfWeek, daysOfWeekA, daysOfWeekB, daysOfWeekC, deadline, displayMyGoalList, displayUserList, displayprimaryGoals, emailGoal, findAndRemove, findAndRemoveUserGoals, firstname, future, futureDate, getDate, goal, goalCategory, goalChange, goalTitle, goalType, goalguid, goalinfo, goals, incentivepic, incentivetext, index, infocreated, init, logSummary, mygoaldate, myinfo, mytitle, newcreated, newgoal, newinfo, newinfocreated, notify, placeincentivetext, primarygoalChange, primarygoals, resetCompleted, setDate, showThatGoalList, showUserList, updateGoal, updateStatus, userguid, username;

showUserList = '';

username = '';

userguid = '';

goalTitle = '';

showThatGoalList = '';

deadline = '';

infocreated = [];

myinfo = [];

newcreated = '';

mygoaldate = '';

chart1 = '';

incentivepic = '';

incentivetext = '';

placeincentivetext = '';

alertmessage = '';

checkinginfotype = '';

mytitle = '';

data = [];

datecreated = '';

dataDate = '';

getDate = function(d) {
  return new Date(d.createdDate);
};

dayToday = '';

currentDate = '';

setDate = '';

futureDate = '';

currentDay = '';

dateString = '';

future = '';

firstname = '';

notify = '';

goal = '';

emailGoal = '';

updateStatus = '';

updateGoal = '';

index = '';

goalguid = '';

goalinfo = [];

newinfo = '';

goalCategory = 'school';

goalType = 'solo';

daysOfWeek = [];

daysOfWeekA = [];

daysOfWeekB = [];

daysOfWeekC = [];

goals = [];

primarygoals = [];

newinfocreated = '';

newgoal = {};

/*
  this checks localStorage for data. If none, use the arrays above.
*/


init = function() {
  return $.getJSON("users.json", function(data) {
    localStorage.setItem("users", JSON.stringify(data));
    return displayUserList();
  });
};

resetCompleted = function() {
  goals = JSON.parse(localStorage["goals"]);
  dayToday = createDayToday();
  updateStatus = 'inprogress';
  $.each(goals, function(i, goal) {
    dateString = '"' + goal.goal.recurring + '"';
    if ((goal.goal.status = 'completed') && (dateString.search(dayToday) !== -1)) {
      return goal.goal.status = updateStatus;
    }
  });
  localStorage.setItem("goals", JSON.stringify(goals));
  goalChange();
  return displayMyGoalList();
};

/*
 this function displays the list of users with a bit of fade for visual interest
*/


displayUserList = function() {
  var newHTML, users;
  users = JSON.parse(localStorage["users"]);
  newHTML = [];
  $.each(users, function(index, user) {
    return newHTML.push("<li data-username='" + user.user.username + "' data-userguid='" + user.user.userguid + "' data-notify='" + user.user.notify + "' data-firstname='" + user.user.firstname + "'><span class='userfullname'>" + user.user.firstname + " " + user.user.lastname + "</span><span><button type=\"button\" class=\"btn btn-mini btn-danger pull-right removeuser\"><b>X</b> </button></span></li>");
  });
  return $(".users").css({
    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)",
    "-moz-opacity": 1,
    "-khtml-opacity": 1,
    opacity: 1,
    visibility: "hidden"
  }).fadeOut(0, function() {
    $(".users").html(newHTML.join(""));
    return $(".users").css({
      visibility: "visible"
    }).fadeIn(200);
  });
};

$('#adduser').click(function() {
  $("#addgoalform").hide();
  $("#addprimarygoalform").hide();
  return $("#adduserform").show();
});

/*
  create a user guid
*/


createGuid = function() {
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(c) {
    var r, v;
    r = Math.random() * 16 | 0;
    v = (c === "x" ? r : r & 0x3 | 0x8);
    return v.toString(16);
  });
};

/*
  create a date for the goal info input
*/


createInfoDate = function() {
  currentDate = new Date();
  return newcreated = currentDate.getDate() + "/" + currentDate.getMonth();
};

/*
  create a date for recurring goal check
*/


createDayToday = function() {
  return currentDay = new Date().getDay();
};

/*
 this creates an array of UserGoals that is empty, adds the User to the usersArray, resaves the usersArray with the new info, then clears the form
*/


$('#saveuser').click(function() {
  datecreated = new Date().toString();
  userguid = createGuid();
  localStorage.setItem(userguid + "Goals", "");
  users[userguid] = {
    firstname: $('#thefirstname').val(),
    lastname: $('#thelastname').val(),
    email: $('#theemail').val(),
    password: $('#thepassword').val(),
    datecreated: datecreated,
    username: $('#theusername').val(),
    userguid: userguid,
    notify: $('#thenotifications').val()
  };
  localStorage.setItem("users", JSON.stringify(users));
  $("#adduserform").hide();
  $('.textempty').val('');
  logSummary();
  return displayUserList();
});

$('#addgoal').click(function() {
  $("#addgoalform").show();
  $("#adduser").show();
  $("#adduserform").hide();
  return $("#addprimarygoalform").hide();
});

$('#addprimarygoal').click(function() {
  $("#addprimarygoalform").show();
  $("#addgoalform").hide();
  $("#adduser").show();
  return $("#adduserform").hide();
});

$('.sologoal').click(function() {
  $('.primarycategory').hide();
  $('.category').show();
  $('#addprimarygoal').hide();
  return $('#addgoal').show();
});

$('.primarygoal').click(function() {
  $('.primarycategory').show();
  $('.category').hide();
  $('#addprimarygoal').show();
  return $('#addgoal').hide();
});

/*
this adds a goal to the goalsArray, resaves the goalsArray with the new info, resaves the usersGoals to localstorage, then clears the form
*/


$('#savegoal').click(function() {
  datecreated = new Date().toString();
  mygoaldate = createInfoDate();
  goalguid = createGuid();
  daysOfWeek = $("input[name=days]:checked").map(function() {
    return $(this).val();
  }).get();
  newgoal = {
    goal: {
      goalguid: goalguid,
      category: $("#thecategory").val().toLowerCase(),
      datecreated: datecreated,
      goal: $("#thegoal").val(),
      icon: $("input[name=icon]:checked").val(),
      status: "inprogress",
      infotype: $("input[name=theinfotype]:checked").val(),
      infocreated: [],
      myinfo: [],
      recurring: daysOfWeek,
      completedmessage: $("#thecomplete").val(),
      deadline: $("#thedeadline").val(),
      incentivepic: $("input[name=incentivepic]:checked").val(),
      incentivetext: $("#theincentivetext").val(),
      userguid: userguid,
      username: username
    }
  };
  goals.push(newgoal);
  localStorage.setItem("goals", JSON.stringify(goals));
  $("#addgoalform").hide();
  $("#daysoftheweek").hide();
  $(".textempty").val('');
  $('.uncheckit input').removeAttr('checked');
  goalChange();
  return displayMyGoalList();
});

/*
this adds a goal to the goalsArray, resaves the goalsArray with the new info, resaves the usersGoals to localstorage, then clears the form
*/


$('#saveprimarygoal').click(function() {
  datecreated = new Date().toString();
  goalguid = createGuid();
  daysOfWeekA = $("#daysoftheweekA input[name=days]:checked").map(function() {
    return $(this).val();
  }).get();
  daysOfWeekB = $("#daysoftheweekB input[name=days]:checked").map(function() {
    return $(this).val();
  }).get();
  daysOfWeekC = $("#daysoftheweekC input[name=days]:checked").map(function() {
    return $(this).val();
  }).get();
  newgoal = {
    primarygoal: {
      category: $("#theprimarycategory").val().toLowerCase(),
      datecreated: datecreated,
      goal: $("#theprimarygoal").val(),
      icon: $("input[name=icon]:checked").val(),
      status: "inprogress",
      username: username,
      userguid: userguid,
      subA: {
        goal: $("#thegoalA").val(),
        icon: $("#theiconsA input[name=iconA]:checked").val(),
        status: "inprogress",
        infotype: $("#infotypeA input[name=theinfotypeA]:checked").val(),
        recurring: daysOfWeekA,
        completedmessage: $("#thecompleteA").val(),
        deadline: $("#thedeadlineA").val()
      },
      subB: {
        goal: $("#thegoalB").val(),
        icon: $("#theiconsB input[name=iconB]:checked").val(),
        status: "inprogress",
        infotype: $("#infotypeB input[name=theinfotype]:checked").val(),
        recurring: daysOfWeekB,
        completedmessage: $("#thecompleteB").val(),
        deadline: $("#thedeadlineB").val()
      },
      subC: {
        goal: $("#thegoalC").val(),
        icon: $("#theiconsC input[name=iconC]:checked").val(),
        status: "inprogress",
        infotype: $("#infotypeC input[name=theinfotype]:checked").val(),
        recurring: daysOfWeekC,
        completedmessage: $("#thecompleteC").val(),
        deadline: $("#thedeadlineC").val()
      }
    }
  };
  primarygoals.push(newgoal);
  localStorage.setItem("primarygoals", JSON.stringify(primarygoals));
  $("#addgoalform").hide();
  $("#daysoftheweek").hide();
  $(".textempty").val('');
  $('.uncheckit input').removeAttr('checked');
  primarygoalChange();
  return displayprimaryGoals();
});

/*
this uses delegate because the lines of info are dynamically placed and won't respond to a simple click. It highlights the clicked User and displays his goals
*/


$(".users").delegate("li", "click", function() {
  $(".goalsection").html('');
  username = $(this).closest('li').data("username");
  $.getJSON(username + "primary.json", function(data) {
    return localStorage.setItem("primarygoals", JSON.stringify(data));
  });
  $.getJSON(username + ".json", function(data) {
    return localStorage.setItem("goals", JSON.stringify(data));
  });
  $(this).addClass("active").siblings("li").removeClass("active");
  if (goalType === 'solo') {
    $("#goalcontent").show();
    $('#primarygoalcontent').hide();
  } else {
    $("#goalcontent").hide();
    $('#primarygoalcontent').show();
  }
  $("#adduser").show();
  $("#addgoalform").hide();
  $("#adduserform").hide();
  $("#school").addClass('active');
  userguid = $(this).closest('li').data("userguid");
  firstname = $(this).closest('li').data('firstname');
  notify = $(this).closest('li').data('notify');
  if (goalType === 'solo') {
    $("#addgoal").show();
    return displayMyGoalList();
  } else {
    $("#addprimarygoal").show();
    return displayprimaryGoals();
  }
});

$(".category").click(function() {
  goalCategory = $(this).data("category");
  return displayMyGoalList();
});

$(".primarycategory").click(function() {
  goalCategory = $(this).data("category");
  return displayprimaryGoals();
});

displayMyGoalList = function() {
  var completedHTML, inprogressHTML, missedHTML;
  completedHTML = [];
  inprogressHTML = [];
  missedHTML = [];
  goals = JSON.parse(localStorage["goals"]);
  $.each(goals, function(i, goal) {
    newinfocreated = JSON.stringify(goal.goal.infocreated);
    if (goal.goal.category === goalCategory) {
      if (goal.goal.status === 'completed') {
        return completedHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "'>\n<span class='goaltitle'><i class='fa-large icon-" + goal.goal.icon + "'></i>" + goal.goal.goal + "</span>\n<span class='goaldeadline'>" + goal.goal.deadline + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b></button></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "' ><input type='checkbox' checked/></span>\n<span><i class='fa-large icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + goal.goal.myinfo + "]' data-incentivetext='" + goal.goal.incentivetext + "' data-incentivepic='" + goal.goal.incentivepic + "' data-goal='" + goal.goal.goal + "'></i></span></li>");
      } else if (goal.goal.status === "inprogress") {
        if (goal.goal.infotype === 'text') {
          return inprogressHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' >\n<span class='goaltitle'><i class='fa-large icon-" + goal.goal.icon + "'></i>" + goal.goal.goal + "</span>\n<span class='goaldeadline'>" + goal.goal.deadline + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "' data-complete='" + goal.goal.completedmessage + "'><input type='checkbox' /></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>");
        } else {
          return inprogressHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' >\n<span class='goaltitle'><i class='fa-large icon-" + goal.goal.icon + "'></i>" + goal.goal.goal + "</span>\n<span class='goaldeadline'>" + goal.goal.deadline + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "' data-complete='" + goal.goal.completedmessage + "'><input type='checkbox' /></span></li>");
        }
      } else {
        if (goal.goal.infotype === 'text') {
          return missedHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' >\n<span class='goaltitle'><i class='fa-large icon-" + goal.goal.icon + "'></i>" + goal.goal.goal + "</span>\n<span class='goaldeadline'>" + goal.goal.deadline + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "'><input type='checkbox' /></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>");
        } else {
          return missedHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' >\n<span class='goaltitle'><i class='fa-large icon-" + goal.goal.icon + "'></i>" + goal.goal.goal + "</span>\n<span class='goaldeadline'>" + goal.goal.deadline + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "'><input type='checkbox' /></span></li>");
        }
      }
    }
  });
  $(".goalsinprogress").html(inprogressHTML.join(""));
  $(".goalscompleted").html(completedHTML.join(""));
  $(".goalsmissed").html(missedHTML.join(""));
  return $(".goalsection").css({
    visibility: "visible"
  }).fadeIn(200);
};

$(".goalscompleted").delegate("input[type=checkbox]", "click", function() {
  goalguid = $(this).closest('li').data("goalguid");
  emailGoal = $(this).parent().data('goal');
  $(this).closest('li').removeClass("completed").addClass("inprogress").prop("checked", false);
  updateStatus = 'inprogress';
  $.each(goals, function(index, goal) {
    if (goal.goal.goalguid === goalguid) {
      goal.goal.status = updateStatus;
      return false;
    }
  });
  localStorage.setItem("goals", JSON.stringify(goals));
  goalChange();
  return displayMyGoalList();
});

$(".goalsinprogress").delegate("input[type=checkbox]", "click", function() {
  checkinginfotype = $(this).closest('li').data('info');
  if ((!$(this).closest('li').find('input[type="text"]').val()) && (checkinginfotype === 'text')) {
    alert("You have to enter a number before this goal can be completed.");
    return $(this).removeAttr('checked');
  } else {
    goalguid = $(this).closest('li').data("goalguid");
    alertmessage = $(this).parent().data("complete");
    emailGoal = $(this).parent().data('goal');
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10);
    mygoaldate = createInfoDate();
    updateStatus = 'completed';
    $.each(goals, function(index, goal) {
      if (goal.goal.goalguid === goalguid) {
        if (goal.goal.infotype === 'text') {
          goal.goal.myinfo.push(newinfo);
          goal.goal.infocreated.push(mygoaldate);
        }
        goal.goal.status = updateStatus;
        goal.goal.datecompleted = mygoaldate;
        alert(alertmessage);
        return false;
      }
    });
    localStorage.setItem("goals", JSON.stringify(goals));
    logSummary();
    $(this).find('.info').val('');
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true);
    goalChange();
    return displayMyGoalList();
  }
});

$(".goalsmissed").delegate("input[type=checkbox]", "click", function() {
  goalguid = $(this).closest('li').data("goalguid");
  emailGoal = $(this).parent().data('goal');
  $(this).closest('li').removeClass("missed").addClass("inprogress").prop("checked", false);
  updateStatus = 'inprogress';
  $.each(goals, function(index, goal) {
    if (goal.goal.goalguid === goalguid) {
      goal.goal.status = updateStatus;
      return false;
    }
  });
  localStorage.setItem("goals", JSON.stringify(goals));
  goalChange();
  return displayMyGoalList();
});

$(".primarygoal").click(function() {
  $('#goalcontent').hide();
  $('#primarygoalcontent').show();
  goalType = 'primary';
  return displayprimaryGoals();
});

$(".sologoal").click(function() {
  $('#goalcontent').show();
  $('#primarygoalcontent').hide();
  goalType = 'solo';
  return displayMyGoalList();
});

displayprimaryGoals = function() {
  var primaryGoalsHTML;
  primaryGoalsHTML = [];
  primarygoals = JSON.parse(localStorage["primarygoals"]);
  $.each(primarygoals, function(index, primarygoal) {
    if (primarygoal.primarygoal.category === goalCategory) {
      primaryGoalsHTML.push("<li class='parent' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'\">\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.icon + "'></i>" + primarygoal.primarygoal.goal + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='" + primarygoal.primarygoal.goalguid + "'><b>X</b> </button></span></li>");
      if (primarygoal.primarygoal.subA.status === 'completed') {
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox' checked></span></li>");
        }
      } else if (primarygoal.primarygoal.subA.status === "inprogress") {
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='infoA' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subA.icon + "'></i>" + primarygoal.primarygoal.subA.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox'/></span></li>");
        }
      }
      if (primarygoal.primarygoal.subB.status === 'completed') {
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox' checked></span></li>");
        }
      } else if (primarygoal.primarygoal.subB.status === "inprogress") {
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subB.icon + "'></i>" + primarygoal.primarygoal.subB.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox'/></span></li>");
        }
      }
      if (primarygoal.primarygoal.subC.status === 'completed') {
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox' checked></span></li>");
        }
      } else if (primarygoal.primarygoal.subC.status === "inprogress") {
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub' data-userguid='" + primarygoal.primarygoal.userguid + "' data-goalguid='" + index + "'>\n<span class='goaltitle'><i class='fa-large icon-" + primarygoal.primarygoal.subC.icon + "'></i>" + primarygoal.primarygoal.subC.goal + "</span>\n<span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox'/></span></li>");
        }
      }
    }
    return primaryGoalsHTML.push('<span class="clearfix"></span>');
  });
  return $(".primarygoals").css({
    "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=1)",
    "-moz-opacity": 1,
    "-khtml-opacity": 1,
    opacity: 1,
    visibility: "hidden"
  }).fadeOut(0, function() {
    $(".primarygoals").html(primaryGoalsHTML.join(""));
    return $(".primarygoals").css({
      visibility: "visible"
    }).fadeIn(200);
  });
};

/*
find and remove user function
*/


$('.users').delegate("button", "click", function() {
  var shouldRemove;
  userguid = $(this).data("removeguid");
  shouldRemove = confirm("Are you sure you want to remove this student?");
  if (shouldRemove) {
    return findAndRemove();
  } else {
    return false;
  }
});

findAndRemove = function() {
  delete users[userguid];
  localStorage.setItem("users", JSON.stringify(users));
  localStorage.removeItem(userguid + "Goals");
  $('.goals').empty();
  logSummary();
  displayUserList();
  return findAndRemoveUserGoals(goals, 'userguid', userguid);
};

/*
find and remove users goals when user is removed
*/


findAndRemoveUserGoals = function(array, property, value) {
  return $.each(array, function(index, result) {
    if (result[property] === value) {
      array.splice(index, 1);
    }
    localStorage.setItem("goals", JSON.stringify(goals));
    return logSummary();
  });
};

/*
  delete a goal
*/


$(".goalsection").delegate("button", "click", function() {
  var i, shouldRemove;
  goalguid = $(this).closest('li').data("goalguid");
  shouldRemove = confirm("Are you sure you want to remove this goal?");
  if (!shouldRemove) {
    return false;
  } else {
    i = 0;
    while (i < goals.length) {
      if (goals[i].goal.goalguid && goals[i].goal.goalguid === goalguid) {
        goals.splice(i, 1);
        break;
      }
      i++;
    }
    localStorage.setItem("goals", JSON.stringify(goals));
    goalChange();
    return displayMyGoalList();
  }
});

$('#therecurring').click(function() {
  return $('#daysoftheweek').toggle(this.checked);
});

$('#therecurringA').click(function() {
  return $('#daysoftheweekA').toggle(this.checked);
});

$('#therecurringB').click(function() {
  return $('#daysoftheweekB').toggle(this.checked);
});

$('#therecurringC').click(function() {
  return $('#daysoftheweekC').toggle(this.checked);
});

$('#modalclose').click(function() {
  $('#adduserform').hide();
  $('#addgoalform').hide();
  return $('#addprimarygoalform').hide();
});

/*
  let's build a chart
*/


$(".goalscompleted").on("click", "i.chartbutton", function() {
  $("#chartbox").show();
  $("#incentivebox").show();
  $(".chart-backdrop").show();
  incentivetext = $(this).data('incentivetext');
  incentivepic = 'url("' + $(this).data('incentivepic') + '")';
  placeincentivetext = '<p>' + incentivetext + '</p>';
  $("#incentivetext").html(placeincentivetext);
  $("#incentivepic").css('background-image', incentivepic);
  infocreated = $(this).data('infocreated');
  myinfo = $(this).data('myinfo');
  mytitle = $(this).data('goal');
  $(function() {});
  return $("#thischart").highcharts({
    chart: {},
    title: {
      text: mytitle
    },
    legend: {
      enabled: false
    },
    xAxis: {
      categories: infocreated
    },
    series: [
      {
        data: myinfo
      }
    ]
  });
});

$('.hidechart').click(function() {
  $("#chartbox").hide();
  $("#incentivebox").hide();
  return $(".chart-backdrop").hide();
});

/*
  let's log it
*/


logSummary = function() {
  var i, key, len, postThis;
  key = void 0;
  postThis = {};
  i = 0;
  len = localStorage.length;
  while (i < len) {
    key = localStorage.key(i);
    postThis[key] = "" + localStorage.getItem(key);
    i++;
  }
  return $.ajax({
    url: "logSummary.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Hooray, it worked!");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("Didn't work so good...");
    }
  });
};

goalChange = function() {
  var postThis;
  postThis = {};
  postThis.goals = localStorage.getItem("goals");
  postThis.userid = username;
  return $.ajax({
    url: "goalChange.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Yay, the save worked!");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("Didn't work so good...");
    }
  });
};

primarygoalChange = function() {
  var postThis;
  postThis = {};
  postThis.primarygoals = localStorage.getItem("primarygoals");
  postThis.userid = username;
  return $.ajax({
    url: "primarygoalChange.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Yay, the save worked!");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("Didn't work so good...");
    }
  });
};
