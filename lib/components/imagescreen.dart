import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp_saver/components/save.dart';
import 'package:share_plus/share_plus.dart';
import 'fabbutton.dart';

class ImageScreen extends StatelessWidget {
  final String tag;
  const ImageScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
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
              await saveimage(tag, context);
            },
            icon: const Icon(
              Icons.save_alt_sharp,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () async {
              await Share.shareFiles([tag]);
            },
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Hero(tag: tag, child: Image.file(File(tag)))),
          ),
        ],
      ),
    );
  }
}
