import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class LayoutBackground extends WatchUi.Drawable {
  function initialize() {
    var dictionary = {
      :identifier => "LayoutBackground"
    };

    Drawable.initialize(dictionary);
  }

  function draw(dc as Dc) as Void {}
}
