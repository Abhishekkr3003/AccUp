import 'package:flutter/material.dart';
import 'package:accup/Utils/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';

class postsPage extends StatefulWidget {
  postsPage({required this.gameName});

  final String gameName;

  @override
  _postsPageState createState() => _postsPageState();
}

class _postsPageState extends State<postsPage> {
  List<Map> postList = [];
  Future<void> getCommunities() async {
    gamesList = [];
    await FirebaseFirestore.instance
        .collection("category")
        .doc("games")
        .collection("communities")
        .doc("yL1H8V8YRV64jMpyLkjE")
        .collection("posts")
        .get()
        .then((querySnapshot) => querySnapshot.docs.forEach((doc) {
              print(doc['title']);
              postList.add(doc.data());
            }));

    setState(() {});
  }

  int index = 0;

  @override
  void initState() {
    getCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Game_Name".text.bold.xl4.make().pOnly(top: 8),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            size: 35.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
              child: Icon(
                FontAwesomeIcons.info,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context));
              })
        ],
      ),
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: new Container(
                height: MediaQuery.of(context).size.height / 5,
                margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(15)),
                width: 105.0,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Column(
                      children: [
                        "Title".text.bold.xl.make(),
                        "Writer".text.caption(context).make(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          scrollDirection: Axis.vertical,
        ).pOnly(top: 10),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('About this game'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Here some of the games information will be shown like its genre and some info from wiki or play store."),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
