import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

(:background)
class WatchFaceApp extends Application.AppBase {
  function initialize() {
    AppBase.initialize();
  }

  function onStart(state as Dictionary?) as Void {}

  function onStop(state as Dictionary?) as Void {}

  function getInitialView() as [Views] or [Views, InputDelegates] {
    return [new $.WatchFaceView()];
  }

  function onSettingsChanged() as Void {
    WatchUi.requestUpdate();
  }

  function getServiceDelegate() as [ServiceDelegate] {
    return [new $.BackgroundDelegate()];
  }
}

function getApp() as WatchFaceApp {
  return Application.getApp() as WatchFaceApp;
}
