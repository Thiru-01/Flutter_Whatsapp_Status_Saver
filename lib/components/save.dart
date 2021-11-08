import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:whatsapp_saver/constant.dart';

saveimage(String path, context) async {
  var result = await ImageGallerySaver.saveFile(
    path,
  );
  if (result['isSuccess']) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Image Saved Successfully!"),
      backgroundColor: primaryswatch.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ));
  }
}

savevideo(String path, context) async {
  var result = await ImageGallerySaver.saveFile(path,
      name: "VIDEO-${DateTime.now().toString()}.mp4");
  if (result['isSuccess']) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Video Saved Successfully!"),
      backgroundColor: primaryswatch.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ));
  }
}
