import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile {
  final String description,
      docId,
      githubId,
      goal,
      imagePath,
      job,
      message,
      name,
      nameKana,
      slackUserId;
  Profile(
      {this.description,
      this.docId,
      this.githubId,
      this.goal,
      this.imagePath,
      this.job,
      this.message,
      this.name,
      this.nameKana,
      this.slackUserId});
}

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  List<Profile> memberLists = [];
  Future fetchMemberProfile() async {
    this.isLoading = true;
    final allDocs =
        await FirebaseFirestore.instance.collection("memberProfile").get();
    for (var i = 0; i < allDocs.docs.length; i++) {
      memberLists.add(Profile(
          description: allDocs.docs[i].data()['name'],
          slackUserId: allDocs.docs[i].data()['slack_user_id'],
          imagePath: allDocs.docs[i].data()['imagePath'],
          message: allDocs.docs[i].data()['message'],
          githubId: allDocs.docs[i].data()['github_id'],
          docId: allDocs.docs[i].data()['docId'],
          goal: allDocs.docs[i].data()['goal'],
          job: allDocs.docs[i].data()['job'],
          name: allDocs.docs[i].data()['name'],
          nameKana: allDocs.docs[i].data()['name_kana']));
    }
    print(memberLists);
    this.isLoading = false;
    notifyListeners();
  }
}
