import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  // String cloudIp = "api-cataloap.herokuapp.com";

  @override
  void initState() {
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
            color: context.canvasColor,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 60 : 0.0)),

        //padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        //color: Colors.white,
        child: GestureDetector(
          onPanDown: (value) async {
            print("hi");
            //await loadData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CatalogHeader().pOnly(left: 20, top: 12, right: 20),
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
                color: Color(0xFFE9C241),
                height: 60.0,
                child: Row(
                  children: [
                    "Categories"
                        .text
                        .xl4
                        .color(context.accentColor)
                        .bold
                        .make(),
                    SizedBox(
                      height: 35,
                      width: 75,
                    ),
                    //"Show All".text.xl3.color(context.accentColor).bold.make(),
                    // GestureDetector(
                    //   onTap: () {
                    //     print('object');
                    //     setState(() {});
                    //   },
                    //   child: Icon(
                    //     Icons.article_outlined,
                    //     size: 40.0,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    //flex: 2, if we want to change the size of the expanded widget to a different ratio.
                    child: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Image.asset('assets/images/games.png'),
                    ),
                  ),
                  Expanded(
                    //flex: 2, if we want to change the size of the expanded widget to a different ratio.
                    child: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Image.asset('assets/images/OTT.png'),
                    ),
                  ),
                  Expanded(
                    //flex: 2, if we want to change the size of the expanded widget to a different ratio.
                    child: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Image.asset(
                        'assets/images/SocialMedia.png',
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 2, if we want to change the size of the expanded widget to a different ratio.
                    child: TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Image.asset(
                        'assets/images/others.png',
                      ),
                    ),
                  ),
                ],
              ),

              //  Container(
              //    child: GridView(
              //    ),),
              // )
              // (CatalogModel.items != null && CatalogModel.items!.length > 0)
              //     ? CatalogShower().pOnly(left: 20, right: 20).expand()
              //     : Center(
              //         child: CircularProgressIndicator(
              //           color: context.accentColor,
              //         ),
              //       ).expand(),
              // Text('hi'),
            ],
          ),
        ),
      ),
    );
  }
}
