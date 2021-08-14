import 'package:flutter/material.dart';

class reusableCard extends StatelessWidget {
  final String image;

  reusableCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(image),
        ],
      ),
    );
  }
}
