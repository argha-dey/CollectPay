
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:collectpay/Model/ContactListResponse/ContactListResponse.dart';
import 'package:collectpay/appConstants.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/UserPreferences.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:collectpay/utils/rounded_input_field_without_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
class QrCodeSendMoneyAnyPersonPage extends StatefulWidget {
   final String userContactData;
   const QrCodeSendMoneyAnyPersonPage({Key key,this.userContactData}) : super(key: key);
  @override
  _QrCodeSendMoneyAnyPersonPageState createState() => _QrCodeSendMoneyAnyPersonPageState();
}


class _QrCodeSendMoneyAnyPersonPageState extends State<QrCodeSendMoneyAnyPersonPage> {
  final myShortNoteTController = TextEditingController();
  String userToken = "";
  String fromUserId = "";
  String budgetRechargeAmount = "0";
  ScanData _scanData;
  @override
  void initState() {
    super.initState();
    setState(() {
      EasyLoading.dismiss();
      userToken = UserPreferences().userCurrentToken;
      fromUserId = UserPreferences().userCurrentId;
      _scanData = ScanData.fromJson(jsonDecode(widget.userContactData));
    });
  }



  // recharge Budget
  Future<void> sendMoneyApi() async {
    EasyLoading.show(status: 'Please wait...');

    Map<String, String> _requestBody = <String, String>{
      'from_id':fromUserId,
      'to_id': _scanData.id,
      'amount':budgetRechargeAmount,
      'type':'wallet'
    };


    var _body = json.encode(_requestBody);
    print("request_json=$_body");

    final ioc = new HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final httpTemp = new IOClient(ioc);

    var url = UrlConstants.transfer;
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
        EasyLoading.showSuccess('Send Money Successfully Done.');
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });

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
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffE5E5E5),
      appBar: new AppBar(
        backgroundColor: Color(0xffE5E5E5),
        title: Text("MONEY SEND TO",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
          leading: IconButton(
              icon:new Image.asset('images/back_icon.png'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
      ),

      body: SingleChildScrollView(

        child: Container(


          child: Column(

            children: <Widget>[

              Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      image: DecorationImage(

                        /*  image:AssetImage("images/ic_user_profile.png",*/
                                image: NetworkImage(_scanData.image
                          ), fit: BoxFit.cover)
                  )),

              Container(
                child: Text(
                 "Paying To "+_scanData.name.toUpperCase(),
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Text(
                 _scanData.mobile.toUpperCase(),
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.black, fontSize: 16),
                ),
                margin: EdgeInsets.only(top: 10,bottom: 30),
              ),
              Container(
                margin: EdgeInsets.only(left: 2,right: 2),
                child:RoundedInputFieldWithoutIcon(

                  hintText: "SRD 0",
                  onChanged: (value) {
                    budgetRechargeAmount = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(top:10,left: 12,right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],

                  // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(6.0)), // set rounded corner radius
                ),


                child: TextFormField(

                  controller: myShortNoteTController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 50,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Add a note',
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),

              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top:120),

                  child: SquareButtonLinearGradient(
                    buttonText: "SEND",
                    press: () {
                      sendMoneyApi();
                    },
                    width: size.width * 9,
                  ),
                ),
              ),
            ],
          ),

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



class ScanData {
  String id;
  String name;
  String mobile;
  String image;
  ScanData(this.id, this.name,this.mobile,this.image);
  factory ScanData.fromJson(dynamic json) {
    return ScanData(json['id'] as String, json['name'] as String,json['mobile'] as String,json['image']);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.name}, ${this.mobile},${this.image}}';
  }


}