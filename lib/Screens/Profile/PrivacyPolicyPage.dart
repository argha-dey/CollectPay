import 'dart:html';

import 'package:collectpay/Screens/Profile/WebViewStack.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {



  @override
  void initState() {
      WebView.platform = SurfaceAndroidWebView();
    super.initState();
    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Privacy Policy",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body:WebViewStack(urlString:'https://collectpay.developerconsole.live/privacy-policy'),
    );
  }






}
