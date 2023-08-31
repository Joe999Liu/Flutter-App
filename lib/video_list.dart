import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

import 'right_menu.dart';
import 'main.dart';
import 'mc_router.dart';

class VideoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 15,
            itemBuilder: (context, index) {
              var url =
                  'https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv';
              return GestureDetector(
                child: AbsorbPointer(
                    absorbing: true,
                    child: VideoView(Player()
                      ..setCommonDataSource('asset/videos/test.flv',
                          type: SourceType.asset, autoPlay: true))),
                onTap: () async => await router.push(
                    name: MCRouter.playerPage, arguments: url),
              );
            }));
  }
}
