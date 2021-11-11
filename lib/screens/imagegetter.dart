import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp_saver/components/imagescreen.dart';
import 'package:whatsapp_saver/streams/streams.dart';

class ImageGetter extends StatefulWidget {
  const ImageGetter({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageGetter> createState() => _ImageGetterState();
}

class _ImageGetterState extends State<ImageGetter> {
  Future<void> makechange() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Image Saver"),
      ),
      body: StreamBuilder<List>(
          stream: getimgaes(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: makechange,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Material(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ImageScreen(tag: snapshot.data?[i]))),
                        child: Hero(
                          tag: snapshot.data?[i],
                          child: Image.file(
                            File(snapshot.data?[i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (i) =>
                      StaggeredTile.count(2, i.isEven ? 2 : 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            print(
                "#############################################################dsfdf");
            return Center(
                child: Text("No Status found",
                    style: TextStyle(color: Colors.black26, fontSize: 14.sp)));
          }),
    );
  }
}
