import 'dart:io';

final Directory dir1 = Directory.fromUri(Uri.parse(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/'));
final Directory dir2 = Directory.fromUri(
    Uri.parse('/storage/emulated/0/WhatsApp/Media/.Statuses'));
Stream<List> getimgaes() async* {
  yield getDirectory()
      .listSync()
      .map((item) => item.path.toString())
      .where((item) => item.endsWith('.jpg'))
      .toList(growable: false);
}

Stream<List> getvideos() async* {
  yield getDirectory()
      .listSync()
      .map((item) => item.path.toString())
      .where((item) => item.endsWith('.mp4'))
      .toList(growable: false);
}

Directory getDirectory() {
  final Directory directory =
      File('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/.nomedia')
              .existsSync()
          ? dir1
          : dir2;
  return directory;
}
