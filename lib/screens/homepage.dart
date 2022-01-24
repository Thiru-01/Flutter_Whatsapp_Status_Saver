import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:whatsapp_saver/components/drawer.dart';
import 'package:whatsapp_saver/constant.dart';
import 'package:whatsapp_saver/provider/bottombarprovider.dart';
import 'package:whatsapp_saver/screens/imagegetter.dart';
import 'package:whatsapp_saver/screens/videogetter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetBox = [const ImageGetter(), const VideoGetter()];
    return Consumer<BottomBarProvider>(builder: (context, object, _) {
      return Scaffold(
        drawerScrimColor: primaryswatch.shade50,
        drawer: CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(object.state == 0 ? "Image Saver" : "Video Saver"),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: primaryswatch.shade300, spreadRadius: 1, blurRadius: 10)
          ]),
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)))),
            child: BottomNavigationBar(
              currentIndex: object.state,
              onTap: (i) {
                object.changestate(i);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.image), label: "Images"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_collection_outlined),
                    label: "Videos")
              ],
            ),
          ),
        ),
        body: _widgetBox[object.state],
      );
    });
  }
}
