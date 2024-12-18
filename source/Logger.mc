import Toybox.Lang;
import Toybox.System;

(:debug)
function info(message as String) as Void {
  System.println(message);
}

(:release)
function info(message as String) as Void {
  // nothing
}
