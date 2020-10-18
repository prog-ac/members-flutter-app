import 'package:flutter/material.dart';

class HomeDialogPage extends StatelessWidget {
  var memberLists;
  HomeDialogPage({Key key, @required this.memberLists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(memberLists.name),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (memberLists.imagePath == '')
                        ? Image.network(
                            'https://www.prog-ac.com/wp-content/uploads/2020/07/cropped-prog-ac-logo.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            memberLists.imagePath,
                            fit: BoxFit.cover,
                          ),
                    Text(memberLists.job),
                    Text(memberLists.githubId),
                    Text(memberLists.slackUserId),
                    Text(memberLists.message),
                    Text(memberLists.description),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text("閉じる"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
            // width: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: (memberLists.imagePath == '')
                  ? Image.network(
                      'https://www.prog-ac.com/wp-content/uploads/2020/07/cropped-prog-ac-logo.png',
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      memberLists.imagePath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Column(
              children: [
                Text(memberLists.name, style: TextStyle(fontSize: 16)),
                Text(
                  memberLists.nameKana,
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
