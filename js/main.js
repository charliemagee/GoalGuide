// Generated by CoffeeScript 1.6.3
/*global console*/var alertmessage,chart1,checkinginfotype,createGuid,createInfoDate,currentDate,data,dataDate,datecreated,daysOfWeek,daysOfWeekA,daysOfWeekB,daysOfWeekC,deadline,displayMyGoalList,displayUserList,displayprimaryGoals,emailGoal,findAndRemove,findAndRemoveUserGoals,firstname,getDate,goal,goalCategory,goalChange,goalTitle,goalType,goalguid,goalinfo,goals,incentivepic,incentivetext,index,infocreated,init,initMine,logSummary,mygoaldate,myinfo,mytitle,newcreated,newgoal,newinfo,newinfocreated,notify,placeincentivetext,primarygoals,showThatGoalList,showUserList,updateGoal,updateStatus,userguid,username,users;showUserList="";username="";userguid="";goalTitle="";showThatGoalList="";deadline="";infocreated=[];myinfo=[];newcreated="";mygoaldate="";chart1="";incentivepic="";incentivetext="";placeincentivetext="";alertmessage="";checkinginfotype="";mytitle="";data=[];datecreated="";dataDate="";getDate=function(e){return new Date(e.createdDate)};currentDate="";firstname="";notify="";goal="";emailGoal="";updateStatus="";updateGoal="";index="";goalguid="";goalinfo=[];newinfo="";goalCategory="school";goalType="solo";daysOfWeek=[];daysOfWeekA=[];daysOfWeekB=[];daysOfWeekC=[];goals=[];primarygoals=[];newinfocreated="";newgoal={};users={"0c7270bd-38e8-4db2-ae92-244de019c543":{datecreated:"2013-10-15",email:"jimmy@example.com",firstname:"Jimmy",lastname:"Smith",username:"jimmysmith",password:"foobar",notify:"barbour@4j.lane.edu"},"0c7270bd-38e8-4db2-ae92-244de019mju7":{datecreated:"2013-10-16",email:"mary@example.com",firstname:"Mary",lastname:"Jones",username:"maryjones",password:"foobar2",notify:"barbour@4j.lane.edu"}};init=function(){localStorage.getItem("users")===null&&localStorage.setItem("users",JSON.stringify(users));localStorage.getItem("goals")===null&&localStorage.setItem("goals",JSON.stringify(goals));localStorage.getItem("primarygoals")===null&&localStorage.setItem("primarygoals",JSON.stringify(primarygoals));return displayUserList()};initMine=function(){username=prompt("What is your username?");$.getJSON(username+"primary.json",function(e){return localStorage.setItem("primarygoals",JSON.stringify(e))});return $.getJSON(username+".json",function(e){localStorage.setItem("goals",JSON.stringify(e));$("#goalcontent").show();$("#addgoal").show();return displayMyGoalList()})};displayUserList=function(){var e;e=[];$.each(users,function(t,n){return e.push('<li data-username="'+n.username+'" data-userguid="'+t+'" data-notify="'+n.notify+'" data-firstname="'+n.firstname+'"><span class="userfullname">'+n.firstname+" "+n.lastname+'</span><span><button type="button" class="btn btn-mini btn-danger pull-right removeuser" data-removeguid="'+t+'"><b>X</b> </button></span></li>')});return $(".users").css({"-ms-filter":"progid:DXImageTransform.Microsoft.Alpha(Opacity=1)","-moz-opacity":1,"-khtml-opacity":1,opacity:1,visibility:"hidden"}).fadeOut(0,function(){$(".users").html(e.join(""));return $(".users").css({visibility:"visible"}).fadeIn(200)})};$("#adduser").click(function(){$("#addgoalform").hide();$("#addprimarygoalform").hide();return $("#adduserform").show()});createGuid=function(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,function(e){var t,n;t=Math.random()*16|0;n=e==="x"?t:t&3|8;return n.toString(16)})};createInfoDate=function(){currentDate=new Date;return newcreated=currentDate.getDate()+"/"+currentDate.getMonth()};$("#saveuser").click(function(){datecreated=(new Date).toString();userguid=createGuid();localStorage.setItem(userguid+"Goals","");users[userguid]={firstname:$("#thefirstname").val(),lastname:$("#thelastname").val(),email:$("#theemail").val(),password:$("#thepassword").val(),datecreated:datecreated,username:$("#theusername").val(),userguid:userguid,notify:$("#thenotifications").val()};localStorage.setItem("users",JSON.stringify(users));$("#adduserform").hide();$(".textempty").val("");logSummary();return displayUserList()});$("#addgoal").click(function(){$("#addgoalform").show();$("#adduser").show();$("#adduserform").hide();return $("#addprimarygoalform").hide()});$("#addprimarygoal").click(function(){$("#addprimarygoalform").show();$("#addgoalform").hide();$("#adduser").show();return $("#adduserform").hide()});$(".sologoal").click(function(){$("#addprimarygoal").hide();return $("#addgoal").show()});$(".primarygoal").click(function(){$("#addprimarygoal").show();return $("#addgoal").hide()});$("#savegoal").click(function(){datecreated=(new Date).toString();mygoaldate=createInfoDate();goalguid=createGuid();daysOfWeek=$("input[name=days]:checked").map(function(){return $(this).val()}).get();newgoal={goal:{goalguid:goalguid,category:$("#thecategory").val().toLowerCase(),datecreated:datecreated,goal:$("#thegoal").val(),icon:$("input[name=icon]:checked").val(),status:"inprogress",infotype:$("input[name=theinfotype]:checked").val(),infocreated:[],myinfo:[],recurring:daysOfWeek,completedmessage:$("#thecomplete").val(),deadline:$("#thedeadline").val(),incentivepic:$("input[name=incentivepic]:checked").val(),incentivetext:$("#theincentivetext").val(),userguid:userguid,username:username}};goals.push(newgoal);localStorage.setItem("goals",JSON.stringify(goals));$("#addgoalform").hide();$("#daysoftheweek").hide();$(".textempty").val("");$(".uncheckit input").removeAttr("checked");goalChange();return displayMyGoalList()});$("#saveprimarygoal").click(function(){datecreated=(new Date).toString();goalguid=createGuid();daysOfWeekA=$("#daysoftheweekA input[name=days]:checked").map(function(){return $(this).val()}).get();daysOfWeekB=$("#daysoftheweekB input[name=days]:checked").map(function(){return $(this).val()}).get();daysOfWeekC=$("#daysoftheweekC input[name=days]:checked").map(function(){return $(this).val()}).get();primarygoals[goalguid]={category:$("#thecategory").val().toLowerCase(),datecreated:datecreated,goal:$("#theprimarygoal").val(),icon:$("input[name=icon]:checked").val(),status:"inprogress",username:username,userguid:userguid,subA:{goal:$("#thegoalA").val(),icon:$("#theiconsA input[name=iconA]:checked").val(),status:"inprogress",infotype:$("#infotypeA input[name=theinfotypeA]:checked").val(),recurring:daysOfWeekA,completedmessage:$("#thecompleteA").val(),deadline:$("#thedeadlineA").val()},subB:{goal:$("#thegoalB").val(),icon:$("#theiconsB input[name=iconB]:checked").val(),status:"inprogress",infotype:$("#infotypeB input[name=theinfotype]:checked").val(),recurring:daysOfWeekB,completedmessage:$("#thecompleteB").val(),deadline:$("#thedeadlineB").val()},subC:{goal:$("#thegoalC").val(),icon:$("#theiconsC input[name=iconC]:checked").val(),status:"inprogress",infotype:$("#infotypeC input[name=theinfotype]:checked").val(),recurring:daysOfWeekC,completedmessage:$("#thecompleteC").val(),deadline:$("#thedeadlineC").val()}};localStorage.setItem("primarygoals",JSON.stringify(primarygoals));goals=JSON.parse(localStorage.goals);$("#addgoalform").hide();$("#daysoftheweek").hide();$(".textempty").val("");$(".uncheckit input").removeAttr("checked");logSummary();return displayprimaryGoals()});$(".users").delegate("li","click",function(){goals=JSON.parse(localStorage.goals);$(this).addClass("active").siblings("li").removeClass("active");if(goalType==="solo"){$("#goalcontent").show();$("#primarygoalcontent").hide()}else{$("#goalcontent").hide();$("#primarygoalcontent").show()}$("#adduser").show();$("#addgoalform").hide();$("#adduserform").hide();$("#school").addClass("active");userguid=$(this).data("userguid");username=$(this).data("username");firstname=$(this).data("firstname");notify=$(this).data("notify");if(goalType==="solo"){$("#addgoal").show();return displayMyGoalList()}$("#addprimarygoal").show();return displayprimaryGoals()});$(".category").click(function(){goalCategory=$(this).data("category");return displayMyGoalList()});displayMyGoalList=function(){var e,t,n;e=[];t=[];n=[];goals=JSON.parse(localStorage.goals);$.each(goals,function(r,i){newinfocreated=JSON.stringify(i.goal.infocreated);if(i.goal.category===goalCategory)return i.goal.status==="completed"?e.push("<li class='"+i.goal.status+"' data-info='"+i.goal.infotype+"' data-goalguid='"+i.goal.goalguid+"'>\n<span class='goaltitle'><i class='fa-large icon-"+i.goal.icon+"'></i>"+i.goal.goal+"</span>\n<span class='goaldeadline'>"+i.goal.deadline+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal'><b>X</b></button></span>\n<span class='goalstatus' data-goal='"+i.goal.goal+"' ><input type='checkbox' checked/></span>\n<span><i class='fa-large icon-stats chartbutton' data-infocreated='"+newinfocreated+"' data-myinfo='["+i.goal.myinfo+"]' data-incentivetext='"+i.goal.incentivetext+"' data-incentivepic='"+i.goal.incentivepic+"' data-goal='"+i.goal.goal+"'></i></span></li>"):i.goal.status==="inprogress"?i.goal.infotype==="text"?t.push("<li class='"+i.goal.status+"' data-info='"+i.goal.infotype+"' data-goalguid='"+i.goal.goalguid+"' >\n<span class='goaltitle'><i class='fa-large icon-"+i.goal.icon+"'></i>"+i.goal.goal+"</span>\n<span class='goaldeadline'>"+i.goal.deadline+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='"+i.goal.goal+"' data-complete='"+i.goal.completedmessage+"'><input type='checkbox' /></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"):t.push("<li class='"+i.goal.status+"' data-info='"+i.goal.infotype+"' data-goalguid='"+i.goal.goalguid+"' >\n<span class='goaltitle'><i class='fa-large icon-"+i.goal.icon+"'></i>"+i.goal.goal+"</span>\n<span class='goaldeadline'>"+i.goal.deadline+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='"+i.goal.goal+"' data-complete='"+i.goal.completedmessage+"'><input type='checkbox' /></span></li>"):i.goal.infotype==="text"?n.push("<li class='"+i.goal.status+"' data-info='"+i.goal.infotype+"' data-goalguid='"+i.goal.goalguid+"' >\n<span class='goaltitle'><i class='fa-large icon-"+i.goal.icon+"'></i>"+i.goal.goal+"</span>\n<span class='goaldeadline'>"+i.goal.deadline+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='"+i.goal.goal+"'><input type='checkbox' /></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'/></span></li>"):n.push("<li class='"+i.goal.status+"' data-info='"+i.goal.infotype+"' data-goalguid='"+i.goal.goalguid+"' >\n<span class='goaltitle'><i class='fa-large icon-"+i.goal.icon+"'></i>"+i.goal.goal+"</span>\n<span class='goaldeadline'>"+i.goal.deadline+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' ><b>X</b></button></span>\n<span class='goalstatus' data-goal='"+i.goal.goal+"'><input type='checkbox' /></span></li>")});$(".goalsinprogress").html(t.join(""));$(".goalscompleted").html(e.join(""));$(".goalsmissed").html(n.join(""));return $(".goalsection").css({visibility:"visible"}).fadeIn(200)};$(".goalscompleted").delegate("input[type=checkbox]","click",function(){goalguid=$(this).closest("li").data("goalguid");emailGoal=$(this).parent().data("goal");$(this).closest("li").removeClass("completed").addClass("inprogress").prop("checked",!1);updateStatus="inprogress";$.each(goals,function(e,t){if(t.goal.goalguid===goalguid){t.goal.status=updateStatus;return!1}});localStorage.setItem("goals",JSON.stringify(goals));goalChange();return displayMyGoalList()});$(".goalsinprogress").delegate("input[type=checkbox]","click",function(){checkinginfotype=$(this).closest("li").data("info");if(!$(this).closest("li").find('input[type="text"]').val()&&checkinginfotype==="text"){alert("You have to enter a number before this goal can be completed.");return $(this).removeAttr("checked")}goalguid=$(this).closest("li").data("goalguid");alertmessage=$(this).parent().data("complete");emailGoal=$(this).parent().data("goal");newinfo=parseInt($(this).closest("li").find('input[type="text"]').val(),10);mygoaldate=createInfoDate();updateStatus="completed";$.each(goals,function(e,t){if(t.goal.goalguid===goalguid){if(t.goal.infotype==="text"){t.goal.myinfo.push(newinfo);t.goal.infocreated.push(mygoaldate)}t.goal.status=updateStatus;t.goal.datecompleted=mygoaldate;alert(alertmessage);return!1}});localStorage.setItem("goals",JSON.stringify(goals));logSummary();$(this).find(".info").val("");$(this).closest("li").removeClass("inprogress missed").addClass("completed").prop("checked",!0);goalChange();return displayMyGoalList()});$(".goalsmissed").delegate("input[type=checkbox]","click",function(){goalguid=$(this).closest("li").data("goalguid");emailGoal=$(this).parent().data("goal");$(this).closest("li").removeClass("missed").addClass("inprogress").prop("checked",!1);updateStatus="inprogress";$.each(goals,function(e,t){if(t.goal.goalguid===goalguid){t.goal.status=updateStatus;return!1}});localStorage.setItem("goals",JSON.stringify(goals));goalChange();return displayMyGoalList()});$(".primarygoal").click(function(){$("#goalcontent").hide();$("#primarygoalcontent").show();goalType="primary";return displayprimaryGoals()});$(".sologoal").click(function(){$("#goalcontent").show();$("#primarygoalcontent").hide();goalType="solo";return displayMyGoalList()});displayprimaryGoals=function(){var e;e=[];primarygoals=JSON.parse(localStorage.primarygoals);console.log(primarygoals);$.each(primarygoals,function(t,n){if(n.primarygoal.category===goalCategory){e.push("<li class='parent' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'\">\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.icon+"'></i>"+n.primarygoal.goal+"</span>\n<span class='goalremove'><button type='button' class='btn btn-mini btn-danger removegoal' data-removegoal='"+n.primarygoal.goalguid+"'><b>X</b> </button></span></li>");n.primarygoal.subA.status==="completed"?n.primarygoal.subA.infotype==="text"?e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"'><input type='checkbox' checked></span></li>"):n.primarygoal.subA.status==="inprogress"?n.primarygoal.subA.infotype==="text"?e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='infoA' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span></li>"):n.primarygoal.subA.infotype==="text"?e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"'><input type='checkbox'/></span></li>"):e.push("<li class='"+n.primarygoal.subA.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subA.icon+"'></i>"+n.primarygoal.subA.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subA.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subA.goal+"'><input type='checkbox'/></span></li>");n.primarygoal.subB.status==="completed"?n.primarygoal.subB.infotype==="text"?e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"'><input type='checkbox' checked></span></li>"):n.primarygoal.subB.status==="inprogress"?n.primarygoal.subB.infotype==="text"?e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span></li>"):n.primarygoal.subB.infotype==="text"?e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"'><input type='checkbox'/></span></li>"):e.push("<li class='"+n.primarygoal.subB.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subB.icon+"'></i>"+n.primarygoal.subB.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subB.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subB.goal+"'><input type='checkbox'/></span></li>");n.primarygoal.subC.status==="completed"?n.primarygoal.subC.infotype==="text"?e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"'><input type='checkbox' checked></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"'><input type='checkbox' checked></span></li>"):n.primarygoal.subC.status==="inprogress"?n.primarygoal.subC.infotype==="text"?e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span>\n<span class='gatherinfo'><input type='text' name='info' class='info'></span></li>"):e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"' data-complete='"+goal.completedmessage+"'><input type='checkbox'/></span></li>"):n.primarygoal.subC.infotype==="text"?e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"'><input type='checkbox'/></span></li>"):e.push("<li class='"+n.primarygoal.subC.status+" sub' data-userguid='"+n.primarygoal.userguid+"' data-goalguid='"+t+"'>\n<span class='goaltitle'><i class='fa-large icon-"+n.primarygoal.subC.icon+"'></i>"+n.primarygoal.subC.goal+"</span>\n<span class='goaldeadline'>"+n.primarygoal.subC.deadline+"</span>\n<span class='chartbutton'><i class='fa-large icon-stats'></i></span>\n<span class='goalstatus' data-goal='"+n.primarygoal.subC.goal+"'><input type='checkbox'/></span></li>");return e.push('<span class="clearfix"></span>')}});return $(".primarygoals").css({"-ms-filter":"progid:DXImageTransform.Microsoft.Alpha(Opacity=1)","-moz-opacity":1,"-khtml-opacity":1,opacity:1,visibility:"hidden"}).fadeOut(0,function(){$(".primarygoals").html(e.join(""));return $(".primarygoals").css({visibility:"visible"}).fadeIn(200)})};$(".users").delegate("button","click",function(){var e;userguid=$(this).data("removeguid");e=confirm("Are you sure you want to remove this student?");return e?findAndRemove():!1});findAndRemove=function(){delete users[userguid];localStorage.setItem("users",JSON.stringify(users));localStorage.removeItem(userguid+"Goals");$(".goals").empty();logSummary();displayUserList();return findAndRemoveUserGoals(goals,"userguid",userguid)};findAndRemoveUserGoals=function(e,t,n){return $.each(e,function(r,i){i[t]===n&&e.splice(r,1);localStorage.setItem("goals",JSON.stringify(goals));return logSummary()})};$(".goalsection").delegate("button","click",function(){var e,t;goalguid=$(this).closest("li").data("goalguid");t=confirm("Are you sure you want to remove this goal?");if(!t)return!1;e=0;while(e<goals.length){console.log(goalguid);if(goals[e].goal.goalguid&&goals[e].goal.goalguid===goalguid){console.log("hello");goals.splice(e,1);break}e++}localStorage.setItem("goals",JSON.stringify(goals));goalChange();return displayMyGoalList()});$("#therecurring").click(function(){return $("#daysoftheweek").toggle(this.checked)});$("#therecurringA").click(function(){return $("#daysoftheweekA").toggle(this.checked)});$("#therecurringB").click(function(){return $("#daysoftheweekB").toggle(this.checked)});$("#therecurringC").click(function(){return $("#daysoftheweekC").toggle(this.checked)});$("#teethclick").click(function(){return $("#teethchart").show()});$("#readingclick").click(function(){return $("#readingchart").show()});$("#modalclose").click(function(){$("#adduserform").hide();$("#addgoalform").hide();return $("#addprimarygoalform").hide()});$(".listheadercategory").click(function(){return $("ul.goals>li").tsort("span.goalcategory",{order:"asc"})});$(".ascending").click(function(){return $("ul.users>li").tsort("span.userfullname",{order:"asc"})});$(".descending").click(function(){return $("ul.users>li").tsort("span.userfullname",{order:"desc"})});$(".goalscompleted").on("click","i.chartbutton",function(){$("#chartbox").show();$("#incentivebox").show();$(".chart-backdrop").show();incentivetext=$(this).data("incentivetext");incentivepic='url("'+$(this).data("incentivepic")+'")';console.log(incentivepic+"  supposed to be incentivepic");placeincentivetext="<p>"+incentivetext+"</p>";$("#incentivetext").html(placeincentivetext);$("#incentivepic").css("background-image",incentivepic);infocreated=$(this).data("infocreated");myinfo=$(this).data("myinfo");mytitle=$(this).data("goal");$(function(){});return $("#thischart").highcharts({chart:{},title:{text:mytitle},legend:{enabled:!1},xAxis:{categories:infocreated},series:[{data:myinfo}]})});$(".hidechart").click(function(){$("#chartbox").hide();$("#incentivebox").hide();return $(".chart-backdrop").hide()});logSummary=function(){var e,t,n,r;t=void 0;r={};e=0;n=localStorage.length;while(e<n){t=localStorage.key(e);r[t]=""+localStorage.getItem(t);e++}return $.ajax({url:"logSummary.php",type:"POST",data:r,success:function(e,t,n){return console.log("Hooray, it worked!")},error:function(e,t,n){return console.log("Didn't work so good...")}})};goalChange=function(){var e;e={};e.goals=localStorage.getItem("goals");e.userid=username;return $.ajax({url:"goalChange.php",type:"POST",data:e,success:function(e,t,n){return console.log("Yay, the save worked!")},error:function(e,t,n){return console.log("Didn't work so good...")}})};