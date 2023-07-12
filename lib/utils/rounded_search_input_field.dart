import 'package:collectpay/utils/text_search_field_container.dart';
import 'package:flutter/material.dart';

import '../appConstants.dart';



class RoundedSearchInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedSearchInputField({
    Key key,
    this.hintText,
    this.icon = Icons.search,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextSearchFieldContainer(

      child: TextField(

        autofocus:false,
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.black,

        decoration: InputDecoration(

          icon: Icon(icon,color: Colors.black,),
          hintText: hintText,
          border: InputBorder.none,

        ),
      ),
    );
  }
}
