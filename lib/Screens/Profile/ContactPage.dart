import 'package:collectpay/Screens/Profile/WebViewStack.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {


  @override
  void initState() {
    WebView.platform = SurfaceAndroidWebView();
    super.initState();
    setState(() {
    //  this.aboutUsDetailsApi();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Contact",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop(true);

            }),
      ),
      body:WebViewStack(urlString:'https://collectpay.developerconsole.live/api/contact-us'),
    );
  }





}
