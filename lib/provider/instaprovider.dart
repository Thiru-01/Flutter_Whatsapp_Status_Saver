import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

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

  void getHtml(WebViewController? controller) async {
    String? url = await controller!.currentUrl();
    String? html;
    print("image");
    html = await controller.runJavascriptReturningResult(
        'window.document.getElementsByClassName("FFVAD")[0].currentSrc;');

    if (html == "null") {
      print("video");
      html = await controller.runJavascriptReturningResult(
          'window.document.getElementsByClassName("tWeCl")[0].currentSrc;');
    }

    if (html == "null" || html == "{}" || html.contains("blob:https")) {
      var respose = await http.get(Uri.parse(url!.split("?")[0] + "?__a=1"));
      Map data = jsonDecode(respose.body.toString());
      var graphql = data['graphql'];
      var shortcodeMedia = graphql['shortcode_media'];
      html = shortcodeMedia['video_url'];
    }
    print(html);
  }
}
