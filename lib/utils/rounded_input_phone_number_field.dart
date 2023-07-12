import 'package:collectpay/utils/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../appConstants.dart';



class RoundedInputPhoneNumberField extends StatelessWidget {
  final String hintText;

  final String text;
  final IconData icon;
  final ValueChanged<String> onChanged;
 final TextEditingController controller;
  const RoundedInputPhoneNumberField({
    Key key,
    this.hintText,
    this.text,
    this.icon = Icons.person,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          labelText:text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
