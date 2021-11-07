import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_saver/components/play_status.dart';
import 'package:whatsapp_saver/streams/streams.dart';

class VideoGetter extends StatefulWidget {
  const VideoGetter({Key? key}) : super(key: key);

  @override
  State<VideoGetter> createState() => _VideoGetterState();
}

class _VideoGetterState extends State<VideoGetter> {
  Future<void> makechange() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<String?> _getImage(videoPathUrl) async {
      final thumb = await VideoThumbnail.thumbnailFile(
        video: videoPathUrl,
        imageFormat: ImageFormat.PNG,
        maxWidth: 250,
        maxHeight: 250,
        quality: 100,
      );
      return thumb;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Video Saver"),
      ),
      body: StreamBuilder<List>(
          stream: getvideos(),
          builder: (context, data) {
            if (data.hasData) {
              return RefreshIndicator(
                onRefresh: makechange,
                child: GridView.builder(
                    itemCount: data.data?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    itemBuilder: (context, i) {
                      return FutureBuilder<String?>(
                          future: _getImage(data.data?[i]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Material(
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlayStatus(
                                              source: data.data?[i]))),
                                  child: Hero(
                                      tag: data.data?[i],
                                      child: Image.file(
                                        File(snapshot.data!),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.all(20.h),
                              child: const CircularProgressIndicator(),
                            );
                          });
                    }),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
