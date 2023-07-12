import 'package:collectpay/utils/CustomBorder.dart';
import 'package:flutter/material.dart';

import '../appConstants.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],

        border: Border.all(
            color: Colors.white,// set border color
            width: 0.0),   // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(6.0)), // set rounded corner radius
      ),
      child: child,
    );
  }
}
