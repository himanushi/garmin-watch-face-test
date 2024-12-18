import Toybox.Application.Storage;
import Toybox.Background;
import Toybox.Lang;
import Toybox.System;

(:background)
class BackgroundDelegate extends System.ServiceDelegate {
  function initialize() {
    ServiceDelegate.initialize();
  }

  function onTemporalEvent() as Void {
    Background.exit(true);
  }
}
