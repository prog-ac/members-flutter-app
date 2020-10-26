import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:member_site/views/signup.dart';
import 'package:member_site/routes/home/home_route.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();

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

  //ログイン
  void signIn() {
    if (_signinKey.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailInputController.text,
              password: pwdInputController.text)
          .then((result) => {
                print("User id is ${result.user.uid}"),
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
        title: Text("ログイン"),
      ),
      body: signinscreen(),
    );
  }

  Widget signinscreen() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
          key: _signinKey,
          child: Column(
            children: <Widget>[
              //メールアドレス
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                controller: emailInputController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              //パスワード
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                controller: pwdInputController,
                obscureText: true,
                validator: pwdValidator,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              //アカウント作成ボタン
              RaisedButton(
                child: Text(
                  "ログイン",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  signIn();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              FlatButton(
                child: Text(
                  "アカウント作成",
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      (_) => false);
                },
              )
            ],
          ),
        )));
  }
}
