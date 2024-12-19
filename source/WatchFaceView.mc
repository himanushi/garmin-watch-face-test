import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WatchFaceView extends WatchUi.WatchFace {
  function initialize() {
    WatchFace.initialize();
  }

  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  function onShow() as Void {}

  function onUpdate(dc as Dc) as Void {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    dc.clear();

    var data = Storage.getValue("data") as Object?;
    if (data != null) {
      var list = data["data"] as Array<Object>;

      if (list != null) {
        for (var i = 0; i < list.size(); i++) {
          var item = list[i] as Object;
          var x = item["x"] as Number?;
          var y = item["y"] as Number?;
          var image = Storage.getValue("image" + i) as BitmapType?;

          if (x != null && y != null && image != null) {
            // dc.drawBitmap(x, y, image);
            var xform = new AffineTransform();
            xform.setToRotation(0.5);
            dc.drawBitmap2(x, y, image, { :transform => xform });
          }
        }
      }
    }

    // var timeFormat = "$1$:$2$";
    // var clockTime = System.getClockTime();
    // var hours = clockTime.hour;
    // if (!System.getDeviceSettings().is24Hour) {
    //   if (hours > 12) {
    //     hours = hours - 12;
    //   }
    // } else {
    //   if (Application.Properties.getValue("UseMilitaryFormat")) {
    //     timeFormat = "$1$$2$";
    //     hours = hours.format("%02d");
    //   }
    // }
    // var timeString = Lang.format(timeFormat, [
    //   hours,
    //   clockTime.min.format("%02d")
    // ]);

    // var view = View.findDrawableById("TimeLabel") as Text;
    // view.setColor(Application.Properties.getValue("ForegroundColor") as Number);
    // view.setText(timeString);

    // View.onUpdate(dc);
  }

  function onHide() as Void {}

  function onExitSleep() as Void {}

  function onEnterSleep() as Void {}
}
