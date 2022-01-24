import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_saver/components/drawer.dart';
import 'package:whatsapp_saver/provider/instaprovider.dart';
import '../constant.dart';

class InstaPage extends StatelessWidget {
  const InstaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtcontroller = TextEditingController();
    WebViewController? controller;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawerScrimColor: primaryswatch.shade50,
        drawer: CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("Instagram Page"),
        ),
        body: Consumer<InstaProvider>(builder: (context, snapshot, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: txtcontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(FontAwesomeIcons.clipboard),
                          hintText: "Paste the link"),
                    ),
                  )),
                  ElevatedButton(
                      onPressed: () {
                        showalertbox("Downloading...", context);
                        FocusScope.of(context).unfocus();
                        String url = txtcontroller.value.text.split("?")[0];
                        print(url);
                        controller!.loadUrl(url);
                        snapshot.setFlag();
                      },
                      child: Text("Download")),
                ],
              ),
              Builder(builder: (context) {
                return Expanded(
                  child: WebView(
                    initialUrl: "https://www.instagram.com/",
                    javascriptMode: JavascriptMode.unrestricted,
                    initialMediaPlaybackPolicy:
                        AutoMediaPlaybackPolicy.always_allow,
                    onWebViewCreated: (_controller) async {
                      controller = _controller;
                    },
                    onPageFinished: (url) {
                      print(snapshot.flag);
                      if (snapshot.flag) {
                        snapshot.getHtml(controller, context);
                      }

                      // controller!.runJavascript('''
                      //     window.document.body.getElementsByClassName("b5itu ")[0].innerText="";
                      //     window.document.body.getElementsByClassName("A8wCM")[0].innerText="";
                      //     window.document.body.getElementsByClassName("zGtbP  ")[0].innerText="";
                      //     ''');
                    },
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}

showalertbox(String txt, context) {
  final alertbox = AlertDialog(
    content: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        const LinearProgressIndicator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(txt),
        )
      ],
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertbox;
      });
}

showSnackbar(String message, context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
