import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  const PlayerPage(this.url);

  @override
  State<StatefulWidget> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  String version = 'null';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var player = Player();
    print('video url is :${widget.url}');
    player.setCommonDataSource(widget.url, type: SourceType.net, autoPlay: true);
    return GestureDetector(
        onLongPress: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Tips"),
                  content: const Text("Do you want to download videos?"),
                  actions: <Widget>[
                    TextButton(child: const Text("Cancel"), onPressed: () => Navigator.pop(context, "cancel")),
                    TextButton(
                        child: const Text("Ok"),
                        onPressed: () {
                          _saveVideo();
                          Navigator.pop(context, 'confirm');
                        }),
                  ],
                );
              });
        },
        child: VideoView(player));
  }

  _save() async {
    var response = await Dio().get(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: "hello");
    print("result: $result");
  }

  _saveVideo() async {
    print('start');

    var appDocDir = await getExternalStorageDirectory();
    print('start: $appDocDir');

    String savePath = "${appDocDir?.path}/temp.mp4";
    await Dio().download(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
        savePath);
    print('downlaod : $savePath');

    // final result = await ImageGallerySaver.saveFile(savePath);
    // print(result);
  }
}
