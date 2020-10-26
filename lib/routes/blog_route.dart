import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  // This widget is the root of your application.
  String title;
  var url = 'https://prog-ac.hatenablog.com/';
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
             const Text('ブログ'),
          centerTitle: true),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
