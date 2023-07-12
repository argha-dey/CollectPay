
import 'dart:async';
import 'dart:io';

import 'package:collectpay/Model/LoginResponse/CommonResponseLogin.dart';
import 'package:collectpay/Screens/ForgotPassword/forgot_password_screen.dart';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/Screens/Landing/landing_page_persist.dart';
import 'package:collectpay/Screens/Login/components/background.dart';
import 'package:collectpay/Screens/Signup/signup_screen.dart';
import 'package:collectpay/utils/MyConnectivity.dart';

import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/already_have_an_account_acheck.dart';
import 'package:collectpay/utils/rounded_button.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:collectpay/utils/rounded_password_field.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:collectpay/appConstants.dart';

StreamController<int> streamController = StreamController<int>();
class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}


class _MyBodyState extends State<Body> {

  bool _connectivityStatus = false;
  MyConnectivity _connectivity = MyConnectivity.instance;

  String userPassword;
  String userEmail;
  final TextEditingController _passwordController = TextEditingController();

  String userId = "";
  SharedPreferences sharedPreferences;
  String fbToken = "";


  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() =>

          _checkInternetConnection(source));
    });
  }
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.38),
           /* SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),*/
            RoundedInputField(
              hintText: "Your Mobile",
              onChanged: (value) {
                //  print("Your Email entered is : $value");
                userEmail = value;
              },
            ),
            RoundedPasswordField(

              onChanged: (value) {
                //  print("The password entered is : $value");
                userPassword = value;
              },
            ),

            SizedBox(height: size.height * 0.005),
        Container(
          width: size.width * 0.8,
         child: InkWell(
            child: Text(
              'Forgot password?',textAlign: TextAlign.right,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ForgotPassword();
                },
              ),
            );},
          ),
        ),


            SizedBox(height: size.height * 0.02),



            SquareButtonLinearGradient(
              buttonText: "LOGIN",
              press: () async {

                   if(userEmail!=null && userPassword!=null && userEmail.isNotEmpty && userPassword.isNotEmpty) {
                     bool isOnline = await hasNetwork();
                     if (isOnline) {
                       _login(context, userEmail, userPassword);
                     } else {
                       snackBarError('Internet Connection Not Available!');
                     }
                   }
                  else
                   EasyLoading.showError('All fields are mandatory');

              },
              width: size.width * 9,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _login(BuildContext _context,String userMobileNo,String userPassword) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'mobile': userMobileNo,
      'password': userPassword,
      'device_token': '123445667890',
      'device_name': 'android',
      "device_os": "The device os field is required.",
      "device_type": "The device type field is required."
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.login;
    Uri myUri = Uri.parse(url);
    final http.Response response  = await httpTemp.post(
        myUri,
        headers:{ "Content-Type": "application/json" } ,
        body: _body,
        encoding: Encoding.getByName("utf-8")
    );


    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      CommonResponseLogin _commonResponseLoginData = CommonResponseLogin.fromJsonMap(jsonDecode(response.body));
      if (_commonResponseLoginData.loginResponseData!=null) {

        print("response_data=$_commonResponseLoginData");
        EasyLoading.showSuccess('Successfully Login!');
        var mobile = _commonResponseLoginData.loginResponseData.mobile;

        UserPreferences().userCurrentToken = _commonResponseLoginData.access_token;
        UserPreferences().userName = _commonResponseLoginData.loginResponseData.name;
        UserPreferences().userLoginStatus = true;

      //  print("response_mobile=$mobile");
        Navigator.pushReplacement(_context, MaterialPageRoute(
            builder: (context) {
          return MyMainPage(currentPage: "Page1",selectedIndex:0); // My Main page
        },
    ),
        );

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Login Failed!');
      }

    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Login Failed!, Response Code :'+ response.statusCode.toString());
    }
  }

  Future<void> _checkInternetConnection(Map source) async{

    String status = "Offline";
    switch (source.keys.toList()[0]) {
      case ConnectivityResult.none:
        status = "Internet Connection Not Available!";
        snackBarError(status);
        _connectivityStatus = false;
        break;
      case ConnectivityResult.mobile:
        status = "Internet Connection Available";
        snackBarGreen(status);
        _connectivityStatus = true;
        break;
      case ConnectivityResult.wifi:
        status = "Internet Connection Available";
        snackBarGreen(status);
        _connectivityStatus = true;
        break;
    }
  }


  // snackBar Widget
  snackBarError(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
  snackBarGreen(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.green,
      ),
    );
  }

  _onChangedSaveLoginStatus(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool( keyLoginStatus,value);
    sharedPreferences.commit();

  }
  _onChangedSaveUserID(String value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(keyUserId, value);
    sharedPreferences.commit();

  }
  _onChangedSaveUserToken(String value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(keyUserToken, value);
    sharedPreferences.commit();

  }
}


