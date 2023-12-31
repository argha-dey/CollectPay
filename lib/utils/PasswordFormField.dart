
import 'package:flutter/material.dart';

import '../appConstants.dart';

class PasswordFormField extends StatefulWidget {



  final TextEditingController controller;

  const PasswordFormField({
    Key key,
    @required this.controller,
  })  : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "Password",
        icon: Icon(
          Icons.lock,
          color: kPrimaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),

        border: InputBorder.none,
      ),
      obscureText: !_showPassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
      },
    );
  }
}