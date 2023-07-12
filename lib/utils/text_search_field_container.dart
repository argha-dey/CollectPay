import 'package:flutter/material.dart';

import '../appConstants.dart';


class TextSearchFieldContainer extends StatelessWidget {
  final Widget child;
  const TextSearchFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      width: size.width *0.95,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
