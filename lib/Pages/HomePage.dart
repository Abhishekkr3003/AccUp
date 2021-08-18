import 'dart:io';
import 'package:accup/Pages/categoriesPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:accup/widgets/HomePageWidgets/CatalogHeader.dart';
import 'package:accup/widgets/HomePageWidgets/CatalogShower.dart';
import 'package:accup/widgets/reusable_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  var toBePrinted = "Android App!";

  final List<String> _listItem = [
    'assets/images/games.png',
    'assets/images/OTT.png',
    'assets/images/SocialMedia.png',
    'assets/images/others.png',
  ];

  final List<String> _listName = ['Games', 'OTT', 'Social Media', 'Others'];
  List<Map> communityData = [];
  Future<void> getCommunities() async {
    communityData = [];
    await FirebaseFirestore.instance
        .collection("category")
        .doc("games")
        .collection("communities")
        .get()
        .then((querySnapshot) => querySnapshot.docs.forEach((doc) {
              print(doc['name']);
              communityData.add(doc.data());
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
    var initial;
    var distance;
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
        print(distance);
        if (distance < 0)
          setState(() {
            xOffset = -100;
            yOffset = 150;
            scaleFactor = 0.7;
            isDrawerOpen = true;
          });
        else {
          setState(() {
            xOffset = 0;
            yOffset = 0;
            scaleFactor = 1;
            isDrawerOpen = false;
          });
        }
      },
      child: AnimatedContainer(
        //height: double.infinity,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 60 : 0.0)),

        //padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        //color: Colors.white,
        child: ListView(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CatalogHeader().pOnly(top: 12, right: 20),
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(FontAwesomeIcons.chevronCircleRight),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            FontAwesomeIcons.ioxhost,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                xOffset = -100;
                                yOffset = 150;
                                scaleFactor = 0.7;
                                isDrawerOpen = true;
                              },
                            );
                          },
                        ),
                ],
              ).pOnly(left: 20, right: 16),
            ),
            CupertinoSearchTextField(
              style: TextStyle(
                color: context.primaryColor,
              ),
              onChanged: (value) {
                // SearchMutation(value);
              },
            ).pOnly(top: 12, left: 20, right: 20),
            20.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFE9C241),
              height: 40.0,
              child: "Games"
                  .text
                  .xl3
                  .color(context.accentColor)
                  .bold
                  .make()
                  .pOnly(left: 10),
            ),
            10.heightBox,
            Container(
              height: 100.0,
              child: new ListView.builder(
                itemCount: communityData.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              communityData[index]["imageURL"],
                            ),
                          ),
                          color: Colors.yellow.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      width: 80.0,
                      // child: new Text('Hello'),
                      alignment: Alignment.center,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            10.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFE9C241),
              height: 40.0,
              child: "Social Media"
                  .text
                  .xl3
                  .color(context.accentColor)
                  .bold
                  .make()
                  .pOnly(left: 10),
            ),
            10.heightBox,
            Container(
              height: 100.0,
              child: new ListView.builder(
                itemCount: communityData.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              communityData[index]["imageURL"],
                            ),
                          ),
                          color: Colors.yellow.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      width: 80.0,
                      // child: new Text('Hello'),
                      alignment: Alignment.center,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            10.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFE9C241),
              height: 40.0,
              child: "OTT"
                  .text
                  .xl3
                  .color(context.accentColor)
                  .bold
                  .make()
                  .pOnly(left: 10),
            ),
            10.heightBox,
            Container(
              height: 100.0,
              child: new ListView.builder(
                itemCount: communityData.length,
                itemBuilder: (context, index) {
                  return new Card(
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              communityData[index]["imageURL"],
                            ),
                          ),
                          color: Colors.yellow.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      width: 80.0,
                      // child: new Text('Hello'),
                      alignment: Alignment.center,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            10.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFE9C241),
              height: 40.0,
              child: "Others"
                  .text
                  .xl3
                  .color(context.accentColor)
                  .bold
                  .make()
                  .pOnly(left: 10),
            ),
            10.heightBox,
            Container(
              height: 100.0,
              child: new ListView.builder(
                itemCount: communityData.length,
                itemBuilder: (context, index) {
                  return new Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5.0),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     blurRadius: 10.0,
                        //   ),
                        // ],
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            communityData[index]["imageURL"],
                          ),
                        ),
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    width: 80.0,
                    // child: new Text('Hello'),
                    alignment: Alignment.center,
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFE9C241),
              height: 40.0,
              child: "Others"
                  .text
                  .xl3
                  .color(context.accentColor)
                  .bold
                  .make()
                  .pOnly(left: 10),
            ),
            10.heightBox,
            Container(
              height: 100.0,
              child: new ListView.builder(
                itemCount: communityData.length,
                itemBuilder: (context, index) {
                  return new Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5.0),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     blurRadius: 10.0,
                        //   ),
                        // ],
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            communityData[index]["imageURL"],
                          ),
                        ),
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    width: 80.0,
                    // child: new Text('Hello'),
                    alignment: Alignment.center,
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
