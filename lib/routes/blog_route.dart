import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ブログ"), // <- (※2)
      ),
      body: Center(child: Text("ブログのページ♡") // <- (※3)
          ),
    );
  }
}
