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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: ListView(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                  icon: Icon(
                    CupertinoIcons.back,
                    size: 35.0,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Game_name',
                  style: TextStyle(fontSize: 30.0),
                ),
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
                    }),
                ]
                ).pOnly(left: 20, right: 16),

              ),

              Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: new ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: new Container(
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 5.0),
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
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Text("hi\n"),
                                      Text("hi"),
                                    ],
                                  ),
                                ),
                              )
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              ),
                  ],
                ).expand(),
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
        Text("Here some of the games information will be shown like its genre and some info from wiki or play store."),
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
