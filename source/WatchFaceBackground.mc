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
    System.println("Phone message received");
    if (data != null) {
      System.println("Data received");
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
      System.println("No data");
    }
  }

  function onTemporalEvent() as Void {}

  public function onImageResponse(
    code as Number,
    data as BitmapResource or BitmapReference or Null
  ) as Void {
    if (code == 200) {
      System.println("Image received");
      if (data != null) {
        Storage.setValue("image", data);
      }
    } else {
      System.println("Image request failed");
    }

    System.println("Image request complete");
  }
}
