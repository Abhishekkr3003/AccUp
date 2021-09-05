import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accup/Utils/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';

class postDetailsPage extends StatefulWidget {
  final Map currentPost;

  const postDetailsPage({Key? key, required this.currentPost})
      : super(key: key);
  @override
  _postDetailsPageState createState() => _postDetailsPageState();
}

class _postDetailsPageState extends State<postDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    String curUserID = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // title: Container(
          //   child: Text(
          //     "Post-title/game_name",
          //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          //   ),
          // ),

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: deviceWidth,
                  child: "${widget.currentPost["author"]} wanna sell: "
                      .text
                      .caption(context)
                      .xl
                      .make()
                      .pOnly(left: 10),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: deviceWidth,
                  child: "${widget.currentPost["title"]}".text.bold.xl2.make(),
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: deviceWidth,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child:
                          "Last Modified: ${widget.currentPost["dateModified"]}"
                              .text
                              .caption(context)
                              .make()
                              .pOnly(left: 10),
                    ).expand(),
                    10.widthBox,
                    Container(
                      width: deviceWidth,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: "Posted On: ${widget.currentPost["datePosted"]}"
                          .text
                          .caption(context)
                          .make()
                          .pOnly(left: 10),
                    ).expand(),
                  ],
                ),
                10.heightBox,
                Container(
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(50)),
                  // width: deviceWidth,
                  child: "Images Posted By Author"
                      .text
                      .caption(context)
                      .xl
                      .make()
                      .pOnly(top: 8, bottom: 8, left: 10, right: 10),
                ),
                10.heightBox,
                Container(
                  height: 105,
                  child: new ListView.builder(
                    itemCount: widget.currentPost["imageURL"].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(widget.currentPost["imageURL"]);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => postsPage(
                          //               gameName: gamesList[index]["name"],
                          //             )));
                        },
                        child: new Container(
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  widget.currentPost["imageURL"][index],
                                ),
                              ),
                              color: Colors.yellow.shade50,
                              borderRadius: BorderRadius.circular(15)),
                          width: 105.0,
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      "Price: ".text.xl.bold.make(),
                      "\$${widget.currentPost["price"]}".text.xl.bold.make()
                    ],
                  ),
                ),
                10.heightBox,
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(50)),
                  child: "Description"
                      .text
                      .caption(context)
                      .xl
                      .make()
                      .pOnly(top: 8, bottom: 8, left: 10, right: 10),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //     // color: Colors.white,
                  //     // borderRadius: BorderRadius.circular(20),
                  //     ),
                  width: deviceWidth,
                  child: "${widget.currentPost["description"]} wanna sell: "
                      .text
                      .justify
                      .make(),
                ),
                Divider(
                  thickness: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(50)),
                  child: "Comments"
                      .text
                      .caption(context)
                      .xl
                      .make()
                      .pOnly(top: 8, bottom: 8, left: 10, right: 10),
                ).centered(),
                10.heightBox,
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
                ).centered(),
              ],
            ).p12(),
          ),
        ),
        bottomNavigationBar: Container(
          height: deviceHeight / 15,
          color: Colors.amber.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // alignment: MainAxisAlignment.spaceBetween,
            // buttonPadding: Vx.mH0,
            children: [
              LikeButton(
                size: 30,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    FontAwesomeIcons.solidHeart,
                    color: isLiked ? Colors.indigo : Colors.grey,
                    size: 30,
                  );
                },
                isLiked: widget.currentPost["likes"].contains(curUserID),
                likeCount: widget.currentPost["likes"].length,
                likeCountPadding: EdgeInsets.only(left: 6),
                onTap: (isLiked) async {
                  print(widget.currentPost["likes"]);
                  if (isLiked) {
                    widget.currentPost["likes"].remove(curUserID);
                    //   await FirebaseFirestore.instance
                    //       .collection("pods")
                    //       .doc(widget.pod)
                    //       .collection("posts")
                    //       .doc(widget.docRef)
                    //       .update({
                    //     'likes': FieldValue.arrayRemove(
                    //         [FirebaseAuth.instance.currentUser!.uid])
                    //   });
                  } else {
                    widget.currentPost["likes"].add(curUserID);
                    //   await FirebaseFirestore.instance
                    //       .collection("pods")
                    //       .doc(widget.pod)
                    //       .collection("posts")
                    //       .doc(widget.docRef)
                    //       .update({
                    //     'likes': FieldValue.arrayUnion(
                    //         [FirebaseAuth.instance.currentUser!.uid])
                    //   });
                  }
                  setState(() {});
                  return isLiked;
                },
              ),
              Icon(
                FontAwesomeIcons.solidCommentAlt,
                size: 30,
                color: Colors.indigo,
              ).pOnly(left: 40),
              Row(
                children: [
                  widget.currentPost["views"]
                      .toString()
                      .text
                      .xl
                      .gray400
                      .make()
                      .px12(),
                  Icon(
                    FontAwesomeIcons.eye,
                    color: Colors.indigo,
                    size: 30,
                  ),
                ],
              ).px12(),
            ],
          ).p12(),
        ));
  }
}
