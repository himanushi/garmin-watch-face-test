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

  /*

{
"data": [{
"imageUrl":"https://avatars.githubusercontent.com/u/27812830",
"x":100,
"y":100},
{"imageUrl":"https://avatars.githubusercontent.com/u/27782135",
"x":200,
"y":200}]
}

{
"data": [{
"imageUrl":"https://avatars.githubusercontent.com/u/27812830",
"x":100,
"y":100},
{"imageUrl":"https://avatars.githubusercontent.com/u/27782135",
"x":200,
"y":200}]
}

*/

  const IMAGE_RESPONSE_METHODS = [
    method(:onImageResponse0),
    method(:onImageResponse1),
    method(:onImageResponse2)
  ];

  public function onPhone(msg as Communications.PhoneAppMessage) as Void {
    var data = msg.data;
    Log.info("Phone message received");
    if (data != null) {
      Log.info("Data received");

      Storage.setValue("data", data);

      var list = data["data"] as Array<Object>;

      if (list != null) {
        Log.info("List received");
        for (var i = 0; i < list.size(); i++) {
          var imageResponseMethod = IMAGE_RESPONSE_METHODS[i];
          var item = list[i] as Dictionary<String, Object>;

          if (imageResponseMethod != null && item != null) {
            var url = item["imageUrl"] as String;
            if (url != null) {
              Log.info("Image URL received");
              Communications.makeImageRequest(
                url,
                null,
                {
                  :dithering => Communications.IMAGE_DITHERING_NONE
                },
                imageResponseMethod
              );
            }
          }
        }
      }
    } else {
      Log.info("No data");
    }
  }

  function onTemporalEvent() as Void {}

  public function onImageResponse1(
    code as Number,
    data as BitmapResource or BitmapReference or Null
  ) as Void {
    imageResponse(code, data, "image1");
  }

  public function onImageResponse0(
    code as Number,
    data as BitmapResource or BitmapReference or Null
  ) as Void {
    imageResponse(code, data, "image0");
  }

  public function onImageResponse2(
    code as Number,
    data as BitmapResource or BitmapReference or Null
  ) as Void {
    imageResponse(code, data, "image2");
  }

  public function imageResponse(
    code as Number,
    data as BitmapResource or BitmapReference or Null,
    key as String
  ) {
    if (code == 200) {
      Log.info("Image received " + key);
      if (data != null) {
        Storage.setValue(key, data);
      }
    } else {
      Log.info("Image request failed " + key);
    }

    Log.info("Image request complete " + key);
  }
}
