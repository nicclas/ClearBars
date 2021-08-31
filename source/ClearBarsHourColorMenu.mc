import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;

//! The app settings menu
class ClearBarsHourColorMenu extends WatchUi.Menu2 {

    //! Constructor
    public function initialize() {
        Menu2.initialize({:title=>"Hour Color"});
    }
}

//! Input handler for the app settings menu
class ClearBarsHourColorMenuDelegate extends WatchUi.Menu2InputDelegate {

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
            Application.getApp().setProperty("HourColor", 0xFFAA00);
            newColor = "Orange";
               Application.getApp().saveProperties();
           }
        if(menuItem.getId() == 2){
            Application.getApp().setProperty("HourColor", 0x0000FF);
            newColor = "Blue";
               Application.getApp().saveProperties();
           }
        if(menuItem.getId() == 3){
            Application.getApp().setProperty("HourColor", 0xFF0000);
            newColor = "Red";
               Application.getApp().saveProperties();
           }
        if(menuItem.getId() == 4){
            Application.getApp().setProperty("HourColor", 0xFFFFFF);
            newColor = "White";
               Application.getApp().saveProperties();
           }
        if(menuItem.getId() == 5){
            Application.getApp().setProperty("HourColor", 0xFF55FF);
            newColor = "Pink";
               Application.getApp().saveProperties();
           }
           System.println("Color name: "+newColor);
           settingsMenuItem.setSubLabel(newColor);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);    
    }
}

