import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_saver/screens/instapage.dart';

class InstaProvider extends ChangeNotifier {
  bool flag = false;
  String value = r"""<h1>Please provide the link</h1>""";
  var url = Uri.parse("https://www.instagram.com/accounts/login/");
  void setvalue(String data) {
    value = data;
    notifyListeners();
  }

  void setFlag() {
    flag = true;
    notifyListeners();
  }

  Future<String?> getcsrftoken() async {
    String? csrfToken;
    var response = await http.get(url);
    response.headers['set-cookie']!.split(";").forEach((element) {
      if (element.contains("csrftoken")) {
        csrfToken = element.split(',')[1].split('=')[1];
      }
    });
    return csrfToken;
  }

  void getHtml(WebViewController? controller, context) async {
    Directory? storagePath;

    final path = Directory("storage/emulated/0/DCIM/instSaver");
    if (await path.existsSync()) {
      storagePath = path;
    } else {
      path.create();
      storagePath = path;
    }

    String? url = await controller!.currentUrl();
    String? html;
    String extenion = ".jpg";

    try {
      html = await controller.runJavascriptReturningResult(
          'window.document.getElementsByClassName("FFVAD")[0].currentSrc;');

      if (html == "null") {
        html = await controller.runJavascriptReturningResult(
            'window.document.getElementsByClassName("tWeCl")[0].currentSrc;');
        if (html != "null") {
          extenion = ".mp4";
        }
      }

      if (html == "null" || html == "{}" || html.contains("blob:https")) {
        var respose = await http.get(Uri.parse(url!.split("?")[0] + "?__a=1"));
        Map data = jsonDecode(respose.body.toString());
        var graphql = data['graphql'];
        var shortcodeMedia = graphql['shortcode_media'];
        html = shortcodeMedia['video_url'];
        if (html != "null") {
          extenion = ".mp4";
        }
      }

      http.Client client = new http.Client();
      var req = await client.get(Uri.parse(html!.replaceFirst('"', "")));
      var bytes = req.bodyBytes;
      print(path);
      File file = new File(
          '${storagePath.path}/INSTA${DateTime.now().millisecond.toString().trim().replaceAll(" ", "")}$extenion');

      await file.writeAsBytes(bytes);
      ImageGallerySaver.saveFile(file.path);
      showSnackbar(
          extenion == ".mp4"
              ? "Video Saved Successfully"
              : "Image Saved Successfully",
          context);
    } catch (e) {
      showSnackbar("Something went wrong !!!", context);
    }
    Navigator.of(context).pop();
  }
}
