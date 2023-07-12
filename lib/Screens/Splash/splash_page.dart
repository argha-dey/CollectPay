import 'dart:async';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/Screens/Landing/landing_page_persist.dart';
import 'package:collectpay/Screens/Welcome/welcome_screen.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    //  getCredential();
    var loginStatus= UserPreferences().userLoginStatus;
     print("Login Status:  $loginStatus");

    Timer(
        Duration(seconds: 4),
            () =>
                UserPreferences().userLoginStatus?Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MyMainPage(currentPage: "Page1",selectedIndex:0))):Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
            /*  decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("images/splashscreen.png"),
                  fit: BoxFit.cover,),
              ),*/

              color: Colors.white,
            ),
            new Center(
              child: Image(
                  image: AssetImage("images/collect_pay_logo.png"),
                  height: 140,
                  alignment: Alignment.center,
                  width: 200),
            )
          ],
        )
    );
  }
}







