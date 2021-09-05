import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accup/Utils/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:accup/Pages/newPostPage.dart';
import 'package:accup/Pages/postDetailsPage.dart';

class postsPage extends StatefulWidget {
  postsPage({required this.gameName});

  final String gameName;

  @override
  _postsPageState createState() => _postsPageState();
}

class _postsPageState extends State<postsPage> {
  bool dataAvlb = false;
  List<Map> postList = [];
  Future<void> getCommunities() async {
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

    setState(() {
      dataAvlb = true;
    });
  }

  int index = 0;

  @override
  void initState() {
    getCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          child: Text(
            "${widget.gameName}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
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
                FontAwesomeIcons.infoCircle,
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
        child: !dataAvlb
            ? CircularProgressIndicator().centered()
            : ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(postList[index]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => postDetailsPage(
                                  currentPost: postList[index])));
                    },
                    child: new Container(
                      // height: MediaQuery.of(context).size.height / 5,
                      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      width: 105.0,
                      // alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${postList[index]["title"]}"
                              .text
                              .justify
                              .bold
                              .make(),
                          "${postList[index]["author"]}"
                              .text
                              .caption(context)
                              .make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(4),
                                height: deviceWidth / 10,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: "\$${postList[index]["price"]}"
                                    .text
                                    .white
                                    .xl
                                    .bold
                                    .makeCentered(),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                // margin: EdgeInsets.all(4),
                                height: deviceWidth / 10,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:
                                    "Likes: ${postList[index]["likes"].length}"
                                        .text
                                        .white
                                        .makeCentered(),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(4),
                                height: deviceWidth / 10,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: "Views: ${postList[index]["views"]}"
                                    .text
                                    .white
                                    .makeCentered(),
                              ),
                            ],
                          ).p12(),
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
              ).pOnly(top: 10),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        newPostPage(gameName: widget.gameName)));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
            minimumSize: MaterialStateProperty.all<Size>(Size(0, 50)),
          ),
          child: Text(
            "Create New Post",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
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
