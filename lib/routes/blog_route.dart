import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Blog extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(routes: {
      "/": (_) => new WebviewScaffold(
            url: "https://prog-ac.hatenablog.com/",
            appBar: new AppBar(
              title: new Text("ブログ"),
            ), // AppBar
          ) // WebviewScaffold
    }); // MaterialApp
  }
}