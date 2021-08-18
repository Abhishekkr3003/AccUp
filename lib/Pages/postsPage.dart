import 'package:flutter/material.dart';
import 'package:accup/Utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';

class postsPage extends StatefulWidget {
  @override
  _postsPageState createState() => _postsPageState();
}

class _postsPageState extends State<postsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.amber.shade50,
        title: "Game_Name_from_Database"
            .text
            .xl3
            .color(context.accentColor)
            .make(),
      ),
    );
  }
}
