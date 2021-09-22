import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webPageScreen extends StatelessWidget{
  String url;
  webPageScreen({Key? key,
    required this.url,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:
        url,

      ),
    );
  }

}