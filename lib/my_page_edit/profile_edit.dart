import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget{
  @override
  _ProfileEdit createState() => _ProfileEdit();
}

class _ProfileEdit extends State {
  String name = '';
  String github_id = '';
  String job = '';
  String message = '';
  String goal = '';
  String description = '';
  String name_kana = '';
  String slack_user_id = '';

  final currentUserUid = FirebaseAuth.instance.currentUser.uid;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('プロフィール編集')),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore
                .instance.collection("memberProfile")
                .doc(currentUserUid)
                .snapshots(),
            builder: (context, snapshot) {
              return (!snapshot.hasData)
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              )
                  : Form(
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
                            initialValue: snapshot.data.get('name').toString(),
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
                            initialValue: snapshot.data.get('name_kana').toString(),
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
                            initialValue: snapshot.data.get('description').toString(),
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
                            initialValue: snapshot.data.get('github_id').toString(),
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
                            initialValue: snapshot.data.get('job').toString(),
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
                            initialValue: snapshot.data.get('message').toString(),
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
                            initialValue: snapshot.data.get('goal').toString(),
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
                            initialValue: snapshot.data.get('slack_user_id').toString(),
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
                                    builder: (context) => ImageUploadScreen()
                                ),
                              );
                            },
                          ),
                          // ボタン表示
                          RaisedButton(
                            child: Text('変更を保存'),
                            onPressed: () async {
                              SaveData();
                              Navigator.pop(context);
                            },
                          )
                        ]
                    )
                ),
              );
            }
        )
    );
  }
  Future<void> SaveData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseFirestore.instance
            .collection('memberProfile')
            .doc(currentUserUid)
            .set({
          'description': description,
          'docId': currentUserUid,
          'github_id': github_id,
          'goal': goal,
          'job': job,
          'message': message,
          'name': name,
          'name_kana': name_kana,
          'slack_user_id': slack_user_id,
        });
      } catch (e){
        print("Error");
      }
    }
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File file;

  Future<int> showCupertinoBottomBar() {
    //選択するためのボトムシートを表示
    return showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            message: Text('写真をアップロードしますか？'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'カメラで撮影',
                ),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'アルバムから選択',
                ),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context, 2);
              },
              isDefaultAction: true,
            ),
          );
        });
  }

  void showBottomSheet() async {
    //ボトムシートから受け取った値によって操作を変える
    final result = await showCupertinoBottomBar();
    File imageFile;
    if (result == 0) {
      imageFile = await CompressFile(ImageSource.camera).getImageFromDevice();
    } else if (result == 1) {
      imageFile = await CompressFile(ImageSource.gallery).getImageFromDevice();
    }
    setState(() {
      file = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (file != null)
              Container(
                height: 300,
                width: 300,
                child: Image.file(file),
              ),
            RaisedButton(
              child: Text('upload'),
              onPressed: () {
                showBottomSheet();
              },
            )
          ],
        ),
      ),
    );
  }
}

//カメラ、ギャラリーからのアップロードはここでやる
class CompressFile {
  CompressFile(this.source, {this.quality = 50});

  final ImageSource source;
  final int quality;

  Future<File> getImageFromDevice() async {
    // 撮影/選択したFileが返ってくる
    final imageFile = await ImagePicker().getImage(source: source);
    // Androidで撮影せずに閉じた場合はnullになる
    if (imageFile == null) {
      return null;
    }
    //画像を圧縮
    final File compressedFile = await FlutterNativeImage.compressImage(
        imageFile.path,
        quality: quality);

    return compressedFile;
  }
}