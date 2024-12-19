import Toybox.System;
import Toybox.Application;

(:debug,:background)
module Log {
  function info(msg) {
    System.println(msg);
  }
}

(:release,:background)
module Log {
  function info(msg) {}
}
