StartCountDown("clock2","03/3/2013 03:00 PM -0800");
StartCountDown("clock3","03/14/2013 06:00 AM -0800");
StartCountDown("clock4","03/18/2013 03:00 PM -0800");
StartCountDown("clock5","03/20/2013 06:00 AM -0800");
StartCountDown("clock6","03/5/2013 03:00 PM -0800");
StartCountDown("clock7","03/11/2013 06:00 AM -0800");
StartCountDown("clock8","03/15/2013 03:00 PM -0800");
StartCountDown("clock9","03/16/2013 06:00 AM -0800");
StartCountDown("clock10","04/5/2013 03:00 PM -0800");
StartCountDown("clock11","04/7/2013 06:00 AM -0800");

/*
 Author:   Robert Hashemian (http://www.hashemian.com/)
 Modified by:  Munsifali Rashid (http://www.munit.co.uk/)
 Modified by:  Tilesh Khatri
 */

function StartCountDown(myDiv,myTargetDate)
{
    var dthen = new Date(myTargetDate);
    var dnow  = new Date();
    ddiff   = new Date(dthen-dnow);
    gsecs   = Math.floor(ddiff.valueOf()/1000);
    CountBack(myDiv,gsecs);
}

function Calcage(secs, num1, num2)
{
    s = ((Math.floor(secs/num1))%num2).toString();
    if (s.length < 2)
    {
        s = "0" + s;
    }
    return (s);
}

function CountBack(myDiv, secs)
{
    var DisplayStr;
    var DisplayFormat = "In %%D%% Days, %%H%% Hrs, %%M%% Min";
    DisplayStr = DisplayFormat.replace(/%%D%%/g,  Calcage(secs,86400,100000));
    DisplayStr = DisplayStr.replace(/%%H%%/g,   Calcage(secs,3600,24));
    DisplayStr = DisplayStr.replace(/%%M%%/g,   Calcage(secs,60,60));
    DisplayStr = DisplayStr.replace(/%%S%%/g,   Calcage(secs,1,60));
    if(secs > 0)
    {
        document.getElementById(myDiv).innerHTML = DisplayStr;
        setTimeout("CountBack('" + myDiv + "'," + (secs-1) + ");", 990);
    }
    else
    {
        document.getElementById(myDiv).innerHTML = "Too late!";
    }
}