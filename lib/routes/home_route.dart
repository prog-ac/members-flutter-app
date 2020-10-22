import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("神戸プログラミングアカデミー"), // <- (※2)
      ),
      body: Center(child: Text("ホームだよ♡") // <- (※3)
          ),
    );
  }
}
