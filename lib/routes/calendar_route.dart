import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("カレンダー"), // <- (※2)
      ),
      body: Center(child: Text("カレンダーのページ") // <- (※3)
          ),
    );
  }
}
