import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accup/Utils/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';

class postDetailsPage extends StatefulWidget {
  @override
  _postDetailsPageState createState() => _postDetailsPageState();
}

class _postDetailsPageState extends State<postDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          child: Text(
            "Post-title/game_name",
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
      ),
      backgroundColor: Colors.amber.shade50,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comment',
                  hintText: 'Enter Your Comment'),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(4),
                // margin: EdgeInsets.all(4),
                height: deviceHeight / 15,
                width: deviceWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: "Post Comment".text.white.xl2.makeCentered(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(4),
                // margin: EdgeInsets.all(4),
                height: deviceHeight / 15,
                width: deviceWidth / 3,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.thumbsUp,
                      color: Colors.white,
                    ),
                    "Like".text.white.xl2.make(),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
