import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:member_site/views/signin.dart';
import 'package:provider/provider.dart';

import 'package:member_site/models/mainModel.dart';
import 'package:member_site/views/home/homeDialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Profile> memberLists;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => SignIn()), (_) => false);
  }

  _showSignOutDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("ログアウトしますか？"),
              actions: <Widget>[
                FlatButton(
                  child: Text('キャンセル'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    _signOut();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..fetchMemberProfile(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        memberLists = model.memberLists;
        print(memberLists);
        return (model.isLoading)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const CircularProgressIndicator()],
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('神戸プログラミングアカデミー'),
                  backgroundColor: Colors.red,
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            const Text('設定'),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                          title: const Text('ログアウト'),
                          onTap: _showSignOutDialog),
                      ListTile(
                        title: const Text('退会'),
                      ),
                    ],
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GridView.builder(
                          itemCount: memberLists.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.75),
                          itemBuilder: (BuildContext context, int index) {
                            return HomeDialogPage(
                                memberLists: memberLists[index]);
                          }),
                    )
                  ],
                ));
      }),
    );
  }
}
