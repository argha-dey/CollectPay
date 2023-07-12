

import 'dart:io';

import 'package:collectpay/Screens/Login/login_screen.dart';
import 'package:collectpay/Screens/Signup/signup_screen.dart';
import 'package:collectpay/Screens/Welcome/components/background.dart';
import 'package:collectpay/utils/RoundedButtonLinearGradient.dart';
import 'package:collectpay/utils/rounded_button.dart';
import 'package:flutter/services.dart';
//import 'package:minimize_app/minimize_app.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class Body extends StatefulWidget {
@override
_MyBodyState createState() => _MyBodyState();
}


class _MyBodyState extends State<Body> {


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () =>/* MinimizeApp.minimizeApp()*//*exit(0)*/SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }



  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.38),

            new Align(

              child:Image(
                  image: AssetImage("images/wellcome_image.png"),
                  height: 140,
                  alignment: Alignment.center,
                  width: 200),
            ),


            SizedBox(height: size.height * 0.06),

            RoundedButtonLinearGradient(
              buttonText: "Login",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              width: 200,
            ),
            SizedBox(height: size.height * 0.02),
            RoundedButtonLinearGradient(
              buttonText: "Signup",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              width: 200,
            ),


          ],
        ),
      ),
    ),
    );
  }



/*
  Future<void> _login(BuildContext _context) async {

    EasyLoading.show(status: 'Please wait...');



    Map<String, String> requestBody = <String,String>{
      'key': api_Key,
      'postType': login_Api,
      'email_id': userEmail,
      'password': userPassword,
      'token': '123445667890'
    };

    Map<String, String> headers= <String,String>{
      'Content-Type':'multipart/form-data'
      */
/*    'Authorization':'Basic ${base64Encode(utf8.encode('user:password'))}'*//*

    };


    var uri = Uri.parse(base_url_api);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(requestBody);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      var _data = jsonDecode(respStr);
      if (!_data['success'])
        EasyLoading.showError('Login Failed');
      else{
        _commonResponseLoginData = CommonResponseLogin.fromJsonMap(jsonDecode(respStr));
        if (_commonResponseLoginData.success) {
          _onChangedSaveLoginStatus(true);

          //   UserPreferences().userCurrentId = '3';
          UserPreferences().userCurrentId =
              _commonResponseLoginData.loginResponseData.user_id;
          UserPreferences().userCurrentEmail =
              _commonResponseLoginData.loginResponseData.email_id;
          Navigator.pushReplacement(_context, MaterialPageRoute(
            builder: (context) {
              return MyMainPage(); // My Main page
            },
          ),
          );
          EasyLoading.showSuccess('Successfully Login!');
        }
        else {
          EasyLoading.showError('Login Failed');
        }
      }
    }
    else {
      throw Exception('Login Failed!');

    }
  }

*/




}


