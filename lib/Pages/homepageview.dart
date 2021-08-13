import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'drawerPage.dart';

class HomeScreenViewer extends StatelessWidget {
  const HomeScreenViewer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [DrawerScreen(), HomePage()],
        ),
      ),
    );
  }
}
