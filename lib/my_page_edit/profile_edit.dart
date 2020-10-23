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
  String githubId = '';
  String job = '';
  String message = '';
  String goal = '';
  String free = '';
  String description = '';
  String nameKana = '';
  String slackUserId = '';

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
                      onChanged: (nameKana) {
                        this.nameKana = nameKana;
                      },
                      onSaved: (nameKana) => this.nameKana = nameKana,
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
                      onChanged: (githubId) {
                        this.githubId = githubId;
                      },
                      onSaved: (githubId) => this.githubId = githubId,
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
                      onChanged: (slackUserId) {
                        this.slackUserId = slackUserId;
                      },
                      onSaved: (slack_user_id) => this.slackUserId = slack_user_id,
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
                      child: Text('変更を保存する'),
                      onPressed: () async {
                        signUp();
                      },
                    )
                  ]
              )
          ),
        )
    );
  }
  Future<void> signUp() async {
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
          'github_id': githubId,
          'goal': goal,
          'job': job,
          'message': message,
          'name': name,
          'name_kana': nameKana,
          'slack_user_id': slackUserId,
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
