import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:share/share.dart';


class InviteFriendsPage extends StatefulWidget {
  @override
  _InviteFriendsPageState createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage> {
  static const platform = MethodChannel('flutter.native/helper');
  String shareResponse = "Sharing";
  String _platformVersion = 'Unknown';

  Future<String> shareApp() async {
    String response = "";
    try {
      String result = await platform.invokeMethod("shareApp");
      print("METHOD : " + result);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed "
          "to shared app";
    }
    setState(() {
      shareResponse = response;
    });
    return shareResponse;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Invite Friends",

          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),
          leading: IconButton(
              icon:new Image.asset('images/back_icon.png'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[createHeader(),/* createMiddle()*/],
                ),
                flex: 90,
              ),
              createFooter(context)
            ],
          );
        },
      ),
    );
  }

  Expanded createFooter(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4, right: 4, bottom: 2),

                child:  SquareButtonLinearGradient(
                  buttonText: "Share Link".toUpperCase(),
                  press: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share("share with your friends and family",
                        subject: "",
                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
                  },
                  width: double.infinity,
                )
            ),
            flex: 85,
          ),

        ],
      ),
      flex: 10,
    );
  }

  createHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 160,
            margin: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/ic_refer_friends_bg.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Invite Friends",
                style: CustomTextStyle.textFormFieldBold,
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text( "Please share this application link with your friends and family to click on 'share link' button",
               /* "When you invite friends to join Carter, you can 100 points to each friends.Whenever your friends consume through Carter, you will get a 5% bonus",
             */   style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.black.withOpacity(0.8)),
              ))
        ],
      ),
    );
  }


}
