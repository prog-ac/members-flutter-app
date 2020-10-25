import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:member_site/views/signin.dart';

import 'home/home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    super.initState();
    emailInputController = TextEditingController();
    pwdInputController = TextEditingController();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  // e-Mailバリデーション
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return '正しいEmailのフォーマットで入力してください';
    } else {
      return null;
    }
  }

  // passwordバリデーション
  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    } else {
      return null;
    }
  }

  // アカウント登録
  void registeUser() {
    if (_signupKey.currentState.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailInputController.text,
              password: pwdInputController.text)
          .then((result) => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (_) => false),
                emailInputController.clear(),
                pwdInputController.clear(),
              })
          .catchError((err) => print(err))
          .catchError((err) => print(err));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("アカウント作成"),
      ),
      body: signupscreen(),
    );
  }

  Widget signupscreen() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
          key: _signupKey,
          child: Column(
            children: <Widget>[
              //メールアドレス
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'メールアドレス*', hintText: "sample@gmail.com"),
                controller: emailInputController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              //パスワード
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'パスワード*', hintText: "********"),
                controller: pwdInputController,
                obscureText: true,
                validator: pwdValidator,
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              //アカウント作成ボタン
              RaisedButton(
                child: const Text(
                  "アカウント作成",
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  registeUser();
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              FlatButton(
                child: const Text(
                  "ログイン",
                  style: const TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                      (_) => false);
                },
              )
            ],
          ),
        )));
  }
}
