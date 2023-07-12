

import 'dart:convert';
import 'dart:io';
import 'package:collectpay/Model/BudgetResponse/GetBudgetResponse.dart';
import 'package:collectpay/Model/ProfileResponse/ProfileDataResponse.dart';
import 'package:collectpay/utils/rounded_input_field_without_icon.dart';
import 'package:http/http.dart' as http;
import 'package:collectpay/Screens/Recharge/add_money_to_user_wallet.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RechargeUserBudgetWalletPage extends StatefulWidget {
  final String budgetId;
  const RechargeUserBudgetWalletPage({Key key, this.budgetId}) : super(key: key);
  @override
  _RechargeUserBudgetWalletPageState createState() => _RechargeUserBudgetWalletPageState();
}

class _RechargeUserBudgetWalletPageState extends State<RechargeUserBudgetWalletPage> {
  final myShortNoteTController = TextEditingController();

  String userToken = "";
  String userId = "";
  SharedPreferences sharedPreferences;
  ProfileData profileDataDetails;
  Budget _budget;
  String budgetRechargeAmount = "0";
  int amount = 0;
  int currentWalletBalance = 0;
  String name="";
  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      userId =  UserPreferences().userCurrentId;
      this.walletGetDataApi();
    });
  }


  // WalletBalance  Details Api
  Future<void> walletGetDataApi() async {
    EasyLoading.show(status: 'Please wait...');

    var url = UrlConstants.getBudget+"/"+widget.budgetId;
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

        GetBudgetResponse  getBudgetResponse = GetBudgetResponse.fromJson(results);
        setState(() {
          _budget = getBudgetResponse.data;
          amount = _budget.amount;
          currentWalletBalance = _budget.currentWalletBalance;
          name = _budget.name;
        });
        EasyLoading.dismiss();

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
    }
  }


  // recharge Budget
  Future<void> rechargeBudgetApi() async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'user_id':userId,
      'budget_id': widget.budgetId,
      'amount':budgetRechargeAmount,
      'status': "credit",
    };


    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.recharge;
    print("url=$url");

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
      if (response.statusCode == 201) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Budget Recharge Successfully Done.');
        Navigator.of(context).pop(true);
      }else if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        EasyLoading.showSuccess('Budget Recharge Successfully Done.');
        Navigator.of(context).pop(true);
      }   else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
      print("exception ="+e.toString());
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
          "ADD MONEY",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18,color: Colors.black),
        ),

        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
      ),

      body: amount>= 0? Container(


        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(

                  child: Column(


                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Container(

                            child: Text(
                              "Main Wallet Balance : SRD ".toUpperCase()+currentWalletBalance.toString().toUpperCase(),
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.black, fontSize: 18),
                            ),
                            margin: EdgeInsets.only(left: 16,right: 2,top: 30),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:Container(

                            child: Text(
                              "Add money to ".toUpperCase()+name.toUpperCase(),
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.black, fontSize: 18),
                            ),
                            margin: EdgeInsets.only(left: 16,right: 2,top: 50),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Available Balance : SRD "+amount.toString().toUpperCase(),
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                            margin: EdgeInsets.only(left: 16,right: 2,top: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2,right: 2,top: 30),
                          child:RoundedInputFieldWithoutIcon(
                            hintText: "  SRD 0",
                            onChanged: (value) {
                              budgetRechargeAmount = value;
                            },
                          ),
                        ),
                      ]
                  )
              ),
            ),


            Container(
              height: 70,
              child: SquareButtonLinearGradient(
                buttonText: "Procced".toUpperCase(),
                press: () {
                  rechargeBudgetApi();

                },
                width: size.width * 9,
              ),
            )


          ],
        ),

      ):new Container(),


    );
  }
}

getSizedBox({double width, double height}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

get _getOtpKeyboard {
  return new Container(

      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "1",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "2",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "3",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "4",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "5",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "6",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _otpKeyboardInputButton(
                    label: "7",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "8",
                    onPressed: () {

                    }),
                _otpKeyboardInputButton(
                    label: "9",
                    onPressed: () {

                    }),
              ],
            ),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  width: 80.0,
                ),
                _otpKeyboardInputButton(
                    label: "0",
                    onPressed: () {
                      _setCurrentDigit(0);
                    }),
                _otpKeyboardActionButton(
                    label: new Icon(
                      Icons.backspace,
                      color: Colors.black,
                    ),
                    onPressed: () {

                    }),
              ],
            ),
          ),
        ],
      ));
}


Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
  return new Material(
    color: Colors.transparent,
    child: new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 30.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}

// Returns "Otp keyboard action Button"
_otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
  return new InkWell(
    onTap: onPressed,
    borderRadius: new BorderRadius.circular(40.0),
    child: new Container(
      height: 80.0,
      width: 80.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: new Center(
        child: label,
      ),
    ),
  );
}



void _setCurrentDigit(int i) {
/*  setState(() {
    _currentDigit = i;
  });*/
}