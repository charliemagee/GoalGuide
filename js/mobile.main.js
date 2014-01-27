// Generated by CoffeeScript 1.6.3
/*global console*/

var capfirstname, chart1, checkId, checkinginfotype, congratulations, createDayToday, createInfoDate, currentDay, data, dateString, datecreated, dayToday, daysOfWeek, daysOfWeekA, daysOfWeekB, daysOfWeekC, deadline, displayMyGoalList, displayprimaryGoals, emailCompletion, emailGoal, firstname, getDate, goal, goalCategory, goalChange, goalType, goalguid, goalinfo, goalmessage, goals, incentivepic, incentivetext, index, infocreated, loadmyFiles, mygoaldate, myinfo, mytitle, newcreated, newgoal, newinfo, newinfocreated, newprimarygoal, notify, password, placeincentivetext, primarygoalChange, primarygoals, resetCompleted, showCongrats, updateStatus, user, username, users;

username = '';

password = '';

deadline = '';

infocreated = [];

myinfo = [];

newcreated = '';

mygoaldate = '';

chart1 = '';

incentivepic = '';

incentivetext = '';

placeincentivetext = '';

congratulations = '';

checkinginfotype = '';

mytitle = '';

data = [];

datecreated = '';

getDate = function(d) {
  return new Date(d.createdDate);
};

dayToday = '';

currentDay = '';

dateString = '';

firstname = '';

capfirstname = '';

notify = '';

goal = '';

emailGoal = '';

updateStatus = '';

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

users = [];

goals = [];

primarygoals = [];

newinfocreated = '';

newgoal = {};

newprimarygoal = {};

user = {};

goalmessage = '';

resetCompleted = function() {
  goals = JSON.parse(localStorage["goals"]);
  dayToday = createDayToday();
  updateStatus = "inprogress";
  $.each(goals, function(i, goal) {
    dateString = "\"" + goal.goal.recurring + "\"";
    if ((goal.goal.status = "completed") && (dateString.search(dayToday) !== -1)) {
      return goal.goal.status = updateStatus;
    }
  });
  localStorage.setItem("goals", JSON.stringify(goals));
  goalChange();
  return displayMyGoalList();
};

checkId = function() {
  if (localStorage.getItem('username') !== null) {
    return loadmyFiles();
  } else {
    $('#checkid').show();
    return setTimeout((function() {
      return $('#theloginusername').focus();
    }), 500);
  }
};

/*
  create a date for the goal info input
*/


createInfoDate = function() {
  var d, month, n;
  d = new Date();
  month = new Array();
  month[0] = "Jan";
  month[1] = "Feb";
  month[2] = "Mar";
  month[3] = "April";
  month[4] = "May";
  month[5] = "June";
  month[6] = "July";
  month[7] = "Aug";
  month[8] = "Sept";
  month[9] = "Oct";
  month[10] = "Nov";
  month[11] = "Dec";
  n = month[d.getMonth()];
  return newcreated = n + ' ' + d.getDate();
};

/*
  create a date for recurring goal check
*/


createDayToday = function() {
  return currentDay = new Date().getDay();
};

$("#checkid").keydown(function(event) {
  if (event.keyCode === 13) {
    return $("#loginbutton").trigger("click");
  }
});

$("#logoutbutton").click(function() {
  $('#logout').hide();
  localStorage.removeItem('firstname');
  localStorage.removeItem('goals');
  localStorage.removeItem('notify');
  localStorage.removeItem('primarygoals');
  localStorage.removeItem('secret');
  localStorage.removeItem('username');
  localStorage.removeItem('users');
  return location.reload();
});

$('#loginbutton').click(function() {
  users = JSON.parse(localStorage["users"]);
  username = $("#theloginusername").val();
  password = $("#theloginpassword").val();
  return $.each(users, function(i, user) {
    if (user.username === username && user.password === password) {
      $('#checkid').hide();
      localStorage.setItem("secret", "this is a secret");
      localStorage.setItem("username", username);
      localStorage.removeItem("users");
      return loadmyFiles();
    } else {
      return $('#errorlogin').show();
    }
  });
});

loadmyFiles = function() {
  username = localStorage.getItem("username");
  $.getJSON(username + "user.json", function(data) {
    var capitaliseFirstLetter;
    capitaliseFirstLetter = function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1);
    };
    localStorage.setItem("user", JSON.stringify(data));
    user = JSON.parse(localStorage.getItem("user"));
    notify = user.notify;
    firstname = user.firstname;
    capfirstname = capitaliseFirstLetter(firstname);
    localStorage.setItem("firstname", capfirstname);
    localStorage.setItem("notify", notify);
    return localStorage.removeItem("user");
  });
  $.getJSON(username + "primary.json", function(data) {
    return localStorage.setItem("primarygoals", JSON.stringify(data));
  });
  return $.getJSON(username + ".json", function(data) {
    localStorage.setItem("goals", JSON.stringify(data));
    $("#goalcontent").show();
    $("#addgoal").show();
    firstname = localStorage.getItem("firstname");
    $("#studentname").html(firstname + "'s" + " Goals");
    $('#goalscontainer').show();
    $('#primarygoalscontainer').show();
    $('#school').show();
    $('#logout').hide();
    $('#checkid').hide();
    $('#home').hide();
    $('#work').hide();
    $('#personal').hide();
    displayMyGoalList();
    return displayprimaryGoals();
  });
};

$('#home').click(function() {
  $('#schoolwrapper').removeClass('show-menu');
  $('#schoolsolowrapper').removeClass('show-menu');
  return $('#schoolprimarywrapper').removeClass('show-menu');
});

$('.menubar').click(function() {
  return $('.menustuff').show();
});

$('#hidescreen').click(function() {
  return $('.menustuff').hide();
});

$('#homemenu').click(function() {
  $('.menustuff').hide();
  $('#home').show();
  if (localStorage.getItem('username') !== null) {
    $('#logout').show();
  } else {
    $('#checkid').show();
  }
  $('#school').hide();
  $('#work').hide();
  $('#personal').hide();
  $('#goalscontainer').hide();
  return $('#primarygoalscontainer').hide();
});

$('#schoolmenu').click(function() {
  $('.menustuff').hide();
  $('#checkid').hide();
  $('#logout').hide();
  $('#goalscontainer').show();
  $('#primarygoalscontainer').show();
  $('#school').show();
  $('#home').hide();
  $('#work').hide();
  $('#personal').hide();
  goalCategory = "school";
  displayMyGoalList();
  return displayprimaryGoals();
});

$('#workmenu').click(function() {
  $('.menustuff').hide();
  $('#checkid').hide();
  $('#logout').hide();
  $('#goalscontainer').show();
  $('#primarygoalscontainer').show();
  $('#work').show();
  $('#home').hide();
  $('#school').hide();
  $('#personal').hide();
  goalCategory = "work";
  displayMyGoalList();
  return displayprimaryGoals();
});

$('#personalmenu').click(function() {
  $('.menustuff').hide();
  $('#checkid').hide();
  $('#logout').hide();
  $('#goalscontainer').show();
  $('#primarygoalscontainer').show();
  $('#personal').show();
  $('#home').hide();
  $('#school').hide();
  $('#work').hide();
  goalCategory = "personal";
  displayMyGoalList();
  return displayprimaryGoals();
});

$('#primarymenu').click(function() {
  $('#goalscontainer').animate({
    left: '500px'
  }, 'fast');
  return $('#primarygoalscontainer').animate({
    left: '7px'
  }, 'slow');
});

$('#solomenu').click(function() {
  $('#primarygoalscontainer').animate({
    left: '500px'
  }, 'fast');
  return $('#goalscontainer').animate({
    left: '7px'
  }, 'slow');
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
  var completedHTML, inprogressHTML;
  completedHTML = [];
  inprogressHTML = [];
  goals = JSON.parse(localStorage["goals"]);
  $.each(goals, function(i, goal) {
    var compareDate, day, month, now, year;
    newinfocreated = JSON.stringify(goal.goal.infocreated);
    now = new Date();
    year = now.getFullYear();
    month = now.getMonth() + 1;
    if (month <= 9) {
      month = '0' + month;
    }
    day = now.getDate();
    if (day <= 9) {
      day = '0' + day;
    }
    compareDate = year + '-' + month + '-' + day;
    if (goal.goal.category === goalCategory) {
      if (goal.goal.deadline && (goal.goal.status === 'inprogress') && (goal.goal.deadline < compareDate)) {
        goal.goal.status = 'missed';
      }
      if (goal.goal.status === 'completed') {
        return completedHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' data-incentivetext='" + goal.goal.incentivetext + "' data-incentivepic='" + goal.goal.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + goal.goal.icon + "'></i></span>\n<span class='goaltitle'>" + goal.goal.goal + "</span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + goal.goal.myinfo + "]' data-goal='" + goal.goal.goal + "'></i></span></li>");
      } else if (goal.goal.status === "inprogress") {
        if (goal.goal.infotype === 'text') {
          return inprogressHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' data-incentivetext='" + goal.goal.incentivetext + "' data-incentivepic='" + goal.goal.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + goal.goal.icon + "'></i></span>\n<span class='goaltitle'>" + goal.goal.goal + "<br/><span class='goaldeadline'>" + goal.goal.deadline + "</span></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'/></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "' data-complete='" + goal.goal.completedmessage + "'><input type='checkbox' /></span></li>");
        } else {
          return inprogressHTML.push("<li class='" + goal.goal.status + "' data-info='" + goal.goal.infotype + "' data-goalguid='" + goal.goal.goalguid + "' data-incentivetext='" + goal.goal.incentivetext + "' data-incentivepic='" + goal.goal.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + goal.goal.icon + "'></i></span>\n<span class='goaltitle'>" + goal.goal.goal + "<br/><span class='goaldeadline'>" + goal.goal.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + goal.goal.goal + "' data-complete='" + goal.goal.completedmessage + "'><input type='checkbox' /></span>\n<span class='clearfix'></span></li>");
        }
      }
    }
  });
  $(".goalsinprogress").html(inprogressHTML.join(""));
  return $(".goalscompleted").html(completedHTML.join(""));
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
    congratulations = $(this).parent().data("complete");
    emailGoal = $(this).parent().data('goal');
    newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10);
    mygoaldate = createInfoDate();
    updateStatus = 'completed';
    incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")';
    $.each(goals, function(index, goal) {
      if (goal.goal.goalguid === goalguid) {
        if (goal.goal.infotype === 'text') {
          goal.goal.myinfo.push(newinfo);
          goal.goal.infocreated.push(mygoaldate);
        }
        goal.goal.status = updateStatus;
        goal.goal.datecompleted = mygoaldate;
        goalmessage = firstname + ' has completed this goal: ' + goal.goal.goal;
        localStorage.setItem("goalmessage", JSON.stringify(goalmessage));
        return false;
      }
    });
    localStorage.setItem("goals", JSON.stringify(goals));
    $(this).find('.info').val('');
    $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true);
    showCongrats();
    emailCompletion(goalmessage);
    goalChange();
    return displayMyGoalList();
  }
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
      primaryGoalsHTML.push("<li class='parent'  data-goalguid='" + primarygoal.primarygoal.goalguid + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.goal + "</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='" + primarygoal.primarygoal.goalguid + "'><b>X</b> </button></span></li>");
      if (primarygoal.primarygoal.subA.status === 'completed') {
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subA.infocreated);
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub' data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-incentivetext='" + primarygoal.primarygoal.subA.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subA.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subA.myinfo + "]' data-goal='" + primarygoal.primarygoal.subA.goal + "'></i></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub'  data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-subB='subA' data-incentivetext='" + primarygoal.primarygoal.subA.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subA.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subA.myinfo + "]' data-goal='" + primarygoal.primarygoal.subA.goal + "'></i></span></li>");
        }
      } else if (primarygoal.primarygoal.subA.status === "inprogress") {
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub'  data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-subB='subA' data-incentivetext='" + primarygoal.primarygoal.subA.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subA.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span class='gatherinfo'><input type='text' name='infoA' class='info'></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub'  data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-subB='subA' data-incentivetext='" + primarygoal.primarygoal.subA.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subA.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subA.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub'  data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-subB='subA'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subA.status + " sub'  data-info='" + primarygoal.primarygoal.subA.infotype + "' data-goalguid='" + primarygoal.primarygoal.subA.goalguid + "' data-subB='subA'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subA.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subA.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subA.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subA.goal + "'><input type='checkbox'/></span></li>");
        }
      }
      if (primarygoal.primarygoal.subB.status === 'completed') {
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subB.infocreated);
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB' data-incentivetext='" + primarygoal.primarygoal.subB.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subB.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subB.myinfo + "]' data-goal='" + primarygoal.primarygoal.subB.goal + "'></i></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB' data-incentivetext='" + primarygoal.primarygoal.subB.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subB.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subB.myinfo + "]' data-goal='" + primarygoal.primarygoal.subB.goal + "'></i></span></li>");
        }
      } else if (primarygoal.primarygoal.subB.status === "inprogress") {
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB' data-incentivetext='" + primarygoal.primarygoal.subB.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subB.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB' data-incentivetext='" + primarygoal.primarygoal.subB.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subB.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subB.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subB.status + " sub'  data-info='" + primarygoal.primarygoal.subB.infotype + "' data-goalguid='" + primarygoal.primarygoal.subB.goalguid + "' data-subB='subB'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subB.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subB.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subB.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subB.goal + "'><input type='checkbox'/></span></li>");
        }
      }
      if (primarygoal.primarygoal.subC.status === 'completed') {
        newinfocreated = JSON.stringify(primarygoal.primarygoal.subC.infocreated);
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC' data-incentivetext='" + primarygoal.primarygoal.subC.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subC.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subC.myinfo + "]' data-goal='" + primarygoal.primarygoal.subC.goal + "'></i></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC' data-incentivetext='" + primarygoal.primarygoal.subC.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subC.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>\n<span><i class='fa-medium icon-stats chartbutton' data-infocreated='" + newinfocreated + "' data-myinfo='[" + primarygoal.primarygoal.subC.myinfo + "]' data-goal='" + primarygoal.primarygoal.subC.goal + "'></i></span></li>");
        }
      } else if (primarygoal.primarygoal.subC.status === "inprogress") {
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC' data-incentivetext='" + primarygoal.primarygoal.subC.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subC.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC' data-incentivetext='" + primarygoal.primarygoal.subC.incentivetext + "' data-incentivepic='" + primarygoal.primarygoal.subC.incentivepic + "' >\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>\n<span class='goalremove primaryremove'><img src='images/spacer.png' /></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "' data-complete='" + goal.completedmessage + "'><input type='checkbox'/></span></li>");
        }
      } else {
        if (primarygoal.primarygoal.subC.infotype === 'text') {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox'/></span></li>");
        } else {
          primaryGoalsHTML.push("<li class='" + primarygoal.primarygoal.subC.status + " sub'  data-info='" + primarygoal.primarygoal.subC.infotype + "' data-goalguid='" + primarygoal.primarygoal.subC.goalguid + "' data-subB='subC'>\n<span class='goalicon'><i class='fa-medium icon-" + primarygoal.primarygoal.subC.icon + "'></i></span>\n<span class='goaltitle'>" + primarygoal.primarygoal.subC.goal + "<br/><span class='goaldeadline'>" + primarygoal.primarygoal.subC.deadline + "</span></span>                        <span class='goalremove primaryremove'><img src='images/spacer.png' /></span>\n<span class='goalstatus' data-goal='" + primarygoal.primarygoal.subC.goal + "'><input type='checkbox'/></span></li>");
        }
      }
    }
    return primaryGoalsHTML.push('<span class="clearfix"></span>');
  });
  return $(".primarygoals").html(primaryGoalsHTML.join(""));
};

$(".primarygoals").delegate("input[type=checkbox]", "click", function() {
  goalguid = $(this).closest('li').data("goalguid");
  if ($(this).closest('li').hasClass('completed')) {
    $(this).closest('li').removeClass("completed").addClass("inprogress").prop("checked", false);
    updateStatus = 'inprogress';
    $.each(primarygoals, function(index, primarygoal) {
      if (primarygoal.primarygoal.subA.goalguid === goalguid) {
        primarygoal.primarygoal.subA.status = updateStatus;
        return false;
      } else if (primarygoal.primarygoal.subB.goalguid === goalguid) {
        primarygoal.primarygoal.subB.status = updateStatus;
        return false;
      } else if (primarygoal.primarygoal.subC.goalguid === goalguid) {
        primarygoal.primarygoal.subC.status = updateStatus;
        return false;
      }
    });
    localStorage.setItem("primarygoals", JSON.stringify(primarygoals));
    primarygoalChange();
    return displayprimaryGoals();
  } else if ($(this).closest('li').hasClass('inprogress')) {
    checkinginfotype = $(this).closest('li').data('info');
    if ((!$(this).closest('li').find('input[type="text"]').val()) && (checkinginfotype === 'text')) {
      alert("You have to enter a number before this goal can be completed.");
      return $(this).removeAttr('checked');
    } else {
      newinfo = parseInt($(this).closest('li').find('input[type="text"]').val(), 10);
      mygoaldate = createInfoDate();
      updateStatus = 'completed';
      $.each(primarygoals, function(index, primarygoal) {
        if (primarygoal.primarygoal.subA.goalguid === goalguid) {
          if (primarygoal.primarygoal.subA.infotype === 'text') {
            primarygoal.primarygoal.subA.myinfo.push(newinfo);
            primarygoal.primarygoal.subA.infocreated.push(mygoaldate);
          }
          primarygoal.primarygoal.subA.status = updateStatus;
          primarygoal.primarygoal.subA.datecompleted = mygoaldate;
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subA.goal;
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage));
          return false;
        } else if (primarygoal.primarygoal.subB.goalguid === goalguid) {
          if (primarygoal.primarygoal.subB.infotype === 'text') {
            primarygoal.primarygoal.subB.myinfo.push(newinfo);
            primarygoal.primarygoal.subB.infocreated.push(mygoaldate);
          }
          primarygoal.primarygoal.subB.status = updateStatus;
          primarygoal.primarygoal.subB.datecompleted = mygoaldate;
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subB.goal;
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage));
          return false;
        } else if (primarygoal.primarygoal.subC.goalguid === goalguid) {
          if (primarygoal.primarygoal.subC.infotype === 'text') {
            primarygoal.primarygoal.subC.myinfo.push(newinfo);
            primarygoal.primarygoal.subC.infocreated.push(mygoaldate);
          }
          primarygoal.primarygoal.subC.status = updateStatus;
          primarygoal.primarygoal.subC.datecompleted = mygoaldate;
          goalmessage = firstname + ' has completed this goal: ' + primarygoal.primarygoal.subC.goal;
          localStorage.setItem("goalmessage", JSON.stringify(goalmessage));
          return false;
        }
      });
      localStorage.setItem("primarygoals", JSON.stringify(primarygoals));
      emailCompletion();
      $(this).find('.info').val('');
      $(this).closest('li').removeClass("inprogress missed").addClass("completed").prop("checked", true);
      emailCompletion(goalmessage);
      primarygoalChange();
      return displayprimaryGoals();
    }
  } else {
    $(this).closest('li').removeClass("missed").addClass("inprogress").prop("checked", false);
    updateStatus = 'inprogress';
    $.each(primarygoals, function(index, primarygoal) {
      if (primarygoal.primarygoal.subA.goalguid === goalguid) {
        primarygoal.primarygoal.subA.status = updateStatus;
        return false;
      } else if (primarygoal.primarygoal.subB.goalguid === goalguid) {
        primarygoal.primarygoal.subB.status = updateStatus;
        return false;
      } else if (primarygoal.primarygoal.subC.goalguid === goalguid) {
        primarygoal.primarygoal.subC.status = updateStatus;
        return false;
      }
    });
    localStorage.setItem("primarygoals", JSON.stringify(primarygoals));
    primarygoalChange();
    return displayprimaryGoals();
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
  $("#incentivebox").css('top', -10);
  $("#incentivebox").css('right', 25);
  $("#incentivebox").show();
  $(".chart-backdrop").show();
  incentivetext = $(this).closest('li').data('incentivetext');
  incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")';
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

$(".primarygoals").on("click", "i.chartbutton", function() {
  $("#chartbox").show();
  $("#incentivebox").css('top', -10);
  $("#incentivebox").css('right', 25);
  $("#incentivebox").show();
  $(".chart-backdrop").show();
  incentivetext = $(this).closest('li').data('incentivetext');
  incentivepic = 'url("' + $(this).closest('li').data('incentivepic') + '")';
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

showCongrats = function() {
  $("#incentivebox").css('top', -90);
  $("#incentivebox").css('right', 430);
  placeincentivetext = '<p>' + congratulations + '</p>';
  $("#incentivetext").html(placeincentivetext);
  $("#incentivepic").css('background-image', incentivepic);
  $("#incentivebox").fadeIn("slow");
  return setTimeout("$('#incentivebox').hide();", 5000);
};

emailCompletion = function() {
  var postThis;
  postThis = {};
  postThis.notify = localStorage.getItem("notify");
  postThis.goalmessage = localStorage.getItem("goalmessage");
  console.log(goalmessage);
  return $.ajax({
    url: "goalNotify.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Yay, the email notify worked!");
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
  username = localStorage.getItem('username');
  postThis.userid = username;
  return $.ajax({
    url: "goalChange.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Yay, the goalChange save worked!");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("GoalChange save didn't work so good...");
    }
  });
};

primarygoalChange = function() {
  var postThis;
  postThis = {};
  postThis.primarygoals = localStorage.getItem("primarygoals");
  username = localStorage.getItem('username');
  postThis.userid = username;
  return $.ajax({
    url: "primarygoalChange.php",
    type: "POST",
    data: postThis,
    success: function(response, textStatus, jqXHR) {
      return console.log("Yay, the primaryGoal save worked!");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return console.log("PrimaryGoal save didn't work so good...");
    }
  });
};
