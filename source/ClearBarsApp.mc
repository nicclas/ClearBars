import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class ClearBarsApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    
    function getInitialView() {
        if( Toybox.WatchUi has :WatchFaceDelegate ) {
            return [new ClearBarsView(), new ClearBarsViewDelegate()];
        } else {
            return [new ClearBarsView()];
        }
    }
    
    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

 
    //! Return the settings view and delegate
    //! @return Array Pair [View, Delegate]
    public function getSettingsView() {
        return [new ClearBarsSettingsMenu(), new ClearBarsSettingsMenuDelegate()];
    }


}

function getApp() as ClearBarsApp {
    return Application.getApp() as ClearBarsApp;
}