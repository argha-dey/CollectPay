

import 'package:collectpay/Screens/Recharge/add_money_to_user_wallet.dart';
import 'package:collectpay/utils/CustomTextStyle.dart';
import 'package:collectpay/utils/SqureButtonLinearGradient.dart';
import 'package:collectpay/utils/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SendMoneyToInternationalUserPage extends StatefulWidget {
  @override
  _SendMoneyToInternationalUserPageState createState() => _SendMoneyToInternationalUserPageState();
}

class _SendMoneyToInternationalUserPageState extends State<SendMoneyToInternationalUserPage> {
  final myShortNoteTController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(

      backgroundColor: Color(0xffE5E5E5),
      appBar: new AppBar(
        title: Text("INTERNATIONAL PAY",style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black)),
        leading: IconButton(
            icon:new Image.asset('images/back_icon.png'),
            onPressed: () {
              /*     Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return MyMainPage(); // My Main page
                      },
                    ),
                    );*/
            }),
      ),

      body:  Container(


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
                              "ADD MONEY TO WALLET",
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.black, fontSize: 18),
                            ),
                            margin: EdgeInsets.only(left: 16,right: 2,top: 80),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Available Balance : SRD 44",
                              style: CustomTextStyle.textFormFieldBold
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                            margin: EdgeInsets.only(left: 16,right: 2,top: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2,right: 2,top: 80),
                          child:RoundedInputField(
                            icon: null,
                            hintText: "SRD 0",
                            onChanged: (value) {

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
               /*   Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AddMoneyToUserWalletPage()
                  )
                  );*/
                },
                width: size.width * 9,
              ),
            )


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