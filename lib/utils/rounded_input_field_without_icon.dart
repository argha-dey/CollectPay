import 'package:collectpay/utils/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../appConstants.dart';



class RoundedInputFieldWithoutIcon extends StatelessWidget {
  final String hintText;
  final String text;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedInputFieldWithoutIcon({
    Key key,
    this.hintText,
    this.text,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          labelText:text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

