import 'package:flutter/material.dart';
import 'package:member_site/views/signin.dart';
import 'package:member_site/my_page_edit/profile_edit.dart';
import 'package:member_site/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Membar Site',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}

class MyHomePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Scaffold(
       appBar: AppBar(title: Text("ホーム"),),  // appBar プロパティに AppBar Widget を追加
       body: Center(child: Text("オラオラオラオラ")),
     ),
   );
 }
}
