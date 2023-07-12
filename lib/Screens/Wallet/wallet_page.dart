import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/Menu.dart';
import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/Model/TransferHistory/TransferHistoryResponse.dart';
import 'package:collectpay/Screens/Home/home_page.dart';
import 'package:collectpay/Screens/Landing/landing_page.dart';
import 'package:collectpay/Screens/Recharge/send_momey_to_international_user.dart';
import 'package:collectpay/Screens/Wallet/qr_code_send_money_any_person.dart';
import 'package:collectpay/Screens/Wallet/send_money_history_list_page.dart';
import 'package:collectpay/Screens/Wallet/transaction_history_page.dart';
import 'package:collectpay/Screens/Wallet/wallet_balance_check_page.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomColors.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  final String menuCategorySlag;
  const WalletPage({Key key, this.menuCategorySlag}) : super(key: key);
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String qrCodeResult;
  ProfileData profileDataDetails;
  String userToken = "";
  String userId = "";
  SharedPreferences sharedPreferences;
  String card_name = null;
  List<TransferHistoryData> transferHistoryData = [];
  @override
  void initState() {
    setState(() {
      userToken = UserPreferences().userCurrentToken;
      userId = UserPreferences().userCurrentId;
      this.profileGetDataApi();
    });

    super.initState();
  }

  Future<void> transactionHistoryGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url =
        UrlConstants.baseUrl + '/user/' + userId + '/transfer?group_by=true';
    print('Token : ${userToken}');
    print('url : $url');

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    Uri myUri = Uri.parse(url);
    var response = await httpTemp.get(myUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results = jsonDecode(response.body);
        EasyLoading.dismiss();
        TransferHistoryResponse transferHistoryResponse =
            TransferHistoryResponse.fromJson(results);

        setState(() {
          transferHistoryData = transferHistoryResponse.data;
        });
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Api Request failed with status: ${response.statusCode}.');
    }
  }

  // profile  Details Api
  Future<void> profileGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getProfile;
    print('Token : ${userToken}');
    print('url : $url');

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    Uri myUri = Uri.parse(url);
    var response = await httpTemp.get(myUri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> results = jsonDecode(response.body);
        EasyLoading.dismiss();
        ProfileDataResponse profileDataResponse =
            ProfileDataResponse.fromJson(results);
        setState(() {
          profileDataDetails = profileDataResponse.data;
          card_name = profileDataDetails.card_name;
        });
        this.transactionHistoryGetDataApi();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Api Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "MY WALLET",
          style: CustomTextStyle.textFormFieldBold
              .copyWith(fontSize: 18, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 32,
              child: card_name == null
                  ? new Container(
                      margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            /*     image: NetworkImage(subCatImage),*/
                            image: AssetImage("images/card_inactive.png"),
                            fit: BoxFit.scaleDown,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(2),
                              topLeft: Radius.circular(2),
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(2))),
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12, left: 0, right: 0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                /*     image: NetworkImage(subCatImage),*/
                                image: AssetImage("images/card_icon.png"),
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
                            "**** **** **** " +
                                profileDataDetails.card_no.substring(
                                    profileDataDetails.card_no.length - 4),
                            style: CustomTextStyle.textFormFieldBold
                                .copyWith(color: Colors.white, fontSize: 22),
                          ),
                          margin: EdgeInsets.only(top: 100, left: 30),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 150, left: 30, right: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Valid Date  " +
                                    profileDataDetails.card_valid_date,
                                style: CustomTextStyle.textFormFieldBold
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                "CVV  " + profileDataDetails.card_cvv,
                                style: CustomTextStyle.textFormFieldBold
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            Expanded(
              flex: 28,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 16),
                            Container(
                              margin: EdgeInsets.only(
                                left: 16,
                                right: 16,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "TRANSFER MONEY",
                                style: CustomTextStyle.textFormFieldSemiBold
                                    .copyWith(
                                        color:
                                            CustomColors.kNearbyTextLevelColor,
                                        fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SendMoneyHistoryListPage(); // My Main page
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 0, right: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 0),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/send_money_icon.png"),
                                              fit: BoxFit.cover)),
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      /*   Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return */ /*RechargeDonePage();*/ /* SendMoneyToInternationalUserPage();// My Main page
                                        },
                                      ),
                                      );*/
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 0, right: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 0),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/recharge_icon.png"),
                                              fit: BoxFit.cover)),
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return WalletBalanceCheckPage(); // My Main page
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 0, right: 16),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 0),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/check_balance_icon.png"),
                                              fit: BoxFit.cover)),
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return TransactionHistoryPage(); // My Main page
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 0, right: 16),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 0),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "images/transaction_icon.png"),
                                                fit: BoxFit.cover)),
                                        width: 60,
                                        height: 60,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 20, right: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "   Send \n  Money",
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                  Text(
                                    "  International \n          Pay",
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                  Text(
                                    "  Check \n Balance",
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                  Text(
                                    "Transaction \n    History",
                                    style: CustomTextStyle.textFormFieldSemiBold
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "TRANSFER TO",
                          style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                              color: CustomColors.kNearbyTextLevelColor,
                              fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TransactionHistoryPage(); // My Main page
                                },
                              ),
                            );
                          },
                          child: Text(
                            "VIEW ALL",
                            style: CustomTextStyle.textFormFieldRegular
                                .copyWith(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  transferHistoryData.length > 0
                      ? Container(
                          child: SingleChildScrollView(
                            child: Container(
                              height: 120,
                              child: GridView.builder(
                                itemCount: transferHistoryData.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (context, position) {
                                  return InkWell(
                                      onTap: () {},
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      /*    image:AssetImage("images/ic_user_profile.png"),*/
                                                      image: NetworkImage(
                                                        transferHistoryData[
                                                                position]
                                                            .to
                                                            .image,
                                                      ),
                                                      fit: BoxFit.cover)),
                                              width: 56,
                                              height: 56,
                                            ),
                                            Container(
                                              height: 30,
                                              margin: EdgeInsets.only(
                                                  left: 16, right: 16),
                                              alignment: Alignment.bottomCenter,
                                              child: Center(
                                                child: Text(
                                                  transferHistoryData[position]
                                                      .to
                                                      .name,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: CustomTextStyle
                                                      .textFormFieldRegular
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 11),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        )
                      : new Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text("No data found!",
                              style: CustomTextStyle.textFormFieldSemiBold
                                  .copyWith(color: Colors.black))),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50, bottom: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 3.0)
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        CustomColors.kButtonGradientColorOne,
                        CustomColors.kButtonGradientColorTwo
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String codeSanner = await scanner.scan();
                        setState(() {
                          qrCodeResult = codeSanner;
                          if (qrCodeResult != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return QrCodeSendMoneyAnyPersonPage(
                                      userContactData:
                                          qrCodeResult); // My Main page
                                },
                              ),
                            );
                          }
                        });
                      },
                      /*     onPressed: () => {


                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) {
                            return ScanQR(); // My Main page
                           },

                         ),
                         ),

                      },*/

                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("SCAN ANY QR CODE"),
                            Image.asset('images/qr_code_scanner.png'),
                          ],
                        ),
                      ),
                    ),
                  )),
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
