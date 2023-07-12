import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/ForgotPassword/ForgotPasswordResponse.dart';
import 'package:collectpay/Screens/Login/login_screen.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/already_have_an_account_acheck.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'forgot_background.dart';


class Body extends StatefulWidget{



  @override
  _Body createState() => new _Body();
}

class _Body extends State<StatefulWidget>  {


  String userToken = "";


  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;

    });
  }

  @override
  Widget build(BuildContext context) {
    String userEmail;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
            child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.04),
            RoundedInputField(
              hintText: "Enter verified mobile",
              onChanged: (value) {
                userEmail = value;
              },
            ),



            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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
            ),
          ],
        ),
            ),
            Container(
              height: 70,
              child: SquareButtonLinearGradient(
                buttonText: "Submit".toUpperCase(),
                press: () {
                  if (userEmail.length==10) {
                    forgotPasswordApi(userEmail);
                  } else{
                    EasyLoading.showError("Kindly enter 10-digit valid mobile number");
                  }
                },
                width: size.width * 9,
              ),
            )
        ]
        ),
      ),
    );


  }

  // forgotPassword
  Future<void> forgotPasswordApi(String _userEmail) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'mobile':_userEmail,
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.forgotPassword;

    Uri myUri = Uri.parse(url);

    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $userToken',} ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );
    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse.fromJson(results);
        EasyLoading.showSuccess(forgotPasswordResponse.message);
        snackBarGreen(forgotPasswordResponse.password);
      } else {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse.fromJson(results);
        EasyLoading.showError(forgotPasswordResponse.message);
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
      print("exception ="+e.toString());
    }
  }
  snackBarGreen(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Your new password is: "+message),
        duration: Duration(seconds: 10),
        backgroundColor: Colors.green,
      ),
    );
  }

}
