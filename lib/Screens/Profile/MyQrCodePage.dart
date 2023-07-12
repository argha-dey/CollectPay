import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyQrCodePage extends StatefulWidget {
  @override
  _MyQrCodePageState createState() => _MyQrCodePageState();
}

class _MyQrCodePageState extends State<MyQrCodePage> {


  ProfileData profileDataDetails;
  String userToken = "";
  SharedPreferences sharedPreferences;
  String qrGenerateData = "";

  @override
  void initState() {
    setState(() {
      userToken = UserPreferences().userCurrentToken;
      this.profileGetDataApi();
    });
    super.initState();
  }


  // profile  Details Api
  Future<void> profileGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getProfile;
    print('Token : ${userToken}');
    print('url : $url');

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    Uri myUri = Uri.parse(url);
    var response = await  httpTemp.get(myUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.dismiss();
        ProfileDataResponse  profileDataResponse = ProfileDataResponse.fromJson(results);
        setState(() {
          profileDataDetails = profileDataResponse.data;
        });

        Map<String, String> _qrCodeDataMap = <String, String>{
          'id':profileDataDetails.userId.toString(),
          'name': profileDataDetails.name,
          'mobile':profileDataDetails.mobile,
          'image': profileDataDetails.image,
        };

         qrGenerateData = json.encode(_qrCodeDataMap);
         print("request_json=$qrGenerateData");

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "MY QR CODE",

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
                  buttonText: "BACk".toUpperCase(),
                  press: () {
                    Navigator.of(context).pop();
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
      margin: EdgeInsets.only(top: 40),
      color: Colors.white,
      child:
      Center (
        child: QrImage(
          data: qrGenerateData,
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ),


    );
  }


}
