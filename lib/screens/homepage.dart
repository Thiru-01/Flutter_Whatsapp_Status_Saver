// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp_saver/constant.dart';
import 'package:whatsapp_saver/provider/bottombarprovider.dart';
import 'package:whatsapp_saver/screens/imagegetter.dart';
import 'package:whatsapp_saver/screens/videogetter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetBox = [const ImageGetter(), const VideoGetter()];
    final Directory photoDir = Directory.fromUri(Uri.parse(
        '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/'));
    return Consumer<BottomBarProvider>(builder: (context, object, _) {
      return Scaffold(
          extendBody: true,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.h),
                    topRight: Radius.circular(2.h)),
                boxShadow: [
                  BoxShadow(
                      color: primaryswatch.shade300,
                      spreadRadius: 1,
                      blurRadius: 10)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2.h),
                  topRight: Radius.circular(2.h)),
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
          body: _widgetBox[object.state]);
    });
  }
}
