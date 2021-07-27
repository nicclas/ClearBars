import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

//! The app settings menu
class ClearBarsSettingsMenu extends WatchUi.Menu2 {

    //! Constructor
    public function initialize() {
        Menu2.initialize({:title=>"Settings"});
        
        var displayIcons = Application.getApp().getProperty("DisplayIcons") as boolean;
        Menu2.addItem(new WatchUi.ToggleMenuItem("Bar Icons", null, 1, displayIcons, null));

        var displayValues = Application.getApp().getProperty("DisplayValues") as boolean;
        Menu2.addItem(new WatchUi.ToggleMenuItem("Sensor Values", null, 2, displayValues, null));

		var displaySeconds = Application.getApp().getProperty("DisplaySeconds") as boolean;
        Menu2.addItem(new WatchUi.ToggleMenuItem("Seconds Indicator", null, 3, displaySeconds, null));

		var minuteColor = Application.getApp().getProperty("MinuteColor");
		var minuteColorName = "Default";
		if(minuteColor == 0xFFAA00) {
			minuteColorName = "Orange";
		}
		if(minuteColor == 0x0000FF) {
			minuteColorName = "Blue";
		}
		if(minuteColor == 0xFF0000) {
			minuteColorName = "Red";
		}
		if(minuteColor == 0xFFFFFF) {
			minuteColorName = "White";
		}
		if(minuteColor == 0xFF55FF) {
			minuteColorName = "Pink";
		}
		if(minuteColor == 0x555555) {
			minuteColorName = "Gray";
		}
        Menu2.addItem(
            new WatchUi.MenuItem(
                "Minute Color",
                minuteColorName,
                4,
                null
            )
        );
		var hourColor = Application.getApp().getProperty("HourColor");
		var hourColorName = "Default";
		if(hourColor == 0xFFAA00) {
			hourColorName = "Orange";
		}
		if(hourColor == 0x0000FF) {
			hourColorName = "Blue";
		}
		if(hourColor == 0xFF0000) {
			hourColorName = "Red";
		}
		if(hourColor == 0xFFFFFF) {
			hourColorName = "White";
		}
		if(hourColor == 0xFF55FF) {
			hourColorName = "Pink";
		}
		if(hourColor == 0x555555) {
			hourColorName = "Gray";
		}
        Menu2.addItem(
            new WatchUi.MenuItem(
                "Hour Color",
                hourColorName,
                5,
                null
            )
        );
		var dateColor = Application.getApp().getProperty("DateColor");
		var dateColorName = "Default";
		if(dateColor == 0xFFAA00) {
			dateColorName = "Orange";
		}
		if(dateColor == 0x0000FF) {
			dateColorName = "Blue";
		}
		if(dateColor == 0xFF0000) {
			dateColorName = "Red";
		}
		if(dateColor == 0xFFFFFF) {
			dateColorName = "White";
		}
		if(dateColor == 0xFF55FF) {
			dateColorName = "Pink";
		}
		if(dateColor == 0x555555) {
			dateColorName = "Gray";
		}
        Menu2.addItem(
            new WatchUi.MenuItem(
                "Date Color",
                dateColorName,
                6,
                null
            )
        );
		var separatorColor = Application.getApp().getProperty("SeparatorColor");
		var separatorColorName = "Default";
		if(separatorColor == 0xFFAA00) {
			separatorColorName = "Orange";
		}
		if(separatorColor == 0x0000FF) {
			separatorColorName = "Blue";
		}
		if(separatorColor == 0xFF0000) {
			separatorColorName = "Red";
		}
		if(separatorColor == 0xFFFFFF) {
			separatorColorName = "White";
		}
		if(separatorColor == 0xFF55FF) {
			separatorColorName = "Pink";
		}
		if(separatorColor == 0x555555) {
			separatorColorName = "Gray";
		}
        Menu2.addItem(
            new WatchUi.MenuItem(
                "Separator Color",
                separatorColorName,
                7,
                null
            )
        );
//        WatchUi.pushView(Menu2, new ClearBarsSettingsMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
        
        
    }
}

//! Input handler for the app settings menu
class ClearBarsSettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    //! Constructor
    public function initialize() {
        Menu2InputDelegate.initialize();
    }

    //! Handle a menu item being selected
    //! @param menuItem The menu item selected
    public function onSelect(menuItem) as Void {
    	System.println("Menu ID: "+menuItem.getId());
    	if(menuItem.getId() == 1){
    		Application.getApp().setProperty("DisplayIcons", menuItem.isEnabled());
    		Application.getApp().saveProperties();
    	}
    	if(menuItem.getId() == 2){
    		Application.getApp().setProperty("DisplayValues", menuItem.isEnabled());
    		Application.getApp().saveProperties();
    	}
    	if(menuItem.getId() == 3){
    		Application.getApp().setProperty("DisplaySeconds", menuItem.isEnabled());
    		Application.getApp().saveProperties();
    	}
    	if(menuItem.getId() == 4){
	        var menu = new ClearBarsMinuteColorMenu();
	        menu.addItem(new WatchUi.MenuItem("Orange", null, 1, null));
	        menu.addItem(new WatchUi.MenuItem("Blue", null, 2, null));
	        menu.addItem(new WatchUi.MenuItem("Red", null, 3, null));
	        menu.addItem(new WatchUi.MenuItem("White", null, 4, null));
	        menu.addItem(new WatchUi.MenuItem("Pink", null, 5, null));
	        menu.addItem(new WatchUi.MenuItem("Gray", null, 6, null));
	
	        WatchUi.pushView(menu, new ClearBarsMinuteColorMenuDelegate(menuItem), WatchUi.SLIDE_IMMEDIATE);
	   	}
    	if(menuItem.getId() == 5){
	        var menu = new ClearBarsHourColorMenu();
	        menu.addItem(new WatchUi.MenuItem("Orange", null, 1, null));
	        menu.addItem(new WatchUi.MenuItem("Blue", null, 2, null));
	        menu.addItem(new WatchUi.MenuItem("Red", null, 3, null));
	        menu.addItem(new WatchUi.MenuItem("White", null, 4, null));
	        menu.addItem(new WatchUi.MenuItem("Pink", null, 5, null));
	        menu.addItem(new WatchUi.MenuItem("Gray", null, 6, null));
	
	        WatchUi.pushView(menu, new ClearBarsHourColorMenuDelegate(menuItem), WatchUi.SLIDE_IMMEDIATE);
	   	}
    	if(menuItem.getId() == 6){
	        var menu = new ClearBarsDateColorMenu();
	        menu.addItem(new WatchUi.MenuItem("Orange", null, 1, null));
	        menu.addItem(new WatchUi.MenuItem("Blue", null, 2, null));
	        menu.addItem(new WatchUi.MenuItem("Red", null, 3, null));
	        menu.addItem(new WatchUi.MenuItem("White", null, 4, null));
	        menu.addItem(new WatchUi.MenuItem("Pink", null, 5, null));
	        menu.addItem(new WatchUi.MenuItem("Gray", null, 6, null));
	
	        WatchUi.pushView(menu, new ClearBarsDateColorMenuDelegate(menuItem), WatchUi.SLIDE_IMMEDIATE);
	   	}
    	if(menuItem.getId() == 7){
	        var menu = new ClearBarsSeparatorColorMenu();
	        menu.addItem(new WatchUi.MenuItem("Orange", null, 1, null));
	        menu.addItem(new WatchUi.MenuItem("Blue", null, 2, null));
	        menu.addItem(new WatchUi.MenuItem("Red", null, 3, null));
	        menu.addItem(new WatchUi.MenuItem("White", null, 4, null));
	        menu.addItem(new WatchUi.MenuItem("Pink", null, 5, null));
	        menu.addItem(new WatchUi.MenuItem("Gray", null, 6, null));
	
	        WatchUi.pushView(menu, new ClearBarsSeparatorColorMenuDelegate(menuItem), WatchUi.SLIDE_IMMEDIATE);
	   	}
    }
    
    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
		return false;
    }
}

