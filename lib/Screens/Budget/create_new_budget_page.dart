import 'dart:convert';
import 'dart:io';

import 'package:collectpay/Model/BudgetResponse/CreateBudgetResponse.dart';
import 'package:collectpay/Screens/Budget/recharge_user_budget_wallet.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_input_field_without_icon.dart';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class CreateNewBudgetPage extends StatefulWidget {

  const CreateNewBudgetPage({Key key}) : super(key: key);

  @override
  _CreateNewBudgetPageState createState() => new _CreateNewBudgetPageState();
}

class _CreateNewBudgetPageState extends State<CreateNewBudgetPage>  {

  String userToken = "";
  String userPrefName = "";
  SharedPreferences sharedPreferences;
  String selectedPrefType;
  CreateDataBudget _createDataBudget;
  String userId= "";
  // SUPER MARKET  => SUPM
  // GASOLIN CENTER => GASC
  // SEND MONEY => SNDM


  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      userId = UserPreferences().userCurrentId;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Create New Budget
  Future<void> createBudgetApi(String _prefName,String _type) async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'name':_prefName,
      'type': _type,
    };

    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.getBudget;

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
        CreateBudgetResponse createBudgetResponse =   CreateBudgetResponse.fromJson(results);
        setState(() {
          _createDataBudget = createBudgetResponse.data;
        });
        EasyLoading.showSuccess('Budget Create Successfully');
        Navigator.of(context).pop(true);
      } else if (response.statusCode == 201){
        EasyLoading.dismiss();
        Map<String, dynamic> results  = jsonDecode(response.body);
        CreateBudgetResponse createBudgetResponse =   CreateBudgetResponse.fromJson(results);
        setState(() {
          _createDataBudget = createBudgetResponse.data;
        });
        EasyLoading.showSuccess('Budget Create Successfully');
        Navigator.of(context).pop(true);
      }else {
        EasyLoading.dismiss();
        EasyLoading.showError('Data Not Found status: ${response.statusCode}.');
      }
    }catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Api Request failed with status: ${response.statusCode}.');
      print("exception ="+e.toString());
    }
  }

// recharge Budget
  Future<void> rechargeBudgetApi() async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'user_id':userId,
      'budget_id': _createDataBudget.id.toString(),
      'amount':"0",
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

      } else {
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
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Create Budget".toUpperCase(),style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
      ),

      body: Builder(builder: (context) {

        return Container(

          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Column(

                        children: <Widget>[
                          SizedBox(height:25),



                          Flexible(

                            child:Container(
                                padding: const EdgeInsets.all(8.0),
                                child:Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      getSizedBox(height: 4),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Preferable Name",
                                          maxLines: 1,
                                          softWrap: true,
                                          style: CustomTextStyle.textFormFieldSemiBold
                                              .copyWith(fontSize: 16,color: Colors.black),
                                        ),
                                      ),
                                      getSizedBox(height: 4),
                                      RoundedInputFieldWithoutIcon(
                                        hintText: "",
                                        onChanged: (value) {
                                          userPrefName = value;
                                        },
                                      ),

                                      getSizedBox(height: 4),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Budget Type",
                                          maxLines: 1,
                                          softWrap: true,
                                          style: CustomTextStyle.textFormFieldSemiBold
                                              .copyWith(fontSize: 16,color: Colors.black),
                                        ),
                                      ),
                                      getSizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10,right: 10),
                                    child:  DropdownButtonFormField<String>(

                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,

                                        ),

                                        value: selectedPrefType,
                                    //elevation: 5,
                                    style: TextStyle(color: Colors.black),

                                    items: <String>[
                                      'SUPM',
                                      'GASC',
                                      'SNDM',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    hint: Text(
                                      "Select",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        selectedPrefType = value;
                                      });
                                    },
                                  ),
                                  )


                                    ],
                                  ),
                                )


                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),

                            child: SquareButtonLinearGradient(
                              buttonText: "Create".toUpperCase(),
                              press: () {
                                createBudgetApi(userPrefName,selectedPrefType);
                              },
                              width: double.infinity,
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        );
      }),

    );
  }






  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }



}













addRadioButton(BuildContext superContext, int i, String s) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[


    ],
  );
}














