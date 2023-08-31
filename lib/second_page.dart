import 'dart:io';

import 'package:flutter/material.dart';

import 'main.dart';

class SecondPage extends StatefulWidget {
  final String params;

  SecondPage({Key? key, this.params = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  String version = 'null';

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (Platform.isIOS) {
      text = 'iOS';
    } else if (Platform.isMacOS) {
      text = 'Mac';
    } else if (Platform.isAndroid) {
      text = 'Android';
    }
    return GestureDetector(
        child: Text('$version：$text'),
        onTap: () {
          // print('Params: $params');
          var result = 'Ack from secondPage';
          router.popRoute(params: result);
        });
  }

  Future<void> _getPlatform() async {
    print('MCLOG====$version');

    // version = await Player.platformVersion;
    print('MCLOG====$version');
    setState(() => version);
  }

  _SecondPageState() {
    _getPlatform();
  }
}
