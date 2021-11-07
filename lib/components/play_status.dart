import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp_saver/components/fabbutton.dart';
import 'package:whatsapp_saver/components/save.dart';
import 'package:whatsapp_saver/components/videoscreen.dart';
import 'package:video_player/video_player.dart';

class PlayStatus extends StatelessWidget {
  final String source;
  const PlayStatus({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 5.0.h, right: 2.w),
        child: ExpandableFab(
          distance: 112.0,
          children: [
            // ActionButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.replay,
            //     color: Colors.white,
            //   ),
            // ),
            ActionButton(
              onPressed: () async {
                await savevideo(source, context);
              },
              icon: const Icon(
                Icons.save_alt_sharp,
                color: Colors.white,
              ),
            ),
            ActionButton(
              onPressed: () async {
                await Share.shareFiles([source]);
              },
              icon: const Icon(Icons.share, color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: VideoScreen(
        looping: true,
        tag: source,
        videoPlayerController: VideoPlayerController.file(File(source)),
      ),
    );
  }
}
