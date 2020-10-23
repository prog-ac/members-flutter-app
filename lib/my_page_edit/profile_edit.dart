import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:member_site/my_page_edit/image_upload.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget{
  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State {
  String name = '';
  String github_id = '';
  String job = '';
  String message = '';
  String goal = '';
  String free = '';
  String description = '';
  String name_kana = '';
  String slack_user_id = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('プロフィール編集')),
        body: Form(
          key: _formKey,
          child: Center(
              child: ListView(
                  children: [
                    // 入力項目
                    TextFormField(
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (name) {
                        this.name = name;
                      },
                      onSaved: (name) => this.name = name,
                      decoration: InputDecoration(
                        labelText: '名前',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      validator: (name_kana) {
                        if (name_kana.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (name_kana) {
                        this.name_kana = name_kana;
                      },
                      onSaved: (name_kana) => this.name_kana = name_kana,
                      decoration: InputDecoration(
                        labelText: 'かな',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (description) {
                        this.description = description;
                      },
                      onSaved: (description) => this.description= description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (github_id) {
                        this.github_id = github_id;
                      },
                      onSaved: (github_id) => this.github_id = github_id,
                      decoration: InputDecoration(
                        labelText: 'Github_ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (job) {
                        this.job = job;
                      },
                      onSaved: (job) => this.job = job,
                      decoration: InputDecoration(
                        labelText: 'Job',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (message) {
                        this.message = message;
                      },
                      onSaved: (message) => this.message = message,
                      decoration: InputDecoration(
                        labelText: 'Comment',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (goal) {
                        this.goal = goal;
                      },
                      onSaved: (goal) => this.goal = goal,
                      decoration: InputDecoration(
                        labelText: 'Goal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (free) {
                        this.free = free;
                      },
                      onSaved: (free) => this.free = free,
                      decoration: InputDecoration(
                        labelText: 'Free',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      onChanged: (slack_user_id) {
                        this.slack_user_id = slack_user_id;
                      },
                      onSaved: (slack_user_id) => this.slack_user_id = slack_user_id,
                      decoration: InputDecoration(
                        labelText: 'Slack_user_id',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    RaisedButton(
                      child: Text('画像をアップロード'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageUploadScreen()),
                        );
                      },
                    ),

                    // ボタン表示
                    RaisedButton(
                      child: Text('次ページへ移動'),
                      onPressed: () async {
                        SaveData();
                      },
                    )
                  ]
              )
          ),
        )
    );
  }
  Future<void> SaveData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await Firebase.initializeApp();
        final userCredential = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection('memberProfile')
            .doc(userCredential.uid)
            .set({
          'description': description,
          'docId': userCredential,
          'github_id': github_id,
          'goal': goal,
          'job': job,
          'message': message,
          'name': name,
          'name_kana': name_kana,
          'slack_user_id': slack_user_id,
        });
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => ())
        // );
      } catch (e){
        print("Error");
      }
    }
  }
}
