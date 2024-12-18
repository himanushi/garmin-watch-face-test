import Toybox.Application.Storage;
import Toybox.Background;
import Toybox.Lang;
import Toybox.System;
import Toybox.Communications;
import Toybox.Graphics;
import Toybox.WatchUi;

(:background)
class BackgroundDelegate extends System.ServiceDelegate {
  function initialize() {
    ServiceDelegate.initialize();

    if (Communications has :registerForPhoneAppMessages) {
      Communications.registerForPhoneAppMessages(method(:onPhone));
    }
  }

  public function onPhone(msg as Communications.PhoneAppMessage) as Void {
    var data = msg.data;
    info("Phone message received");
    if (data != null) {
      info("Data received");
      var url = data["jsonKey"];
      Communications.makeImageRequest(
        url,
        null,
        {
          :dithering => Communications.IMAGE_DITHERING_NONE
        },
        method(:onImageResponse)
      );
    } else {
      info("No data");
    }
  }

  function onTemporalEvent() as Void {}

  public function onImageResponse(
    code as Number,
    data as BitmapResource or BitmapReference or Null
  ) as Void {
    if (code == 200) {
      info("Image received");
      if (data != null) {
        Storage.setValue("image", data);
      }
    } else {
      info("Image request failed");
    }

    info("Image request complete");
  }
}
