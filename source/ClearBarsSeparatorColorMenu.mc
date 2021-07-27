import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

//! The app settings menu
class ClearBarsSeparatorColorMenu extends WatchUi.Menu2 {

    //! Constructor
    public function initialize() {
        Menu2.initialize({:title=>"Separator Color"});
    }
}

//! Input handler for the app settings menu
class ClearBarsSeparatorColorMenuDelegate extends WatchUi.Menu2InputDelegate {

	var settingsMenuItem;

    //! Constructor
    public function initialize(sMI) {
    	settingsMenuItem = sMI;
        Menu2InputDelegate.initialize();
    }

    //! Handle a menu item being selected
    //! @param menuItem The menu item selected
    public function onSelect(menuItem) as Void {
    	System.println("Submenu ID: "+menuItem.getId());
    	var newColor = "default";
    	if(menuItem.getId() == 1){
	    	Application.getApp().setProperty("SeparatorColor", 0xFFAA00);
	    	newColor = "Orange";
   			Application.getApp().saveProperties();
   		}
    	if(menuItem.getId() == 2){
	    	Application.getApp().setProperty("SeparatorColor", 0x0000FF);
	    	newColor = "Blue";
   			Application.getApp().saveProperties();
   		}
    	if(menuItem.getId() == 3){
	    	Application.getApp().setProperty("SeparatorColor", 0xFF0000);
	    	newColor = "Red";
   			Application.getApp().saveProperties();
   		}
    	if(menuItem.getId() == 4){
	    	Application.getApp().setProperty("SeparatorColor", 0xFFFFFF);
	    	newColor = "White";
   			Application.getApp().saveProperties();
   		}
    	if(menuItem.getId() == 5){
	    	Application.getApp().setProperty("SeparatorColor", 0xFF55FF);
	    	newColor = "Pink";
   			Application.getApp().saveProperties();
   		}
    	if(menuItem.getId() == 6){
	    	Application.getApp().setProperty("SeparatorColor", 0x555555);
	    	newColor = "Gray";
   			Application.getApp().saveProperties();
   		}
   		System.println("Color name: "+newColor);
   		settingsMenuItem.setSubLabel(newColor);
		WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);    
	}
}

