import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp_saver/provider/themeprovider.dart';
import 'package:whatsapp_saver/screens/homepage.dart';
import 'package:whatsapp_saver/screens/instapage.dart';

import '../constant.dart';

final drawerItems = [
  DrawerItem("Whatsapp Saver", FontAwesomeIcons.whatsapp),
  DrawerItem("Instagram Saver", FontAwesomeIcons.instagram),
];

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "Menu",
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      elevation: 10,
      child: Consumer<ThemeProvider>(builder: (context, snapshot, _) {
        return ListView(
          children: [
            DrawerHeader(
                child: Center(
              child: Text(
                "ST Saver",
                style: TextStyle(color: Colors.black, fontSize: 20.sp),
              ),
            )),
            for (int i = 0; i < drawerItems.length; i++)
              ListTile(
                leading: Icon(
                  drawerItems[i].icon,
                  size: 4.h,
                ),
                selected: i == snapshot.selected,
                selectedColor: primaryswatch,
                title: Text(
                  drawerItems[i].title,
                  style: TextStyle(fontSize: 12.sp),
                ),
                onTap: () {
                  snapshot.changeselect(i);
                  _changepage(i, context);
                },
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: Text(
                  "App Version 1.1",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  _changepage(int index, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => _getDrawerItemWidget(index),
            maintainState: true));
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomePage();
      case 1:
        return InstaPage();
      default:
        return new Text("Error");
    }
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
