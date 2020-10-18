import 'package:flutter/material.dart';
import 'package:member_site/models/mainModel.dart';
import 'package:member_site/views/home/homeDialog.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Profile> memberLists;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..fetchMemberProfile(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        memberLists = model.memberLists;
        print(memberLists);
        return (model.isLoading)
            ?  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const CircularProgressIndicator()],
                ),
              )
            : Scaffold(
                body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const SizedBox(height: 80),
                  Expanded(
                    child: GridView.builder(
                        itemCount: memberLists.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
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
