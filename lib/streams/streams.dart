import 'dart:io';

final Directory photoDir = Directory.fromUri(Uri.parse(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/'));
File fp = File(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/');
Stream<List> getimgaes() async* {
  yield photoDir
      .listSync()
      .map((item) => item.path.toString())
      .where((item) => item.endsWith('.jpg'))
      .toList(growable: false);
}

Stream<List> getvideos() async* {
  yield photoDir
      .listSync()
      .map((item) => item.path.toString())
      .where((item) => item.endsWith('.mp4'))
      .toList(growable: false);
}
