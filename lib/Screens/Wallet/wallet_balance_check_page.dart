

import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletBalanceCheckPage extends StatefulWidget {
  @override
  _WalletBalanceCheckPageState createState() => _WalletBalanceCheckPageState();
}

class _WalletBalanceCheckPageState extends State<WalletBalanceCheckPage> {

  ProfileData profileDataDetails;
  String userToken = "";
  SharedPreferences sharedPreferences;
  String card_name = null;
  int walletBalance =0;

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
          card_name = profileDataDetails.card_name;
          walletBalance = profileDataDetails.walletBalance;
        });

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
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
      backgroundColor: Colors.white70,
      title: Text(
        "CHECK BALANCE",
        style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
      ),

      leading: IconButton(
          icon:new Image.asset('images/back_icon.png'),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    ),

      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 32,

              child: card_name==null?new Container(

                margin: EdgeInsets.only(top: 0, left: 0,right: 0),

                decoration: BoxDecoration(

                    image: DecorationImage(

                      /*     image: NetworkImage(subCatImage),*/
                      image:AssetImage("images/card_inactive.png"),

                      fit: BoxFit.scaleDown,
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2))),

              ):Stack(

                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12, left: 0,right: 0),

                    decoration: BoxDecoration(
                        image: DecorationImage(

                          /*     image: NetworkImage(subCatImage),*/
                          image:AssetImage("images/card_icon.png"),

                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),

                  ),
                  Container(
                    child: Text(
                      "Physical",
                      style: CustomTextStyle.textFormFieldRegular
                          .copyWith(color: Colors.white, fontSize: 16),
                    ),
                    margin: EdgeInsets.only(top: 30, left: 30),
                  ),
                  Container(
                    child: Text(
                      profileDataDetails.card_name.toUpperCase(),
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    margin: EdgeInsets.only(top: 70, left: 30),
                  ),
                  Container(
                    child: Text(
                      "**** **** **** "+profileDataDetails.card_no.substring(profileDataDetails.card_no.length - 4),
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.white, fontSize: 22),
                    ),
                    margin: EdgeInsets.only(top: 100, left: 30),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 150,  left: 30, right: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Valid Date  "+ profileDataDetails.card_valid_date,
                          style: CustomTextStyle.textFormFieldBold
                              .copyWith(color:Colors.white,fontSize: 14),
                        ),
                        Text(
                          "CVV  "+ profileDataDetails.card_cvv,
                          style: CustomTextStyle.textFormFieldBold
                              .copyWith(color:Colors.white,fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 68,





              child:Container(

                child:   Stack(


                  children: <Widget>[





                    Container(

                      margin: EdgeInsets.only(bottom:100,left: 16, right: 16,),
                      alignment: Alignment.center,
                      child: Text(
                        "AVAILABLE BALANCE",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.black, fontSize: 22),overflow: TextOverflow.ellipsis,
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top:0,left: 16, right: 16,),
                      alignment: Alignment.center,
                      child:Row(

                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 4.0),

                            child: Text(
                              "SRD",
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.black, fontSize: 16),overflow: TextOverflow.ellipsis,
                            ),),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),

                            child: Text(
                                walletBalance.toString(),
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.black, fontSize: 24),overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                        child: SquareButtonLinearGradient(
                          buttonText: "Re-Check BALANCE".toUpperCase(),
                          press: () {
profileGetDataApi();
                          },
                          width: size.width * 9,
                        ),
                      ),
                    ),
                  ],



                ),

              ),





            ),







          ],
        ),
      ),

    );
  }
}

getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}



