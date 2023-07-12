import 'package:flutter/material.dart';

import '../appConstants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: size.width * 9,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],

        border: Border.all(
            color: Colors.grey, // set border color
            width: 0.0), // set border width
        borderRadius:
            BorderRadius.all(Radius.circular(8.0)), // set rounded corner radius
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ElevatedButton(
          //  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          // color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
