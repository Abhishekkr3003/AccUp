import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({required this.page});

  final String page;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Map> communityData = [];
  final String category = "";

  Future<void> getCommunities() async {
    communityData = [];
    await FirebaseFirestore.instance
        .collection("category")
        .doc("${widget.page}")
        .collection("communities")
        .get()
        .then((querySnapshot) => querySnapshot.docs.forEach((doc) {
              print(doc['name']);
              communityData.add(doc.data());
            }));
    setState(() {});
    // String id = "1N7ZJO2akHWyvluyD3tl";
    // await FirebaseFirestore.instance
    //     .collection("category")
    //     .doc(id)
    //     .collection("communities")
    //     .get()
    //     .then((querySnapshot) => querySnapshot.docs.forEach((doc) {
    //           print(doc['name']);
    //           FirebaseFirestore.instance
    //               .collection("category")
    //               .doc("games")
    //               .collection("communities")
    //               .add(doc.data());
    //           // communityData.add(doc.data());
    //         }));
  }

  @override
  void initState() {
    // TODO: implement initState
    getCommunities();
    super.initState();
  }

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
        // title: "Communities"
        //     .text
        //     .xl4
        //     .color(context.accentColor)
        //     .bold
        //     .make()
        //     .pOnly(left: 10),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          "${widget.page.toUpperCase()}"
              .text
              .xl5
              .color(context.accentColor)
              .bold
              .make()
              .pOnly(left: 16),
          CupertinoSearchTextField(
            style: TextStyle(
              color: context.primaryColor,
            ),
            placeholder: "Search in ${widget.page.toUpperCase()}",
            onChanged: (value) {
              // SearchMutation(value);
            },
          ).pOnly(top: 12, left: 16, right: 16),
          10.heightBox,
          communityData.isNotEmpty
              ? LiquidPullToRefresh(
                  color: Color(0xFFE9C241),
                  showChildOpacityTransition: false,
                  animSpeedFactor: 10.0,
                  springAnimationDurationInMilliseconds: 500,
                  // key: _refreshIndicatorKey, // key if you want to add
                  onRefresh: getCommunities, // refresh callback
                  child: GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 1.25,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: communityData.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            // TODO
                            Fluttertoast.showToast(
                                msg: communityData[index]["name"]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                              // border: Border.all(color: Colors.amber, width: 5.0),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    communityData[index]["imageURL"],
                                  )),
                              color: Colors.yellow.shade50,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      }),
                ).expand()
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
