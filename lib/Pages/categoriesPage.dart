import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({required this.page});

  final String page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Categories"
            .text
            .xl4
            .color(context.accentColor)
            .bold
            .make()
            .pOnly(left: 10),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: 20,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: Text(page),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            );
          }),
    );
  }
}
