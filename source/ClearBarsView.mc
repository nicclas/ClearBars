import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian as Calendar;
using Toybox.UserProfile;


var partialUpdatesAllowed = false;
var myDc;

class ClearBarsView extends WatchUi.WatchFace {

    var customFont = null;
    var screenCenterPoint;    
    var curClip;
    var bgRedrawRequested;
    var ThemeColor;
    var fullScreenRefresh;
    var isAwake;
    var displaySeconds = true;
    var iconR;
    var dayLang = new [7];
    var monthLang = new [12];
    var histpropVector = new [6];
    
    function initialize() {
        WatchFace.initialize();
        dayLang[0] = WatchUi.loadResource($.Rez.Strings.Sun) as String;
        dayLang[1] = WatchUi.loadResource($.Rez.Strings.Mon) as String;
        dayLang[2] = WatchUi.loadResource($.Rez.Strings.Tue) as String;
        dayLang[3] = WatchUi.loadResource($.Rez.Strings.Wed) as String;
        dayLang[4] = WatchUi.loadResource($.Rez.Strings.Thu) as String;
        dayLang[5] = WatchUi.loadResource($.Rez.Strings.Fri) as String;
        dayLang[6] = WatchUi.loadResource($.Rez.Strings.Sat) as String;

        monthLang[0] = WatchUi.loadResource($.Rez.Strings.Jan) as String;
        monthLang[1] = WatchUi.loadResource($.Rez.Strings.Feb) as String;
        monthLang[2] = WatchUi.loadResource($.Rez.Strings.Mar) as String;
        monthLang[3] = WatchUi.loadResource($.Rez.Strings.Apr) as String;
        monthLang[4] = WatchUi.loadResource($.Rez.Strings.May) as String;
        monthLang[5] = WatchUi.loadResource($.Rez.Strings.Jun) as String;
        monthLang[6] = WatchUi.loadResource($.Rez.Strings.Jul) as String;
        monthLang[7] = WatchUi.loadResource($.Rez.Strings.Aug) as String;
        monthLang[8] = WatchUi.loadResource($.Rez.Strings.Sep) as String;
        monthLang[9] = WatchUi.loadResource($.Rez.Strings.Oct) as String;
        monthLang[10] = WatchUi.loadResource($.Rez.Strings.Nov) as String;
        monthLang[11] = WatchUi.loadResource($.Rez.Strings.Dec) as String;

        histpropVector[0] = (Math.rand() % 1000) / 1000.0 + 0.2;
        histpropVector[1] = (Math.rand() % 1000) / 1000.0 + 0.2;
        histpropVector[2] = (Math.rand() % 1000) / 1000.0 + 0.2;
        histpropVector[3] = (Math.rand() % 1000) / 1000.0 + 0.2;
        histpropVector[4] = (Math.rand() % 1000) / 1000.0 + 0.2;
        histpropVector[5] = (Math.rand() % 1000) / 1000.0 + 0.2;

        partialUpdatesAllowed = ( Toybox.WatchUi.WatchFace has :onPartialUpdate );
        displaySeconds = partialUpdatesAllowed;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
         customFont = WatchUi.loadResource(Rez.Fonts.customfont);    
//         customFont = Graphics.FONT_NUMBER_HOT;
        setLayout(Rez.Layouts.WatchFace(dc));
        bgRedrawRequested = new[2];
        myDc = dc;
        screenCenterPoint = [dc.getWidth()/2, dc.getHeight()/2];
        iconR = new ClearBarsIcons(dc);   
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
         fullScreenRefresh = true;
         isAwake = true;    
        WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {


        var iconPos = [[45,83],[53,120],[61,139]];
        var valuePos = [[dc.getWidth()/2,50],[dc.getWidth()/2,70],[dc.getWidth()/2,90]];
    
              
          if (dc.getWidth()==280 && dc.getHeight()==280){
            iconPos = [[55,93],[63,130],[71,149]];
            valuePos = [[dc.getWidth()/2,70],[dc.getWidth()/2,90],[dc.getWidth()/2,110]];
          }
          if (dc.getWidth()==260 && dc.getHeight()==260){
            iconPos = [[45,83],[53,120],[61,139]];
            valuePos = [[dc.getWidth()/2,60],[dc.getWidth()/2,80],[dc.getWidth()/2,100]];
          }
          if (dc.getWidth()==240 && dc.getHeight()==240){
            iconPos = [[35,74],[44,111],[53,130]];
            valuePos = [[dc.getWidth()/2,47],[dc.getWidth()/2,67],[dc.getWidth()/2,87]];
          }
          if (dc.getWidth()==218 && dc.getHeight()==218){
            iconPos = [[23,64],[32,101],[41,120]];
            valuePos = [[dc.getWidth()/2,37],[dc.getWidth()/2,57],[dc.getWidth()/2,77]];
          }
       
        dc.clearClip(); 
        dc.clear();
//        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
//        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        // Update the view
        View.onUpdate(dc);
        // Get and show the current time
        var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hour > 12) {
                hour = hour - 12;
            }
        }

        if(dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }

        ThemeColor = Application.getApp().getProperty("MinuteColor") as Number;


        var color = Application.getApp().getProperty("HourColor") as Number;
        dc.setColor((color), Graphics.COLOR_TRANSPARENT);
        if(hour < 10){
            dc.drawText(dc.getWidth()/2-8, dc.getHeight()/2+3, customFont, "0"+hour.toString(), Graphics.TEXT_JUSTIFY_RIGHT); 
        }else{
            dc.drawText(dc.getWidth()/2-8, dc.getHeight()/2+3, customFont, hour.toString(), Graphics.TEXT_JUSTIFY_RIGHT); 
        }
        
        color = Application.getApp().getProperty("SeparatorColor") as Number;
//        System.println("Color: "+color);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(dc.getWidth()/2+1, dc.getHeight()/2-1, customFont, ":", Graphics.TEXT_JUSTIFY_CENTER); 
        color = Application.getApp().getProperty("MinuteColor") as Number;
        dc.setColor((color), Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2+10, dc.getHeight()/2+3, customFont, Lang.format("$1$", [clockTime.min.format("%02d")]), Graphics.TEXT_JUSTIFY_LEFT); 
        
        // Display Month and day value
        var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_LONG);
        var dayNameStr;
        var monthNameStr;
        var dayStr;
        var dayOfWeek = Calendar.info(Time.now(), Time.FORMAT_SHORT).day_of_week-1;
        var monthNum = Calendar.info(Time.now(), Time.FORMAT_SHORT).month-1;
//        monthStr = Lang.format("$1$", [info.month]);
        dayNameStr = dayLang[dayOfWeek].toUpper();
        dayStr = Lang.format("$1$", [info.day]);

        monthNameStr = monthLang[monthNum].toUpper();

//        view = View.findDrawableById("DateDisplayDayname") as Text;
//        view.setText(dayNameStr.toUpper());
//        view = View.findDrawableById("DateDisplay") as Text;
//        view.setText(dayStr);
        color = Application.getApp().getProperty("DateColor") as Number;
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2+68, Graphics.FONT_XTINY , dayNameStr+", "+monthNameStr+" "+dayStr, Graphics.TEXT_JUSTIFY_CENTER); 

        var prop;
        var steps = ActivityMonitor.getInfo().steps;
        var stepGoal = ActivityMonitor.getInfo().stepGoal;
        if(steps == null || steps < 1){
            steps = 1;
        }
//        steps = 4400;
        prop = 1.0*steps/stepGoal;
        if(prop >= 1){
            prop = 0.999;
        }

        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 140, Graphics.ARC_CLOCKWISE, 121, 59);
//        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
//        dc.setPenWidth(12);
//        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 140, Graphics.ARC_CLOCKWISE, 120, 60);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 140, Graphics.ARC_CLOCKWISE, 120, 120 - 60 * prop);

        var deg = 120.0; // Start circle
        var rad = deg * Math.PI / 180.0;
        var clength = 140;
        var startx = screenCenterPoint[0] + clength * Math.cos(rad);
        var starty = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(startx, starty, 5);

        deg = 60.0; // End circle
        rad = deg * Math.PI / 180.0;
        var endx = screenCenterPoint[0] + clength * Math.cos(rad) + 1;
        var endy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(endx, endy, 5);    

        deg = 120 - 60 * prop; // Draw indicator circles
        rad = deg * Math.PI / 180.0;
        var x = screenCenterPoint[0] + clength * Math.cos(rad);
        var y = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 7);    
        var stepColor = ThemeColor;
        if(prop >= 1.001){
            stepColor = 0x00FF00;
        }

        dc.setColor(stepColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 5);    




        var stats = System.getSystemStats();
        var pwr = stats.battery + 0.5;
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 120, Graphics.ARC_CLOCKWISE, 121, 59);
//        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
//        dc.setPenWidth(12);
//      dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 120, Graphics.ARC_CLOCKWISE, 120, 60);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 120, Graphics.ARC_CLOCKWISE, 120, 120 - 60 * pwr/100);
        
        deg = 120.0; // Start circle
        rad = deg * Math.PI / 180.0;
        clength = 120;
        startx = screenCenterPoint[0] + clength * Math.cos(rad);
        starty = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(startx, starty, 5);

        deg = 60.0; // End circle
        rad = deg * Math.PI / 180.0;
        endx = screenCenterPoint[0] + clength * Math.cos(rad) + 1;
        endy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(endx, endy, 5);    

        deg = 120 - 60 * pwr / 100; // Draw indicator circles
        rad = deg * Math.PI / 180.0;
        x = screenCenterPoint[0] + clength * Math.cos(rad);
        y = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 7);    
        var pwrColor = 0xFF0000;
        if(pwr/100 >= 0.1){
            pwrColor = 0xFF5500;
        }                            
        if(pwr/100 >= 0.2){
            pwrColor = 0xFFAA55;
        }                            
        if(pwr/100 >= 0.3){
            pwrColor = 0xFFFF55;
        }                            
        if(pwr/100 >= 0.4){
            pwrColor = 0xAAFF00;
        }                            
        if(pwr/100 >= 0.5){
            pwrColor = 0x00FF00;
        }
//        dc.setColor(pwrColor, Graphics.COLOR_TRANSPARENT);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 5);    


        var heartRate = null;
        var maxheartRate = 220;
        if (ActivityMonitor has :getHeartRateHistory) {
            heartRate = Activity.getActivityInfo().currentHeartRate;
            if(UserProfile.getHeartRateZones(0) != null){
                maxheartRate = UserProfile.getHeartRateZones(0)[5];
            }
            if(heartRate==null) {
                var HRH=ActivityMonitor.getHeartRateHistory(1, true);
                var HRS=HRH.next();
                if(HRS!=null && HRS.heartRate!= ActivityMonitor.INVALID_HR_SAMPLE){
                    heartRate = HRS.heartRate;
                }
            }
            if(heartRate==null) {
                heartRate = 0;
            }
        }
        if(heartRate==null) {
            heartRate = 1;
        }
        var hrRatio = 1.0 * heartRate / maxheartRate;
        if(hrRatio > 1.0 || hrRatio < 0.01){
            hrRatio = 0.01;
        }
         
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 100, Graphics.ARC_CLOCKWISE, 121, 59);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 100, Graphics.ARC_CLOCKWISE, 120, 120 - 60 * hrRatio);

        deg = 120.0; // Start circle
        rad = deg * Math.PI / 180.0;
        clength = 100;
        startx = screenCenterPoint[0] + clength * Math.cos(rad)+2;
        starty = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(startx, starty, 5);

        deg = 60.0; // End circle
        rad = deg * Math.PI / 180.0;
        endx = screenCenterPoint[0] + clength * Math.cos(rad) + 1;
        endy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(endx, endy, 5);    

        deg = 120 - 60 * hrRatio; // Draw indicator circles
        rad = deg * Math.PI / 180.0;
        x = screenCenterPoint[0] + clength * Math.cos(rad);
        y = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 7);    
        dc.setColor(ThemeColor, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(x, y, 5);    



        // Draw step goal history as circles
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(12);
        clength = 160;
        dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, clength, Graphics.ARC_CLOCKWISE, 121, 59);
        deg = 120.0; // Start circle
        rad = deg * Math.PI / 180.0;
        startx = screenCenterPoint[0] + clength * Math.cos(rad);
        starty = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(startx, starty, 5);
        deg = 60.0; // End circle
        rad = deg * Math.PI / 180.0;
        endx = screenCenterPoint[0] + clength * Math.cos(rad);
        endy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillCircle(endx, endy, 5);    

        var actHistArray = ActivityMonitor.getHistory();
        if ((null != actHistArray) && (actHistArray.size() > 0)) {

            var historySize = actHistArray.size();
            if(historySize > 6){
                historySize = 6;
            }

            for(var i = 0; i <= historySize - 1; i++){
                var histColor = 0x000000;
                var histprop = 0;
                var curHistory = actHistArray[historySize - 1 - i];
                if ((null != curHistory) && (null != curHistory.steps)) {
                    histprop = 0.0 + curHistory.steps / (1.0 * curHistory.stepGoal);
                    histColor = 0xFF0000;
                    if(histprop >= 0.60){
                        histColor = 0xFF5500;
                    }                            
                    if(histprop >= 0.7){
                        histColor = 0xFFAA55;
                    }                            
                    if(histprop >= 0.8){
                        histColor = 0xFFFF55;
                    }                            
                    if(histprop >= 0.9){
                        histColor = 0xAAFF00;
                    }                            
                    if(histprop >= 1.0){
                        histColor = 0x00FF00;
                    }
                    deg = 115 - 10 * i; // History circles
                    rad = deg * Math.PI / 180.0;
                    var histx = screenCenterPoint[0] + clength * Math.cos(rad) + 1;
                    var histy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
                    
                    dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                    dc.fillCircle(histx, histy, 9);    
                    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                    dc.fillCircle(histx, histy, 7);    
                    dc.setColor(histColor, Graphics.COLOR_TRANSPARENT);
                    dc.fillCircle(histx, histy, 5);    
                }
            }
        }else{
            for(var i = 0; i <= 5; i++){
                var histColor = 0x000000;
                histColor = 0xFF0000;
                var histprop = histpropVector[i];
                if(histprop >= 0.60){
                    histColor = 0xFF5500;
                }                            
                if(histprop >= 0.7){
                    histColor = 0xFFAA55;
                }                            
                if(histprop >= 0.8){
                    histColor = 0xFFFF55;
                }                            
                if(histprop >= 0.9){
                    histColor = 0xAAFF00;
                }                            
                if(histprop >= 1.0){
                    histColor = 0x00FF00;
                }
                deg = 115 - 10 * i; // History circles
                rad = deg * Math.PI / 180.0;
                var histx = screenCenterPoint[0] + clength * Math.cos(rad) + 1;
                var histy = screenCenterPoint[1]+80 - clength * Math.sin(rad);
                
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(histx, histy, 9);    
                dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(histx, histy, 7);    
                dc.setColor(histColor, Graphics.COLOR_TRANSPARENT);
                dc.fillCircle(histx, histy, 5);    
            }
        }
        


/*
        dc.setPenWidth(8);
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
           dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 156, Graphics.ARC_CLOCKWISE, 121, 59);
        dc.setPenWidth(6);

        var actHistArray = ActivityMonitor.getHistory();
        if ((null != actHistArray) && (actHistArray.size() > 0)) {
            for(var i = 0; i <= 5; i++){
                var histColor = 0x000000;
                var histprop = 0;
                var curHistory = actHistArray[5-i];
                if ((null != curHistory) && (null != curHistory.steps)) {
                    histprop = 0.0 + curHistory.steps / (1.0 * curHistory.stepGoal);
                    histColor = 0xFF0000;
                    if(histprop >= 0.60){
                        histColor = 0xFF5500;
                    }                            
                    if(histprop >= 0.7){
                        histColor = 0xFFAA55;
                    }                            
                    if(histprop >= 0.8){
                        histColor = 0xFFFF55;
                    }                            
                    if(histprop >= 0.9){
                        histColor = 0xAAFF00;
                    }                            
                    if(histprop >= 1.0){
                        histColor = 0x00FF00;
                    }
                }
                dc.setColor(histColor, Graphics.COLOR_TRANSPARENT);
                var offset = 0.5;
                if(i==0){
                    offset = 0;
                }
                    dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 156, Graphics.ARC_CLOCKWISE, 120 - i * 60.0 / 6 - offset, 120 - (i+1) * 60.0 / 6 + 0.5);
                }
        }else{
            for(var i = 0; i <= 5; i++){
                var histColor = 0xFFFFFF;
                var histprop = histpropVector[i];
                histColor = 0xFF0000;
                if(histprop > 0.60){
                    histColor = 0xFF5500;
                }                            
                if(histprop > 0.7){
                    histColor = 0xFFAA55;
                }                            
                if(histprop > 0.8){
                    histColor = 0xFFFF55;
                }                            
                if(histprop > 0.9){
                    histColor = 0xAAFF55;
                }                            
                if(histprop > 1.0){
                    histColor = 0x00FF00;
                }
                dc.setColor(histColor, Graphics.COLOR_TRANSPARENT);
                var offset = 0.5;
                if(i==0){
                    offset = 0;
                }
                    dc.drawArc(screenCenterPoint[0], screenCenterPoint[1]+80, 156, Graphics.ARC_CLOCKWISE, 120 - i * 60.0 / 6 - offset, 120 - (i+1) * 60.0 / 6 + 0.5);
            }
        }
*/


        var displayIcons = Application.getApp().getProperty("DisplayIcons") as boolean;
        if(displayIcons == true){
            iconR._themeColor = Graphics.COLOR_WHITE;
            iconR._bgColor = Graphics.COLOR_TRANSPARENT;
            iconR.renderSymbol(iconPos[0][0],iconPos[0][1],0);
            iconR.renderSymbol(iconPos[1][0],iconPos[1][1],1);
            iconR.renderSymbol(iconPos[2][0],iconPos[2][1],2);
        }    
        var displayValues = Application.getApp().getProperty("DisplayValues") as boolean;
        if(displayValues == true){
            if( (Application.getApp().getProperty("MinuteColor") as number) == 16777215){
                dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
            }else{            
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            }
            if(steps > 1000){
                steps = (steps / 100).toNumber();
                steps = (steps / 10);
                steps = steps + "k";
            }
            dc.drawText(valuePos[0][0],valuePos[0][1],Graphics.FONT_XTINY,steps,Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(valuePos[1][0],valuePos[1][1],Graphics.FONT_XTINY,pwr.toNumber()+"%",Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(valuePos[2][0],valuePos[2][1],Graphics.FONT_XTINY,heartRate,Graphics.TEXT_JUSTIFY_CENTER);
        }    
        // Debug
//        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
//        dc.drawText(178, 100, Graphics.FONT_XTINY , ""+maxheartRate, Graphics.TEXT_JUSTIFY_CENTER); 

        displaySeconds = Application.getApp().getProperty("DisplaySeconds") as boolean && partialUpdatesAllowed;

        if(displaySeconds==true) {
            var secs = System.getClockTime().sec;
            drawSeconds(dc,ThemeColor,secs);
           }

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
           
        var secs =System.getClockTime().sec;
        curClip = null;
//        myDc.clearClip();
//        myDc.clear();
        WatchUi.requestUpdate();
        fullScreenRefresh = false;
        isAwake = false;
    }
    function drawSeconds(dc,Color,secs)    { 
        var secondsAngle = (secs/60.0) * Math.PI * 2;
        
        var thick = generateSecondsThicks(screenCenterPoint,secondsAngle,dc);
        
        ////now dc restrict
        curClip = getBoundingBox(thick);
         dc.setClip(curClip[0][0], curClip[0][1], curClip[1], curClip[2]); 
        dc.setColor(Color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);
        
        DrawArrow(dc,[thick[0],thick[1],thick[2]]);    
        
//        DrawPolygon(dc,thick[0]);
//        DrawPolygon(dc,thick[1]);

    }
    function generateSecondsThicks(centerPoint, angle, dc) {
        // Map out the coordinates of the watch hand
        var ThickLen = 8;
        var ThickWidth = 4;
          if (dc.getWidth()==218 && dc.getHeight()==218) {
            ThickLen = 2;
            ThickWidth = 1;
        }          
        var yMax = centerPoint[1];
        var cP = centerPoint;
        angle = angle+Math.PI/2;

        var coords1 = [[-1*ThickWidth,-yMax+ThickLen],[-1*ThickWidth,-yMax]];
        var coords2 = [[0,-yMax+ThickLen],[0,-yMax]];
        var coords3 = [[ThickWidth,-yMax+ThickLen],[ThickWidth,-yMax]];
        
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);
        var ret = new[2];
        //System.println([cos,sin,angle]);

        // Transform the coordinates
        var result1 = [[cP[0]+  coords1[0][1]*cos+coords1[0][0]*sin,    cP[1]+coords1[0][1]*sin-coords1[0][0]*cos ]     ,  
                 [cP[0]+coords1[1][1]*cos+coords1[1][0]*sin,    cP[1]+coords1[1][1]*sin-coords1[1][0]*cos]];
        var result2 = [[cP[0]+  coords2[0][1]*cos+coords2[0][0]*sin,    cP[1]+coords2[0][1]*sin-coords2[0][0]*cos ]     ,  
                 [cP[0]+coords2[1][1]*cos+coords2[1][0]*sin,    cP[1]+coords2[1][1]*sin-coords2[1][0]*cos]];     
        var result3 = [[cP[0]+  coords3[0][1]*cos+coords3[0][0]*sin,    cP[1]+coords3[0][1]*sin-coords3[0][0]*cos ]     ,  
                 [cP[0]+coords3[1][1]*cos+coords3[1][0]*sin,    cP[1]+coords3[1][1]*sin-coords3[1][0]*cos]];                         
        
        return [result1,result2,result3];
    } 
    
    function DrawArrow(DrawContext,polygon) {
        // Arrow pointing out
        DrawContext.drawLine(polygon[0][0][0], polygon[0][0][1], polygon[1][1][0], polygon[1][1][1]);
        DrawContext.drawLine(polygon[1][1][0], polygon[1][1][1], polygon[2][0][0], polygon[2][0][1]);
        DrawContext.drawLine(polygon[2][0][0], polygon[2][0][1], polygon[0][0][0], polygon[0][0][1]);

        // Arrow pointing in
//        DrawContext.drawLine(polygon[0][1][0], polygon[0][1][1], polygon[2][1][0], polygon[2][1][1]);
//        DrawContext.drawLine(polygon[2][1][0], polygon[2][1][1], polygon[1][0][0], polygon[1][0][1]);
//        DrawContext.drawLine(polygon[1][0][0], polygon[1][0][1], polygon[0][1][0], polygon[0][1][1]);

    }
    function DrawPolygon(DrawContext,polygon) {
        for(var i=1;i<polygon.size();i++) {
            DrawContext.drawLine(polygon[i-1][0], polygon[i-1][1], polygon[i][0], polygon[i][1]);
        }
    }
    
    function getBoundingBox(array) {
        var minX=array[0][0][0];
        var minY=array[0][0][1];
        var maxX=array[0][0][0];
        var maxY=array[0][0][1];
   
        for(var i=0;i<array.size();i++){
            for(var j=0;j<array[i].size();j++) {
                if(array[i][j][0]<minX)    {
                    minX = array[i][j][0];
                }
                if(array[i][j][1]<minY) {
                    minY = array[i][j][1];
                }
                if(array[i][j][0]>maxX) {
                    maxX = array[i][j][0];
                }
                if(array[i][j][1]>maxY) {
                     maxY = array[i][j][1];
                }                                          
            }
        }
        var width = maxX+2- (minX-2);
        var height = maxY+2- (minY-2);
        return [[minX-1,minY-1], width,height];                    
    }
  
    function onPartialUpdate(dc) {
        if( displaySeconds==true) {
            miniBgRedraw();
             var secs = System.getClockTime().sec;
            dc.clearClip();
            var secondsAngle = (secs/60.0) * Math.PI * 2;
        
            var thick = generateSecondsThicks(screenCenterPoint,secondsAngle,dc);
 
            curClip = getBoundingBox(thick);
            dc.setClip(curClip[0][0], curClip[0][1], curClip[1], curClip[2]); 

            var ThemeColor2 = Application.getApp().getProperty("MinuteColor") as Number;
            drawSeconds(dc,ThemeColor2, secs);  
        }
    }
    
    function miniBgRedraw() {
        if(curClip !=null) {
            myDc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
            myDc.fillRectangle(curClip[0][0], 
                                curClip[0][1], 
                                curClip[1] , 
                                curClip[2]);
        }
    } 



}

class ClearBarsViewDelegate extends WatchUi.WatchFaceDelegate {
    // The onPowerBudgetExceeded callback is called by the system if the
    // onPartialUpdate method exceeds the allowed power budget. If this occurs,
    // the system will stop invoking onPartialUpdate each second, so we set the
    // partialUpdatesAllowed flag here to let the rendering methods know they
    // should not be rendering a second hand.
    function initialize() {
        WatchFaceDelegate.initialize();
    }
    
    function onPowerBudgetExceeded(powerInfo) {
        System.println( "Average execution time: " + powerInfo.executionTimeAverage );
        System.println( "Allowed execution time: " + powerInfo.executionTimeLimit );
        partialUpdatesAllowed = false;
    }
}
